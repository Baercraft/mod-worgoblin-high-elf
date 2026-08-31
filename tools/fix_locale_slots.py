#!/usr/bin/env python3
import csv, pathlib, struct
ROOT = pathlib.Path(__file__).resolve().parents[1]
CSV = ROOT / 'data/CSV from DBC'
DBC = ROOT / 'data/patch-A.MPQ/DBFilesClient'
LOCALES = ['enUS','koKR','frFR','deDE','zhCN','zhTW','esES','esMX','ruRU']


def read_csv(name):
    with (CSV/name).open(encoding='utf-8-sig', newline='') as f:
        return list(csv.DictReader(f))


def patch_dbc(path, patches):
    b = bytearray(path.read_bytes())
    magic, n, f, rs, ss = struct.unpack_from('<4s4I', b, 0)
    assert magic == b'WDBC'
    rec_start = 20
    str_start = rec_start + n*rs
    strings = bytearray(b[str_start:str_start+ss])
    offsets = {}
    def put(s):
        if not s:
            return 0
        if s in offsets:
            return offsets[s]
        raw = s.encode('utf-8') + b'\0'
        off = len(strings)
        strings.extend(raw)
        offsets[s] = off
        return off
    id_to_row = {}
    for j in range(n):
        rid = struct.unpack_from('<I', b, rec_start+j*rs)[0]
        id_to_row[rid] = j
    for rid, fieldmap in patches.items():
        if rid not in id_to_row:
            raise RuntimeError(f'{path.name}: missing ID {rid}')
        j=id_to_row[rid]
        base=rec_start+j*rs
        for field, text in fieldmap.items():
            struct.pack_into('<I', b, base+field*4, put(text))
    struct.pack_into('<I', b, 16, len(strings))
    path.write_bytes(b[:str_start] + strings)


def locale_value(row, prefix, loc):
    # legacy CSVs use expanded labels; use them only as semantic source data.
    v = row.get(f'{prefix}_Lang_{loc}', '') or ''
    if not v and loc == 'zhTW':
        v = row.get(f'{prefix}_Lang_zhCN', '') or ''
    if not v:
        v = row.get(f'{prefix}_Lang_enUS', '') or ''
    return v

# Faction: fix every record because this DBC was rebuilt with the expanded/enGB layout.
frows = {int(r['ID']):r for r in read_csv('Faction.csv') if r.get('ID','').isdigit()}
patches={}
for rid,r in frows.items():
    fm={}
    for start,prefix in [(23,'Name'),(40,'Description')]:
        for slot,loc in enumerate(LOCALES): fm[start+slot]=locale_value(r,prefix,loc)
    patches[rid]=fm
patch_dbc(DBC/'Faction.dbc', patches)

# ChrRaces: same expanded/enGB issue; fix all name blocks.
rrows = {int(r['ID']):r for r in read_csv('ChrRaces.csv') if r.get('ID','').isdigit()}
patches={}
for rid,r in rrows.items():
    fm={}
    for start,prefix in [(14,'Name'),(31,'Name_Female'),(48,'Name_Male')]:
        for slot,loc in enumerate(LOCALES): fm[start+slot]=locale_value(r,prefix,loc)
    patches[rid]=fm
patch_dbc(DBC/'ChrRaces.dbc', patches)

# SkillLine stock rows are already in compact 3.3.5 order; repair only our custom rows.
srows = {int(r['ID']):r for r in read_csv('SkillLine.csv') if r.get('ID','').isdigit()}
patches={}
for rid in (789,790,791,792,793):
    r=srows[rid]; fm={}
    for start,prefix in [(3,'DisplayName'),(20,'Description'),(38,'AlternateVerb')]:
        for slot,loc in enumerate(LOCALES): fm[start+slot]=locale_value(r,prefix,loc)
    patches[rid]=fm
patch_dbc(DBC/'SkillLine.dbc', patches)

# Spell.dbc has 234 physical fields. Legacy CSV headers are two fields short, so use
# the CSV only as translation source and the real 3.3.5 physical field positions here.
sp_rows = {int(r['ID']):r for r in read_csv('Spell.csv') if r.get('ID','').isdigit() and int(r['ID']) in (110001,110002,110003,110004)}
patches={}
for rid,r in sp_rows.items():
    fm={}
    for start,prefix in [(136,'Name'),(153,'NameSubtext'),(170,'Description'),(187,'AuraDescription')]:
        for slot,loc in enumerate(LOCALES): fm[start+slot]=locale_value(r,prefix,loc)
    patches[rid]=fm
patch_dbc(DBC/'Spell.dbc', patches)
print('DBC LOCALE SLOTS FIXED')
