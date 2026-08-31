Baercraft v5.9 - locale GlueXML overlays

WHY
The 3.3.5a locale MPQs can override Interface/GlueXML/CharacterCreate.lua from the
common Data/patch-A.MPQ. That is why custom race descriptions may work in enUS but
be missing in deDE/frFR/esES/etc.

INSTALL
Pack/copy ONLY the folder matching the client locale as a locale MPQ in Data/<locale>/:

  deDE -> Data/deDE/patch-deDE-4.MPQ
  frFR -> Data/frFR/patch-frFR-4.MPQ
  esES -> Data/esES/patch-esES-4.MPQ
  esMX -> Data/esMX/patch-esMX-4.MPQ
  ruRU -> Data/ruRU/patch-ruRU-4.MPQ
  zhCN -> Data/zhCN/patch-zhCN-4.MPQ
  zhTW -> Data/zhTW/patch-zhTW-4.MPQ

Each MPQ must contain:
  Interface/GlueXML/CharacterCreate.lua

Do not add GlueStrings.lua. The stock locale strings remain untouched.
No server recompile and no SQL changes are required.
