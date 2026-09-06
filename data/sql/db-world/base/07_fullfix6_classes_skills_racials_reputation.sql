-- FULLFIX6: final runtime repair for custom races 13-16.
-- Race masks: High Elf 4096, Maghar 8192, Ogre 16384, Dark Iron 32768.
SET @HE := 4096; SET @MH := 8192; SET @OG := 16384; SET @DI := 32768;

-- 1) Class/weapon/armor/language SkillLines: inherit the complete parent skill masks.
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @HE WHERE (`raceMask` & 512) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @MH | @OG WHERE (`raceMask` & 2) <> 0;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` | @DI WHERE (`raceMask` & 4) <> 0;
DELETE FROM `playercreateinfo_skills` WHERE `skill`=794;
UPDATE `playercreateinfo_skills` SET `raceMask`=`raceMask` & ~@OG WHERE `skill`=793 AND (`raceMask` & @OG) <> 0;
DELETE FROM `playercreateinfo_skills` WHERE `raceMask`=0;

-- 2) Rebuild ALL class starter spells for races 13-16 from a native donor that really supports that class.
-- Keep racial spells out; the exact custom-race racials are inserted below.
DELETE FROM `playercreateinfo_spell_custom` WHERE (`racemask` & (@HE|@MH|@OG|@DI)) <> 0;

-- Alliance custom races: class donors Human(1), Dwarf(3), Draenei(11), NightElf(4).
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`)
SELECT r.mask, s.classmask, s.Spell, CONCAT('FULLFIX6 class donor: ',COALESCE(s.Note,''))
FROM `playercreateinfo_spell_custom` s
CROSS JOIN (SELECT @HE mask UNION ALL SELECT @DI) r
WHERE ((s.racemask & 1)<>0 AND s.classmask IN (1,2,8,16,32,64,256))
   OR ((s.racemask & 4)<>0 AND s.classmask=4)
   OR ((s.racemask & 1024)<>0 AND s.classmask=64)
   OR ((s.racemask & 8)<>0 AND s.classmask=1024);

-- Horde custom races: class donors Orc(2), BloodElf(10), Undead(5), Tauren(6).
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`)
SELECT r.mask, s.classmask, s.Spell, CONCAT('FULLFIX6 class donor: ',COALESCE(s.Note,''))
FROM `playercreateinfo_spell_custom` s
CROSS JOIN (SELECT @MH mask UNION ALL SELECT @OG) r
WHERE ((s.racemask & 2)<>0 AND s.classmask IN (1,4,8,32,64,256))
   OR ((s.racemask & 512)<>0 AND s.classmask=2)
   OR ((s.racemask & 16)<>0 AND s.classmask IN (16,128))
   OR ((s.racemask & 32)<>0 AND s.classmask=1024);

-- Remove native donor racials/languages before adding the intended custom set.
DELETE FROM `playercreateinfo_spell_custom`
WHERE (`racemask` & (@HE|@MH|@OG|@DI)) <> 0
AND `Spell` IN (668,669,672,813,20572,33697,33702,20573,20574,20575,28730,25046,28734,28877,822,20594,20595,20596,2481,59224);

-- Exact languages and racials matching the character-creation descriptions.
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
(@HE,0,668,'High Elf - Common'),(@HE,0,813,'High Elf - Thalassian'),
(@HE,1503,110005,'High Elf - Quel dorei Meditation'),(@HE,32,110007,'High Elf - Quel dorei Meditation DK'),
(@HE,0,110006,'High Elf - Swiftness of the Rangers'),(@HE,0,110008,'High Elf - Bow Specialization'),(@HE,0,110009,'High Elf - Enchanting Specialization'),
(@MH,0,669,'Maghar - Orcish'),(@MH,0,110001,'Maghar - Ancestral Call'),(@MH,0,110002,'Maghar - Savage Blood'),(@MH,0,110003,'Maghar - Sympathetic Vigor'),(@MH,0,110004,'Maghar - Unwavering Will'),
(@OG,0,669,'Ogre - Orcish'),(@OG,0,20549,'Ogre - War Stomp'),(@OG,0,20550,'Ogre - Endurance'),(@OG,0,20573,'Ogre - Hardiness'),(@OG,0,20575,'Ogre - Command'),
(@DI,0,668,'Dark Iron - Common'),(@DI,0,672,'Dark Iron - Dwarven'),(@DI,0,20594,'Dark Iron - Stoneform'),(@DI,0,20595,'Dark Iron - Gun Specialization'),(@DI,0,20596,'Dark Iron - Frost Resistance'),(@DI,0,2481,'Dark Iron - Find Treasure'),(@DI,0,59224,'Dark Iron - Mace Specialization');

-- 3) Correct action bars: use donors by CLASS, never blindly by parent race.
DELETE FROM `playercreateinfo_action` WHERE `race` IN (13,14,15,16);
INSERT IGNORE INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT r.race,a.class,a.button,a.action,a.type FROM `playercreateinfo_action` a
CROSS JOIN (SELECT 13 race UNION ALL SELECT 16) r
WHERE (a.race,a.class) IN ((1,1),(1,2),(3,3),(1,4),(1,5),(1,6),(11,7),(1,8),(1,9),(4,11));
INSERT IGNORE INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT r.race,a.class,a.button,a.action,a.type FROM `playercreateinfo_action` a
CROSS JOIN (SELECT 14 race UNION ALL SELECT 15) r
WHERE (a.race,a.class) IN ((2,1),(10,2),(2,3),(2,4),(5,5),(2,6),(2,7),(5,8),(2,9),(6,11));

-- 4) Reputation inheritance is DBC-side, NOT a World DB table.
-- AzerothCore does not provide `acore_world`.`faction`; Faction.dbc is loaded from DBC data.
-- The custom race reputation masks must therefore be supplied by the patched Faction.dbc / Patch-A.
-- Do not issue UPDATE `faction` statements here: they make the module SQL auto-updater abort with ERROR 1146.

-- 5) Achievement criteria expected by the custom Achievement_Criteria.dbc.
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (13484,13485,13498,13499);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(13484,2,0,13,''),(13484,9,18,0,''),(13484,10,1,0,''),(13485,2,0,13,''),
(13498,2,0,14,''),(13498,9,18,0,''),(13498,10,1,0,''),(13499,2,0,14,'');

-- Remove stale invalid WotLK graveyard-zone rows from older mod revisions.
DELETE FROM `graveyard_zone` WHERE `GhostZone` IN (4714,4720,4737,4755);
