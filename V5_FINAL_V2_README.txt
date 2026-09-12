mod-worgoblin-high-elf V5 FINAL v2
Build: 2026-09-13

This build is based on V5 FINAL and adds the confirmed stable Ogre face customization update.

Included on top of V5 FINAL:
- Ogre (Race 15) selectable face variants via CharSections.dbc
- Matching Ogre custom face BLP textures
- CharSections.dbc copied to both client patch data and server_dbc_fix for synchronized deployment

Already retained from V5 FINAL:
- ARAC/language/armor fixes
- SQL fixes
- Ogre/Dark Iron FactionTemplate cooperate/invite fix
- No erroneous Playerbots guild patch

Not included:
- Later experimental Ogre hairstyle/horn/piercing geoset tests that did not produce a confirmed visible improvement
- Starter Guild module (separate module; use mod-starter-guild-31R-CUSTOM-RACE-FIX separately)

Installation:
- Use data/patch-A.MPQ content for the client patch.
- Keep server DBCs synchronized using data/server_dbc_fix.
- Recompile the module/core where your existing V5 installation requires it.
