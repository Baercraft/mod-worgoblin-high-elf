-- Custom race 13-16 full server inheritance for ACDB 335.16-dev
-- Parent policy:
-- High Elf (13): Blood Elf skills/languages, Alliance/Human reputation in Faction.dbc
-- Mag'har (14): Orc skills/languages/reputation
-- Ogre (15): Orc skills/languages/reputation + Ogre racial skill line
-- Dark Iron Dwarf (16): Dwarf skills/languages/reputation

SET @HIGH_ELF_MASK := 4096;
SET @MAGHAR_MASK := 8192;
SET @OGRE_MASK := 16384;
SET @DARKIRON_MASK := 32768;

-- Skills/languages: extend the exact parent rows. Idempotent bitwise update.
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @HIGH_ELF_MASK WHERE (`raceMask` & 512) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @MAGHAR_MASK WHERE (`raceMask` & 2) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @OGRE_MASK WHERE (`raceMask` & 2) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @DARKIRON_MASK WHERE (`raceMask` & 4) <> 0;

-- Explicit custom racial skill lines. Skill 793 belongs to Worgen forms/riding and MUST NOT be assigned to Ogre.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(@HIGH_ELF_MASK,0,791,0,'High Elf - Racial'),
(@MAGHAR_MASK,0,792,0,'Maghar Orc - Racial');

-- Explicit languages, in addition to parent inheritance.
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @HIGH_ELF_MASK WHERE `skill` IN (98,137);
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @MAGHAR_MASK WHERE `skill` = 109;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @OGRE_MASK WHERE `skill` = 109;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @DARKIRON_MASK WHERE `skill` IN (98,111);

-- Only replace racial entries for these custom races; leave class starter spells from other modules alone.
DELETE FROM `playercreateinfo_spell_custom`
WHERE `racemask` IN (@HIGH_ELF_MASK,@MAGHAR_MASK,@OGRE_MASK,@DARKIRON_MASK)
  AND `Spell` IN (110001,110002,110003,110004,110005,110006,110007,110008,110009,
                  20549,20550,20573,20575,20594,20595,20596,2481,59224);

-- classmask 0 = all classes in AC custom player-create-spell loader.
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
-- High Elf custom racials
(@HIGH_ELF_MASK,1503,110005,'High Elf - Quel dorei Meditation'),
(@HIGH_ELF_MASK,0,110006,'High Elf - Swiftness of the Rangers'),
(@HIGH_ELF_MASK,32,110007,'High Elf - Quel dorei Meditation (Death Knight)'),
(@HIGH_ELF_MASK,0,110008,'High Elf - Bow Specialization'),
(@HIGH_ELF_MASK,0,110009,'High Elf - Enchanting Specialization'),
-- Maghar custom racials
(@MAGHAR_MASK,0,110001,'Maghar - Ancestral Call'),
(@MAGHAR_MASK,0,110002,'Maghar - Savage Blood'),
(@MAGHAR_MASK,0,110003,'Maghar - Sympathetic Vigor'),
(@MAGHAR_MASK,0,110004,'Maghar - Unwavering Will'),
-- Ogre: stable WotLK racials matching the intended strong/tough theme
(@OGRE_MASK,0,20549,'Ogre - War Stomp'),
(@OGRE_MASK,0,20550,'Ogre - Endurance'),
(@OGRE_MASK,0,20573,'Ogre - Hardiness'),
(@OGRE_MASK,0,20575,'Ogre - Command'),
-- Dark Iron: stable dwarf racial baseline until bespoke Fireblood spells are authored
(@DARKIRON_MASK,0,20594,'Dark Iron - Stoneform'),
(@DARKIRON_MASK,0,20595,'Dark Iron - Gun Specialization'),
(@DARKIRON_MASK,0,20596,'Dark Iron - Frost Resistance'),
(@DARKIRON_MASK,0,2481,'Dark Iron - Find Treasure'),
(@DARKIRON_MASK,0,59224,'Dark Iron - Mace Specialization');

-- Two Forms is owned by the C++ PlayerScript, not a stale SpellScript binding.
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_two_forms';

-- Spells 68994/110020 use native SPELL_AURA_TRANSFORM from Spell.dbc.
-- No custom AuraScript binding is required.
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_costume_override';
