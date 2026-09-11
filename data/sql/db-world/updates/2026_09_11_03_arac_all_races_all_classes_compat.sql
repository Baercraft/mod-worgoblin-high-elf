-- ARAC V5 - complete race/class compatibility hardening for races 1-16.
--
-- This update closes the remaining gaps that appear when Blizzard-only
-- race/class combinations are opened by ARAC:
--   * Worgen/Goblin/Dark Iron racial SkillLines are mirrored into the SQL DBC overrides.
--   * Alliance/Horde RaceMasks are normalized so High Elf never inherits Horde data and
--     Mag'har never inherits Alliance data.
--   * Starting racial SkillLines/spells are explicit for Worgen/Goblin/High Elf/Ogre/Dark Iron.
--   * Every ARAC Shaman race gets a valid totem model fallback.
--   * Every ARAC Druid race gets valid Cat/Bear/Dire Bear/Flight/Epic Flight model fallbacks.
--   * Worgen and Troll use the custom druid models already shipped by Patch-A.
--   * Missing class action-bar basics are copied to every valid race/class combination.
--
-- Safe to re-run: REPLACE/INSERT IGNORE are used intentionally.

-- ---------------------------------------------------------------------------
-- 1) SQL-backed SkillRaceClassInfo overrides.
--    These IDs must match the DBC, otherwise AzerothCore can override a good
--    client/server DBC row with stale database data during startup.
-- ---------------------------------------------------------------------------
REPLACE INTO `skillraceclassinfo_dbc`
(`ID`,`SkillID`,`RaceMask`,`ClassMask`,`Flags`,`MinLevel`,`SkillTierID`,`SkillCostIndex`)
VALUES
(68,  101, 32772, 1535, 1170, 0, 0, 0), -- Dwarf racial line: Dwarf + Dark Iron
(971, 789,  2048, 1535, 1170, 0, 0, 0), -- Worgen racial line
(972, 790,   256, 1535, 1170, 0, 0, 0); -- Goblin racial line

-- ---------------------------------------------------------------------------
-- 2) SQL-backed SkillLineAbility overrides.
--    Includes the full Worgen/Goblin/Dark-Iron racial packages and all rows
--    whose faction masks were normalized in Patch-A.
-- ---------------------------------------------------------------------------
REPLACE INTO `skilllineability_dbc`
(`ID`,`SkillLine`,`Spell`,`RaceMask`,`ClassMask`,`ExcludeRace`,`ExcludeClass`,
 `MinSkillLineRank`,`SupercededBySpell`,`AcquireMethod`,`TrivialSkillLineRankHigh`,
 `TrivialSkillLineRankLow`,`CharacterPoints_1`,`CharacterPoints_2`)
VALUES

