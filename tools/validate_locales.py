#!/usr/bin/env python3
import pathlib, struct
ROOT=pathlib.Path(__file__).resolve().parents[1]
D=ROOT/'data/patch-A.MPQ/DBFilesClient'
LOCALES=['enUS','koKR','frFR','deDE','zhCN','zhTW','esES','esMX','ruRU']

def load(name):
 b=(D/name).read_bytes(); magic,n,f,rs,ss=struct.unpack_from('<4s4I',b,0); assert magic==b'WDBC'
 rec=b[20:20+n*rs]; st=b[20+n*rs:]
 def text(off):
  if not off:return ''
  e=st.find(b'\0',off); return st[off:e].decode('utf-8')
 rows={}
 for j in range(n):
  v=struct.unpack_from('<'+'I'*f,rec,j*rs); rows[v[0]]=v
 return rows,text

def block(rows,text,rid,start): return [text(rows[rid][start+i]) for i in range(9)]

rows,s=load('Faction.dbc')
b=block(rows,s,2,23)
assert b[0]=='PLAYER, Orc', b
assert b[2]=='JOUEUR, Orc', b
assert b[3]=='SPIELER, Orc', b
assert '兽人' in b[4], b
assert b[6]=='JUGADOR, orco', b
assert 'ИГРОК' in b[8], b

rows,s=load('ChrRaces.dbc')
b=block(rows,s,14,14)
assert b[0]=="Mag'har Orc", b
assert b[2]=="Orc mag'har", b
assert b[3]=="Mag'har-Orc", b
assert '玛格汉' in b[4], b
assert 'Орк' in b[8], b

rows,s=load('SkillLine.dbc')
b=block(rows,s,792,3)
assert b[0]=="Racial - Mag'har Orc", b
assert b[2]=="Racial - Orc mag'har", b
assert b[3]=="Rassenfähigkeit - Mag'har-Orc", b
assert '玛格汉' in b[4], b
assert 'Расовая' in b[8], b

rows,s=load('Spell.dbc')
name=block(rows,s,110001,136); desc=block(rows,s,110001,170)
assert name[0]=='Ancestral Call', name
assert name[2]=='Appel ancestral', name
assert name[3]=='Ruf der Ahnen', name
assert name[4]=='先祖召唤', name
assert name[5]=='先祖召喚', name
assert name[6]=='Llamada ancestral', name
assert name[8]=='Зов предков', name
assert desc[3].startswith('Ruft die Kraft'), desc
assert desc[2].startswith('Invoque la force'), desc
assert desc[8].startswith('Призывает силу'), desc

lua=(ROOT/'data/patch-A.MPQ/Interface/GlueXML/CharacterCreate.lua').read_text(encoding='utf-8')
for loc in ['deDE','enUS','frFR','esES','esMX','ruRU','zhCN','zhTW']:
 assert loc in lua, f'CharacterCreate.lua missing {loc}'
print('LOCALE SLOT VALIDATION PASSED')
