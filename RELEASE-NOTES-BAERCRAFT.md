
## v5.4 SQL installer fix

- Fixed idempotent installation of `creaturemodeldata_dbc`.
- Added missing IDs 3516, 3517, 3518, 3519, 3805, 3845 and 3846 to the replacement set.
- Uses `REPLACE INTO` for the merged CreatureModelData DBC overrides so a partially installed or previously modified world database can be safely re-run.
# Baercraft custom-races release

Main changes versus the uploaded fork:
- completed Mag'har Race 14 / RaceMask 8192 wiring
- Mag'har Orc-compatible class, weapon, armor, language and start data
- separate Mag'har racial skill line/spells
- Playerbots Race 14 support
- fixed DBC/CSV synchronization for changed character appearance/start datasets
- fixed duplicate merged SQL composite keys discovered during final audit
- fixed current AzerothCore `OnPlayerResurrect(..., bool&)` hook signature
- regenerated Core and Playerbots patches in clean `git apply` format
- fixed Mag'har GM race label (no Goblin fall-through)
- Worgen Two Forms / combat form / Running Wild C++ integration
- ARAC server gate default OFF, with optional patch-A CharBaseInfo overlay for client UI
- Fly Anywhere default OFF but config-switchable using fly-capable AreaTable in patch-A plus server gate

Static validation does not replace runtime testing. The release should be tested on a fresh database/client with at least one character per custom race/class combination and, for Playerbots, bot creation/equipment/leveling smoke tests.


## V5 packaging cleanup
- Removed obsolete generated client-profile/source directories from intermediate builds.
- ARAC client support remains an optional **patch-A** `CharBaseInfo.dbc` overlay.
- All maintained custom-race client work remains in `data/patch-A.MPQ/` (plus the optional patch-A ARAC overlay).

## v5.3 database installer

- Added `data/sql/db-world/install.sql` as the single required world-database installer.
- Added `data/sql/db-world/install-extras.sql` for optional extra content.
- The required installer combines all maintained `dbc/` and `base/` SQL files in a deterministic order.
- Updated installation documentation to remove the obsolete SQL path from the original merged module.


## v5.3 SQL installer fix

- Made `playercreateinfo_skills` RaceMask migrations idempotent.
- Replaced primary-key-changing `UPDATE` statements with `INSERT IGNORE` plus targeted source-row cleanup.
- Prevents duplicate-key errors when `install.sql` is re-run after a partial or previous installation.
- Excludes the normal Orc racial skill line from Mag'har inheritance; Mag'har keeps its dedicated racial skill line 792.


### AzerothCore spell_learn_spell compatibility

Current AzerothCore does not include `spell_learn_spell` in the standard world database schema. The legacy Worgoblin SQL for that table is therefore not imported. Worgen Running Wild synchronization is handled in `src/Worgoblin.cpp`.


## v5.5

- Remove obsolete `spell_learn_spell` SQL from the required installer for current AzerothCore.
- Keep the old statement only as a non-imported legacy reference.
- Running Wild remains handled by the C++ module.


## v5.6 runtime fixes

- Added Mag'har RaceMask 8192 to every Faction.dbc reputation slot that accepts Orc RaceMask 2, fixing the empty Reputation pane.
- Added matching `faction_dbc` server overrides.
- Moved mandatory Mag'har racial spells 110001-110004 into `playercreateinfo_spell` so they do not depend on `PlayerStart.CustomSpells`.
- Added login/create-time Mag'har racial synchronization to repair already-created characters.
- Removed generated/manual installer SQL from the automatic `db-world` tree.
- Moved optional world SQL outside `db-world` so AzerothCore does not install optional content automatically.

## v5.7

- Removed legacy `data/sql/db-world/base/playercreateinfo_spell.sql` from the AzerothCore auto-update tree.
- Mag'har racials remain mandatory through the C++ create/login synchronization.
- Fixes startup failure on Playerbots-compatible AzerothCore schemas without `playercreateinfo_spell`.

## v5.8 runtime fixes

- Repairs Mag'har reputation visibility for characters created before the RaceMask reputation fixes by refreshing applicable visible factions on login.
- Adds locale-safe client fallbacks for Mag'har racial spell names/descriptions (110001-110004), preventing blank tooltips on non-enUS clients.
- Adds locale-safe fallback text for Mag'har racial SkillLine 792.