(11724,101,2481,32772,0,0,0,1,0,2,0,0,0,0), -- Dwarf/Dark Iron racial
(11725,101,20596,32772,0,0,0,1,0,2,0,0,0,0), -- Dwarf/Dark Iron racial
(11726,101,20595,32772,0,0,0,1,0,2,0,0,0,0), -- Dwarf/Dark Iron racial
(11727,101,20594,32772,0,0,0,1,0,2,0,0,0,0), -- Dwarf/Dark Iron racial
(20143,101,59224,32772,0,0,0,1,0,2,0,0,0,0), -- Dwarf/Dark Iron racial
(21981,789,68975,2048,0,0,0,1,0,2,0,0,0,0), -- Worgen racial
(21982,789,68976,2048,0,0,0,1,0,2,0,0,0,0), -- Worgen racial
(21983,789,68978,2048,0,0,0,1,0,2,0,0,0,0), -- Worgen racial
(21984,789,68992,2048,0,0,0,1,0,2,0,0,0,0), -- Worgen racial
(21985,790,69041,256,0,0,0,1,0,2,0,0,0,0), -- Goblin racial
(21986,790,69042,256,0,0,0,1,0,2,0,0,0,0), -- Goblin racial
(21987,790,69044,256,0,0,0,1,0,2,0,0,0,0), -- Goblin racial
(21988,790,69045,256,0,0,0,1,0,2,0,0,0,0), -- Goblin racial
(21989,790,69046,256,0,0,0,1,0,2,0,0,0,0), -- Goblin racial
(31448,790,69070,256,0,0,0,1,0,2,0,0,0,0), -- Goblin racial
(14784,184,31898,25522,2,0,0,1,0,0,0,0,0,0), -- Horde mask
(18308,184,53733,25522,2,0,0,1,0,0,0,0,0,0), -- Horde mask
(18311,184,53736,25522,2,0,0,1,0,0,0,0,0,0), -- Horde mask
(18314,184,53742,25522,2,0,0,1,0,0,0,0,0,0), -- Horde mask
(20290,202,60866,25522,0,0,0,1,0,0,490,480,0,0), -- Horde mask
(3271,237,3567,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(3273,237,3566,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(3274,237,3563,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(5991,237,11417,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(5993,237,11420,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(5994,237,11418,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(14816,237,32272,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(14818,237,32267,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(15606,237,35715,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(15607,237,35717,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(17000,237,49358,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(17003,237,49361,25522,128,0,0,1,0,0,0,0,0,0), -- Horde mask
(13151,373,2825,25522,64,0,0,1,0,0,0,0,0,0), -- Horde mask
(7594,594,13819,40013,2,0,0,1,0,0,0,0,0,0), -- Alliance mask
(12518,594,23214,40013,2,0,0,1,0,0,0,0,0,0), -- Alliance mask
(15252,594,34767,25522,2,0,0,1,0,0,0,0,0,0), -- Horde mask
(15253,594,34769,25522,2,0,0,1,0,0,0,0,0,0), -- Horde mask
(20090,777,34767,25522,2,0,0,1,0,0,0,0,0,0), -- Horde mask
(20092,777,34769,25522,2,0,0,1,0,0,0,0,0,0), -- Horde mask
(20110,777,55531,25522,0,0,0,1,0,0,0,0,0,0); -- Horde mask

-- ---------------------------------------------------------------------------
-- 3) Starting racial SkillLines and spells. ClassMask 0 = every class.
-- ---------------------------------------------------------------------------
REPLACE INTO `playercreateinfo_skills`
(`raceMask`,`classMask`,`skill`,`rank`,`comment`)
VALUES
(2048,  0,  98, 0, 'Worgen - Language: Common'),
(2048,  0, 789, 0, 'Worgen - Racial'),
(256,   0, 109, 0, 'Goblin - Language: Orcish'),
(256,   0, 790, 0, 'Goblin - Racial'),
(4096,  0, 791, 0, 'High Elf - Racial'),
(16384, 0, 124, 0, 'Ogre - Tauren inherited racial line'),
(16384, 0, 125, 0, 'Ogre - Orc inherited racial line'),
(32768, 0, 101, 0, 'Dark Iron - Dwarf racial line');

-- The ARAC-expanded CharStartOutfit.dbc contains valid starting weapons for
-- combinations Blizzard did not ship in WotLK. Some matching weapon skills
-- are race-gated in the stock playercreateinfo_skills table, so add only the
-- exact missing skill required by the shipped starting outfit. The DBC side
-- already permits every row below for its race/class combination.
REPLACE INTO `playercreateinfo_skills`
(`raceMask`,`classMask`,`skill`,`rank`,`comment`)
VALUES
(1,4,46,0,'ARAC start weapon: Human Hunter - Guns'),
(2,2,160,0,'ARAC start weapon: Orc Paladin - Two-Handed Maces'),
(8,2,160,0,'ARAC start weapon: Night Elf Paladin - Two-Handed Maces'),
(16,2,160,0,'ARAC start weapon: Undead Paladin - Two-Handed Maces'),
(16,4,46,0,'ARAC start weapon: Undead Hunter - Guns'),
(32,8,173,0,'ARAC start weapon: Tauren Rogue - Daggers'),
(64,2,160,0,'ARAC start weapon: Gnome Paladin - Two-Handed Maces'),
(64,4,46,0,'ARAC start weapon: Gnome Hunter - Guns'),
(128,2,160,0,'ARAC start weapon: Troll Paladin - Two-Handed Maces'),
(256,1,160,0,'ARAC start weapon: Goblin Warrior - Two-Handed Maces'),
(256,2,160,0,'ARAC start weapon: Goblin Paladin - Two-Handed Maces'),
(256,4,46,0,'ARAC start weapon: Goblin Hunter - Guns'),
(256,8,173,0,'ARAC start weapon: Goblin Rogue - Daggers'),
(256,8,54,0,'ARAC start weapon: Goblin Rogue - Maces'),
(1024,8,173,0,'ARAC start weapon: Draenei Rogue - Daggers'),
(2048,2,160,0,'ARAC start weapon: Worgen Paladin - Two-Handed Maces'),
(2048,4,46,0,'ARAC start weapon: Worgen Hunter - Guns'),
(2048,8,44,0,'ARAC start weapon: Worgen Rogue - Axes'),
(2048,8,173,0,'ARAC start weapon: Worgen Rogue - Daggers'),
(4096,2,160,0,'ARAC start weapon: High Elf Paladin - Two-Handed Maces'),
(4096,4,45,0,'ARAC start weapon: High Elf Hunter - Bows'),
(4096,8,173,0,'ARAC start weapon: High Elf Rogue - Daggers'),
(8192,2,160,0,'ARAC start weapon: Maghar Paladin - Two-Handed Maces'),
(8192,4,45,0,'ARAC start weapon: Maghar Hunter - Bows'),
(8192,8,173,0,'ARAC start weapon: Maghar Rogue - Daggers'),
(8192,256,173,0,'ARAC start weapon: Maghar Warlock - Daggers'),
(16384,2,160,0,'ARAC start weapon: Ogre Paladin - Two-Handed Maces'),
(16384,4,45,0,'ARAC start weapon: Ogre Hunter - Bows'),
(16384,8,173,0,'ARAC start weapon: Ogre Rogue - Daggers'),
(16384,256,173,0,'ARAC start weapon: Ogre Warlock - Daggers'),
(32768,1,160,0,'ARAC start weapon: Dark Iron Warrior - Two-Handed Maces'),
(32768,4,46,0,'ARAC start weapon: Dark Iron Hunter - Guns'),
(32768,8,173,0,'ARAC start weapon: Dark Iron Rogue - Daggers');

REPLACE INTO `playercreateinfo_spell_custom`
(`racemask`,`classmask`,`Spell`,`Note`)
VALUES
-- Worgen
(2048,0,68975,'Worgen - Viciousness'),
(2048,0,68976,'Worgen - Aberration'),
(2048,0,68978,'Worgen - Flayer'),
(2048,0,68992,'Worgen - Darkflight'),
(2048,0,68996,'Worgen - Two Forms'),
-- Goblin
(256,0,69041,'Goblin - Rocket Barrage'),
(256,0,69042,'Goblin - Time is Money'),
(256,0,69044,'Goblin - Best Deals Anywhere'),
(256,0,69045,'Goblin - Better Living Through Chemistry'),
(256,0,69046,'Goblin - Pack Hobgoblin'),
(256,0,69070,'Goblin - Rocket Jump'),
-- Dark Iron (inherits Dwarf racials)
(32768,0,2481, 'Dark Iron - Find Treasure'),
(32768,0,20594,'Dark Iron - Stoneform'),
(32768,0,20595,'Dark Iron - Gun Specialization'),
(32768,0,20596,'Dark Iron - Frost Resistance'),
(32768,0,59224,'Dark Iron - Mace Specialization');

-- ---------------------------------------------------------------------------
-- 4) ARAC Shaman: totem display fallbacks for every race that has no native
--    WotLK entry. Native Orc/Dwarf/Tauren/Troll/Draenei rows are untouched.
-- ---------------------------------------------------------------------------
REPLACE INTO `player_totem_model` (`TotemID`,`RaceID`,`ModelID`) VALUES

(1,1,19074),
(2,1,19073),
(3,1,19075),
(4,1,19071),
(1,4,19074),
(2,4,19073),
(3,4,19075),
(4,4,19071),
(1,5,30758),
(2,5,30757),
(3,5,30759),
(4,5,30756),
(1,7,30754),
(2,7,30753),
(3,7,30755),
(4,7,30736),
(1,9,30758),
(2,9,30757),
(3,9,30759),
(4,9,30756),
(1,10,30758),
(2,10,30757),
(3,10,30759),
(4,10,30756),
(1,12,30754),
(2,12,30753),
(3,12,30755),
(4,12,30736),
(1,13,19074),
(2,13,19073),
(3,13,19075),
(4,13,19071),
(1,14,30758),
(2,14,30757),
(3,14,30759),
(4,14,30756),
(1,15,30758),
(2,15,30757),
(3,15,30759),
(4,15,30756),
(1,16,30754),
(2,16,30753),
(3,16,30755),
(4,16,30736);

-- ---------------------------------------------------------------------------
-- 5) ARAC Druid: model fallbacks for races without Blizzard WotLK rows.
--    CustomizationID 255 / GenderID 2 is AzerothCore's fallback key.
--    Worgen/Troll receive the custom Cat/Bear models already present in Patch-A.
-- ---------------------------------------------------------------------------
REPLACE INTO `player_shapeshift_model`
(`ShapeshiftID`,`RaceID`,`CustomizationID`,`GenderID`,`ModelID`) VALUES

(1,1,255,2,892),
(5,1,255,2,2281),
(8,1,255,2,2281),
(27,1,255,2,21243),
(29,1,255,2,20857),
(1,3,255,2,892),
(5,3,255,2,2281),
(8,3,255,2,2281),
(27,3,255,2,21243),
(29,3,255,2,20857),
(1,7,255,2,892),
(5,7,255,2,2281),
(8,7,255,2,2281),
(27,7,255,2,21243),
(29,7,255,2,20857),
(1,11,255,2,892),
(5,11,255,2,2281),
(8,11,255,2,2281),
(27,11,255,2,21243),
(29,11,255,2,20857),
(1,13,255,2,892),
(5,13,255,2,2281),
(8,13,255,2,2281),
(27,13,255,2,21243),
(29,13,255,2,20857),
(1,16,255,2,892),
(5,16,255,2,2281),
(8,16,255,2,2281),
(27,16,255,2,21243),
(29,16,255,2,20857),
(1,2,255,2,8571),
(5,2,255,2,2289),
(8,2,255,2,2289),
(27,2,255,2,21244),
(29,2,255,2,20872),
(1,5,255,2,8571),
(5,5,255,2,2289),
(8,5,255,2,2289),
(27,5,255,2,21244),
(29,5,255,2,20872),
(1,9,255,2,8571),
(5,9,255,2,2289),
(8,9,255,2,2289),
(27,9,255,2,21244),
(29,9,255,2,20872),
(1,10,255,2,8571),
(5,10,255,2,2289),
(8,10,255,2,2289),
(27,10,255,2,21244),
(29,10,255,2,20872),
(1,14,255,2,8571),
(5,14,255,2,2289),
(8,14,255,2,2289),
(27,14,255,2,21244),
(29,14,255,2,20872),
(1,15,255,2,8571),
(5,15,255,2,2289),
(8,15,255,2,2289),
(27,15,255,2,21244),
(29,15,255,2,20872),
(5,8,0,2,33655),
(8,8,0,2,33655),
(1,8,0,2,33665),
(5,8,1,2,33656),
(8,8,1,2,33656),
(1,8,1,2,33666),
(5,8,2,2,33657),
(8,8,2,2,33657),
(1,8,2,2,33667),
(5,8,3,2,33658),
(8,8,3,2,33658),
(1,8,3,2,33668),
(5,8,4,2,33659),
(8,8,4,2,33659),
(1,8,4,2,33669),
(5,8,255,2,33655),
(8,8,255,2,33655),
(1,8,255,2,33665),
(27,8,255,2,21244),
(29,8,255,2,37730),
(5,12,0,2,33650),
(8,12,0,2,33650),
(1,12,0,2,33660),
(5,12,1,2,33651),
(8,12,1,2,33651),
(1,12,1,2,33661),
(5,12,2,2,33652),
(8,12,2,2,33652),
(1,12,2,2,33662),
(5,12,3,2,33653),
(8,12,3,2,33653),
(1,12,3,2,33663),
(5,12,4,2,33654),
(8,12,4,2,33654),
(1,12,4,2,33664),
(5,12,255,2,33650),
(8,12,255,2,33650),
(1,12,255,2,33660),
(27,12,255,2,37727),
(29,12,255,2,37729);

-- ---------------------------------------------------------------------------
-- 6) ARAC action bars: add only generic CLASS buttons to combinations that
--    exist in playercreateinfo. Native/custom racial buttons are deliberately
--    not copied from a parent race here.
-- ---------------------------------------------------------------------------
DROP TEMPORARY TABLE IF EXISTS `tmp_arac_action_core`;
CREATE TEMPORARY TABLE `tmp_arac_action_core` (
  `class` TINYINT UNSIGNED NOT NULL,
  `button` TINYINT UNSIGNED NOT NULL,
  `action` INT UNSIGNED NOT NULL,
  `type` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`class`,`button`)
) ENGINE=MEMORY;

INSERT INTO `tmp_arac_action_core` (`class`,`button`,`action`,`type`) VALUES
-- Warrior
(1,72,6603,0),(1,73,78,0),(1,84,6603,0),(1,96,6603,0),
-- Paladin
(2,0,6603,0),(2,1,21084,0),(2,2,635,0),
-- Hunter
(3,0,6603,0),(3,1,2973,0),(3,2,75,0),
-- Rogue
(4,0,6603,0),(4,1,1752,0),(4,2,2098,0),(4,3,2764,0),
-- Priest
(5,0,585,0),(5,1,2050,0),
-- Death Knight
(6,0,6603,0),(6,1,49576,0),(6,2,45477,0),(6,3,45462,0),(6,4,45902,0),(6,5,47541,0),
-- Shaman
(7,0,6603,0),(7,1,403,0),(7,2,331,0),
-- Mage
(8,0,133,0),(8,1,168,0),
-- Warlock
(9,0,686,0),(9,1,687,0),
-- Druid
(11,0,5176,0),(11,1,5185,0),(11,72,6603,0),(11,96,6603,0);

INSERT IGNORE INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT pci.`race`, a.`class`, a.`button`, a.`action`, a.`type`
FROM `playercreateinfo` pci
JOIN `tmp_arac_action_core` a ON a.`class` = pci.`class`
WHERE pci.`race` BETWEEN 1 AND 16;

DROP TEMPORARY TABLE IF EXISTS `tmp_arac_action_core`;
