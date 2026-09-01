# Baercraft 6.1 Ogre TEST5

TEST5 concentrates on restoring one consistent character-creation and custom-race data path.

## Important client installation
`data/patch-A.MPQ` remains the main client patch.

Some 3.3.5a locales load locale-specific GlueXML/DBC data after the common Data patch.
That was the reason enUS could still show `Too many races` / checkerboard Ogre while deDE
used a different character creation path.

For the locale you actually use, also build/copy the matching source folder from:

    data/LocalePatches/<locale>/patch-<locale>-A.MPQ

Examples:
    Data/enUS/patch-enUS-A.MPQ
    Data/deDE/patch-deDE-A.MPQ
    Data/frFR/patch-frFR-A.MPQ
    Data/esES/patch-esES-A.MPQ
    Data/ruRU/patch-ruRU-A.MPQ
    Data/zhCN/patch-zhCN-A.MPQ
    Data/zhTW/patch-zhTW-A.MPQ

The locale patch contains only the critical CharacterCreate/Glue files and custom-race DBCs.
It is intentionally identical across locales; text selection is done by GetLocale() in Lua.

## TEST5 fixes
- filters NPC/placeholder races out of GetAvailableRaces without breaking selection indexes
- keeps MAX_RACES at 15 playable races
- preserves the real source selection index for SetSelectedRace()
- uses the same Lua path for enUS/deDE/frFR/esES/ruRU/zhCN/zhTW
- race lore stays in the lore text; starting location is shown separately in the abilities pane
- custom-race languages are explicitly listed in character creation
- restores start spells/languages/class skills using racemask/classmask instead of literal custom race IDs
- Ogre racials 110100-110103 are granted per valid class mask
- directly repairs client and server Faction.dbc reputation masks:
  Worgen <- Human, Goblin <- Orc, High Elf <- Night Elf, Mag'har <- Orc, Ogre <- Orc
- removes polluted custom-race bits before inheriting parent reputation slots
- keeps dedicated home factions:
  1167 High Elven Loyalists, 1168 Mag'har of the Horde, 1170 Stonemaul Clan

## Database
The new authoritative SQL is:
    data/sql/db-world/base/zzzz_custom_race_spellmask_test5_fix.sql

It removes stale rows that used literal custom race IDs 9/12/13/14/15 as `racemask`
and re-adds the same starting spells, languages and class skills with the correct masks:
    Goblin 256
    Worgen 2048
    High Elf 4096
    Mag'har 8192
    Ogre 16384

Do not manually import AzerothCore repository updates in parallel with the auto updater.
