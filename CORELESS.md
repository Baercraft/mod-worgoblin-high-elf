# Coreless custom-race build

This build intentionally requires no AzerothCore source patch and contains no `integration/` folder.

Replaced in-module:
- parent-race transforms/costumes (High Elf -> Blood Elf, Mag'har/Ogre/Goblin -> Orc, Dark Iron -> Dwarf, Worgen -> Human, Zandalari -> Troll)
- custom-race starting taxi nodes
- custom-race language normalization after creation/login/faction update
- High Elf Death Knight initiate visuals (display IDs 33924/33925)
- reputation watch bar is hidden client-side while reputation itself remains functional

Argent Tournament needs no replacement patch: the removed patch entries duplicated existing city pennants and their achievement/spell pairs. The native city pennants remain available.

Playerbots compatibility is intentionally not included; maintain it as a separate Playerbots-specific patch/module.
