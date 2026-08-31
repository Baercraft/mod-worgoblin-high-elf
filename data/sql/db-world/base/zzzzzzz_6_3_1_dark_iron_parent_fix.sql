-- Baercraft 6.3.1 - Dark Iron Dwarf (Race 16) parent normalization
-- Target schema: AzerothCore Playerbot branch around 2026-05-22.
-- Dark Iron Dwarf inherits Dwarf gameplay data and adds its own racial skill line.
SET @DARK_IRON_MASK := 32768;
SET @DWARF_MASK := 4;

-- Base racial stats: copy normal Dwarf exactly.
DELETE FROM `player_race_stats` WHERE `Race`=16;
INSERT INTO `player_race_stats` (`Race`,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit`)
SELECT 16,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit`
FROM `player_race_stats` WHERE `Race`=3 LIMIT 1;

-- Start positions/classes: copy every Dwarf row. This preserves optional ARAC rows when present,
-- while the STANDARD client CharBaseInfo.dbc still greys unsupported combinations.
DELETE FROM `playercreateinfo` WHERE `race`=16;
INSERT IGNORE INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT 16,src.`class`,src.`map`,src.`zone`,src.`position_x`,src.`position_y`,src.`position_z`,src.`orientation`
FROM `playercreateinfo` src WHERE src.`race`=3;

-- Starting action bars: same buttons as a Dwarf of the same class.
DELETE FROM `playercreateinfo_action` WHERE `race`=16;
INSERT IGNORE INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT 16,src.`class`,src.`button`,src.`action`,src.`type`
FROM `playercreateinfo_action` src WHERE src.`race`=3;

-- Skills/languages: every Dwarf skill mask also applies to Dark Iron.
UPDATE `playercreateinfo_skills`
SET `racemask`=`racemask`|@DARK_IRON_MASK
WHERE (`racemask` & @DWARF_MASK)<>0;

-- Own racial skill category, visible in the Skills pane when supported by the client DBC.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
VALUES (@DARK_IRON_MASK,0,795,0,'Dark Iron Dwarf - Racial');

-- Guarantee Common + Dwarven and the stable WotLK mechanics used as Dark Iron racials.
DELETE FROM `playercreateinfo_spell_custom`
WHERE `racemask`=@DARK_IRON_MASK AND `Spell` IN (668,672,20594,20595,24445,2481);
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
(@DARK_IRON_MASK,0,668,'Dark Iron Dwarf - Language Common'),
(@DARK_IRON_MASK,0,672,'Dark Iron Dwarf - Language Dwarven'),
(@DARK_IRON_MASK,0,20594,'Dark Iron Dwarf - Fireblood'),
(@DARK_IRON_MASK,0,20595,'Dark Iron Dwarf - Black Anvil Training'),
(@DARK_IRON_MASK,0,24445,'Dark Iron Dwarf - Forged in Flame'),
(@DARK_IRON_MASK,0,2481,'Dark Iron Dwarf - Secrets Below');

-- Every quest available to Dwarves is also available to Dark Iron Dwarves.
UPDATE `quest_template`
SET `AllowableRaces`=`AllowableRaces`|@DARK_IRON_MASK
WHERE (`AllowableRaces` & @DWARF_MASK)<>0 AND `AllowableRaces`<>-1;
