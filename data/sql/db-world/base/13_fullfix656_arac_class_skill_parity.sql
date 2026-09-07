-- FULLFIX 6.5.6 - ARAC class-skill parity audit/fix
-- Incremental on top of 6.5.5. No destructive changes to native races or global rows.
-- The DBC patch expands only SkillRaceClassInfo rows whose RaceMask was exactly 4095
-- (all native playable races 1-12) to 65535 (all playable races 1-16).
-- ClassMask is NEVER broadened, so class restrictions stay identical to native class behavior.

INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(0,0,95,0,'Defense'),
(0,0,162,0,'Unarmed'),
(0,0,183,0,'GENERIC (DND)'),
(0,0,415,0,'Cloth'),
(0,0,777,0,'Mounts'),
(0,0,778,0,'Companion Pets'),
(0,1,26,0,'Warrior - Arms'),
(0,1,256,0,'Warrior - Fury'),
(0,1,257,0,'Warrior - Protection'),
(0,2,184,0,'Paladin - Retribution'),
(0,2,267,0,'Paladin - Protection'),
(0,2,594,0,'Paladin - Holy'),
(0,4,50,0,'Hunter - Beast Mastery'),
(0,4,51,0,'Hunter - Survival'),
(0,4,163,0,'Hunter - Marksmanship'),
(0,8,38,0,'Rogue - Combat'),
(0,8,39,0,'Rogue - Subtlety'),
(0,8,253,0,'Rogue - Assassination'),
(0,9,176,0,'Thrown'),
(0,16,56,0,'Priest - Holy'),
(0,16,78,0,'Priest - Shadow'),
(0,16,613,0,'Priest - Discipline'),
(0,32,129,4,'Death Knight - First Aid'),
(0,32,229,0,'Polearms'),
(0,32,293,0,'Plate'),
(0,32,762,0,'Death Knight - Riding'),
(0,32,770,0,'Death Knight - Blood'),
(0,32,771,0,'Death Knight - Frost'),
(0,32,772,0,'Death Knight - Unholy'),
(0,35,55,0,'Two-Handed Swords'),
(0,35,413,0,'Mail'),
(0,37,44,0,'Axes'),
(0,37,172,0,'Two-Handed Axes'),
(0,39,43,0,'Swords'),
(0,40,118,0,'Dual Wield'),
(0,64,373,0,'Shaman - Enhancement'),
(0,64,374,0,'Shaman - Restoration'),
(0,64,375,0,'Shaman - Elemental'),
(0,67,433,0,'Shield'),
(0,128,6,0,'Mage - Frost'),
(0,128,8,0,'Mage - Fire'),
(0,128,237,0,'Mage - Arcane'),
(0,256,354,0,'Warlock - Demonology'),
(0,256,355,0,'Warlock - Affliction'),
(0,256,593,0,'Warlock - Destruction'),
(0,400,228,0,'Wands'),
(0,1024,134,0,'Druid - Feral'),
(0,1024,573,0,'Druid - Restoration'),
(0,1024,574,0,'Druid - Balance'),
(0,1107,54,0,'Maces'),
(0,1135,414,0,'Leather'),
(0,1488,136,0,'Staves');

-- Preserve dedicated custom racial/language SkillLines from 6.5.5.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(4096,0,98,0,'High Elf - Language Common'),(4096,0,137,0,'High Elf - Language Thalassian'),(4096,0,791,0,'High Elf - Racial'),
(8192,0,109,0,'Maghar Orc - Language Orcish'),(8192,0,792,0,'Maghar Orc - Racial'),
(16384,0,109,0,'Ogre - Language Orcish'),(16384,0,794,0,'Ogre - Racial'),
(32768,0,98,0,'Dark Iron - Language Common'),(32768,0,111,0,'Dark Iron - Language Dwarven'),(32768,0,795,0,'Dark Iron Dwarf - Racial');

-- Ensure all 16 races x all 10 WotLK classes have PlayerInfo without overwriting existing starts.
DROP TEMPORARY TABLE IF EXISTS `tmp_fullfix656_races`;
CREATE TEMPORARY TABLE `tmp_fullfix656_races` (`race` TINYINT UNSIGNED PRIMARY KEY);
INSERT INTO `tmp_fullfix656_races` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16);
DROP TEMPORARY TABLE IF EXISTS `tmp_fullfix656_classes`;
CREATE TEMPORARY TABLE `tmp_fullfix656_classes` (`class` TINYINT UNSIGNED PRIMARY KEY);
INSERT INTO `tmp_fullfix656_classes` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(11);
INSERT IGNORE INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT r.`race`,c.`class`,p.`map`,p.`zone`,p.`position_x`,p.`position_y`,p.`position_z`,p.`orientation`
FROM `tmp_fullfix656_races` r CROSS JOIN `tmp_fullfix656_classes` c
JOIN `playercreateinfo` p ON p.`race`=r.`race`
JOIN (SELECT `race`,MIN(`class`) AS `baseclass` FROM `playercreateinfo` WHERE `class`<>6 AND `race` BETWEEN 1 AND 16 GROUP BY `race`) b
ON b.`race`=p.`race` AND b.`baseclass`=p.`class` WHERE c.`class`<>6;
INSERT IGNORE INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT `race`,6,609,4298,2358.44,-5666.9,426.023,3.65997 FROM `tmp_fullfix656_races`;
DROP TEMPORARY TABLE IF EXISTS `tmp_fullfix656_classes`;
DROP TEMPORARY TABLE IF EXISTS `tmp_fullfix656_races`;

-- Read-only sanity checks. Expected result for missing pairs = 0.
SELECT COUNT(*) AS `FULLFIX656_missing_race_class_pairs` FROM
(SELECT r.race,c.class FROM
 (SELECT 1 race UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16) r
 CROSS JOIN (SELECT 1 class UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 11) c) x
LEFT JOIN `playercreateinfo` p ON p.race=x.race AND p.class=x.class WHERE p.race IS NULL;
