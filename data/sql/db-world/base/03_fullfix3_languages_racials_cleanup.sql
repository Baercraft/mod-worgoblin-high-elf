-- FULLFIX3 runtime migration for already existing installations (ACDB 335.16-dev)
-- Safe to run once through the AzerothCore module updater.

SET @HIGH_ELF_MASK := 4096;
SET @MAGHAR_MASK := 8192;
SET @OGRE_MASK := 16384;
SET @DARKIRON_MASK := 32768;

-- Parent skills and languages. Re-run inheritance under a new update filename so older installs receive it too.
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @HIGH_ELF_MASK WHERE (`raceMask` & 512) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @MAGHAR_MASK WHERE (`raceMask` & 2) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @OGRE_MASK WHERE (`raceMask` & 2) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @DARKIRON_MASK WHERE (`raceMask` & 4) <> 0;

-- Explicit language coverage.
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @HIGH_ELF_MASK WHERE `skill` IN (98,137); -- Common + Thalassian
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @MAGHAR_MASK WHERE `skill` = 109;       -- Orcish
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @OGRE_MASK WHERE `skill` = 109;         -- Orcish
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @DARKIRON_MASK WHERE `skill` IN (98,111); -- Common + Dwarven

-- Skill 793 is Worgen Forms/Running Wild, not an Ogre racial line.
DELETE FROM `playercreateinfo_skills` WHERE `skill` = 793 AND `raceMask` = @OGRE_MASK;
UPDATE `playercreateinfo_skills`
   SET `raceMask` = `raceMask` & ~@OGRE_MASK
 WHERE `skill` = 793 AND (`raceMask` & @OGRE_MASK) <> 0;
DELETE FROM `playercreateinfo_skills` WHERE `raceMask` = 0;

-- Remove the invalid synthetic Dark Iron skill line from older builds.
DELETE FROM `playercreateinfo_skills` WHERE `skill` = 794;

-- Rebuild only our custom-race racial starter spells.
DELETE FROM `playercreateinfo_spell_custom`
WHERE (`racemask` & (@HIGH_ELF_MASK | @MAGHAR_MASK | @OGRE_MASK | @DARKIRON_MASK)) <> 0
  AND `Spell` IN (110001,110002,110003,110004,110005,110006,110007,110008,110009,
                  20549,20550,20573,20575,20594,20595,20596,2481,59224);

INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
-- High Elf: normal Meditation for all non-DK classes, runic variant for Death Knight only.
(@HIGH_ELF_MASK,1503,110005,'High Elf - Quel dorei Meditation'),
(@HIGH_ELF_MASK,0,110006,'High Elf - Swiftness of the Rangers'),
(@HIGH_ELF_MASK,32,110007,'High Elf - Quel dorei Meditation (Death Knight)'),
(@HIGH_ELF_MASK,0,110008,'High Elf - Bow Specialization'),
(@HIGH_ELF_MASK,0,110009,'High Elf - Enchanting Specialization'),
-- Maghar
(@MAGHAR_MASK,0,110001,'Maghar - Ancestral Call'),
(@MAGHAR_MASK,0,110002,'Maghar - Savage Blood'),
(@MAGHAR_MASK,0,110003,'Maghar - Sympathetic Vigor'),
(@MAGHAR_MASK,0,110004,'Maghar - Unwavering Will'),
-- Ogre
(@OGRE_MASK,0,20549,'Ogre - War Stomp'),
(@OGRE_MASK,0,20550,'Ogre - Endurance'),
(@OGRE_MASK,0,20573,'Ogre - Hardiness'),
(@OGRE_MASK,0,20575,'Ogre - Command'),
-- Dark Iron Dwarf
(@DARKIRON_MASK,0,20594,'Dark Iron - Stoneform'),
(@DARKIRON_MASK,0,20595,'Dark Iron - Gun Specialization'),
(@DARKIRON_MASK,0,20596,'Dark Iron - Frost Resistance'),
(@DARKIRON_MASK,0,2481,'Dark Iron - Find Treasure'),
(@DARKIRON_MASK,0,59224,'Dark Iron - Mace Specialization');

-- Obsolete spell-script bindings: Two Forms is handled by PlayerScript; costume spells use native TRANSFORM.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_two_forms','spell_costume_override');

-- Old optional Open Azeroth data referenced zones not present in the WotLK AreaTable used by this package.
DELETE FROM `graveyard_zone` WHERE `GhostZone` IN (4714,4720,4737,4755);

-- Old optional achievement rows fail ACDB 335.16-dev validation and are unrelated to custom races.
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (13484,13485,13498,13499) AND `type` = 110;
