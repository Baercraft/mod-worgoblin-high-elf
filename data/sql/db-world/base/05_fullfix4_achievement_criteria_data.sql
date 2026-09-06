-- FULLFIX4.1: Custom race achievement criteria data
-- Fixes missing data warnings for custom High Elf / Mag'har criteria in Achievement_Criteria.dbc.
-- Race IDs: High Elf = 13, Mag'har Orc = 14.

DELETE FROM `achievement_criteria_data`
WHERE `criteria_id` IN (13484, 13485, 13498, 13499);

REPLACE INTO `achievement_criteria_data`
(`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
-- High Elf: Achievement 2422 (Shake Your Bunny-Maker)
(13484, 2, 0, 13, ''),
(13484, 9, 18, 0, ''),
(13484, 10, 1, 0, ''),
-- High Elf: Achievement 291 (Check Your Head)
(13485, 2, 0, 13, ''),
-- Mag'har Orc: Achievement 2422 (Shake Your Bunny-Maker)
(13498, 2, 0, 14, ''),
(13498, 9, 18, 0, ''),
(13498, 10, 1, 0, ''),
-- Mag'har Orc: Achievement 291 (Check Your Head)
(13499, 2, 0, 14, '');
