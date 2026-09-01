Baercraft 6.5.2 - Character Creation Race Layout Fix

Fixed deterministic race slots in CharacterCreate.lua/xml.

Alliance (left):
1 Human
2 Dwarf
3 Night Elf
4 Gnome
5 Draenei
6 Worgen
7 High Elf
8 Dark Iron Dwarf

Horde (right):
9 Orc
10 Undead / Scourge
11 Tauren
12 Troll
13 Blood Elf
14 Goblin
15 Ogre
16 Mag'har Orc

The button slot is now independent from the raw GetAvailableRaces() order.
Each visible button keeps the raw selectionIndex required by the 3.3.5 client.
This prevents custom races from disappearing or moving Orc/Undead onto Alliance.
Dark Iron remains forced to Alliance in the Glue UI and uses the Dwarf glue background.
