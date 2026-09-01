-- Baercraft 6.2.5 emergency normalization for High Elf (13) and Ogre (15)
-- Target: AzerothCore Playerbot branch schema used by 2026-05-22 build.
SET @HIGH_ELF_MASK := 4096;
SET @OGRE_MASK := 16384;
SET @ORC_MASK := 2;

-- Ensure race stat rows exist. Ogre uses Orc as gameplay parent; High Elf uses Night Elf-like Alliance baseline.
DELETE FROM `player_race_stats` WHERE `Race`=15;
INSERT INTO `player_race_stats` (`Race`,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit`)
SELECT 15,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit` FROM `player_race_stats` WHERE `Race`=2 LIMIT 1;

INSERT INTO `player_race_stats` (`Race`,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit`)
SELECT 13,`Strength`,`Agility`,`Stamina`,`Intellect`,`Spirit` FROM `player_race_stats` src
WHERE src.`Race`=4 AND NOT EXISTS (SELECT 1 FROM `player_race_stats` x WHERE x.`Race`=13) LIMIT 1;

-- Ensure valid playercreateinfo rows exist for the supported Ogre classes by cloning Orc coordinates.
DELETE FROM `playercreateinfo` WHERE `race`=15 AND `class` NOT IN (1,3,7,8,9);
INSERT IGNORE INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT 15,src.`class`,src.`map`,src.`zone`,src.`position_x`,src.`position_y`,src.`position_z`,src.`orientation`
FROM `playercreateinfo` src WHERE src.`race`=2 AND src.`class` IN (1,3,7,8,9);

-- Clone every Orc starting skill to Ogre via the RaceMask. This includes Orcish and weapon/class skills.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
SELECT @OGRE_MASK, `classMask`, `skill`, `rank`, CONCAT('Ogre parent: ', COALESCE(`comment`,''))
FROM `playercreateinfo_skills`
WHERE (`raceMask` & @ORC_MASK)<>0;

-- Explicit Ogre racial skill line. Avoid deleting any inherited skills.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
VALUES (@OGRE_MASK,0,793,0,'Ogre - Racial');

-- Guarantee High Elf languages in starting skills.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
SELECT @HIGH_ELF_MASK, `classMask`, `skill`, `rank`, CONCAT('High Elf parent: ', COALESCE(`comment`,''))
FROM `playercreateinfo_skills`
WHERE `skill` IN (98,137);

-- Guarantee language spells + Ogre racials for every valid class (classmask 0 = all classes in this AC loader).
DELETE FROM `playercreateinfo_spell_custom`
WHERE `racemask` IN (@HIGH_ELF_MASK,@OGRE_MASK) AND `Spell` IN (668,669,813,110100,110101,110102,110103);
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
(@HIGH_ELF_MASK,0,668,'High Elf - Language Common'),
(@HIGH_ELF_MASK,0,813,'High Elf - Language Thalassian'),
(@OGRE_MASK,0,669,'Ogre - Language Orcish'),
(@OGRE_MASK,0,110100,'Ogre - Ogre''s Might'),
(@OGRE_MASK,0,110101,'Ogre - Thick Hide'),
(@OGRE_MASK,0,110102,'Ogre - Clan Bond'),
(@OGRE_MASK,0,110103,'Ogre - Stubborn as Stone');

-- Orc quests are valid for Ogre.
UPDATE `quest_template` SET `AllowableRaces`=`AllowableRaces`|@OGRE_MASK
WHERE (`AllowableRaces` & @ORC_MASK)<>0 AND `AllowableRaces`<>-1;
