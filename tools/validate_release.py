#!/usr/bin/env python3
from pathlib import Path
import csv, re, struct, sys, hashlib, collections

ROOT = Path(__file__).resolve().parents[1]
errors=[]

def ok(cond,msg):
    if not cond: errors.append(msg)

def sha(p):
    h=hashlib.sha256(); h.update(Path(p).read_bytes()); return h.hexdigest()

# Core/playerbots patch essentials and clean git paths.
core=(ROOT/'integration/mod-worgoblin-highelf-azerothcore.patch').read_text(encoding='utf-8')
pb=(ROOT/'integration/mod-worgoblin-highelf-playerbots.patch').read_text(encoding='utf-8')
ok('RACE_MAGHAR             = 14' in core, 'Core patch lacks RACE_MAGHAR = 14')
ok('EnumUtils<Races>::Count() { return 14; }' in core, 'EnumUtils race count is not 14')
ok('raceStr = "Maghar Orc";' in core, 'GM command race label for Maghar is missing')
ok('RACE_MAGHAR' in pb, 'Playerbots patch lacks RACE_MAGHAR')
ok('case RACE_MAGHAR:' in core and 'return TEAM_HORDE;' in core, 'Core patch lacks explicit Maghar Horde mapping')
ok('barberBaseRace = RACE_ORC;' in core, 'Core patch lacks Maghar -> Orc barber fallback')
ok('barberBaseRace = RACE_BLOODELF;' in core, 'Core patch lacks High Elf -> Blood Elf barber fallback')
ok('barberBaseRace = RACE_HUMAN;' in core, 'Core patch lacks Worgen -> Human barber fallback')
ok("Mag'har Orc" in pb, 'Playerbots patch lacks Maghar display name')
for text,name in [(core,'core'),(pb,'playerbots')]:
    ok('originals/' not in text and 'merged/' not in text, f'{name} patch still contains internal snapshot paths')
    ok(text.startswith('diff --git a/'), f'{name} patch is not git-apply formatted')

# Fly Anywhere: A always carries fly-capable AreaTable; server gate turns it off when requested.
a_area=ROOT/'data/patch-A.MPQ/DBFilesClient/AreaTable.dbc'
expected_fly_area_sha='4e1b3495ca7bcd4929ada743a506d845c12e8a58b6cbc8a7447f5dce9718c4d7'
ok(sha(a_area)==expected_fly_area_sha, 'patch-A AreaTable is not the validated fly-capable build required for config gating')

# Essential SQL wiring.
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

# playercreateinfo_skills racemask is part of its primary key; in-place
# racemask UPDATEs can collide on repeated/partial installs.
skills_sql=(ROOT/'data/sql/db-world/base/playercreateinfo_skills.sql').read_text(encoding='utf-8').lower()
ok(not re.search(r'update\s+`?playercreateinfo_skills`?\s+set\s+`?racemask`?', skills_sql),
   'playercreateinfo_skills.sql: unsafe in-place racemask UPDATE found')

# No duplicate composite keys in the main merged creation datasets.
def numeric_rows(path,k):
    rows=[]
    text=Path(path).read_text(encoding='utf-8',errors='ignore')
    for m in re.finditer(r'\(([^;()]+)\)',text):
        vals=[v.strip().strip("'`") for v in m.group(1).split(',')]
        if len(vals)>=k and all(re.fullmatch(r'-?\d+',x or '') for x in vals[:k]):
            rows.append(tuple(vals[:k]))
    return rows
for rel,k in [
('data/sql/db-world/base/playercreateinfo.sql',2),
('data/sql/db-world/base/playercreateinfo_action.sql',3),
('data/sql/db-world/base/playercreateinfo_skills.sql',3),
('data/sql/db-world/base/playercreateinfo_spell_custom.sql',3),
('data/sql/db-world/base/playercreateinfo_cast_spell.sql',3),
]:
    rows=numeric_rows(ROOT/rel,k); dup=[x for x,n in collections.Counter(rows).items() if n>1]
    ok(not dup, f'{rel}: duplicate composite keys found: {dup[:5]}')

