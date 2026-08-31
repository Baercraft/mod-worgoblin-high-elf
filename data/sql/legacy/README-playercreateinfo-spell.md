# Legacy note

The old playercreateinfo_spell.sql was removed from the automatic db-world update tree.
The Playerbots-compatible AzerothCore schema used by this module does not expose playercreateinfo_spell in acore_world.
Mag'har mandatory racials are learned in src/Worgoblin.cpp on character creation/login instead.
