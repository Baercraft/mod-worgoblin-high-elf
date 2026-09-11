-- ARAC: create the missing race/class start rows for every race that already
-- exists in playercreateinfo (limited to playable client races 1-16).
-- Existing customized rows are never overwritten.
--
-- Non-DK combinations inherit the race's own starting location. Death Knights
-- inherit the standard Ebon Hold start from an existing DK row.

DROP TEMPORARY TABLE IF EXISTS `tmp_arac_classes`;
CREATE TEMPORARY TABLE `tmp_arac_classes` (`class` TINYINT UNSIGNED PRIMARY KEY);
INSERT INTO `tmp_arac_classes` (`class`) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(11);

DROP TEMPORARY TABLE IF EXISTS `tmp_arac_races`;
CREATE TEMPORARY TABLE `tmp_arac_races` AS
SELECT DISTINCT `race`
FROM `playercreateinfo`
WHERE `race` BETWEEN 1 AND 16;
ALTER TABLE `tmp_arac_races` ADD PRIMARY KEY (`race`);

-- One normal starting position per race, preserving each custom race's own
-- configured start area when it already has at least one non-DK class.
DROP TEMPORARY TABLE IF EXISTS `tmp_arac_start`;
CREATE TEMPORARY TABLE `tmp_arac_start` AS
SELECT p.`race`, p.`map`, p.`zone`, p.`position_x`, p.`position_y`, p.`position_z`, p.`orientation`
FROM `playercreateinfo` p
JOIN (
    SELECT `race`, MIN(`class`) AS `template_class`
    FROM `playercreateinfo`
    WHERE `race` BETWEEN 1 AND 16 AND `class` <> 6
    GROUP BY `race`
) t ON t.`race` = p.`race` AND t.`template_class` = p.`class`;
ALTER TABLE `tmp_arac_start` ADD PRIMARY KEY (`race`);

INSERT IGNORE INTO `playercreateinfo`
    (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT r.`race`, c.`class`, s.`map`, s.`zone`,
       s.`position_x`, s.`position_y`, s.`position_z`, s.`orientation`
FROM `tmp_arac_races` r
JOIN `tmp_arac_start` s ON s.`race` = r.`race`
CROSS JOIN `tmp_arac_classes` c
WHERE c.`class` <> 6;

-- Add DK for races that do not yet have one. Use an existing Ebon Hold DK row
-- as the positional template; race-specific DK coordinates differ only by a
-- few yards and are not functionally required for ARAC.
INSERT IGNORE INTO `playercreateinfo`
    (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT r.`race`, 6, dk.`map`, dk.`zone`, dk.`position_x`, dk.`position_y`, dk.`position_z`, dk.`orientation`
FROM `tmp_arac_races` r
CROSS JOIN (
    SELECT `map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`
    FROM `playercreateinfo`
    WHERE `class` = 6
    ORDER BY `race`
    LIMIT 1
) dk;

DROP TEMPORARY TABLE IF EXISTS `tmp_arac_start`;
DROP TEMPORARY TABLE IF EXISTS `tmp_arac_races`;
DROP TEMPORARY TABLE IF EXISTS `tmp_arac_classes`;
