# Mag'har playable-race integration

Race 14 / RaceMask 8192 is wired through the custom-race client DBCs, AzerothCore integration patch and world DB overrides.

Default (ARAC off) Mag'har follows the normal Orc class set used by this release: Warrior, Hunter, Rogue, Death Knight, Shaman and Warlock. The optional ARAC patch-A overlay exposes the remaining WotLK classes when `ARAC.Enable = 1`.

Mag'har inherits Orc-oriented start locations, starting stats, class kit, Orcish language, weapon/armor eligibility, item/quest eligibility and Horde treatment. It does not copy Orc racials; its own racial skill line 792 and spells 110001-110004 are supplied instead.

The final audit also fixed two pre-existing merge-data errors unrelated to Race 14 that could cause SQL trouble: a duplicate Tauren Warrior action row and four Draenei Druid racial rows carrying the wrong class mask.

## Playerbots
The optional Playerbots patch treats Mag'har as an Orc-derived Horde race for AI infrastructure while leaving spell/racial data to the normal world/custom-race datasets. It adds Race 14 to random bot selection, Horde routing, Orc name/mount reuse, race-specific emote branches, chat race names, start routing and RPG leveling locations.

Current `mod-playerbots` requires its own AzerothCore fork/branch (`mod-playerbots/azerothcore-wotlk`, branch `Playerbot`). The custom-race module itself remains a single repository; only the server core target differs when Playerbots is used.
