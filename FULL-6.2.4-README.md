# Baercraft 6.2.4 Full Mod

Base: Medviten v1.0.3 client assets + Baercraft fixes through 6.2.3. Dark Iron is not included.

## Client
- `data/patch-A.MPQ` is the STANDARD client patch with normal race/class restrictions and the 6.2.3 class-grey fix.
- `data/Optional/patch-A-ARAC.MPQ` is the ARAC client variant. Use one or the other, never both.
- Real Medviten v1.0.3 Ogre player assets are included (male OgrePC and female OgreMagePC).
- No locale-specific GlueXML overlays are included.
- `AreaTable.dbc` is intentionally not shipped inside client patch-A so stock localized character-list locations remain visible.
- Custom SkillLine/SkillRaceClassInfo data includes racial skill lines, languages and inherited class/weapon skills.

## Ogre
- Race 15, Horde parent: Orc.
- Reputation masks in client and server `Faction.dbc` copy the exact Orc reputation slots to Ogre.
- Stonemaul Clan remains Ogre-only.
- Orcish language is granted.
- Ogre racial skill line 793 and spells 110100-110103 are granted.
- Orc-restricted quests are extended to Ogre.

## Server
Copy `server/dbc` to the active server DBC directory as a matched set for race/reputation/skills. Let the module SQL updater apply the files in `data/sql/db-world/base`.

## Important
Do not reuse old LocalePatches/GlueXML overrides from TEST5/TEST6. They caused enUS/deDE to load different CharacterCreate code.
