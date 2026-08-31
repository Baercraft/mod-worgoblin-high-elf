-- Baercraft 6.2.4 - Ogre Race 15 world-side normalization
-- AzerothCore Playerbot branch 2026-05 schema: playercreateinfo_spell_custom uses racemask/classmask.
SET @OGRE_MASK := 16384;
SET @ORC_MASK := 2;

-- Orcish language and Ogre racial skill line.
UPDATE `playercreateinfo_skills` SET `racemask`=`racemask`|@OGRE_MASK WHERE `skill`=109 AND (`racemask` & @ORC_MASK);
DELETE FROM `playercreateinfo_skills` WHERE `raceMask`=@OGRE_MASK AND `classMask`=0 AND `skill`=793;
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(@OGRE_MASK,0,793,0,'Ogre - Racial');

-- Orcish language spell and Ogre racials.
DELETE FROM `playercreateinfo_spell_custom` WHERE `racemask`=@OGRE_MASK AND `Spell` IN (669,110100,110101,110102,110103);
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
(@OGRE_MASK,0,669,'Ogre - Language Orcish'),
(@OGRE_MASK,0,110100,'Ogre - Ogre''s Might'),
(@OGRE_MASK,0,110101,'Ogre - Thick Hide'),
(@OGRE_MASK,0,110102,'Ogre - Clan Bond'),
(@OGRE_MASK,0,110103,'Ogre - Stubborn as Stone');

-- Any quest available to Orcs is also available to Ogres.
UPDATE `quest_template` SET `AllowableRaces`=`AllowableRaces`|@OGRE_MASK WHERE (`AllowableRaces` & @ORC_MASK)<>0;
