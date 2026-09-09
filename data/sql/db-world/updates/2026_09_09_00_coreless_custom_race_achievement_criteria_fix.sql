-- CORELESS custom-race achievement criteria cleanup / migration
-- Fixes stale achievement_criteria_data rows from older module revisions.
-- Safe to run repeatedly.
--
-- Custom races:
--   9 Goblin, 12 Worgen, 13 High Elf, 14 Mag'har Orc,
--   15 Ogre, 16 Dark Iron Dwarf, 17 Zandalari Troll

START TRANSACTION;

-- ACHIEVEMENT_CRITERIA_TYPE_HK_RACE (53) carries the race directly in
-- Achievement_Criteria.dbc req_asset_id. AzerothCore does not accept normal
-- achievement_criteria_data rows for this criteria type. Older revisions may
-- have left target race/level/gender rows behind; remove them.
DELETE FROM `achievement_criteria_data`
WHERE `criteria_id` IN (
    13471, -- Goblin: Know Thy Enemy
    13472, -- Worgen: Know Thy Enemy
    13484, -- High Elf: Know Thy Enemy
    13498, -- Mag'har Orc: Know Thy Enemy
    19218, -- Ogre: Know Thy Enemy
    19222, -- Dark Iron Dwarf: Know Thy Enemy
    19226  -- Zandalari Troll: Know Thy Enemy
);

-- Rebuild all custom-race data for ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2 (110).
-- Shake Your Bunny-Maker needs target race + level 18 + female target.
-- Check Your Head needs the target race restriction.
DELETE FROM `achievement_criteria_data`
WHERE `criteria_id` IN (
    13473, 13474, 13475, 13476,
    13485, 19215,
    13499, 13500,
    19219, 19220,
    19223, 19224,
    19227, 19228
);

INSERT INTO `achievement_criteria_data`
    (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`)
VALUES
    -- Goblin (race 9)
    (13473, 2, 0, 9,  ''),
    (13473, 9, 18, 0, ''),
    (13473,10, 1, 0,  ''),
    (13475, 2, 0, 9,  ''),

    -- Worgen (race 12)
    (13474, 2, 0, 12, ''),
    (13474, 9, 18, 0, ''),
    (13474,10, 1, 0,  ''),
    (13476, 2, 0, 12, ''),

    -- High Elf (race 13)
    (13485, 2, 0, 13, ''),
    (13485, 9, 18, 0, ''),
    (13485,10, 1, 0,  ''),
    (19215, 2, 0, 13, ''),

    -- Mag'har Orc (race 14)
    (13499, 2, 0, 14, ''),
    (13499, 9, 18, 0, ''),
    (13499,10, 1, 0,  ''),
    (13500, 2, 0, 14, ''),

    -- Ogre (race 15)
    (19219, 2, 0, 15, ''),
    (19219, 9, 18, 0, ''),
    (19219,10, 1, 0,  ''),
    (19220, 2, 0, 15, ''),

    -- Dark Iron Dwarf (race 16)
    (19223, 2, 0, 16, ''),
    (19223, 9, 18, 0, ''),
    (19223,10, 1, 0,  ''),
    (19224, 2, 0, 16, ''),

    -- Zandalari Troll (race 17)
    (19227, 2, 0, 17, ''),
    (19227, 9, 18, 0, ''),
    (19227,10, 1, 0,  ''),
    (19228, 2, 0, 17, '');

COMMIT;
