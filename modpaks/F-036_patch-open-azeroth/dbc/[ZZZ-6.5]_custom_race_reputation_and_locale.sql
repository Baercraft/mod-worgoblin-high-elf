-- Baercraft 6.5 authoritative custom-race reputation/locale model.
-- Rebuild child-race reputation masks from their gameplay parents.
UPDATE faction SET
 reputation_race_mask_1 = reputation_race_mask_1 & ~(256|2048|4096|8192|16384|32768),
 reputation_race_mask_2 = reputation_race_mask_2 & ~(256|2048|4096|8192|16384|32768),
 reputation_race_mask_3 = reputation_race_mask_3 & ~(256|2048|4096|8192|16384|32768),
 reputation_race_mask_4 = reputation_race_mask_4 & ~(256|2048|4096|8192|16384|32768);

-- Worgen -> Human.
UPDATE faction SET reputation_race_mask_1=reputation_race_mask_1|2048 WHERE reputation_race_mask_1&1;
UPDATE faction SET reputation_race_mask_2=reputation_race_mask_2|2048 WHERE reputation_race_mask_2&1;
UPDATE faction SET reputation_race_mask_3=reputation_race_mask_3|2048 WHERE reputation_race_mask_3&1;
UPDATE faction SET reputation_race_mask_4=reputation_race_mask_4|2048 WHERE reputation_race_mask_4&1;
-- High Elf -> Night Elf.
UPDATE faction SET reputation_race_mask_1=reputation_race_mask_1|4096 WHERE reputation_race_mask_1&8;
UPDATE faction SET reputation_race_mask_2=reputation_race_mask_2|4096 WHERE reputation_race_mask_2&8;
UPDATE faction SET reputation_race_mask_3=reputation_race_mask_3|4096 WHERE reputation_race_mask_3&8;
UPDATE faction SET reputation_race_mask_4=reputation_race_mask_4|4096 WHERE reputation_race_mask_4&8;
-- Goblin, Mag'har and Ogre -> Orc.
UPDATE faction SET reputation_race_mask_1=reputation_race_mask_1|256|8192|16384 WHERE reputation_race_mask_1&2;
UPDATE faction SET reputation_race_mask_2=reputation_race_mask_2|256|8192|16384 WHERE reputation_race_mask_2&2;
UPDATE faction SET reputation_race_mask_3=reputation_race_mask_3|256|8192|16384 WHERE reputation_race_mask_3&2;
UPDATE faction SET reputation_race_mask_4=reputation_race_mask_4|256|8192|16384 WHERE reputation_race_mask_4&2;
-- Dark Iron Dwarf -> Dwarf.
UPDATE faction SET reputation_race_mask_1=reputation_race_mask_1|32768 WHERE reputation_race_mask_1&4;
UPDATE faction SET reputation_race_mask_2=reputation_race_mask_2|32768 WHERE reputation_race_mask_2&4;
UPDATE faction SET reputation_race_mask_3=reputation_race_mask_3|32768 WHERE reputation_race_mask_3&4;
UPDATE faction SET reputation_race_mask_4=reputation_race_mask_4|32768 WHERE reputation_race_mask_4&4;

-- Custom home reputations only apply to their own custom race.
UPDATE faction SET reputation_race_mask_1=4096,reputation_race_mask_2=0,reputation_race_mask_3=0,reputation_race_mask_4=0,reputation_base_1=3100,reputation_flags_1=273 WHERE id=1167;
UPDATE faction SET reputation_race_mask_1=8192,reputation_race_mask_2=0,reputation_race_mask_3=0,reputation_race_mask_4=0,reputation_base_1=3100,reputation_flags_1=273 WHERE id=1168;
UPDATE faction SET reputation_race_mask_1=16384,reputation_race_mask_2=0,reputation_race_mask_3=0,reputation_race_mask_4=0,reputation_base_1=3100,reputation_flags_1=273 WHERE id=1170;

-- Names shown by the reputation panel. These names are also baked into the delivered Faction.dbc.
UPDATE faction SET name_enus='High Elven Loyalists', name_frfr='Loyalistes hauts-elfes', name_dede='Hochelfische Loyalisten', name_zhcn='高等精灵效忠者', name_zhtw='高等精靈效忠者', name_eses='Leales altos elfos', name_esmx='Leales altos elfos', name_ruru='Верные высшие эльфы', name_ptpt='Leais altos elfos', name_itit='Lealisti Alti Elfi' WHERE id=1167;
UPDATE faction SET name_enus='Mag''har of the Horde', name_frfr='Mag''har de la Horde', name_dede='Mag''har der Horde', name_zhcn='部落玛格汉', name_zhtw='部落瑪格哈', name_eses='Mag''har de la Horda', name_esmx='Mag''har de la Horda', name_ruru='Маг''хары Орды', name_ptpt='Mag''har da Horda', name_itit='Mag''har dell''Orda' WHERE id=1168;
UPDATE faction SET name_enus='Stonemaul Clan', name_frfr='Clan Cognepierre', name_dede='Steinbrecherklan', name_zhcn='石槌氏族', name_zhtw='石槌氏族', name_eses='Clan Quebrantapiedras', name_esmx='Clan Quebrantapiedras', name_ruru='Клан Каменного Молота', name_ptpt='Clã Malho de Pedra', name_itit='Clan Mazzapietra' WHERE id=1170;
