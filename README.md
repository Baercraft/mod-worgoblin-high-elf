# mod-worgoblin-high-elf

> 🚧 **Work in Progress / Development Version**

A ready-to-use custom race module for **AzerothCore 3.3.5a**, focused on providing additional playable races.

The main idea behind this fork is simple:

> **Put the module into your AzerothCore `modules` directory, install the provided DBC files and `patch-A.MPQ`, compile the server normally, and play.**

The goal is to keep custom-race integration as self-contained as possible inside the module instead of requiring users to manually modify or maintain additional patches inside the AzerothCore source tree.

This project is still under active development. Features, DBC files, SQL data and compatibility may continue to change while the project is brought closer to the functionality and quality of Medviten's work, especially regarding the integration of additional playable races.

**Please make backups before installing or updating the module.**

---

# Special Thanks

A very special thanks goes to **[Medviten](https://github.com/Medviten/mod-worgoblin-high-elf)**.

His work on `mod-worgoblin-high-elf`, continued development, testing, ideas and especially his **tireless support** have been an enormous help to this project.

This repository would not exist in its current form without his work and assistance.

The purpose of this fork is **not to replace Medviten's project**. Instead, it follows a somewhat different approach to installation and maintenance.

Medviten's project continues to be an important foundation and reference for this work, while this fork focuses strongly on providing a package that can be installed with as few manual modifications to AzerothCore itself as possible.

There are now several technical differences between both versions, but fixes, discoveries and improvements from either project can continue to benefit the other.

---

# Project Goal – As Few Core Changes As Possible

Custom playable races in WoW 3.3.5a normally require changes across several different systems:

* AzerothCore server data
* DBC files
* Client files
* SQL
* Race/class definitions
* Starting data
* Racials and skills
* Reputation
* Languages
* Character creation
* Client UI data

Traditionally, this can result in several separate patches, manual source changes and different DBC versions that must all remain synchronized.

This fork attempts to avoid that wherever possible.

The intended installation model is:

```text
AzerothCore
└── modules
    └── mod-worgoblin-high-elf
```

plus the supplied client and server data.

The module contains the server-side compatibility work required by this project wherever that functionality can reasonably be implemented without modifying the AzerothCore core itself.

The long-term goal is:

> **No manual AzerothCore core patching for the custom-race system.**

Simply install the module, use the supplied DBC files and client patch, compile AzerothCore normally and let the module handle the additional race integration.

---

# Playable Races

In addition to the original WoW 3.3.5a races, the project currently includes:

* **Worgen**
* **Goblin**
* **High Elf**
* **Mag'har Orc**
* **Ogre**
* **Dark Iron Dwarf**

Additional races are planned.

The project is still being developed with the intention of remaining as close as reasonably possible to the functionality established by Medviten when introducing and integrating additional playable races.

Because this fork uses a different technical approach in several areas, the implementation may not always be identical.

---

# Features

Development currently includes support for:

* Custom playable races
* Starting locations
* Starting quests and race handling
* Languages
* Racial abilities
* Starting skills
* Reputation integration
* Character creation
* Race/class definitions
* Armor and weapon proficiencies
* Client-side race definitions
* Worgen-specific functionality
* **Two Forms**
* **Running Wild**
* Druid forms
* Custom race SkillLines
* Custom achievements
* Parent-race compatibility
* ARAC – All Races All Classes
* PlayerBots compatibility through a dedicated PlayerBots version
* Multi-language client support

Not every feature or race/class combination should currently be considered complete.

---

# 🌍 Multi-Language Support

One of the major focuses of this fork is **multi-language support**.

Many WoW 3.3.5a custom-race projects were primarily designed around the English client. Adding new races, however, affects far more than simply displaying a translated race name.

For this reason, the DBC files supplied with this project have been **modified and extended with localization support for the custom races and their related data**.

Localization work includes areas such as:

* Race names
* Race descriptions
* Character creation
* Locations
* Languages
* Racial abilities
* SkillLines
* Client DBC entries
* Custom UI elements
* Additional custom-race related text

## Currently supported client languages

| Locale | Language                 |
| ------ | ------------------------ |
| `enUS` | 🇺🇸 English             |
| `deDE` | 🇩🇪 German              |
| `frFR` | 🇫🇷 French              |
| `esES` | 🇪🇸 Spanish             |
| `ruRU` | 🇷🇺 Russian             |
| `zhCN` | 🇨🇳 Simplified Chinese  |
| `zhTW` | 🇹🇼 Traditional Chinese |

The supplied DBC files have been adapted and extended accordingly.

Where a translation is not yet available, **English may be used as a fallback** instead of leaving the corresponding client entry empty.

Localization is still being improved. Corrections and improved translations from native speakers are very welcome.

---

# ARAC – All Races All Classes

Support for **All Races All Classes (ARAC)** is being integrated into the project.

ARAC allows race/class combinations that are normally unavailable in WoW 3.3.5a.

Development includes:

* Race/class availability
* Armor proficiencies
* Weapon proficiencies
* Class SkillLines
* Starting skills
* Class abilities
* Custom race support

ARAC remains under development and unusual race/class combinations may still expose issues.

## Future ARAC installation

This project is moving away from the old `patch-J.MPQ` approach.

### `patch-J.MPQ` will no longer be used in future versions.

Instead, the project is intended to provide an **alternative `patch-A.MPQ` version** for installations where ARAC should be disabled.

The intention is therefore to provide two matching client configurations rather than requiring `patch-J.MPQ` to override parts of another patch.

For example:

```text
patch-A.MPQ
└── ARAC-enabled client configuration

Alternative patch-A.MPQ
└── ARAC-disabled client configuration
```

This keeps the client setup easier to understand and avoids stacking patches whose purpose is to undo or override data from another patch.

More information will be provided as this system is finalized.

---

# Client and Server DBC Files

Custom races require changes to several DBC tables.

The DBC files supplied with this project have therefore been **modified, synchronized and extended specifically for this module**.

They contain data required for areas such as:

* Custom races
* Race/class combinations
* Racial abilities
* SkillLines
* Character creation
* Reputation-related integration
* Client localization
* Custom race descriptions
* Additional language entries

Because the client and server must agree on this data, it is strongly recommended to use the DBC files supplied with the matching version of the module.

**Do not randomly mix DBC files from different releases.**

---

# Client Patch

The project uses:

```text
patch-A.MPQ
```

as its primary client patch.

It contains the client-side data required for the additional playable races, including the modified DBC files and related client resources.

## No future patch-J requirement

Older approaches used an additional `patch-J.MPQ` for optional behavior.

This project is moving away from that design.

Future releases are intended to use **only `patch-A.MPQ`**, with an alternative Patch-A package being provided when ARAC should be disabled.

This should make the client installation more predictable and reduce problems caused by patch priority or incompatible combinations of Patch-A and Patch-J.

---

# PlayerBots

PlayerBots compatibility is provided through a dedicated adapted version of `mod-playerbots`:

**[Baercraft/mod-playerbots](https://github.com/Baercraft/mod-playerbots)**

The adapted PlayerBots module contains the compatibility work required for the additional playable races.

The same philosophy applies here:

> **No additional manual AzerothCore core modifications should be necessary just to use the custom races with PlayerBots.**

Users who want PlayerBots install the adapted PlayerBots module alongside this custom-race module.

Users who do not use PlayerBots do not need it.

Keeping PlayerBots integration separate also prevents PlayerBots-specific modifications from being forced on normal installations.

PlayerBots compatibility is still under development and will continue to be adapted as additional races and race/class combinations are introduced.

---

# Installation

> ⚠️ **This is currently a development version.**

Before installing or updating, back up:

* Your AzerothCore databases
* Your existing DBC directory
* Your WoW client
* Your current module version

## 1. Install the module

Copy or clone the repository into the AzerothCore module directory:

```text
AzerothCore/
└── modules/
    └── mod-worgoblin-high-elf/
```

The important point is that the module belongs inside the normal AzerothCore `modules` directory.

**No additional manual source patch to the AzerothCore core is intended to be required.**

---

## 2. Install the server DBC files

Copy the supplied server DBC files into the DBC directory used by your AzerothCore installation.

The directory used by the server is configured through:

```text
DataDir
```

in `worldserver.conf`.

Back up your existing DBC files before replacing them.

The server and client DBC versions should always come from the same module release.

---

## 3. Install `patch-A.MPQ`

Copy:

```text
patch-A.MPQ
```

into the `Data` directory of your WoW 3.3.5a client.

Example:

```text
World of Warcraft/
└── Data/
    └── patch-A.MPQ
```

That's the primary client-side installation required by the module.

Future releases will no longer rely on `patch-J.MPQ`.

If ARAC should be disabled, an alternative Patch-A version is planned instead.

---

## 4. Compile AzerothCore

Compile AzerothCore normally with the module inside the `modules` directory.

No separate manual modification of AzerothCore source files should be required for the custom-race integration supplied by this project.

Changes to the module's own C++ source code naturally require recompilation.

For general AzerothCore module installation instructions, see:

https://www.azerothcore.org/wiki/installing-a-module

---

## 5. Database Updates

The module contains the SQL updates required by the additional races and related systems.

Normally these should be handled by the AzerothCore module database updater.

Check the `worldserver` startup log after installing or updating the module to verify that the SQL updates were successfully applied.

---

## 6. Client Executable

Custom races require a WoW 3.3.5a client capable of loading modified client files.

A patched executable with the appropriate signature checks disabled may therefore be necessary.

A commonly used patcher is:

https://github.com/anzz1/WoWPatcher335

Always keep a backup of the original executable.

---

# Quick Installation Summary

For an existing AzerothCore installation, the intended process is essentially:

```text
1. Copy mod-worgoblin-high-elf into AzerothCore/modules/
2. Copy the supplied server DBC files to the server DataDir/dbc directory
3. Copy patch-A.MPQ into World of Warcraft/Data/
4. Compile AzerothCore normally
5. Start worldserver and allow the module SQL updates to run
6. Create a new custom-race character and test
```

There should be **no need to manually patch AzerothCore core source files** for the custom-race integration provided by this module.

That simplicity is one of the primary goals of this fork.

---

# Development Status

This project is still in **active development**.

The current goal is not merely to add races that can be selected on the character creation screen. The intention is to integrate them properly into the existing WoW 3.3.5a and AzerothCore systems.

Current development includes:

* Improving race integration
* Remaining as close as possible to Medviten's custom-race functionality
* Adding additional playable races
* Improving racial abilities
* Correcting starting skills
* Correcting armor and weapon proficiencies
* Improving reputation integration
* Improving Worgen functionality
* Testing race/class combinations
* Expanding ARAC support
* Expanding localization
* Keeping client and server DBC data synchronized
* Improving PlayerBots compatibility
* Reducing manual installation steps
* Eliminating unnecessary AzerothCore core modifications
* Replacing the old Patch-J approach with cleaner Patch-A variants

Some systems already work well while others remain under testing.

**This should therefore still be considered a development version rather than a finished release.**

---

# Bug Reports

Testing and bug reports are very welcome.

When reporting a problem, please include whenever possible:

* Module version
* AzerothCore revision
* Race
* Class
* Client locale
* Whether ARAC is enabled
* Whether PlayerBots is installed
* Whether the character was newly created
* Relevant `worldserver` log output

For race/class problems, please describe exactly which skill, spell, racial ability, armor type, weapon proficiency, reputation entry or other functionality is missing or incorrect.

---

# Updating

Because this project is under active development, module code, SQL and DBC data may change between versions.

Before updating:

* Back up your world database
* Back up your server DBC directory
* Back up `patch-A.MPQ`
* Keep your previous working module version

Always keep the module, server DBC files and client Patch-A from compatible releases together.

Characters created with older development versions may contain outdated race or skill data. For major updates, testing with a **newly created character** is recommended.

---

# Credits

This project builds upon the work of many developers in the AzerothCore and WoW modding communities.

Special thanks to:

* **[Medviten](https://github.com/Medviten/mod-worgoblin-high-elf)** – for his continued development of the combined project, extensive testing, ideas, assistance and especially his tireless support
* **heyitsbench** and **Helias** – original Worgoblin modules
* **idempotentiation** – Worgoblin fork and compatibility work
* **Abracadaniel22** – AzerothCore High Elf and Fly Anywhere modules
* **heyitsbench** – original ARAC module
* **ChromWolf** – updated ARAC work
* **Justurn / Zeppelin-Craft** – inspiration for modular DBC handling
* The **AzerothCore community**
* Everyone who has helped test, debug, translate and improve the project

A large part of the foundation, research and original credits behind this project comes from Medviten's combined `mod-worgoblin-high-elf` project.

---

# Contributing

Testing, fixes, translations and compatibility improvements are welcome.

In particular, help is appreciated with:

* Additional client languages
* Translation corrections
* Race/class testing
* Racials
* Reputation
* DBC compatibility
* ARAC
* PlayerBots
* Additional playable races

The project is still evolving, so detailed testing and reproducible bug reports are especially valuable.

---

# Disclaimer

This is a community project for **AzerothCore and World of Warcraft 3.3.5a modding**.

It is not affiliated with or endorsed by Blizzard Entertainment.

---

**Current Status: 🚧 Work in Progress / Development Version**
