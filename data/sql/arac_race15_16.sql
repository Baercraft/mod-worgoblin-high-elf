-- ARAC support for custom race slots 15 (Ogre) and 16 (Dark Iron Dwarf).
-- Run AFTER the normal ARAC SQL and AFTER the base Ogre/Dark-Iron SQL.
SET @OgreRace := 15;
SET @DarkIronRace := 16;
SET @OgreMask := 16384;
SET @DarkIronMask := 32768;

-- Clone every ARAC-enabled Orc combination to Ogre.
DELETE FROM `playercreateinfo` WHERE `race`=@OgreRace;
INSERT INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT @OgreRace,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation` FROM `playercreateinfo` WHERE `race`=2;
DELETE FROM `playercreateinfo_action` WHERE `race`=@OgreRace;
INSERT INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT @OgreRace,`class`,`button`,`action`,`type` FROM `playercreateinfo_action` WHERE `race`=2;

-- Clone every ARAC-enabled Dwarf combination to Dark Iron Dwarf.
DELETE FROM `playercreateinfo` WHERE `race`=@DarkIronRace;
INSERT INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT @DarkIronRace,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation` FROM `playercreateinfo` WHERE `race`=3;
DELETE FROM `playercreateinfo_action` WHERE `race`=@DarkIronRace;
INSERT INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT @DarkIronRace,`class`,`button`,`action`,`type` FROM `playercreateinfo_action` WHERE `race`=3;

-- Inherit weapon/language/profession skill availability from their parent races.
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @OgreMask WHERE (`raceMask` & 2) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @DarkIronMask WHERE (`raceMask` & 4) <> 0;
