-- FULLFIX 6.5.9 - ARAC native class proficiency parity
-- Additive only. These are the canonical AzerothCore starter skill rows used by
-- native classes. RaceMask=0 means every race; class masks remain unchanged.
-- The 6.5.9 C++ PlayerScript also provides an idempotent proficiency-spell
-- safety net because custom/ARAC combinations can otherwise miss the passive.

INSERT IGNORE INTO `playercreateinfo_skills`
(`raceMask`,`classMask`,`skill`,`rank`,`comment`) VALUES
(0,32,229,0,'Polearms'),
(0,32,293,0,'Plate'),
(0,35,55,0,'Two-Handed Swords'),
(0,35,413,0,'Mail'),
(0,37,44,0,'Axes'),
(0,37,172,0,'Two-Handed Axes'),
(0,39,43,0,'Swords'),
(0,40,118,0,'Dual Wield'),
(0,67,433,0,'Shield'),
(0,400,228,0,'Wands'),
(0,1107,54,0,'Maces'),
(0,1135,414,0,'Leather'),
(0,1488,136,0,'Staves');
