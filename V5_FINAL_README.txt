mod-worgoblin-high-elf - V5 FINAL
Build date: 2026-09-13

This package is the consolidated V5 release based on the last working V5 tree.

Included fixes:
- ARAC final DBC/SQL fixes from the working V5 base
- Custom race language and armor corrections
- Race 13 High Elf support
- Race 14 Mag'har Orc support
- Race 15 Ogre support
- Race 16 Dark Iron Dwarf support
- Correct client/server FactionTemplate for custom race cooperation
- Ogre (Race 15) corrected to Horde/Orc-style faction cooperation
- Dark Iron Dwarf (Race 16) corrected to Alliance/Dwarf-style faction cooperation
- Matching FactionTemplate.dbc included for client and server

Confirmed by runtime testing before packaging:
- Mag'har can invite/group normally
- Ogre can invite/group normally after the FactionTemplate correction
- Dark Iron Dwarf can invite/group normally after the FactionTemplate correction
- Dark Iron Dwarf automatic starter-guild join works

Important:
- The separate mod-starter-guild 31R custom-race fix is NOT merged into this module.
  It remains a separate AzerothCore module and should be installed separately.
- The experimental Playerbots guild fix created during diagnosis is NOT included.
- Keep client and server DBCs synchronized.

Install:
1. Use this folder as your mod-worgoblin-high-elf module.
2. Build patch-A from data/patch-A.MPQ as usual.
3. Copy the matching files from data/server_dbc_fix to the server Data/dbc directory.
4. Apply the SQL updates from data/sql through the normal AzerothCore module update process.
5. Recompile AzerothCore after replacing the module.
6. Restart both worldserver and WoW client after DBC changes.

Recommended final checks:
- Create a fresh High Elf, Mag'har, Ogre and Dark Iron character.
- Verify languages, armor/weapon skills, reputation and grouping.
- Test Ogre and Dark Iron right-click group invite.
- With the separate starter-guild fix installed, verify first-login guild assignment for custom races.
