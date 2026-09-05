-- Custom races 12-16: make every class advertised by CharBaseInfo.dbc
-- a real server-side PlayerInfo entry. This prevents Player::Create from
-- rejecting valid custom race/class combinations as a hacking attempt.
-- WotLK class IDs: 1 Warrior, 2 Paladin, 3 Hunter, 4 Rogue, 5 Priest,
-- 6 Death Knight, 7 Shaman, 8 Mage, 9 Warlock, 11 Druid.

DELETE FROM `playercreateinfo`
WHERE `race` IN (12,13,14,15,16);

INSERT INTO `playercreateinfo`
(`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
-- Worgen (12) - Teldrassil, DK in Scarlet Enclave
(12,1,1,141,10311.3,832.463,1326.41,5.69632),
(12,2,1,141,10311.3,832.463,1326.41,5.69632),
(12,3,1,141,10311.3,832.463,1326.41,5.69632),
(12,4,1,141,10311.3,832.463,1326.41,5.69632),
(12,5,1,141,10311.3,832.463,1326.41,5.69632),
(12,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(12,7,1,141,10311.3,832.463,1326.41,5.69632),
(12,8,1,141,10311.3,832.463,1326.41,5.69632),
(12,9,1,141,10311.3,832.463,1326.41,5.69632),
(12,11,1,141,10311.3,832.463,1326.41,5.69632),

-- High Elf (13) - Elwynn Forest, DK in Scarlet Enclave
(13,1,0,12,-8949.95,-132.493,83.5312,0),
(13,2,0,12,-8949.95,-132.493,83.5312,0),
(13,3,0,12,-8949.95,-132.493,83.5312,0),
(13,4,0,12,-8949.95,-132.493,83.5312,0),
(13,5,0,12,-8949.95,-132.493,83.5312,0),
(13,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(13,7,0,12,-8949.95,-132.493,83.5312,0),
(13,8,0,12,-8949.95,-132.493,83.5312,0),
(13,9,0,12,-8949.95,-132.493,83.5312,0),
(13,11,0,12,-8949.95,-132.493,83.5312,0),

-- Mag'har Orc (14) - Durotar, DK in Scarlet Enclave
(14,1,1,14,-618.518,-4251.67,38.718,0),
(14,2,1,14,-618.518,-4251.67,38.718,0),
(14,3,1,14,-618.518,-4251.67,38.718,0),
(14,4,1,14,-618.518,-4251.67,38.718,0),
(14,5,1,14,-618.518,-4251.67,38.718,0),
(14,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(14,7,1,14,-618.518,-4251.67,38.718,0),
(14,8,1,14,-618.518,-4251.67,38.718,0),
(14,9,1,14,-618.518,-4251.67,38.718,0),
(14,11,1,14,-618.518,-4251.67,38.718,0),

-- Ogre (15) - Durotar, DK in Scarlet Enclave
(15,1,1,14,-618.518,-4251.67,38.718,0),
(15,2,1,14,-618.518,-4251.67,38.718,0),
(15,3,1,14,-618.518,-4251.67,38.718,0),
(15,4,1,14,-618.518,-4251.67,38.718,0),
(15,5,1,14,-618.518,-4251.67,38.718,0),
(15,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(15,7,1,14,-618.518,-4251.67,38.718,0),
(15,8,1,14,-618.518,-4251.67,38.718,0),
(15,9,1,14,-618.518,-4251.67,38.718,0),
(15,11,1,14,-618.518,-4251.67,38.718,0),

-- Dark Iron Dwarf (16) - Dun Morogh, DK in Scarlet Enclave
(16,1,0,1,-6240.32,331.033,382.758,0),
(16,2,0,1,-6240.32,331.033,382.758,0),
(16,3,0,1,-6240.32,331.033,382.758,0),
(16,4,0,1,-6240.32,331.033,382.758,0),
(16,5,0,1,-6240.32,331.033,382.758,0),
(16,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(16,7,0,1,-6240.32,331.033,382.758,0),
(16,8,0,1,-6240.32,331.033,382.758,0),
(16,9,0,1,-6240.32,331.033,382.758,0),
(16,11,0,1,-6240.32,331.033,382.758,0);

-- Extend parent-race skill masks so every ARAC class gets the normal
-- racial/language/weapon skill initialization for the custom race.
UPDATE `playercreateinfo_skills` SET `raceMask` = `raceMask` | 2048  WHERE (`raceMask` & 8)   <> 0; -- Worgen <- Night Elf
UPDATE `playercreateinfo_skills` SET `raceMask` = `raceMask` | 4096  WHERE (`raceMask` & 512) <> 0; -- High Elf <- Blood Elf
UPDATE `playercreateinfo_skills` SET `raceMask` = `raceMask` | 8192  WHERE (`raceMask` & 2)   <> 0; -- Mag'har <- Orc
UPDATE `playercreateinfo_skills` SET `raceMask` = `raceMask` | 16384 WHERE (`raceMask` & 2)   <> 0; -- Ogre <- Orc
UPDATE `playercreateinfo_skills` SET `raceMask` = `raceMask` | 32768 WHERE (`raceMask` & 4)   <> 0; -- Dark Iron <- Dwarf

-- Starter action bars for ARAC combinations. Use a native race that supports
-- the class as template; this avoids empty action bars on newly created chars.
DELETE FROM `playercreateinfo_action` WHERE `race` IN (12,13,14,15,16);

-- Alliance-side custom races: Worgen 12, High Elf 13, Dark Iron 16
INSERT IGNORE INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT r.race, a.class, a.button, a.action, a.type
FROM `playercreateinfo_action` a
CROSS JOIN (SELECT 12 race UNION ALL SELECT 13 UNION ALL SELECT 16) r
WHERE (a.race,a.class) IN ((1,1),(1,2),(3,3),(1,4),(1,5),(1,6),(11,7),(1,8),(1,9),(4,11));

-- Horde-side custom races: Mag'har 14, Ogre 15
INSERT IGNORE INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT r.race, a.class, a.button, a.action, a.type
FROM `playercreateinfo_action` a
CROSS JOIN (SELECT 14 race UNION ALL SELECT 15) r
WHERE (a.race,a.class) IN ((2,1),(10,2),(2,3),(2,4),(5,5),(2,6),(2,7),(5,8),(2,9),(6,11));
