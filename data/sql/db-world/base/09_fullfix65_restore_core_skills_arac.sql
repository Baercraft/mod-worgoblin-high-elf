-- FULLFIX 6.5
-- Repairs the FULLFIX6.x playercreateinfo_skills damage and enables true ARAC
-- without PlayerStart.CustomSpells.
-- IMPORTANT: raceMask=0 means ALL races. Older FULLFIX files deleted these rows;
-- that removed normal class skill lines from every race.

SET @HE := 4096;
SET @MH := 8192;
SET @OG := 16384;
SET @DI := 32768;
SET @CUSTOM := @HE | @MH | @OG | @DI;

-- 1) Remove only rows polluted with custom-race bits by older inheritance updates.
-- Do NOT delete raceMask=0 rows: they are the core class/weapon/armor skill rows.
DELETE FROM `playercreateinfo_skills`
WHERE (`raceMask` & @CUSTOM) <> 0;

-- 2) Restore the canonical AzerothCore player-create skill table rows.
-- INSERT IGNORE keeps unrelated server customizations intact.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(0,0,95,0,'Defense'),
(0,0,162,0,'Unarmed'),
(0,0,183,0,'GENERIC (DND)'),
(0,0,415,0,'Cloth'),
(0,0,777,0,'Mounts'),
(0,0,778,0,'Companion Pets'),
(0,1,26,0,'Warrior - Arms'),
(0,1,256,0,'Warrior - Fury'),
(0,1,257,0,'Warrior - Protection'),
(0,2,184,0,'Paladin - Retribution'),
(0,2,267,0,'Paladin - Protection'),
(0,2,594,0,'Paladin - Holy'),
(0,4,50,0,'Hunter - Beast Mastery'),
(0,4,51,0,'Hunter - Survival'),
(0,4,163,0,'Hunter - Marksmanship'),
(0,8,38,0,'Rogue - Combat'),
(0,8,39,0,'Rogue - Subtlety'),
(0,8,253,0,'Rogue - Assassination'),
(0,9,176,0,'Thrown'),
(0,16,56,0,'Priest - Holy'),
(0,16,78,0,'Priest - Shadow'),
(0,16,613,0,'Priest - Discipline'),
(0,32,129,4,'Death Knight - First Aid'),
(0,32,229,0,'Polearms'),
(0,32,293,0,'Plate'),
(0,32,762,0,'Death Knight - Riding'),
(0,32,770,0,'Death Knight - Blood'),
(0,32,771,0,'Death Knight - Frost'),
(0,32,772,0,'Death Knight - Unholy'),
(0,35,55,0,'Two-Handed Swords'),
(0,35,413,0,'Mail'),
(0,37,44,0,'Axes'),
(0,37,172,0,'Two-Handed Axes'),
(0,39,43,0,'Swords'),
(0,40,118,0,'Dual Wield'),
(0,64,373,0,'Shaman - Enhancement'),
(0,64,374,0,'Shaman - Restoration'),
(0,64,375,0,'Shaman - Elemental'),
(0,67,433,0,'Shield'),
(0,128,6,0,'Mage - Frost'),
(0,128,8,0,'Mage - Fire'),
(0,128,237,0,'Mage - Arcane'),
(0,256,354,0,'Warlock - Demonology'),
(0,256,355,0,'Warlock - Affliction'),
(0,256,593,0,'Warlock - Destruction'),
(0,400,228,0,'Wands'),
(0,1024,134,0,'Druid - Feral'),
(0,1024,573,0,'Druid - Restoration'),
(0,1024,574,0,'Druid - Balance'),
(0,1107,54,0,'Maces'),
(0,1135,414,0,'Leather'),
(0,1488,136,0,'Staves'),
(1,0,754,0,'Human - Racial'),
(2,0,125,0,'Orc - Racial'),
(4,0,101,0,'Dwarf - Racial'),
(4,0,111,0,'Language: Dwarven'),
(8,0,113,0,'Language: Darnassian'),
(8,0,126,0,'Night Elf - Racial'),
(16,0,220,0,'Undead - Racial'),
(16,0,673,0,'Language: Forsaken'),
(32,0,115,0,'Language: Taurahe'),
(32,0,124,0,'Tauren - Racial'),
(36,4,46,0,'Guns'),
(64,0,313,0,'Language: Gnomish'),
(64,0,753,0,'Gnome - Racial'),
(128,0,315,0,'Language: Troll'),
(128,0,733,0,'Troll - Racial'),
(512,0,137,0,'Language: Thalassian'),
(512,0,756,0,'Blood Elf - Racial'),
(650,4,45,0,'Bows'),
(690,0,109,0,'Language: Orcish'),
(735,1293,173,0,'Daggers'),
(1024,0,759,0,'Language: Draenei'),
(1024,0,760,0,'Draenei - Racial'),
(1024,4,226,0,'Crossbows'),
(1061,3,160,0,'Two-Handed Maces'),
(1101,0,98,0,'Language: Common');

