# Baercraft 6.0 FULL TEST10 - Worgen / Goblin / High Elf / Maghar / Ogre

This is a full merged test build based on the supplied Ogre master plus the previously stabilized custom-race work.

## Ogre Race 15
- Male visual: stock WotLK one-headed Ogre (display 19924 / Ogre model).
- Female visual: stock WotLK two-headed Ogre Mage (display 19922). The supplied master did not contain the referenced custom OgrePC model files, so this avoids cubes and ERROR #132.
- Own character-create icon: stock WotLK Ogre reputation icon, no Orc icon fallback.
- Baseline classes exposed in the normal client patch: Warrior, Hunter, Shaman, Mage, Warlock.
- Horde / Orc quest eligibility is added by SQL.
- Faction.dbc copies Orc reputation race access to Ogre, so Ogre sees the same reputation factions as Orc where race masks are used.

## Ogre racial abilities (own IDs)
- 110100 Ogre's Might / Ogerstaerke
- 110101 Thick Hide / Dicke Haut
- 110102 Clan Bond / Clanbindung
- 110103 Stubborn as Stone / Stur wie Stein
These clone the intended mechanics from the source mod but use Ogre-only spell IDs and the new Ogre racial SkillLine 794, so Maghar is not overwritten.

## Locales
Character-create race text includes enUS, deDE, frFR, esES/esMX, ruRU, zhCN, zhTW and fallbacks for other locales. The old full English GlueStrings override is removed, so normal Blizzard UI strings stay in the selected client language. Ogre Spell.dbc names/descriptions are localized for the major requested locales, with English fallback.

## Install
1. Rebuild the module/core using the integration/merged sources if your current core does not already contain Race 15. The race EnumUtils count is fixed to 15 in this package.
2. World DB: let AzerothCore module auto-update apply data/sql/db-world/base/zz_ogre_race15_full_fix.sql, or import that file once manually only if you are not using the module updater.
3. Server DBC: copy server/dbc/*.dbc into the DataDir/dbc directory used by worldserver.
4. Client: build/replace patch-A.MPQ from data/patch-A.MPQ.
5. Delete the client Cache directory before first login.
6. Use conf/mod_worgoblin.conf.

IMPORTANT: Client and server DBCs in this package are a matched set. Do not mix TEST7/8/9 ChrRaces.dbc with this build.
