# Baercraft master update - Dark Iron strict Dwarf fallback

This update is based on `Baercraft-6.3.0-FINAL-623-STANDARD`.

## What was verified from the supplied CreatureDisplayInfo.dbc

- Display 7789-7792 -> ModelID 53 (Dwarf male), with NPC extras 5324-5327.
- Display 21826/21827 -> ModelID 53 (Dwarf male), NPC extras 14845/14847.
- Display 21828/21829 -> ModelID 54 (Dwarf female), NPC extras 14846/14848.
- Those NPC extras contain fixed NPC equipment. They are therefore NOT used as ChrRaces player display IDs.
- Playable Dark Iron stays on the proper player models 53/54 and gets its Dark Iron appearance from race-16 CharSections using the existing Dwarf Dark-Iron skins (male 09-11 / female 09-11).

## Fixes

- Race 16 remains Alliance and uses Dwarf faction 3.
- Male/Female display stays 53/54: no giant/random NPC model.
- Race-16 CharSections are synced to Dwarf player assets with Dark Iron skins.
- Standard classes are exactly the Dwarf classes.
- World SQL clones Dwarf stats, start rows, action bars, skills and spells instead of maintaining separate class/racial data.
- Faction.dbc now adds race mask 32768 wherever Dwarf mask 4 is present, so Dark Iron inherits Dwarf reputation visibility/base rules.
- Removed hard-coded pseudo Dark-Iron spell injection from Worgoblin.cpp.
- Character-create icon changed to `INV_Hammer_04`.
- Stale source CSVs for race 16 are synchronized so a later DBC rebuild does not restore Vrykul data.

## Install into master

Copy the contents of this ZIP over the repository root. Rebuild the server after the C++ change. Replace client `patch-A.MPQ/DBFilesClient` files and server DBC files with the included versions, apply the new SQL through AzerothCore's update system, delete the WoW Cache folder, then test a newly-created Dark Iron character.

Do not replace ChrRaces display IDs with 21826/21828: those are NPC display wrappers with baked NPC equipment, not clean player base displays.
