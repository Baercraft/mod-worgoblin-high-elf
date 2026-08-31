#!/usr/bin/env python3
from pathlib import Path
import csv, re, struct, sys

ROOT = Path(__file__).resolve().parents[1]
errors=[]

def ok(cond,msg):
    if not cond: errors.append(msg)

# Core patch essentials
core=(ROOT/'integration/mod-worgoblin-highelf-azerothcore.patch').read_text(encoding='utf-8')
pb=(ROOT/'integration/mod-worgoblin-highelf-playerbots.patch').read_text(encoding='utf-8')
ok('RACE_MAGHAR             = 14' in core, 'Core patch lacks RACE_MAGHAR = 14')
ok('EnumUtils<Races>::Count() { return 14; }' in core, 'EnumUtils race count is not 14')
ok('raceStr = "Maghar Orc";' in core, 'GM command race label for Maghar is missing')
ok('RACE_MAGHAR' in pb, 'Playerbots patch lacks RACE_MAGHAR')
ok('Mag\'har Orc' in pb, 'Playerbots patch lacks Maghar display name')

# Essential SQL wiring
checks={
'data/sql/db-world/base/playercreateinfo.sql':['SELECT 14, `class`'],
'data/sql/db-world/base/playercreateinfo_skills.sql':['| 8192','(8192,0,792'],
'data/sql/db-world/base/player_race_stats.sql':['`Race` = 14','SELECT 14'],
'data/sql/db-world/dbc/skillraceclassinfo_dbc.sql':['| 8192','1141,792,8192'],
'data/sql/db-world/dbc/skilllineability_dbc.sql':['110001,8192','110004,8192'],
}
for rel,needles in checks.items():
    text=(ROOT/rel).read_text(encoding='utf-8')
    for n in needles: ok(n in text, f'{rel}: missing {n}')

# Maghar class spell kit must match Orc kit, excluding Orc racials, plus four Maghar racials.
spellfile=ROOT/'data/sql/db-world/base/playercreateinfo_spell_custom.sql'
pat=re.compile(r"\('(?P<race>\d+)',\s*'(?P<class>\d+)',\s*'(?P<spell>\d+)',\s*'(?P<comment>[^']*)'\)")
rows={}
for line in spellfile.read_text(encoding='utf-8').splitlines():
    m=pat.search(line)
    if m:
        rows.setdefault(int(m['race']),{}).setdefault(int(m['class']),set()).add(int(m['spell']))
orc=rows.get(2,{})
mag=rows.get(8192,{})
orc_racials={20572,20573,20574,20575,20576,21563,33697,33702}
mag_racials={110001,110002,110003,110004}
for cls in sorted(set(orc)|set(mag)):
    expected=orc.get(cls,set())-orc_racials
    actual=mag.get(cls,set())-mag_racials
    if cls != 32:
        ok(expected == actual, f'ClassMask {cls}: Maghar class spell kit differs from Orc kit')
    ok(mag_racials.issubset(mag.get(cls,set())), f'ClassMask {cls}: missing one or more Maghar racials')


# Reputation inheritance: Maghar follows Orc; High Elf follows Night Elf.
faction_csv=ROOT/'data/CSV from DBC/Faction.csv'
with faction_csv.open(newline='',encoding='utf-8-sig') as f:
    faction_rows=list(csv.DictReader(f))
for r in faction_rows:
    for idx in range(1,5):
        m=int(r[f'ReputationRaceMask_{idx}'])
        ok(not (m & 2) or bool(m & 8192), f"Faction {r['ID']} slot {idx}: Orc reputation mask lacks Maghar bit")
        ok(not (m & 8) or bool(m & 4096), f"Faction {r['ID']} slot {idx}: Night Elf reputation mask lacks High Elf bit")

faction_dbc=ROOT/'data/patch-A.MPQ/DBFilesClient/Faction.dbc'
raw=faction_dbc.read_bytes()
magic,rc,fc,rs,ss=struct.unpack('<4s4I',raw[:20])
ok(magic==b'WDBC' and fc==57 and rs==228, 'Faction.dbc header/format unexpected')
for n in range(rc):
    off=20+n*rs
    rid=struct.unpack_from('<I',raw,off)[0]
    for idx in range(2,6):
        m=struct.unpack_from('<I',raw,off+idx*4)[0]
        ok(not (m & 2) or bool(m & 8192), f'Faction.dbc {rid} slot {idx-1}: Orc reputation mask lacks Maghar bit')
        ok(not (m & 8) or bool(m & 4096), f'Faction.dbc {rid} slot {idx-1}: Night Elf reputation mask lacks High Elf bit')

# Mandatory Maghar racials must not depend on optional player-create spell tables.
# They are synchronized by the module on character creation/login.
cpp=(ROOT/'src/Worgoblin.cpp').read_text(encoding='utf-8')
for spell in ['110001','110002','110003','110004']:
    ok(spell in cpp, f'Worgoblin.cpp missing Maghar racial {spell}')
