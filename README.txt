Race 15/16 source-only correction
================================

Scope intentionally limited to source/SQL integration. No patch-A, GlueXML, camera, ARAC or client-model changes are included.

Race 15 - Ogre
- Race ID 15 / mask 16384 retained.
- Fixed racial spell package: War Stomp (20549), Endurance (20550), Hardiness (20573), Command (20575).
- Removes accidental Mag'har racial IDs 110001-110004 from Ogre starting-spell source.
- Racial skill line 793 now has actual SkillLineAbility links.
- Existing Stonemaul reputation/faction and Ogre skill masks retained.

Race 16 - Dark Iron Dwarf
- Adds RACE_DARKIRONDWARF = 16 to AzerothCore patch and EnumUtils mappings.
- Adds DisplayRace::DarkIronDwarf = 16.
- Adds race mask 32768 to Alliance/Playable masks.
- Inherits normal Dwarf starting stats, positions, action bars, skills and class spells.
- Inherits Dwarf reputation race masks in all four Faction.dbc reputation slots.
- Adds racial skill line 794.
- Stable initial racial spells: Stoneform 20594, Gun Specialization 20595, Frost Resistance 20596, Find Treasure 2481, Mace Specialization 59224.
- Taxi/pennant fallbacks use Dwarf/Ironforge behavior.

Mask fixes
- Corrects duplicate @GoblinHelmetMask for race 10 to @BloodElfHelmetMask.
- Adds @DarkIronDwarfHelmetMask = 65536.

Important
- This package changes source-generation SQL and core patch only. It intentionally does not modify client DBC/MPQ assets.