# Maghar class spell kit must match Orc kit, excluding Orc racials, plus Maghar racials.
spellfile=ROOT/'data/sql/db-world/base/playercreateinfo_spell_custom.sql'
pat=re.compile(r"\('(?P<race>\d+)',\s*'(?P<class>\d+)',\s*'(?P<spell>\d+)',\s*'(?P<comment>[^']*)'\)")
rows={}
for line in spellfile.read_text(encoding='utf-8').splitlines():
    m=pat.search(line)
    if m: rows.setdefault(int(m['race']),{}).setdefault(int(m['class']),set()).add(int(m['spell']))
orc=rows.get(2,{}); mag=rows.get(8192,{})
orc_racials={20572,20573,20574,20575,20576,21563,33697,33702}; mag_racials={110001,110002,110003,110004}
for cls in sorted(set(orc)|set(mag)):
    expected=orc.get(cls,set())-orc_racials; actual=mag.get(cls,set())-mag_racials
    if cls != 32: ok(expected == actual, f'ClassMask {cls}: Maghar class spell kit differs from Orc kit')
    ok(mag_racials.issubset(mag.get(cls,set())), f'ClassMask {cls}: missing one or more Maghar racials')

# Base patch-A is non-ARAC; optional A overlay enables ARAC.
cb=ROOT/'data/CSV from DBC/CharBaseInfo.csv'
with cb.open(newline='',encoding='utf-8-sig') as f: data=list(csv.DictReader(f))
classes={int(r['ClassID']) for r in data if int(r['RaceID'])==14}
ok(classes == {1,3,4,6,7,9}, f'Base CharBaseInfo race 14 classes wrong: {sorted(classes)}')
arac=ROOT/'data/Optional/patch-A-ARAC-overlay/DBFilesClient/CharBaseInfo.dbc'
if arac.exists():
    raw=arac.read_bytes(); _,rc,fc,rs,ss=struct.unpack('<4s4I',raw[:20]); body=raw[20:20+rc*rs]
    arclasses={body[i+1] for i in range(0,len(body),rs) if body[i] == 14}
    ok(arclasses == {1,2,3,4,5,6,7,8,9,11}, f'ARAC overlay race 14 classes wrong: {sorted(arclasses)}')
else: errors.append('Missing optional patch-A ARAC overlay')

# DBC record count equals CSV record count for key changed DBCs.
for name in ['CharBaseInfo','ChrRaces','SkillLine','SkillLineAbility','SkillRaceClassInfo','Spell','CharStartOutfit','CharSections','CharHairGeosets']:
    dbc=ROOT/f'data/patch-A.MPQ/DBFilesClient/{name}.dbc'; csvp=ROOT/f'data/CSV from DBC/{name}.csv'
    if not dbc.exists() or not csvp.exists(): errors.append(f'Missing DBC/CSV pair: {name}'); continue
    magic,rc,fc,rs,ss=struct.unpack('<4s4I',dbc.read_bytes()[:20])
    with csvp.open(newline='',encoding='utf-8-sig') as f: csvrows=sum(1 for _ in csv.reader(f))-1
    ok(magic==b'WDBC',f'{name}.dbc is not WDBC'); ok(rc==csvrows,f'{name}: DBC records {rc} != CSV rows {csvrows}')

# Runtime gates and current hook signatures.
cpp=(ROOT/'src/Worgoblin.cpp').read_text(encoding='utf-8'); conf=(ROOT/'conf/mod_worgoblin_high_elf.conf.dist').read_text(encoding='utf-8')
for needle in ['ARAC.Enable','FlyAnywhere.Enable','Worgen.TwoForms.Enable','OnPlayerCanFlyInZone','CanAccountCreateCharacter','OnPlayerEnterCombat','OnPlayerLearnSpell']:
    ok(needle in cpp or needle in conf, f'Missing runtime integration: {needle}')
ok('OnPlayerResurrect(Player* player, float /*restorePercent*/, bool& /*applySickness*/)' in cpp, 'OnPlayerResurrect does not use current AzerothCore bool& signature')
ok('ARAC.Enable = 0' in conf,'ARAC default is not OFF'); ok('FlyAnywhere.Enable = 0' in conf,'FlyAnywhere default is not OFF'); ok('Worgen.TwoForms.Enable = 1' in conf,'Worgen Two Forms default is not ON')

if errors:
    print('RELEASE VALIDATION FAILED')
    for e in errors: print(' -',e)
    sys.exit(1)
print('RELEASE VALIDATION PASSED')
print('Custom races, Maghar wiring, DBC/CSV counts, SQL composite keys and runtime gates are consistent.')
