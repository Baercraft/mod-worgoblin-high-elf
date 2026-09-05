-- Dark Iron Dwarf race 16 - world DB integration
-- Requires modpaks/config.sql variables.
DELETE FROM `player_race_stats` WHERE `Race`=@DarkIronDwarf;
INSERT INTO `player_race_stats` (`Race`,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit`) SELECT @DarkIronDwarf,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit` FROM `player_race_stats` WHERE `Race`=@Dwarf LIMIT 1;
DELETE FROM `playercreateinfo` WHERE `race`=@DarkIronDwarf;
INSERT INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`) SELECT @DarkIronDwarf,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation` FROM `playercreateinfo` WHERE `race`=@Dwarf;
DELETE FROM `playercreateinfo_action` WHERE `race`=@DarkIronDwarf;
INSERT INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`) SELECT @DarkIronDwarf,`class`,`button`,`action`,`type` FROM `playercreateinfo_action` WHERE `race`=@Dwarf;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @DarkIronDwarfMask WHERE (`raceMask` & @DwarfMask) <> 0;
UPDATE `playercreateinfo_spell_custom` SET `racemask`=`racemask` | @DarkIronDwarfMask WHERE (`racemask` & @DwarfMask) <> 0;
