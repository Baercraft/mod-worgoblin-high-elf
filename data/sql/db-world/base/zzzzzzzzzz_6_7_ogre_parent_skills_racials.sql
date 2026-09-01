-- Baercraft 6.6.1 - Ogre final normalization
-- Race 15 is an Orc gameplay child but retains its own Ogre racial skill line 793.
SET @OGRE_MASK := 16384;
SET @ORC_MASK := 2;

-- Clone every Orc starting skill for Ogre (weapons, armor, language and class-related skills).
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
SELECT @OGRE_MASK, src.`classMask`, src.`skill`, src.`rank`, CONCAT('Ogre parent: ', COALESCE(src.`comment`,''))
FROM `playercreateinfo_skills` src
WHERE (src.`raceMask` & @ORC_MASK) <> 0;

-- Keep Ogre's own racial category visible.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
VALUES (@OGRE_MASK,0,793,0,'Ogre - Racial');

-- Language and Ogre racials for all supported classes.
DELETE FROM `playercreateinfo_spell_custom`
WHERE `racemask`=@OGRE_MASK AND `Spell` IN (669,110100,110101,110102,110103);
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
(@OGRE_MASK,0,669,'Ogre - Language Orcish'),
(@OGRE_MASK,0,110100,'Ogre - Ogre''s Might'),
(@OGRE_MASK,0,110101,'Ogre - Thick Hide'),
(@OGRE_MASK,0,110102,'Ogre - Clan Bond'),
(@OGRE_MASK,0,110103,'Ogre - Stubborn as Stone');

-- Orc quests remain valid for Ogre.
UPDATE `quest_template` SET `AllowableRaces`=`AllowableRaces`|@OGRE_MASK
WHERE (`AllowableRaces` & @ORC_MASK)<>0 AND `AllowableRaces`<>-1;
