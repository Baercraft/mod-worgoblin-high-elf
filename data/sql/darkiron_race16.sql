-- Dark Iron Dwarf race 16
DELETE FROM `player_race_stats` WHERE `Race`=16;
INSERT INTO `player_race_stats` (`Race`,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit`) SELECT 16,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit` FROM `player_race_stats` WHERE `Race`=3 LIMIT 1;
DELETE FROM `playercreateinfo` WHERE `race`=16;
INSERT INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`) SELECT 16,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation` FROM `playercreateinfo` WHERE `race`=3;
DELETE FROM `playercreateinfo_action` WHERE `race`=16;
INSERT INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`) SELECT 16,`class`,`button`,`action`,`type` FROM `playercreateinfo_action` WHERE `race`=3;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | 32768 WHERE (`raceMask` & 4) <> 0;
