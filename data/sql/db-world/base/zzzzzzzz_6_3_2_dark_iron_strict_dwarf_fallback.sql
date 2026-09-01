-- Baercraft master update - Dark Iron Dwarf strict Dwarf fallback
-- Race 16 is visually Dark Iron, but gameplay data follows Dwarf (race 3).
SET @DI_RACE := 16;
SET @DI_MASK := 32768;
SET @DWARF_RACE := 3;
SET @DWARF_MASK := 4;

DELETE FROM `player_race_stats` WHERE `Race`=@DI_RACE;
INSERT INTO `player_race_stats` (`Race`,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit`)
SELECT @DI_RACE,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit`
FROM `player_race_stats` WHERE `Race`=@DWARF_RACE LIMIT 1;

DELETE FROM `playercreateinfo` WHERE `race`=@DI_RACE;
INSERT IGNORE INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT @DI_RACE,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`
FROM `playercreateinfo` WHERE `race`=@DWARF_RACE;

DELETE FROM `playercreateinfo_action` WHERE `race`=@DI_RACE;
INSERT IGNORE INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT @DI_RACE,`class`,`button`,`action`,`type` FROM `playercreateinfo_action` WHERE `race`=@DWARF_RACE;

-- Remove prior Dark-Iron-only experimental skills/spells, then clone Dwarf parent rows.
DELETE FROM `playercreateinfo_skills` WHERE `raceMask`=@DI_MASK;
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
SELECT @DI_MASK,`classMask`,`skill`,`rank`,CONCAT('Dark Iron parent Dwarf: ',COALESCE(`comment`,''))
FROM `playercreateinfo_skills` WHERE (`raceMask` & @DWARF_MASK)<>0;

DELETE FROM `playercreateinfo_spell_custom` WHERE `racemask`=@DI_MASK;
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`)
SELECT @DI_MASK,`classmask`,`Spell`,CONCAT('Dark Iron parent Dwarf: ',COALESCE(`Note`,''))
FROM `playercreateinfo_spell_custom` WHERE (`racemask` & @DWARF_MASK)<>0;

UPDATE `quest_template` SET `AllowableRaces`=`AllowableRaces`|@DI_MASK
WHERE (`AllowableRaces` & @DWARF_MASK)<>0 AND `AllowableRaces`<>-1;
