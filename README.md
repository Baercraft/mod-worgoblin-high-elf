# mod-worgoblin-high-elf

> [!WARNING]
>
> ## Work in Progress
>
> This module is **not finished yet** and is still under active development.
>
> It is currently intended for testing, development and experienced AzerothCore users. Features, DBC files, SQL structure and compatibility may still change between versions.
>
> Bugs are expected, especially with unusual race/class combinations, ARAC and PlayerBots integration.
>
> **Please make backups before installing or updating the module.**

A ready-to-use custom race module for **AzerothCore 3.3.5a**.

This project is based on the original Worgoblin and High Elf projects and has since been expanded with additional playable races, localization work, compatibility improvements and experimental ARAC support.

The main goal of this repository is to provide a more integrated installation that requires as little manual patching and assembly as possible.

However, the project is still actively being developed and should **not yet be considered a finished or fully stable release**.

---

# Special Thanks

A very special thanks goes to **[Medviten](https://github.com/Medviten/mod-worgoblin-high-elf)**.

His work on `mod-worgoblin-high-elf`, continued development, testing, ideas and especially his **tireless support** have been an enormous help to this project.

This repository would not exist in its current form without his work and assistance.

Rather than replacing his approach, this repository takes a slightly different direction:

* Medviten's project follows a more modular approach and experiments with systems such as modpaks.
* This repository focuses primarily on providing a more **ready-to-use and integrated installation**.

Both approaches have their advantages and can benefit from fixes and discoveries made in either project.

---

# Purpose

Custom races in WoW 3.3.5a require changes across several systems at the same time:

* AzerothCore server data
* DBC files
* Client patches
* SQL
* Race/class definitions
* Racials and skills
* Localization

Using several independent follow-up patches can provide more flexibility, but it also increases the possibility of mismatched files or installation-order problems.

For that reason, this repository attempts to provide a more complete and consistent base package.

The goal is to make installation as close as possible to:

> **Install the module, install the client patch, compile AzerothCore and play.**

Where possible, related fixes are integrated directly rather than distributed across multiple optional patches.

---

# Playable Races

In addition to the original WoW 3.3.5a races, the project currently includes the following custom playable races:

* **Worgen**
* **Goblin**
* **High Elf**
* **Mag'har Orc**
* **Ogre**
* **Dark Iron Dwarf**

Further improvements and additional races may be added over time.

---

# Features

The project aims to integrate the custom races into AzerothCore while preserving the standard WoW 3.3.5a systems as much as possible.

Development includes support for:

* Custom playable races
* Starting locations
* Languages
* Racial abilities
* Starting skills
* Reputation
* Character creation
* Race/class definitions
* Armor and weapon proficiencies
* Client-side race definitions
* Worgen features
* PlayerBots compatibility
* Multiple client languages
* Experimental All Races All Classes support

Not every feature or race/class combination should currently be considered complete.

---

# Ready-to-use Approach

This repository intentionally follows a more integrated approach.

Instead of requiring users to manually combine many DBC modifications, modpaks and follow-up patches, the goal is to provide a known compatible set of files.

This should make installation easier for users who simply want to use the additional races without having to manually rebuild every individual DBC modification.

It also helps reduce problems caused by:

* Incorrect patch order
* Missing follow-up patches
* Mismatched DBC files
* SQL and DBC data being out of sync
* Different versions of optional patches being mixed together

The ready-to-use approach does **not** mean that the project is already finished. The integrated package itself is still under active development and testing.

---

# Multi-Language Support

One of the major focuses and advantages of this fork is **improved multi-language support**.

Many custom-race projects for WoW 3.3.5a were primarily developed around an English client. This project attempts to make the additional races usable across multiple client locales.

Localization work includes areas such as:

* Race names
* Race descriptions
* Character creation
* Locations
* Languages
* Racials
* Client DBC data
* Custom UI elements

Current localization work includes support for:

* English (`enUS`)
* German (`deDE`)
* French (`frFR`)
* Spanish (`esES`)
* Russian (`ruRU`)
* Simplified Chinese (`zhCN`)
* Traditional Chinese (`zhTW`)

Where a translation does not yet exist, English may be used as a fallback instead of leaving the client entry empty.

Localization is still being improved and contributions or corrections from native speakers are very welcome.

---

# ARAC – All Races All Classes

Support for **All Races All Classes (ARAC)** is currently being integrated directly into the project.

> [!IMPORTANT]
> **ARAC is still work in progress and should currently be considered experimental.**

The long-term goal is to support race/class combinations without requiring users to manually combine several separate follow-up DBC patches.

Current ARAC development includes:

* Race/class availability
* Armor proficiencies
* Weapon proficiencies
* Class SkillLines
* Starting skills
* Class abilities
* Custom race support

Some unusual race/class combinations may still have missing abilities, incorrect proficiencies or other issues.

Testing and detailed bug reports are very welcome.

---

# Client Patch

The project uses **`patch-A.MPQ`** as its primary client patch.

It contains the client-side files required by the custom races, including modified DBC files and other race-related client data.

This repository does **not** use `patch-J.MPQ`.

The goal is to maintain one consistent client configuration instead of requiring an additional patch to reverse or disable parts of the primary patch.

---

# Worgen

The original Worgoblin project remains an important foundation of this module.

Development includes support for features such as:

* Playable Worgen
* Worgen models
* Worgen racial abilities
* Running Wild
* Druid forms
* Two Forms
* Alliance handling

Some functionality originates directly from the original Worgoblin projects while other parts have been modified or expanded.

---

# Goblin

Goblin support originates from the original Worgoblin module.

The project contains the client and server modifications required to make Goblins playable in WoW 3.3.5a and continues to integrate them with the other custom-race systems.

---

# High Elf

High Elf support originates from the **AzerothCore High Elf** project by Abracadaniel22.

The race has since received additional compatibility, integration and localization work.

---

# Mag'har Orc

Mag'har Orcs are available as an additional Horde race.

Development includes support for their:

* Race definition
* Languages
* Racials
* Starting data
* Class compatibility
* Reputation

---

# Ogre

Ogres are available as a playable Horde race.

Their integration includes custom race data, racial abilities and compatibility work with the existing AzerothCore systems.

Ogre integration is still being tested and improved.

---

# Dark Iron Dwarf

Dark Iron Dwarves are available as an additional Alliance race.

They use the existing Dwarf systems as a foundation while receiving their own custom race definition and racial support.

Their integration is also still under active development.

---

# PlayerBots

PlayerBots support is provided through a dedicated fork of `mod-playerbots`:

**[Baercraft/mod-playerbots](https://github.com/Baercraft/mod-playerbots)**

This fork contains compatibility work for the additional custom races and is intended to be used together with this project.

> [!NOTE]
> PlayerBots compatibility is also **still under development**.

Some custom races or unusual race/class combinations may not yet work perfectly with bot generation or automated character creation.

Keeping the PlayerBots modifications in a separate fork allows PlayerBots-specific changes to be developed without forcing them on users who do not use PlayerBots.

PlayerBots compatibility will continue to be updated as the custom race system expands.

---

# Installation

> [!CAUTION]
> This is currently a development version.
>
> Back up your AzerothCore databases, DBC files and WoW client before installing or updating.

## 1. Install the module

Copy the module into your AzerothCore modules directory:

```text
AzerothCore/
└── modules/
    └── mod-worgoblin-high-elf/
```

---

## 2. Install the server DBC files

Copy the provided server DBC files into the DBC directory used by your AzerothCore installation.

The exact directory is configured through `DataDir` in `worldserver.conf`.

**Back up your existing DBC directory before replacing any files.**

---

## 3. Install patch-A.MPQ

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

---

## 4. Compile AzerothCore

After installing or updating the module, compile AzerothCore normally.

Changes to the module's C++ source code require recompilation.

See the official AzerothCore documentation for information about installing and compiling modules:

https://www.azerothcore.org/wiki/installing-a-module

---

## 5. Database Updates

The module contains SQL updates required for the additional races and related systems.

Depending on your AzerothCore configuration, these updates may be applied through the AzerothCore database updater.

Check the worldserver startup log to verify that the required module SQL updates were successfully applied.

If necessary, SQL updates can also be imported manually.

---

## 6. Client Executable

Custom races require a WoW 3.3.5a client that allows modified client files.

You may therefore need a patched WoW executable with signature checks disabled.

A commonly used patcher is available here:

https://github.com/anzz1/WoWPatcher335

Always keep a backup of your original executable.

---

# Development Status

This project is currently in **active development**.

The current focus includes:

* Improving ARAC compatibility
* Testing race/class combinations
* Correct armor and weapon skills
* Correct class SkillLines
* Improving racial abilities
* Correcting custom race reputation
* Improving starting data
* Expanding localization
* Improving PlayerBots compatibility
* Keeping client and server DBC data synchronized
* Reducing the number of separate installation steps

Some systems are already working well, while others are still being redesigned or tested.

Users should currently expect possible issues with:

* ARAC combinations
* Starting skills
* Armor and weapon proficiencies
* Racials
* Languages
* Reputation
* Druid forms
* PlayerBots
* Characters created with older development versions

For reliable testing, creating a **new character** after major updates is recommended.

---

# Bug Reports

Bug reports and testing feedback are very welcome.

When reporting a problem, please include whenever possible:

* Module version
* AzerothCore revision
* Race
* Class
* Client locale
* Whether ARAC is enabled
* Whether the character was newly created
* Relevant worldserver log output

For race/class problems, please describe exactly which skill, spell, racial, armor type or weapon proficiency is missing.

This makes problems significantly easier to reproduce and fix.

---

# Updating

Because this project is still under active development, files and database structures may change between versions.

Before updating:

* Back up your world database
* Back up your DBC directory
* Back up `patch-A.MPQ`
* Keep your previous working module version

Do not assume that characters created with one development version will always behave identically after a future update.

---

# Credits

This project builds upon the work of many developers in the AzerothCore and WoW modding communities.

Special thanks to:

* **[Medviten](https://github.com/Medviten/mod-worgoblin-high-elf)** – for his continued development of the combined project, testing, ideas and especially his tireless support
* **heyitsbench** and **Helias** – original Worgoblin modules
* **idempotentiation** – Worgoblin fork and compatibility work
* **Abracadaniel22** – AzerothCore High Elf and Fly Anywhere modules
* **heyitsbench** – original ARAC module
* **ChromWolf** – updated ARAC work
* **Justurn / Zeppelin-Craft** – inspiration for modular DBC handling
* The AzerothCore community
* Everyone who has helped test, debug, translate and improve the project

A large part of the original project's foundation and credits comes from Medviten's combined `mod-worgoblin-high-elf` project.

---

# Contributing

Testing, fixes, translations and compatibility improvements are welcome.

This project is still evolving, so contributions that improve compatibility across different races, classes and client languages are particularly useful.

---

# Disclaimer

This is a community project for **AzerothCore and World of Warcraft 3.3.5a modding**.

It is not affiliated with or endorsed by Blizzard Entertainment.

---

**Current Status: 🚧 Work in Progress / Development Version**
