# 3.3.5a DBC locale slot mapping

This fork uses the locale slot order actually consumed by AzerothCore/WoW 3.3.5a for localized DBC arrays:

| Physical slot | Locale |
|---:|---|
| 0 | enUS |
| 1 | koKR |
| 2 | frFR |
| 3 | deDE |
| 4 | zhCN |
| 5 | zhTW |
| 6 | esES |
| 7 | esMX |
| 8 | ruRU |

Slots 9-15 are not used by AzerothCore's `LocaleConstant` set for this client version.

Some legacy CSV headers in the merged upstream project contain labels such as `enGB`, `enCN`, and `enTW`. Those labels must **not** be used as the physical index mapping for the 3.3.5a client. Doing so shifts frFR/deDE and causes symptoms such as German clients displaying French faction names.

`tools/fix_locale_slots.py` writes the maintained localized entries to the correct physical DBC fields. `tools/validate_locales.py` reads the resulting binary DBCs back and verifies concrete strings in the expected physical slots.
