# Barbershop compatibility

This release adds a server-side safety/fallback mapping for the currently supported custom races.

| Custom race | Barber base race | Behaviour |
|---|---|---|
| Worgen (12) | Human (1) | Accepts Worgen-specific styles and Human styles |
| High Elf (13) | Blood Elf (10) | Accepts High-Elf-specific styles and Blood-Elf styles |
| Mag'har (14) | Orc (2) | Accepts Mag'har-specific styles and Orc styles |
| Goblin (9) | Goblin (9) | Keeps its existing custom Goblin barber data |

The character's real race ID is never changed. The mapping is used only while validating a barber-shop style sent by the client. Invalid style/race/gender combinations are rejected instead of being written to the character.

The client still requires the supplied `BarberShopStyle.dbc` and the matching appearance DBCs from `patch-A`. Client and server DBCs must be kept in sync.

## Build requirement

The AzerothCore integration patch changed in this release. Re-apply/update `integration/mod-worgoblin-highelf-azerothcore.patch`, regenerate CMake if needed, and rebuild the core.

## Test recommendation

Test each custom race with a disposable character first. This patch makes the server-side validation tolerant and safe, but a 3.3.5a client can still crash before sending `CMSG_ALTER_APPEARANCE` if its local MPQ/DBC set is incomplete or overridden by another patch.

## Recompile required
The Barber Shop fallback validation is implemented in the AzerothCore integration patch. Re-apply the core patch and rebuild the core after upgrading to this release.
