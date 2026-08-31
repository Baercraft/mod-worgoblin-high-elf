# World database SQL

Do **not** import the files in this directory manually when using AzerothCore's normal module database updater.

AzerothCore discovers and applies the SQL files under `data/sql/db-world/` automatically. Mixing manual imports with the automatic updater can cause duplicate update records and partial/repeated installations.

Required custom-race SQL is located in:

- `base/`
- `dbc/`

These files are written so that module updates can be reapplied safely where practical.

Optional content is intentionally kept **outside** `db-world` under `data/sql/optional-world/` so the automatic updater does not install it accidentally.

Legacy/manual recovery scripts are kept under `data/sql/manual/` and are not part of the automatic installation path.
