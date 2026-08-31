#!/usr/bin/env python3
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parents[1]
DBC = ROOT / 'data/patch-A.MPQ/DBFilesClient/BarberShopStyle.dbc'
CSV = ROOT / 'data/CSV from DBC/BarberShopStyle.csv'
GLUE = ROOT / 'data/patch-A.MPQ/Interface/GlueXML/GlueStrings.lua'

# Race IDs currently maintained by this release.
GOBLIN = 9
WORGEN = 12
HIGH_ELF = 13
MAGHAR = 14
ORC = 2
BLOOD_ELF = 10

b = DBC.read_bytes()
magic, count, fields, recsize, strsize = struct.unpack_from('<4s4I', b, 0)
assert magic == b'WDBC'
assert fields == 40 and recsize == 160, (fields, recsize)
rows=[]
for i in range(count):
    rows.append(list(struct.unpack_from('<40I', b, 20 + i*recsize)))

def race_rows(race):
    return [r for r in rows if r[37] == race]

def normalized(r):
    x=r.copy(); x[0]=0; x[37]=0; return x

assert race_rows(GOBLIN), 'Goblin has no BarberShopStyle records'
assert race_rows(WORGEN), 'Worgen has no BarberShopStyle records'
assert race_rows(HIGH_ELF), 'High Elf has no BarberShopStyle records'
assert race_rows(MAGHAR), 'Maghar has no BarberShopStyle records'

# High Elf intentionally inherits Blood Elf barber choices.
he = race_rows(HIGH_ELF); be = race_rows(BLOOD_ELF)
assert len(he) == len(be), (len(he), len(be))
assert [normalized(r) for r in he] == [normalized(r) for r in be], 'High Elf barber data differs from Blood Elf base'

# Mag'har intentionally inherits Orc barber choices.
ma = race_rows(MAGHAR); oc = race_rows(ORC)
assert len(ma) == len(oc), (len(ma), len(oc))
assert [normalized(r) for r in ma] == [normalized(r) for r in oc], "Mag'har barber data differs from Orc base"

# Do not ship a full enUS GlueStrings.lua: it replaces the stock locale file
# and makes generic glue UI (DELETE/CANCEL/etc.) English in every client locale.
assert not GLUE.exists(), 'patch-A must not override localized GlueStrings.lua'

# Source CSV should represent the binary Mag'har barber rows as well.
import csv
with CSV.open(encoding='utf-8-sig', newline='') as f:
    src=list(csv.DictReader(f))
assert sum(1 for r in src if r['Race'] == '14') == len(ma), 'BarberShopStyle.csv is not synchronized for Maghar'

print('BARBERSHOP / GLUE LOCALIZATION VALIDATION PASSED')
