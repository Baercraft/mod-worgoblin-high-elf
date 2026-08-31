# Client profiles


## Standard profile
Use `data/patch-A.MPQ/` and keep:

```ini
ARAC.Enable = 0
```

The standard `CharBaseInfo.dbc` exposes only the intended race/class combinations.

## ARAC profile
Start from the same complete `data/patch-A.MPQ/` tree and replace only:

```text
DBFilesClient/CharBaseInfo.dbc
```

with:

```text
data/Optional/patch-A-ARAC-overlay/DBFilesClient/CharBaseInfo.dbc
```

Copy that same ARAC `CharBaseInfo.dbc` to the server `Data/dbc` directory and set:

```ini
ARAC.Enable = 1
```

ARAC cannot be toggled completely by server config alone because the character-creation race/class matrix is client-side.

## Fly Anywhere
`patch-A` carries the fly-capable `AreaTable.dbc`; `FlyAnywhere.Enable` controls whether the server permits the additional flying behavior.

## Optional Auberdine <-> Exodar taxi route
The maintained patch includes the custom taxi route. To remove only that route, replace `TaxiPath.dbc` and `TaxiPathNode.dbc` in patch-A (and the matching server DBCs) with clean files from the same 3.3.5a client build. Do **not** replace the custom-race DBCs such as `ChrRaces.dbc`.

## Locale UI
Do not add a replacement `Interface/GlueXML/GlueStrings.lua` to patch-A. The client must load its own locale-specific GlueStrings so stock buttons and dialogs remain in the selected client language.

## Locale-specific CharacterCreate overlay
For non-enUS clients, the locale MPQ can override the common patch-A GlueXML.
Use the matching source under `data/Optional/Locale-Patches/` and pack it as
`Data/<locale>/patch-<locale>-4.MPQ`. It contains only `CharacterCreate.lua` and
does not replace `GlueStrings.lua`.