ok('SyncMagharRacials(player);' in cpp, 'Maghar racial synchronization hook missing')
ok('SyncInheritedReputationVisibility(player);' in cpp, 'Inherited reputation visibility repair hook missing')
ok(not (ROOT/'data/sql/db-world/base/playercreateinfo_spell.sql').exists(),
   'Legacy playercreateinfo_spell.sql must not be in the auto-update tree')


# Maghar client localization: custom racial spells and skill line must have a non-empty deDE fallback.
spell_csv=ROOT/'data/CSV from DBC/Spell.csv'
with spell_csv.open(newline='',encoding='utf-8-sig') as f:
    spell_rows={r['ID']:r for r in csv.DictReader(f) if r.get('ID') in {'110001','110002','110003','110004'}}
for sid in ['110001','110002','110003','110004']:
    r=spell_rows.get(sid)
    ok(r is not None, f'Spell.csv missing Maghar racial {sid}')
    if r:
        ok(bool(r.get('Name_Lang_deDE')), f'Spell {sid}: missing deDE name/fallback')
        ok(bool(r.get('Description_Lang_deDE')), f'Spell {sid}: missing deDE description/fallback')

skill_csv=ROOT/'data/CSV from DBC/SkillLine.csv'
with skill_csv.open(newline='',encoding='utf-8-sig') as f:
    skill_rows={r['ID']:r for r in csv.DictReader(f)}
r=skill_rows.get('792')
ok(r is not None, 'SkillLine.csv missing Maghar racial skill line 792')
if r:
    ok(bool(r.get('DisplayName_Lang_deDE')), 'SkillLine 792: missing deDE display name/fallback')

# Base patch-A is non-ARAC by default; Mag'har inherits the Orc class set.
cb=ROOT/'data/CSV from DBC/CharBaseInfo.csv'
with cb.open(newline='',encoding='utf-8-sig') as f:
    data=list(csv.DictReader(f))
classes={int(r['ClassID']) for r in data if int(r['RaceID'])==14}
ok(classes == {1,3,4,6,7,9}, f'Base CharBaseInfo race 14 classes wrong: {sorted(classes)}')

# Optional ARAC profile must expose all ten WotLK classes for Race 14.
arac=ROOT/'data/Optional/patch-A-ARAC-overlay/DBFilesClient/CharBaseInfo.dbc'
if arac.exists():
    raw=arac.read_bytes(); _,rc,fc,rs,ss=struct.unpack('<4s4I',raw[:20]); body=raw[20:20+rc*rs]
    arclasses={body[i+1] for i in range(0,len(body),rs) if body[i] == 14}
    ok(arclasses == {1,2,3,4,5,6,7,8,9,11}, f'ARAC CharBaseInfo race 14 classes wrong: {sorted(arclasses)}')
else:
    errors.append('Missing optional ARAC CharBaseInfo.dbc')

# DBC record count must equal CSV record count for key changed DBCs.
for name in ['CharBaseInfo','ChrRaces','SkillLine','SkillLineAbility','SkillRaceClassInfo','Spell','CharStartOutfit','CharSections','CharHairGeosets']:
    dbc=ROOT/f'data/patch-A.MPQ/DBFilesClient/{name}.dbc'
    csvp=ROOT/f'data/CSV from DBC/{name}.csv'
    if not dbc.exists() or not csvp.exists():
        errors.append(f'Missing DBC/CSV pair: {name}')
        continue
    with dbc.open('rb') as f:
        hdr=f.read(20)
    magic,rc,fc,rs,ss=struct.unpack('<4s4I',hdr)
    with csvp.open(newline='',encoding='utf-8-sig') as f:
        csvrows=sum(1 for _ in csv.reader(f))-1
    ok(magic==b'WDBC',f'{name}.dbc is not WDBC')
    ok(rc==csvrows,f'{name}: DBC records {rc} != CSV rows {csvrows}')


# Runtime feature gates and Worgen C++ integration.
cpp=(ROOT/'src/Worgoblin.cpp').read_text(encoding='utf-8')
conf=(ROOT/'conf/mod_worgoblin_high_elf.conf.dist').read_text(encoding='utf-8')
for needle in ['ARAC.Enable', 'FlyAnywhere.Enable', 'Worgen.TwoForms.Enable', 'OnPlayerCanFlyInZone', 'CanAccountCreateCharacter', 'OnPlayerEnterCombat', 'OnPlayerLearnSpell', 'SyncMagharRacials']:
    ok(needle in cpp or needle in conf, f'Missing runtime integration: {needle}')
ok('ARAC.Enable = 0' in conf, 'ARAC default is not OFF')
ok('FlyAnywhere.Enable = 0' in conf, 'FlyAnywhere default is not OFF')
ok('Worgen.TwoForms.Enable = 1' in conf, 'Worgen Two Forms default is not ON')

if errors:
    print('MAGHAR VALIDATION FAILED')
    for e in errors: print(' -',e)
    sys.exit(1)
print('MAGHAR VALIDATION PASSED')
print('Race 14 / RaceMask 8192 static wiring and key DBC/CSV counts are consistent.')