## v5.9 reputation inheritance

- Mag'har (Race 14) now inherits reputation eligibility directly from Orc race masks.
- High Elf (Race 13) now inherits reputation eligibility directly from Night Elf race masks.
- Existing Mag'har and High Elf characters refresh inherited visible factions on login.
- Shapeshift model handling is intentionally unchanged in this release.

### v5.9 tooltip correction
- Corrected Mag'har racial spell tooltips for the German 3.3.5a client.
- Added real deDE names, racial/passive subtexts and descriptions for spells 110001-110004.
- Removed dynamic `$s1`/`$s2`/`$d` substitutions from the custom racial descriptions so the client does not depend on custom-spell tooltip expansion to display the explanatory text.
- Kept the server `spell_dbc` override and client `Spell.dbc` synchronized.

## V5.9 locale correction
- Character creation custom-race flavor and racial ability text now selects enUS, deDE, frFR, esES (and esMX fallback) at runtime via GetLocale().
- Localization is applied from CharacterCreate.lua after GlueStrings.lua so locale-specific Blizzard GlueStrings cannot erase the custom race strings.

## Locale correction update

- Corrected custom DBC locale fields for the supported custom races and Mag'har racial data.
- Added localized DBC text for `deDE`, `enUS`, `frFR`, `esES`, `esMX`, `ruRU`, `zhCN` and `zhTW`.
- Added Russian, Simplified Chinese and Traditional Chinese character-creation descriptions and racial ability text.
- Localized Mag'har racial Spell/SkillLine names and descriptions in the same client locales.
- Added `tools/validate_locales.py` to verify CSV/DBC locale alignment.

## Locale slot correction (v5.9 locales v3)

- Corrected physical 3.3.5a localized-string slot order in `Faction.dbc` and `ChrRaces.dbc`.
- Corrected custom race skill lines in `SkillLine.dbc`.
- Corrected Mag'har racial names, subtexts, descriptions and aura descriptions in `Spell.dbc`.
- `deDE` now occupies physical locale slot 3 and no longer reads the French text.
- Added binary read-back validation for enUS, frFR, deDE, zhCN, zhTW, esES, esMX and ruRU.
- Added `LOCALE-SLOTS.md` and `tools/fix_locale_slots.py` to prevent the legacy CSV header layout from reintroducing the bug.

## v5.9 locales v4 - Barber and Glue localization cleanup

- Removed the bundled enUS `Interface/GlueXML/GlueStrings.lua` from patch-A. The client now uses its own locale-specific stock GlueStrings again, fixing generic character-select/create buttons and deletion confirmation text being forced to English.
- Kept Baercraft-only race descriptions/abilities localized in `CharacterCreate.lua`.
- Synchronized Mag'har `BarberShopStyle` source data with the already Orc-derived binary records.
- Added explicit Barber Shop validation for the four currently supported custom races.
- High Elf barber choices inherit Blood Elf; Mag'har barber choices inherit Orc; Goblin and Worgen keep their own appearance data.
- No future Race 15+ work is included in this maintenance release.


## v5.9 locales v5 - Barbershop core compatibility

- Added server-side barber base-race fallback validation.
- Worgen -> Human fallback.
- High Elf -> Blood Elf fallback.
- Mag'har -> Orc fallback.
- Goblin keeps its custom Goblin barber styles.
- Real character race IDs are never changed.
- Invalid barber style/race/gender combinations are rejected safely.
- Requires re-applying the AzerothCore integration patch and recompiling.

## Final cleanup
- Kept documentation for removing only the optional Auberdine/Exodar taxi-route edits.
- Added explicit custom-race team mapping in the AzerothCore integration patch (Goblin/Maghar = Horde, Worgen/High Elf = Alliance).
- Added optional `mod-starter-guild` compatibility patch for first-login guild assignment.
- Retained Barber Shop compatibility: Worgen -> Human, High Elf -> Blood Elf, Maghar -> Orc; Goblin keeps its own barber data.
- Invalid barber styles are rejected instead of being applied.

### deDE CharacterCreate locale detection fix

CharacterCreate custom-race text now detects the client locale through both `GetLocale()` and the Glue `locale` CVar. This prevents German clients from incorrectly falling back to the English custom-race descriptions when the Glue environment reports the locale inconsistently.
