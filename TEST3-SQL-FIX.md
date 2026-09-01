# 6.1 Ogre TEST3 - SQL compatibility fix

Fixed `data/sql/db-world/base/zz_ogre_race15_full_fix.sql` for the AzerothCore Playerbot branch used by the test server.

- `playercreateinfo_spell_custom` uses `racemask`, `classmask`, `Spell`, `Note`.
- Ogre Race 15 mask is `16384` (`1 << 14`).
- Ogre racials are inserted with `classmask = 0`, so they apply to every valid Ogre class.
- Legacy/experimental Ogre racial rows are cleaned using the correct mask columns.

No client asset/Lua/DBC changes were made relative to 6.1 Ogre TEST2.
