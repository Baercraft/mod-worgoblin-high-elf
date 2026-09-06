-- FULLFIX2 runtime cleanup for databases that already applied older module updates.
-- Safe/idempotent on ACDB 335.16-dev.

-- The costume AuraScript expected SPELL_AURA_DUMMY, but these spells are native
-- SPELL_AURA_TRANSFORM. Let the core handle their DBC transform effect.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_costume_override';

-- Skill 794 is not present in the WotLK SkillLine.dbc used by this build.
-- Dark Iron racials are supplied as player-create spells, so this synthetic skill is unnecessary.
DELETE FROM `playercreateinfo_skills` WHERE `skill` = 794;

-- These custom achievement-criteria helper rows do not match the WotLK criteria
-- definitions in this build and only generate validation warnings.
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (13484,13485,13498,13499);

-- Open-Azeroth graveyard links for areas absent from this build's AreaTable.dbc.
-- The core skips them anyway; remove stale rows to keep startup clean.
DELETE FROM `graveyard_zone` WHERE `GhostZone` IN (4714,4720,4737,4755);
