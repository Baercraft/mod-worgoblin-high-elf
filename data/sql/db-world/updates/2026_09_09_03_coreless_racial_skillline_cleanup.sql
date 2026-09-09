-- CORELESS FINAL FIX6 - custom racial SkillLine cleanup
-- Safe/idempotent. Apply to WORLD DB.

SET @HE := 4096;
SET @MH := 8192;
SET @OG := 16384;
SET @DI := 32768;

-- Remove stale/wrong synthetic mappings left by older revisions.
DELETE FROM `playercreateinfo_skills`
WHERE (`raceMask` & (@HE | @MH | @OG | @DI)) <> 0
  AND `skill` IN (795);

-- Rebuild the four custom racial SkillLines deterministically.
DELETE FROM `playercreateinfo_skills`
WHERE (`raceMask` & (@HE | @MH | @OG | @DI)) <> 0
  AND `skill` IN (791,792,793,794);

INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(@HE,0,791,0,'High Elf - Racial'),
(@MH,0,792,0,'Maghar Orc - Racial'),
(@OG,0,793,0,'Ogre - Racial'),
(@DI,0,794,0,'Dark Iron Dwarf - Racial');
