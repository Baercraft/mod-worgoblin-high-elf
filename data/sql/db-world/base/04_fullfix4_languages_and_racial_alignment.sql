-- FULLFIX4: make custom-race languages functional and keep racial assignments aligned.
-- ACDB 335.16-dev compatible. New filename ensures existing installations receive it.

SET @HIGH_ELF_MASK := 4096;
SET @MAGHAR_MASK := 8192;
SET @OGRE_MASK := 16384;
SET @DARKIRON_MASK := 32768;
SET @CUSTOM_MASK := @HIGH_ELF_MASK | @MAGHAR_MASK | @OGRE_MASK | @DARKIRON_MASK;

-- Language skill lines (server-side skill ownership).
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @HIGH_ELF_MASK WHERE `skill` IN (98,137);
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @MAGHAR_MASK WHERE `skill` = 109;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @OGRE_MASK WHERE `skill` = 109;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @DARKIRON_MASK WHERE `skill` IN (98,111);

-- Language spells are required in addition to the skill line. This is what the
-- stock Blizzard races receive and what the custom races were missing.
DELETE FROM `playercreateinfo_spell_custom`
 WHERE (`racemask` & @CUSTOM_MASK) <> 0 AND `Spell` IN (668,669,672,813);

INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
(@HIGH_ELF_MASK,0,668,'High Elf - Language Common'),
(@HIGH_ELF_MASK,0,813,'High Elf - Language Thalassian'),
(@MAGHAR_MASK,0,669,'Maghar - Language Orcish'),
(@OGRE_MASK,0,669,'Ogre - Language Orcish'),
(@DARKIRON_MASK,0,668,'Dark Iron - Language Common'),
(@DARKIRON_MASK,0,672,'Dark Iron - Language Dwarven');
