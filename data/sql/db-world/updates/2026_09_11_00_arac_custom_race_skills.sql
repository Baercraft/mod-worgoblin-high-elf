-- ARAC/custom-race defaults for playable races 13-16.
-- Fixes missing language SkillLines and makes sure the standard class armor
-- SkillLines are present for every race, including ARAC combinations.
-- Existing characters are repaired on login by mod_coreless_compat.cpp via
-- Player::LearnDefaultSkills() / Player::LearnCustomSpells().

SET @RACE_HIGH_ELF := 4096;       -- race 13
SET @RACE_MAGHAR   := 8192;       -- race 14
SET @RACE_OGRE     := 16384;      -- race 15
SET @RACE_DARKIRON := 32768;      -- race 16

-- Language SkillLines.  The stock AzerothCore rows only cover Blizzard races,
-- so custom races need their own race-mask rows.
INSERT IGNORE INTO `playercreateinfo_skills`
    (`raceMask`, `classMask`, `skill`, `rank`, `comment`)
VALUES
    (@RACE_HIGH_ELF, 0, 98,  0, 'High Elf - Language: Common'),
    (@RACE_HIGH_ELF, 0, 137, 0, 'High Elf - Language: Thalassian'),
    (@RACE_MAGHAR,   0, 109, 0, 'Maghar Orc - Language: Orcish'),
    (@RACE_OGRE,     0, 109, 0, 'Ogre - Language: Orcish'),
    (@RACE_DARKIRON, 0, 98,  0, 'Dark Iron Dwarf - Language: Common'),
    (@RACE_DARKIRON, 0, 111, 0, 'Dark Iron Dwarf - Language: Dwarven');

-- Matching language spells.  Keeping these explicit avoids depending on a
-- particular SkillLineAbility loading path for custom race masks.
INSERT IGNORE INTO `playercreateinfo_spell_custom`
    (`racemask`, `classmask`, `Spell`, `Note`)
VALUES
    (@RACE_HIGH_ELF, 0, 668,  'High Elf - Common'),
    (@RACE_HIGH_ELF, 0, 813,  'High Elf - Thalassian'),
    (@RACE_MAGHAR,   0, 669,  'Maghar Orc - Orcish'),
    (@RACE_OGRE,     0, 669,  'Ogre - Orcish'),
    (@RACE_DARKIRON, 0, 668,  'Dark Iron Dwarf - Common'),
    (@RACE_DARKIRON, 0, 672,  'Dark Iron Dwarf - Dwarven');

-- Baseline armor SkillLines used by AzerothCore.  raceMask=0 deliberately
-- means every race, which is what ARAC needs. INSERT IGNORE makes this safe on
-- databases where the stock rows already exist.
INSERT IGNORE INTO `playercreateinfo_skills`
    (`raceMask`, `classMask`, `skill`, `rank`, `comment`)
VALUES
    (0, 0,    415, 0, 'Cloth'),
    (0, 1135, 414, 0, 'Leather'),
    (0, 35,   413, 0, 'Mail'),
    (0, 32,   293, 0, 'Plate'),
    (0, 67,   433, 0, 'Shield');
