-- ARAC / custom races: synchronize AzerothCore's SQL-backed DBC overrides.
--
-- IMPORTANT:
-- AzerothCore first loads SkillRaceClassInfo.dbc / SkillLineAbility.dbc and then
-- overwrites matching IDs from the world DB tables skillraceclassinfo_dbc and
-- skilllineability_dbc.  Old rows in those tables therefore win over a fixed
-- DBC file.  These rows intentionally mirror the corrected Patch-A DBC values.

-- ---------------------------------------------------------------------------
-- SkillRaceClassInfo.dbc overrides
-- Columns: ID, SkillID, RaceMask, ClassMask, Flags, MinLevel, SkillTierID,
--          SkillCostIndex
-- ---------------------------------------------------------------------------
REPLACE INTO `skillraceclassinfo_dbc`
(`ID`,`SkillID`,`RaceMask`,`ClassMask`,`Flags`,`MinLevel`,`SkillTierID`,`SkillCostIndex`)
VALUES
-- Languages
(40,   98, 40013, 1535, 128,  0,  0, 0), -- Common: incl. High Elf (13), Dark Iron (16)
(48,  109, 25522, 1535, 128,  0,  0, 0), -- Orcish: incl. Mag'har (14), Ogre (15)
(44,  111, 32772, 1535, 128,  0,  0, 0), -- Dwarven: Dwarf + Dark Iron (16)
(882, 137,  4608, 1535, 128,  0,  0, 0), -- Thalassian: Blood Elf + High Elf (13)

-- Ogre inherited racials
(71,  124, 16416, 1535, 1170, 0,  0, 0), -- Tauren racial line: Tauren + Ogre
(70,  125, 16386, 1535, 146,  0,  0, 0), -- Orc racial line: Orc + Ogre

-- High Elf custom racial line
(1140,791, 36877, 1535, 1170, 0,  0, 0),

-- Armor skill lines / ARAC
(21,  293, 65535,    3, 128, 40, 0, 0), -- Plate at 40 (Warrior/Paladin)
(906, 293,262143,   32, 128,  0, 0, 0), -- Plate (Death Knight)
(145, 413, 65535,   68, 128, 40, 0, 0), -- Mail at 40
(146, 413, 65535,   35, 128,  0, 0, 0), -- Mail baseline
(147, 414, 65535, 1135, 128,  0, 0, 0), -- Leather
(148, 415, 65535, 1535, 128,  0, 0, 0), -- Cloth
(246, 433, 65535,   67, 128,  0, 0, 0); -- Shield

-- ---------------------------------------------------------------------------
-- SkillLineAbility.dbc overrides
-- Columns follow AzerothCore's skilllineability_dbc table exactly.
-- ---------------------------------------------------------------------------
REPLACE INTO `skilllineability_dbc`
(`ID`,`SkillLine`,`Spell`,`RaceMask`,`ClassMask`,`ExcludeRace`,`ExcludeClass`,
 `MinSkillLineRank`,`SupercededBySpell`,`AcquireMethod`,`TrivialSkillLineRankHigh`,
 `TrivialSkillLineRankLow`,`CharacterPoints_1`,`CharacterPoints_2`)
VALUES
-- Languages
(590,  98,   668, 40013, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0),
(592, 109,   669, 25522, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0),
(594, 111,   672, 32772, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0),
(727, 137,   813,  4608, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0),

-- Ogre racials
(11696,124,20549,16416,0,0,0,1,0,2,0,0,0,0),
(11697,124,20550,16416,0,0,0,1,0,2,0,0,0,0),
(11709,125,20573,16386,0,0,0,1,0,2,0,0,0,0),
(11710,125,20574,16386,0,0,0,1,0,2,0,0,0,0),

-- High Elf custom racials
(31463,791,110005,4096,1503,0,0,0,0,1,0,2,0,0),
(31464,791,110006,4096,   0,0,0,0,0,1,0,2,0,0),
(31465,791,110007,4096,  32,0,0,0,0,1,0,2,0,0),
(31466,791,110008,4096,   0,0,0,0,0,1,0,2,0,0),
(31467,791,110009,4096,   0,0,0,0,0,1,0,2,0,0);

-- Keep character creation defaults explicit as well.
SET @RACE_HIGH_ELF := 4096;
SET @RACE_MAGHAR   := 8192;
SET @RACE_OGRE     := 16384;
SET @RACE_DARKIRON := 32768;

REPLACE INTO `playercreateinfo_skills`
(`raceMask`,`classMask`,`skill`,`rank`,`comment`)
VALUES
(@RACE_HIGH_ELF,0, 98,0,'High Elf - Language: Common'),
(@RACE_HIGH_ELF,0,137,0,'High Elf - Language: Thalassian'),
(@RACE_MAGHAR,  0,109,0,'Maghar Orc - Language: Orcish'),
(@RACE_OGRE,    0,109,0,'Ogre - Language: Orcish'),
(@RACE_DARKIRON,0, 98,0,'Dark Iron Dwarf - Language: Common'),
(@RACE_DARKIRON,0,111,0,'Dark Iron Dwarf - Language: Dwarven');

REPLACE INTO `playercreateinfo_spell_custom`
(`racemask`,`classmask`,`Spell`,`Note`)
VALUES
(@RACE_HIGH_ELF,0,668,'High Elf - Common'),
(@RACE_HIGH_ELF,0,813,'High Elf - Thalassian'),
(@RACE_MAGHAR,  0,669,'Maghar Orc - Orcish'),
(@RACE_OGRE,    0,669,'Ogre - Orcish'),
(@RACE_DARKIRON,0,668,'Dark Iron Dwarf - Common'),
(@RACE_DARKIRON,0,672,'Dark Iron Dwarf - Dwarven');