-- 3) Custom races inherit only useful parent start skills, never the parent's racial SkillLine.
-- High Elf <- Blood Elf, excluding Blood Elf racial SkillLine 756.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
SELECT @HE, `classMask`, `skill`, `rank`, CONCAT('High Elf inherited: ',COALESCE(`comment`,''))
FROM `playercreateinfo_skills`
WHERE (`raceMask` & 512) <> 0 AND (`raceMask` & @CUSTOM)=0 AND `skill` <> 756;

-- Maghar and Ogre <- Orc, excluding Orc racial SkillLine 125.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
SELECT @MH, `classMask`, `skill`, `rank`, CONCAT('Maghar inherited: ',COALESCE(`comment`,''))
FROM `playercreateinfo_skills`
WHERE (`raceMask` & 2) <> 0 AND (`raceMask` & @CUSTOM)=0 AND `skill` <> 125;
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
SELECT @OG, `classMask`, `skill`, `rank`, CONCAT('Ogre inherited: ',COALESCE(`comment`,''))
FROM `playercreateinfo_skills`
WHERE (`raceMask` & 2) <> 0 AND (`raceMask` & @CUSTOM)=0 AND `skill` <> 125;

-- Dark Iron <- Dwarf, excluding Dwarf racial SkillLine 101.
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`,`classMask`,`skill`,`rank`,`comment`)
SELECT @DI, `classMask`, `skill`, `rank`, CONCAT('Dark Iron inherited: ',COALESCE(`comment`,''))
FROM `playercreateinfo_skills`
WHERE (`raceMask` & 4) <> 0 AND (`raceMask` & @CUSTOM)=0 AND `skill` <> 101;

-- Alliance common language does not come from Blood Elf/Dwarf donor masks in every case.
INSERT IGNORE INTO `playercreateinfo_skills` VALUES
(@HE,0,98,0,'High Elf - Language Common'),
(@DI,0,98,0,'Dark Iron - Language Common');

-- Explicit custom racial SkillLines used by the bespoke High Elf / Maghar DBC spells.
INSERT IGNORE INTO `playercreateinfo_skills` VALUES
(@HE,0,791,0,'High Elf - Racial'),
(@MH,0,792,0,'Maghar Orc - Racial');

-- 4) Remove the massive FULLFIX6.4 copied class spell packages.
-- Class spells must come from the normal SkillLine/SkillLineAbility path.
DELETE FROM `playercreateinfo_spell_custom`
WHERE (`racemask` & @CUSTOM) <> 0;

-- Keep only language/racial safety entries. With PlayerStart.CustomSpells=0 these are inert;
-- the module PlayerScript and normal skill initialization provide them.
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`,`classmask`,`Spell`,`Note`) VALUES
(@HE,0,668,'High Elf - Common'),(@HE,0,813,'High Elf - Thalassian'),
(@HE,1503,110005,'High Elf - Quel dorei Meditation'),(@HE,32,110007,'High Elf - Quel dorei Meditation DK'),
(@HE,0,110006,'High Elf - Swiftness of the Rangers'),(@HE,0,110008,'High Elf - Bow Specialization'),(@HE,0,110009,'High Elf - Enchanting Specialization'),
(@MH,0,669,'Maghar - Orcish'),(@MH,0,110001,'Maghar - Ancestral Call'),(@MH,0,110002,'Maghar - Savage Blood'),(@MH,0,110003,'Maghar - Sympathetic Vigor'),(@MH,0,110004,'Maghar - Unwavering Will'),
(@OG,0,669,'Ogre - Orcish'),(@OG,0,20549,'Ogre - War Stomp'),(@OG,0,20550,'Ogre - Endurance'),(@OG,0,20573,'Ogre - Hardiness'),(@OG,0,20575,'Ogre - Command'),
(@DI,0,668,'Dark Iron - Common'),(@DI,0,672,'Dark Iron - Dwarven'),(@DI,0,20594,'Dark Iron - Stoneform'),(@DI,0,20595,'Dark Iron - Gun Specialization'),(@DI,0,20596,'Dark Iron - Frost Resistance'),(@DI,0,2481,'Dark Iron - Find Treasure'),(@DI,0,59224,'Dark Iron - Mace Specialization');

