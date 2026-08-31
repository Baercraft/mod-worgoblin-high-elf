-- [F-032] mod-maghar: skillline: 1 inserts, 0 updates, 0 deletes

-- New entries
DELETE FROM `skillline` WHERE `id` = 793;
INSERT INTO `skillline` (`id`, `category`, `cost`, `name_enus`, `name_kokr`, `name_frfr`, `name_dede`, `name_zhcn`, `name_zhtw`, `name_eses`, `name_esmx`, `name_ruru`, `name_jajp`, `name_ptpt`, `name_itit`, `name_unused_1`, `name_unused_2`, `name_unused_3`, `name_unused_4`, `name_flags`, `desc_enus`, `desc_kokr`, `desc_frfr`, `desc_dede`, `desc_zhcn`, `desc_zhtw`, `desc_eses`, `desc_esmx`, `desc_ruru`, `desc_jajp`, `desc_ptpt`, `desc_itit`, `desc_unused_1`, `desc_unused_2`, `desc_unused_3`, `desc_unused_4`, `desc_flags`, `icon_id`, `verb_enus`, `verb_kokr`, `verb_frfr`, `verb_dede`, `verb_zhcn`, `verb_zhtw`, `verb_eses`, `verb_esmx`, `verb_ruru`, `verb_jajp`, `verb_ptpt`, `verb_itit`, `verb_unused_1`, `verb_unused_2`, `verb_unused_3`, `verb_unused_4`, `verb_flags`, `can_link`) VALUES (793, 9, 0, 'Racial - Ogre', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712172, 133032, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712172, 0);

-- Baercraft locale-column correction
UPDATE `skillline` SET `name_enus`='Racial - Ogre', `name_kokr`='종족 - 오우거', `name_frfr`='Racial - Ogre', `name_dede`='Volk - Oger', `name_zhcn`='种族 - 食人魔', `name_zhtw`='種族 - 食人魔', `name_eses`='Racial - Ogro', `name_esmx`='Racial - Ogro', `name_ruru`='Расовая - Огр' WHERE `id`=793;
