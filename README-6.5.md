# Baercraft 6.5 COMPLETE - STANDARD (no ARAC)

This is a complete 6.5 package. Patch-A content is already integrated in `data/patch-A.MPQ`.

## 6.5 reputation / locale fix

- Fixed the final binary `Faction.dbc`, not only the SQL source.
- Worgen inherits Human reputation masks.
- High Elf inherits Night Elf reputation masks.
- Goblin, Mag'har and Ogre inherit Orc reputation masks.
- Dark Iron Dwarf inherits Dwarf reputation masks.
- Custom home reputations are explicitly bound to their own races:
  - 1167 High Elven Loyalists -> High Elf only.
  - 1168 Mag'har of the Horde -> Mag'har only.
  - 1170 Stonemaul Clan -> Ogre only.
- Reputation names are populated for enUS/enGB, koKR, frFR, deDE, zhCN/zhTW, esES/esMX, ruRU, ptPT/ptBR and itIT in the delivered DBC.
- The source `Faction.csv` and authoritative DBC SQL are synchronized with the binary so a later rebuild does not silently remove the fix.

## Dark Iron Dwarf model verification

The supplied `CreatureDisplayInfo.dbc` was checked against the playable-race setup.

- NPC displays 7789-7792 resolve to Dwarf male ModelID 53 with NPC display extras.
- NPC displays 21826/21827 resolve to Dwarf male ModelID 53 with fixed NPC extras.
- NPC displays 21828/21829 resolve to Dwarf female ModelID 54 with fixed NPC extras.
- Those NPC display wrappers are not suitable as `ChrRaces` player display IDs because their extras can bake NPC equipment/appearance into the model.
- Race 16 therefore correctly stays on clean Dwarf player displays 53 male / 54 female.
- The Dark Iron appearance comes from race-16 `CharSections` using Dark Iron Dwarf skin sections.
- Race 16 remains Alliance and uses Dwarf faction 3.

Do not replace race-16 MaleDisplayId/FemaleDisplayId with 21826/21828.

## Installation

1. Replace/update the server module with this complete package.
2. Re-run CMake and rebuild the server if your previous module version differs.
3. Copy `server/dbc` to the server DBC directory used by AzerothCore.
4. Use the included `data/patch-A.MPQ` as the client patch-A content/build source.
5. Delete the WoW client Cache folder before testing.
6. Test with newly-created Ogre, High Elf and Dark Iron characters first. Existing characters should also use the corrected DBC on the next login/server start.

## Variant

STANDARD (no ARAC)
