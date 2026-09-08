-- Coreless custom-race compatibility.
-- The native transform handler still runs first; this script only corrects the final model
-- for custom races by mapping them to their intended parent race.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_coreless_parent_race_transform','spell_coreless_high_elf_dk_initiate');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(16739,'spell_coreless_parent_race_transform'),
(50517,'spell_coreless_parent_race_transform'),
(51926,'spell_coreless_parent_race_transform'),
(65511,'spell_coreless_parent_race_transform'),
(65522,'spell_coreless_parent_race_transform'),
(65523,'spell_coreless_parent_race_transform'),
(65524,'spell_coreless_parent_race_transform'),
(65525,'spell_coreless_parent_race_transform'),
(65526,'spell_coreless_parent_race_transform'),
(65527,'spell_coreless_parent_race_transform'),
(65528,'spell_coreless_parent_race_transform'),
(51519,'spell_coreless_high_elf_dk_initiate');
