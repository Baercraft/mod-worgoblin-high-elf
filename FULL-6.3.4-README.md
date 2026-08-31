# Baercraft 6.3.4 Full Mod

Clean 16-race build based on the 6.3.2 feature set with the compile corrections integrated directly into the normal module/source tree.

Playable custom races:
- High Elf: Race 13, gameplay fallback Night Elf.
- Mag'har Orc: Race 14, gameplay fallback Orc.
- Ogre: Race 15, gameplay fallback Orc.
- Dark Iron Dwarf: Race 16, gameplay fallback Dwarf.

Compile fixes integrated:
- SharedDefines.h directly declares races 13-16.
- EnumUtils<Races>::Count() is 16 and indexes 0-15 map to the 16 playable races.
- Worgoblin.cpp uses local numeric custom-race IDs so the module itself does not fail before the patched core enum is visible.
- Source files in the merged compile set are valid UTF-8; non-ASCII punctuation in affected comments was normalized.

Client:
- data/patch-A.MPQ is STANDARD.
- data/Optional/ARAC/DBFilesClient/CharBaseInfo.dbc is the only ARAC replacement required.
- No patch-J is included.
- CharacterCreate is configured for 16 races.
- AreaTable.dbc is included in patch-A.

Server:
- Use the server/dbc set from this same release.
- Use data/sql updates from this release.
- Apply the core changes from integration/merged to the matching AzerothCore/Playerbots source before rebuilding.
