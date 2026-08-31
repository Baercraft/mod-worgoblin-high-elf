-- Baercraft 6.1 Ogre TEST4 - Race 15 finalizer
-- Official Medviten v1.0.3 Ogre client assets + Orc gameplay parent.
SET @OGRE_MASK := 16384;
SET @ORC_MASK := 2;

INSERT IGNORE INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(15,1,1,14,-618.518,-4251.67,38.718,0),
(15,3,1,14,-618.518,-4251.67,38.718,0),
(15,7,1,14,-618.518,-4251.67,38.718,0),
(15,8,1,14,-618.518,-4215.67,38.718,0),
(15,9,1,14,-618.518,-4251.67,38.718,0);

-- Orcish and Ogre racial skill line.
UPDATE `playercreateinfo_skills` SET `racemask`=`racemask`|@OGRE_MASK WHERE `skill`=109;
DELETE FROM `playercreateinfo_skills` WHERE `raceMask`=@OGRE_MASK AND `classMask`=0;
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(@OGRE_MASK,0,793,0,'Ogre - Racial');

-- Ogre start spells, languages and racial spells are normalized by zzzz_custom_race_spellmask_test5_fix.sql.

-- Orc quests are valid for Ogre as the gameplay parent race.
UPDATE `quest_template`
SET `AllowableRaces`=`AllowableRaces`|@OGRE_MASK
WHERE (`AllowableRaces` & @ORC_MASK)<>0
  AND `AllowableRaces` NOT IN (-1,2147483647,2047,4095,8191,16383,32767,65535,131071,262143,524287,1048575,2097151);
UPDATE `quest_template` SET `AllowableRaces`=@ORC_MASK|@OGRE_MASK WHERE `ID`=12748;
