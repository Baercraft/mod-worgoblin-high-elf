-- CORELESS FINAL FIX5 - parent-race quest eligibility + Worgen Two Forms
-- Safe/idempotent. Apply to WORLD DB; AzerothCore auto-updater will run it once.

SET @GOBLIN_MASK := 256;
SET @WORGEN_MASK := 2048;
SET @HIGH_ELF_MASK := 4096;
SET @MAGHAR_MASK := 8192;
SET @OGRE_MASK := 16384;
SET @DARK_IRON_MASK := 32768;

-- Parent-race quest inheritance. This makes Kaltunk/Sten Stoutarm and the
-- normal Human/Orc/Dwarf starting chains recognize the custom races.
-- AllowableRaces=0 already means unrestricted and is intentionally untouched.
UPDATE `quest_template`
SET `AllowableRaces` = `AllowableRaces` | @GOBLIN_MASK | @MAGHAR_MASK | @OGRE_MASK
WHERE `AllowableRaces` > 0 AND (`AllowableRaces` & 2) <> 0;

UPDATE `quest_template`
SET `AllowableRaces` = `AllowableRaces` | @WORGEN_MASK | @HIGH_ELF_MASK
WHERE `AllowableRaces` > 0 AND (`AllowableRaces` & 1) <> 0;

UPDATE `quest_template`
SET `AllowableRaces` = `AllowableRaces` | @DARK_IRON_MASK
WHERE `AllowableRaces` > 0 AND (`AllowableRaces` & 4) <> 0;

-- Ensure Worgen know Two Forms on new characters. The Lua login hook below
-- also repairs existing Worgen characters that are missing the spell.
DELETE FROM `playercreateinfo_spell_custom`
WHERE (`racemask` & @WORGEN_MASK) <> 0 AND `Spell` = 68996;

INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
(@WORGEN_MASK, 0, 68996, 'Worgen - Two Forms');
