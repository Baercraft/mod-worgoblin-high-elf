-- CORELESS FIX4 - exact racial packages for races 13-16.
-- Existing player spellbooks are repaired safely on login by mod_coreless_compat.cpp.

SET @OGRE_MASK := 16384;

-- Old Ogre data incorrectly reused the Mag'har racials. Clear both the old
-- package and any partial Ogre-package rows, then use one all-classes package.
DELETE FROM `playercreateinfo_spell_custom`
WHERE (`racemask` & @OGRE_MASK) <> 0
  AND `Spell` IN (110001,110002,110003,110004,20549,20550,20573,20574);

INSERT IGNORE INTO `playercreateinfo_spell_custom` VALUES
(@OGRE_MASK, 0, 20549, 'Ogre - War Stomp'),
(@OGRE_MASK, 0, 20550, 'Ogre - Endurance'),
(@OGRE_MASK, 0, 20573, 'Ogre - Hardiness'),
(@OGRE_MASK, 0, 20574, 'Ogre - Command');

-- Race 17 is intentionally hidden/not released yet. FIX2 prematurely added
-- criteria-data rows for criteria that are not present in the shipped DBC.
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (19227,19228);
