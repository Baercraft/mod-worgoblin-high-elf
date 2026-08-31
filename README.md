# Purpose
This repository is my attempt at merging the Worgoblin and AzerothCore High Elf modules, as well as some other DBC-reliant modules. Any two modules that rely on the same DBCs need to be merged manually, unfortunately. This requires making them compatible in certain ways, and at the end of the day, I had to make some editorial decisions that went beyond a simple merger.

## TaxiPath and TaxiPathNodes
I have edited in a flight path from Auberdine to the Exodar and back. It is optional.

If you do not want the custom taxi route, remove the maintained `TaxiPath.dbc` and `TaxiPathNode.dbc` changes from your patch-A build and replace those two files with clean 3.3.5a DBCs from the same client build. Keep the remaining custom-race DBCs from patch-A; in particular, do not replace `ChrRaces.dbc`.

## Fly Anywhere
Allows players to fly anywhere as soon as they learn flying (though Northrend still requires Cold Weather Flying).

## ARAC (All Races All Classes)
Allows all races to be all classes. The updated version fixed some bugs in the original and adds a few spells. I noticed some missing combinations (e.g. Blood Elf Druid) were missing spells in some files, so I have added those in there as well as extending the module to cover Worgen, Goblins and High Elves.

## Worgoblin Module
[![core-build](https://github.com/benjymansy123/mod-worgoblin/actions/workflows/core-build.yml/badge.svg)](https://github.com/benjymansy123/mod-worgoblin/actions/workflows/core-build.yml)

This is a module for [AzerothCore](http://www.azerothcore.org) that adds Worgen, Goblins, and numerous features related to their playability.

### Features

- Worgen as a playable Alliance race and goblins as a playable Horde race
- Optional alpha Worgen models and Gilnean voices
- Mage and warlock class trainers in Teldrassil (I ought to extend this to give ARAC combinations access to trainers in their starting areas)
- Compatibility patches for Playerbots and the maintained custom-race core integration

#### Remaining limitations
- Worgen druid forms still use the inherited/custom merged form data rather than a full Cataclysm implementation.
- The backported Worgen Two Forms system does not provide a fully independent editable second human appearance.
- Vanilla goblin models are not a maintained target of this fork.

### Important Notes
This module makes *heavy* use of client patching and modification. Because of this, it is recommended to use a [clean, unmodified enUS WoW client](https://www.chromiecraft.com/downloads) as issues have been reported due to use of other clients, such as the one offered from Warmane. The HD patch included on the ChromieCraft website has been known to cause issues with this patch. It is for that reason that it's recommended for you to use the HD patch adapted to the Worgoblin module in particular, which can be found [here](https://github.com/benjymansy123/mod-worgoblin/releases/tag/hd-patch) with instructions on how to install it.

(It may not work with *this* module, however.)

## AzerothCore High Elf
Mod to add High Elves as playable characters on Azeroth Core with support for mod-playerbots. By Abracadaniel22.

### Features

- A new High Elf alliance race is added
- - It shares the same models as the Blood Elf race
- - It shares the existing High Elf starting implementation and inherits Alliance/Night-Elf-compatible reputation visibility in this maintained fork
- - High Elves can be any class except shaman or druid (in the non-ARAC version)

- Compatible with HD models

# How to Install

## 1) Replace the DBC files in your AzerothCore Data directory with the ones provided in data/patch-A.MPQ/DBFilesClient

Copy the contents of the DBFilesClient folder (`mod-worgoblin-high-elf/data/patch-A.MPQ/DBFilesClient`) to your AzerothCore `Data/dbc` directory (defined by `DataDir` in `worldserver.conf`). I recommend backing up your DBC folder before overwriting these files.

If you're using the alpha models and/or Gilnean voice files, overwrite the relevant DBC files.

## 2) Copy patch-A.MPQ from (`mod-worgoblin-high-elf/data/patch-A.MPQ`) to your Data folder in your WoW client

Overwrite the relevant files in `patch-A.MPQ/DBFilesClient` if you're using the alpha models and/or Gilnean voice files.

## 2.5) Optional: compatibility patches

### [Playerbots](https://github.com/liyunfan1223/mod-playerbots)

This patch teaches Playerbots the maintained custom races, including Mag'har Race 14, and keeps faction/race handling consistent for Worgen, Goblin, High Elf and Mag'har.

To apply the patch, copy playerbots.patch to the root of your Playerbots directory and run the following commands from there:

```
git apply --ignore-space-change --ignore-whitespace playerbots.patch
git add .
git commit -m "Add worgoblin-high-elf playerbots patch"
```

There is also a patch for Individual Progression. I tried to merge it too, but I don't use that mod myself and so can't test it. Take it for what it's worth.

## 3) Compile and install AzerothCore

See AzerothCore's [official documentation](https://www.azerothcore.org/wiki/installing-a-module) for more details about compiling and installing modules. If you applied one of the compatibility patches after a previous installation, you will have to recompile AzerothCore.

## 4) Remove signature checks from your WoW executable
Windows users can use [this patcher](https://www.wowmodding.net/files/file/283-wow-335-patcher-custom-item-fix/) created by kebabstorm to patch Wow.exe file (also available from [this](https://github.com/anzz1/WoWPatcher335/releases) GitHub repository). macOS users can download this [pre-patched .app file](https://github.com/benjymansy123/custom-race-ac-12_6_21/releases/download/sig-check/WoW.app.zip), since no easy patcher exists for macOS.

Because WoW uses signature checks so as to not allow Interface files to be modified, we need to remove those checks in order to be able to use custom races. This is accomplished using the patcher included in the repo. Move the patcher into your WoW client directory and run it. Again, feel free to make a backup of your original executable.

There is a longstanding bug in WotLK that causes your mouse to reset to the center of the screen, resulting in frequent disorientation while playing. It requires a patched client executable to fix, which causes compatibility issues with this module. However, you can use the script provided [here](https://github.com/idempotentiation/mod-worgoblin/releases/tag/patched-client-merger) to merge the two patched executables, allowing you to use this module alongside the camera fix.
## Database installation

The required world-database SQL is installed by AzerothCore's **module database updater**. Do not manually import `data/sql/db-world/*.sql` when automatic updates are enabled.

Required module SQL lives under:

```text
data/sql/db-world/base/
data/sql/db-world/dbc/
```

Optional content is stored outside the automatic update tree at:

```text
data/sql/optional-world/
```

Install optional SQL manually only when you explicitly want that extra content.

## Maghar Orc support
This fork includes Race 14 (Maghar Orc) as a fully wired playable race. Maghar inherits Orc class/start-zone, weapon, armor, language and item/quest eligibility, while using its own racial skill line (792) and racial spells 110001-110004. CharBaseInfo and server-side race/skill DBC overrides are synchronized for RaceMask 8192.

## Baercraft maintained release

This fork completes Mag'har Race 14 support, updates the custom-race Core patch, adds optional Playerbots integration, and implements Worgen Two Forms/Running Wild support in C++. Runtime defaults keep ARAC and Fly Anywhere disabled.

`patch-A.MPQ` is the maintained client source. ARAC requires the optional patch-A CharBaseInfo profile because the client race/class matrix cannot be changed by server config alone. Fly Anywhere is config-gated server-side while patch-A carries the fly-capable AreaTable.

See `FINAL-INSTALL.md`, `CLIENT-PROFILES.md`, and `RELEASE-NOTES-BAERCRAFT.md` before building.


### AzerothCore spell_learn_spell compatibility

Current AzerothCore does not include `spell_learn_spell` in the standard world database schema. The legacy Worgoblin SQL for that table is therefore not imported. Worgen Running Wild synchronization is handled in `src/Worgoblin.cpp`.


## Supported client locales

The maintained custom-race client text and custom DBC locale fields include:

- `enUS` - English
- `deDE` - German
- `frFR` - French
- `esES` - Spanish (Spain)
- `esMX` - Spanish (Mexico)
- `ruRU` - Russian
- `zhCN` - Simplified Chinese
- `zhTW` - Traditional Chinese / Taiwan

The correct WoW locale codes are `zhCN` and `zhTW` (not `chCN` or `cnTW`).

## Barber Shop and localized Glue UI

The maintained patch-A keeps the real custom race IDs intact. High Elf barber choices are derived from Blood Elf and Mag'har barber choices from Orc, while Goblin and Worgen keep their own appearance records. See `BARBERSHOP-COMPATIBILITY.md`.

`patch-A` does not ship a replacement `GlueStrings.lua`. This is intentional: the WoW client must load its own locale-specific GlueStrings so stock buttons, dialogs and character deletion confirmation text use the selected client language. Baercraft custom-race descriptions remain localized through `CharacterCreate.lua`.

## Barber Shop compatibility
The AzerothCore integration patch validates custom-race barber choices against a compatible base race without changing the character's real race ID:

- Worgen -> Human
- High Elf -> Blood Elf
- Mag'har -> Orc
- Goblin -> its own Goblin barber data

Invalid style/race/gender combinations are rejected. See `BARBERSHOP-COMPATIBILITY.md`. Rebuilding the core is required after applying the updated core patch.

## Optional Starter Guild compatibility
For AzerothCore `mod-starter-guild`, an optional patch is included at `integration/mod-starter-guild-custom-races.patch`. It uses the core race-to-team mapping and repairs stale first-login guild-field state only when no real membership exists.