-- 5) TRUE ARAC server side: create every race/class PlayerInfo combination for races 1-16.
-- CharBaseInfo.dbc in FULLFIX6 already advertises all 160 combinations; the server DB must match.
DROP TEMPORARY TABLE IF EXISTS `tmp_fullfix65_races`;
CREATE TEMPORARY TABLE `tmp_fullfix65_races` (`race` TINYINT UNSIGNED PRIMARY KEY);
INSERT INTO `tmp_fullfix65_races` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16);

DROP TEMPORARY TABLE IF EXISTS `tmp_fullfix65_classes`;
CREATE TEMPORARY TABLE `tmp_fullfix65_classes` (`class` TINYINT UNSIGNED PRIMARY KEY);
INSERT INTO `tmp_fullfix65_classes` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(11);

-- Use one existing non-DK start position of the same race for all normal classes.
INSERT IGNORE INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT r.`race`, c.`class`, p.`map`, p.`zone`, p.`position_x`, p.`position_y`, p.`position_z`, p.`orientation`
FROM `tmp_fullfix65_races` r
CROSS JOIN `tmp_fullfix65_classes` c
JOIN `playercreateinfo` p ON p.`race`=r.`race`
JOIN (
    SELECT `race`, MIN(`class`) AS `baseclass`
    FROM `playercreateinfo`
    WHERE `class`<>6 AND `race` BETWEEN 1 AND 16
    GROUP BY `race`
) b ON b.`race`=p.`race` AND b.`baseclass`=p.`class`
WHERE c.`class`<>6;

-- Death Knights always start in the Scarlet Enclave.
INSERT IGNORE INTO `playercreateinfo` (`race`,`class`,`map`,`zone`,`position_x`,`position_y`,`position_z`,`orientation`)
SELECT `race`,6,609,4298,2358.44,-5666.9,426.023,3.65997
FROM `tmp_fullfix65_races`;

-- 6) Starter action bars for every ARAC pair, copied by CLASS from a valid native donor.
-- Do not delete existing bars; only fill missing buttons.
INSERT IGNORE INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`)
SELECT r.`race`, a.`class`, a.`button`, a.`action`, a.`type`
FROM `tmp_fullfix65_races` r
JOIN `playercreateinfo_action` a ON
       (a.`race`=1  AND a.`class` IN (1,2,4,5,6,8,9))
    OR (a.`race`=3  AND a.`class`=3)
    OR (a.`race`=11 AND a.`class`=7)
    OR (a.`race`=4  AND a.`class`=11);

DROP TEMPORARY TABLE IF EXISTS `tmp_fullfix65_classes`;
DROP TEMPORARY TABLE IF EXISTS `tmp_fullfix65_races`;
