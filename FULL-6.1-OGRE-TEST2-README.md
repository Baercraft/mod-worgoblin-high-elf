# Baercraft 6.1 Ogre TEST2

This build deliberately drops the Dark Iron experiment and focuses on a stable Ogre Race 15.

## Base
- Server/module source: current Baercraft TEST10 fixes based on Medviten mod-worgoblin-high-elf.
- Client asset master: official Medviten v1.0.3 release `patch-A.MPQ`.
- The v1.0.3 Ogre player assets are included: `OgrePC.m2` (male) and `OgreMagePC.m2` (female/two-headed), skins and textures.

## Fixed in TEST2
- Uses the official Ogre player model assets instead of Orc/creature fallbacks.
- Restores the original v1.0.3 race icon atlas and CharacterCreate layout.
- Uses the release `GlueParent.lua` (Ogre ambience/background mapping already exists there).
- Removes the release's full English `GlueStrings.lua`; native Blizzard locale files are no longer overwritten.
- Adds custom-race locale strings in `CharacterCreate.lua` only.
- deDE/enUS/frFR/esES/esMX/ruRU/zhCN/zhTW supported; unsupported locales fall back to English custom-race text while stock UI stays native.
- Custom-race descriptions show the actual configured starting locations.
- Corrects the shifted locale columns for High Elf and Mag'har in `ChrRaces.dbc`; adds Ogre localized race names.
- Localizes SkillLine 791/792/793 and the Stonemaul faction.
- Adds four real Ogre racial spells in `Spell.dbc`, linked to Ogre skill line 793:
  - 110100 Ogre's Might (Blood Fury mechanics)
  - 110101 Thick Hide (Endurance mechanics)
  - 110102 Clan Bond (Command mechanics)
  - 110103 Stubborn as Stone (Hardiness mechanics)
- Fixes the upstream Ogre `playercreateinfo_action.sql` race IDs (14/2 -> 15).
- Ogre inherits Orcish language, Orc quest eligibility and Horde/Orc reputation masks.
- Keeps the previously fixed pre-June-2026 AzerothCore `creature.id1/id2/id3` SQL compatibility and Running Wild config handling from TEST10.

## Install
1. Rebuild/recompile if replacing the module/core source.
2. Copy `data/patch-A.MPQ` contents into your client patch-A.MPQ (or rebuild the MPQ from the folder).
3. Copy `data/patch-A.MPQ/DBFilesClient/*.dbc` to the server DataDir/dbc folder.
4. Let the module/world SQL updater apply the SQL files, including `zz_ogre_race15_full_fix.sql`.
5. Delete the client Cache folder before testing.

Do not mix TEST7/8/9 fallback DBCs with this build.

## TEST3 SQL compatibility fix
For AzerothCore Playerbot branch around 2026-05-22, `playercreateinfo_spell_custom` uses `racemask` / `classmask` bitmasks. The Ogre finalizer now uses Ogre mask 16384 and classmask 0 for racials instead of legacy `race` / `class` column names.
