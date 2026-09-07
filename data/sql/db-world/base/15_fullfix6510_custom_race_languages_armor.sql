-- FULLFIX 6.5.10 - explicit custom-race baseline/class SkillLines
-- Additive only. This avoids relying on raceMask=0 initialization for races 13-16.
SET @HE := 4096;
SET @MH := 8192;
SET @OG := 16384;
SET @DI := 32768;

-- Baseline cloth for every custom race/class.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(@HE,0,415,0,'High Elf - Cloth'),(@MH,0,415,0,'Maghar - Cloth'),(@OG,0,415,0,'Ogre - Cloth'),(@DI,0,415,0,'Dark Iron - Cloth'),
-- Leather: Warrior, Paladin, Hunter, Rogue, DK, Shaman, Druid
(@HE,1135,414,0,'High Elf - Leather'),(@MH,1135,414,0,'Maghar - Leather'),(@OG,1135,414,0,'Ogre - Leather'),(@DI,1135,414,0,'Dark Iron - Leather'),
-- Mail at creation for the canonical class mask
(@HE,35,413,0,'High Elf - Mail'),(@MH,35,413,0,'Maghar - Mail'),(@OG,35,413,0,'Ogre - Mail'),(@DI,35,413,0,'Dark Iron - Mail'),
-- Plate for Death Knight
(@HE,32,293,0,'High Elf - Plate'),(@MH,32,293,0,'Maghar - Plate'),(@OG,32,293,0,'Ogre - Plate'),(@DI,32,293,0,'Dark Iron - Plate'),
-- Shield: Warrior, Paladin, Shaman
(@HE,67,433,0,'High Elf - Shield'),(@MH,67,433,0,'Maghar - Shield'),(@OG,67,433,0,'Ogre - Shield'),(@DI,67,433,0,'Dark Iron - Shield'),
-- Languages (explicit custom rows)
(@HE,0,98,0,'High Elf - Language Common'),(@HE,0,137,0,'High Elf - Language Thalassian'),
(@MH,0,109,0,'Maghar Orc - Language Orcish'),(@OG,0,109,0,'Ogre - Language Orcish'),
(@DI,0,98,0,'Dark Iron - Language Common'),(@DI,0,111,0,'Dark Iron - Language Dwarven');
