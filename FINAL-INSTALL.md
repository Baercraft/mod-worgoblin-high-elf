# Baercraft final installation

## One module, two server targets
There is one `mod-worgoblin-high-elf` repository.

### A. Normal AzerothCore (no Playerbots)
1. Clone/build a compatible AzerothCore WotLK tree.
2. Put this repository under `modules/mod-worgoblin-high-elf`.
3. From the AzerothCore root run `modules/mod-worgoblin-high-elf/tools/apply-core-patch.sh` (or the PowerShell equivalent).
4. Copy `data/patch-A.MPQ/DBFilesClient/*` to the server `Data/dbc` directory.
5. Let AzerothCore apply the required files under `data/sql/db-world/` automatically. Do not manually import them when the module updater is enabled. Optional content is stored under `data/sql/optional-world/` and must be imported manually only if desired.
6. Reconfigure CMake and rebuild the core.
7. Pack `data/patch-A.MPQ/` as client `patch-A.MPQ`.

### B. AzerothCore + Playerbots
Playerbots requires the AzerothCore Playerbot-compatible core/branch required by your selected `mod-playerbots` revision.

Do all base steps above, install `mod-playerbots`, then from the `mod-playerbots` repository root run:
`modules/mod-worgoblin-high-elf/tools/apply-playerbots-patch.sh`
(or apply `integration/mod-worgoblin-highelf-playerbots.patch` manually).

The Playerbots integration adds custom-race faction/race handling and makes Mag'har available to random bots using Orc-compatible names, mounts and routing while the normal player creation/skill datasets supply its class, weapon, armor and spell kits.

## Runtime defaults
`conf/mod_worgoblin_high_elf.conf.dist`:
- `ARAC.Enable = 0`
- `FlyAnywhere.Enable = 0`
- `Worgen.TwoForms.Enable = 1`
- `Worgen.TwoForms.CombatForceWorgen = 1`

Read `CLIENT-PROFILES.md` before changing ARAC.

## Worgen Two Forms
The old Eluna workaround is not required for the release behavior. C++ integration:
- learns the gender-correct Two Forms spell
- forces Worgen form on combat entry and resurrection
- keeps gender-specific Running Wild synchronized with riding rank

Important limitation: the backported 3.3.5 implementation uses fixed male/female human transform models. It is not a complete Cataclysm per-character second-appearance editor. Gender is handled; a fully independent second customized human face is not claimed.


## Validation
Before release this tree is checked with:
`python3 tools/validate_release.py`

Additionally both integration patches were regenerated as standard `git apply` patches and validated with `git apply --check` against their bundled source snapshots.


### AzerothCore spell_learn_spell compatibility

Current AzerothCore does not include `spell_learn_spell` in the standard world database schema. The legacy Worgoblin SQL for that table is therefore not imported. Worgen Running Wild synchronization is handled in `src/Worgoblin.cpp`.

## Optional Starter Guild compatibility
If you use AzerothCore `mod-starter-guild`, apply `integration/mod-starter-guild-custom-races.patch` in that module before compiling. It resolves team selection through `Player::TeamIdForRace()` and clears only stale guild-field state that does not correspond to an actual guild membership before the starter-guild AddMember call.
