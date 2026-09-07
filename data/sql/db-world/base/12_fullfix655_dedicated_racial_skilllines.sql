-- FULLFIX 6.5.5 - dedicated racial SkillLines for Ogre and Dark Iron Dwarf
-- Safe incremental WORLD DB patch on top of 6.5.4.
-- 793 stays Worgen Forms, 794 = Ogre Racial, 795 = Dark Iron Dwarf Racial.

SET @OG := 16384;
SET @DI := 32768;

-- Do not let Ogre or Dark Iron inherit native racial SkillLines.
DELETE FROM `playercreateinfo_skills` WHERE `raceMask`=@OG AND `skill` IN (125,793);
DELETE FROM `playercreateinfo_skills` WHERE `raceMask`=@DI AND `skill`=101;

-- Dedicated custom racial lines.
DELETE FROM `playercreateinfo_skills` WHERE `raceMask`=@OG AND `skill`=794;
DELETE FROM `playercreateinfo_skills` WHERE `raceMask`=@DI AND `skill`=795;
INSERT INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(@OG,0,794,0,'Ogre - Racial'),
(@DI,0,795,0,'Dark Iron Dwarf - Racial');

-- Language starter rows remain normal SkillLines.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(@OG,0,109,0,'Ogre - Language Orcish'),
(@DI,0,98,0,'Dark Iron - Language Common'),
(@DI,0,111,0,'Dark Iron - Language Dwarven');
