-- 6.2.4 authoritative parent-race reputation mask model.
UPDATE faction SET
 reputation_race_mask_1=reputation_race_mask_1 & ~(256|2048|4096|8192|16384|32768),
 reputation_race_mask_2=reputation_race_mask_2 & ~(256|2048|4096|8192|16384|32768),
 reputation_race_mask_3=reputation_race_mask_3 & ~(256|2048|4096|8192|16384|32768),
 reputation_race_mask_4=reputation_race_mask_4 & ~(256|2048|4096|8192|16384|32768);
UPDATE faction SET reputation_race_mask_1=reputation_race_mask_1|2048 WHERE reputation_race_mask_1&1;
UPDATE faction SET reputation_race_mask_2=reputation_race_mask_2|2048 WHERE reputation_race_mask_2&1;
UPDATE faction SET reputation_race_mask_3=reputation_race_mask_3|2048 WHERE reputation_race_mask_3&1;
UPDATE faction SET reputation_race_mask_4=reputation_race_mask_4|2048 WHERE reputation_race_mask_4&1;
UPDATE faction SET reputation_race_mask_1=reputation_race_mask_1|4096 WHERE reputation_race_mask_1&8;
UPDATE faction SET reputation_race_mask_2=reputation_race_mask_2|4096 WHERE reputation_race_mask_2&8;
UPDATE faction SET reputation_race_mask_3=reputation_race_mask_3|4096 WHERE reputation_race_mask_3&8;
UPDATE faction SET reputation_race_mask_4=reputation_race_mask_4|4096 WHERE reputation_race_mask_4&8;
UPDATE faction SET reputation_race_mask_1=reputation_race_mask_1|256|8192|16384 WHERE reputation_race_mask_1&2;
UPDATE faction SET reputation_race_mask_2=reputation_race_mask_2|256|8192|16384 WHERE reputation_race_mask_2&2;
UPDATE faction SET reputation_race_mask_3=reputation_race_mask_3|256|8192|16384 WHERE reputation_race_mask_3&2;
UPDATE faction SET reputation_race_mask_4=reputation_race_mask_4|256|8192|16384 WHERE reputation_race_mask_4&2;
UPDATE faction SET reputation_race_mask_1=4096,reputation_race_mask_2=0,reputation_race_mask_3=0,reputation_race_mask_4=0,reputation_base_1=3100,reputation_flags_1=273 WHERE id=1167;
UPDATE faction SET reputation_race_mask_1=8192,reputation_race_mask_2=0,reputation_race_mask_3=0,reputation_race_mask_4=0,reputation_base_1=3100,reputation_flags_1=273 WHERE id=1168;
UPDATE faction SET reputation_race_mask_1=16384,reputation_race_mask_2=0,reputation_race_mask_3=0,reputation_race_mask_4=0,reputation_base_1=3100,reputation_flags_1=273 WHERE id=1170;

-- 6.5: Dark Iron Dwarf inherits Dwarf reputation masks.
UPDATE faction SET reputation_race_mask_1=reputation_race_mask_1|32768 WHERE reputation_race_mask_1&4;
UPDATE faction SET reputation_race_mask_2=reputation_race_mask_2|32768 WHERE reputation_race_mask_2&4;
UPDATE faction SET reputation_race_mask_3=reputation_race_mask_3|32768 WHERE reputation_race_mask_3&4;
UPDATE faction SET reputation_race_mask_4=reputation_race_mask_4|32768 WHERE reputation_race_mask_4&4;
