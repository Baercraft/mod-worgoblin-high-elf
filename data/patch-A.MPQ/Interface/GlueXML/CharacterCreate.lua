-- Baercraft clean client overlay: custom races only; Blizzard locale strings stay untouched.
local BAER_LOCALE=(GetLocale and GetLocale()) or "enUS";
local BAER_TEXT={};
BAER_TEXT["enUS"]={};
BAER_TEXT["enUS"]["WORGEN"]={name="Worgen",zone="Teldrassil",info="Behind the ferocity of the worgen beats a human heart. These cursed warriors have learned to master the beast within and now lend their speed, instincts, and fierce resolve to the Alliance.",abilities={"Viciousness — Increases critical strike chance.","Darkflight — Greatly increases movement speed for a short time.","Aberration — Reduces the duration of curses and diseases.","Flayer — Skinning is faster and your skill is increased.","Language: Common."}};
BAER_TEXT["enUS"]["GOBLIN"]={name="Goblin",zone="Durotar",info="For goblins, opportunity is worth more than gold. Brilliant engineers and ruthless negotiators, these explosive members of the Horde turn speed, rockets, chemistry and commerce into deadly advantages.",abilities={"Time is Money — Increases attack and casting speed.","Rocket Jump — Launches you forward with a rocket belt.","Rocket Barrage — Fires explosive rockets at an enemy.","Best Deals Anywhere — Grants the best vendor discounts.","Pack Hobgoblin — Calls a personal bank assistant.","Language: Orcish."}};
BAER_TEXT["enUS"]["HIGHELF"]={name="High Elf",zone="Elwynn Forest",info="The quel'dorei who remained loyal to the Alliance refused to follow their blood elven kin into the Horde. Disciplined and steeped in ancient magic, these high elves combine Thalassian tradition with the keen reflexes of veteran rangers.",abilities={"Quel'dorei Meditation — Restores your primary combat resource through focused meditation.","Swiftness of the Rangers — Grants the practiced agility of high elven rangers.","Language: Thalassian."}};
BAER_TEXT["enUS"]["MAGHAR"]={name="Mag'har Orc",zone="Durotar",info="The Mag'har are the uncorrupted orc clans who escaped the fel taint that changed so many of their kin. Proud of their Draenor heritage, they bring ancestral strength, hardiness and an unbreakable clan spirit to the Horde.",abilities={"Ancestral Call — Draw upon the strength of your ancestors.","Savage Blood — Grants natural resilience.","Sympathetic Vigor — Strengthens the bond with your companion.","Unwavering Will — Helps resist disabling effects.","Language: Orcish."}};
BAER_TEXT["enUS"]["OGRE"]={name="Ogre",zone="Durotar",info="The Stonemaul ogres have found a place among the Horde. Their enormous strength, thick hides, fierce clan loyalty and legendary stubbornness make them formidable allies on any battlefield.",abilities={"Ogre's Might — Increases attack power for a short time.","Thick Hide — Increases base health.","Clan Bond — Your pets deal increased damage.","Stubborn as Stone — Reduces the duration of stun effects.","Language: Orcish."}};
BAER_TEXT["enUS"]["DARKIRONDWARF"]={name="Dark Iron Dwarf",zone="Dun Morogh",info="Forged in the shadow of Blackrock Mountain, the Dark Iron dwarves are a hard-bitten people of master smiths, riflemen and subterranean fighters. Their return to the Alliance brings fiery resolve, ancient craft and a stubborn strength tempered in flame.",abilities={"Fireblood — Purges harmful effects and hardens the body.","Black Anvil Training — Improves your skill with firearms.","Forged in Flame — Grants increased resistance to Fire.","Secrets Below — Reveals nearby treasure.","Languages: Common and Dwarven."}};
BAER_TEXT["deDE"]={};
BAER_TEXT["deDE"]["WORGEN"]={name="Worgen",zone="Teldrassil",info="Hinter der Wildheit der Worgen schlägt noch immer ein menschliches Herz. Diese Verfluchten haben gelernt, die Bestie in ihrem Inneren zu beherrschen, und stellen nun Schnelligkeit, Instinkt und unerbittliche Entschlossenheit in den Dienst der Allianz.",abilities={"Bösartigkeit — Erhöht die Chance auf kritische Treffer.","Dunkelflucht — Erhöht für kurze Zeit deutlich das Bewegungstempo.","Aberration — Verringert die Dauer von Flüchen und Krankheiten.","Kürschner — Kürschnerei wird schneller ausgeführt und Euer Können ist erhöht.","Sprache: Gemeinsprache."}};
BAER_TEXT["deDE"]["GOBLIN"]={name="Goblin",zone="Durotar",info="Für Goblins ist eine Gelegenheit oft mehr wert als Gold. Als geniale Ingenieure und gnadenlose Händler verwandeln diese explosiven Mitglieder der Horde Geschwindigkeit, Raketen, Chemie und Geschäftssinn in tödliche Vorteile.",abilities={"Zeit ist Geld — Erhöht Angriffs- und Zaubertempo.","Raketensprung — Schleudert Euch mit einem Raketengürtel nach vorn.","Raketenbeschuss — Feuert explosive Raketen auf einen Gegner.","Überall die besten Preise — Gewährt die besten Händlerpreise.","Packhobgoblin — Ruft einen persönlichen Bankgehilfen.","Sprache: Orcisch."}};
BAER_TEXT["deDE"]["HIGHELF"]={name="Hochelf",zone="Wald von Elwynn",info="Die Quel'dorei, die der Allianz treu blieben, weigerten sich, ihren blutelfischen Verwandten in die Horde zu folgen. Diszipliniert und von uralter Magie geprägt verbinden diese Hochelfen thalassische Tradition mit den geschärften Reflexen erfahrener Waldläufer.",abilities={"Quel'dorei-Meditation — Stellt durch konzentrierte Meditation Eure wichtigste Kampfressource wieder her.","Flinkheit der Waldläufer — Verleiht Euch die geübte Beweglichkeit hochelfischer Waldläufer.","Sprache: Thalassisch."}};
BAER_TEXT["deDE"]["MAGHAR"]={name="Mag'har-Orc",zone="Durotar",info="Die Mag'har sind jene unverdorbenen Orcclans, die dem dämonischen Makel entgingen. Stolz auf ihr Erbe aus Draenor bringen sie die Kraft ihrer Ahnen, große Widerstandsfähigkeit und einen unerschütterlichen Clangeist in die Horde ein.",abilities={"Ruf der Ahnen — Ruft die Stärke Eurer Vorfahren an.","Wildes Blut — Verleiht natürliche Widerstandskraft.","Verbündete Lebenskraft — Stärkt die Bindung zu Eurem Begleiter.","Unerschütterlicher Wille — Hilft gegen Kontrollverlust.","Sprache: Orcisch."}};
BAER_TEXT["deDE"]["OGRE"]={name="Oger",zone="Durotar",info="Die Oger des Steinbrecherklans haben ihren Platz in der Horde gefunden. Ihre gewaltige Kraft, dicke Haut, starke Clantreue und sprichwörtliche Sturheit machen sie zu furchterregenden Verbündeten.",abilities={"Ogerstärke — Erhöht für kurze Zeit Eure Angriffskraft.","Dicke Haut — Erhöht Eure Grundgesundheit.","Clanbindung — Eure Begleiter verursachen erhöhten Schaden.","Stur wie Stein — Verringert die Dauer von Betäubungseffekten.","Sprache: Orcisch."}};
BAER_TEXT["deDE"]["DARKIRONDWARF"]={name="Dunkeleisenzwerg",zone="Dun Morogh",info="Im Schatten des Schwarzfels geschmiedet sind die Dunkeleisenzwerge ein unbeugsames Volk aus Meisterschmieden, Schützen und erfahrenen Kämpfern der Tiefen. Ihre Rückkehr zur Allianz bringt feurige Entschlossenheit, uraltes Handwerk und eine im Feuer gehärtete Widerstandskraft.",abilities={"Feuerblut — Reinigt schädliche Effekte und härtet den Körper.","Ausbildung am Schwarzen Amboss — Verbessert den Umgang mit Schusswaffen.","In Flammen geschmiedet — Erhöht den Feuerwiderstand.","Geheimnisse der Tiefe — Spürt Schätze in der Nähe auf.","Sprachen: Gemeinsprache und Zwergisch."}};
BAER_TEXT["frFR"]={};
BAER_TEXT["frFR"]["WORGEN"]={name="Worgen",zone="Teldrassil",info="Sous la férocité des worgens bat encore un cœur humain. Ces maudits ont appris à maîtriser la bête qui sommeille en eux et mettent désormais leur vitesse, leur instinct et leur détermination au service de l'Alliance.",abilities={"Acharnement — augmente les chances de coup critique.","Sombre course — augmente fortement la vitesse de déplacement.","Aberration — réduit la durée des malédictions et maladies.","Écorcheur — le dépeçage est plus rapide.","Langue : commun."}};
BAER_TEXT["frFR"]["GOBLIN"]={name="Gobelin",zone="Durotar",info="Pour un gobelin, une bonne occasion vaut parfois plus que l'or. Ingénieurs brillants et négociateurs impitoyables, ces membres explosifs de la Horde transforment vitesse, fusées, chimie et commerce en avantages mortels.",abilities={"Le temps, c’est de l’argent — augmente la vitesse d’attaque et d’incantation.","Fusée de saut — vous propulse vers l’avant.","Barrage de fusées — lance des roquettes explosives.","Les meilleures affaires — garantit les meilleurs prix.","Hobgobelin de bât — appelle un assistant bancaire.","Langue : orc."}};
BAER_TEXT["frFR"]["HIGHELF"]={name="Haut-elfe",zone="Forêt d'Elwynn",info="Les quel'dorei restés fidèles à l'Alliance refusèrent de suivre leurs cousins elfes de sang dans la Horde. Disciplinés et imprégnés d'une magie ancienne, ils unissent les traditions thalassiennes aux réflexes aiguisés des forestiers.",abilities={"Méditation quel’dorei — restaure votre ressource de combat principale.","Célérité des forestiers — confère l’agilité des forestiers hauts-elfes.","Langue : thalassien."}};
BAER_TEXT["frFR"]["MAGHAR"]={name="Orc mag'har",zone="Durotar",info="Les Mag'har sont les clans orcs non corrompus qui échappèrent à la souillure gangrenée. Fiers de leur héritage de Draenor, ils apportent à la Horde la force des ancêtres, l'endurance et un esprit de clan inébranlable.",abilities={"Appel ancestral — invoque la force de vos ancêtres.","Sang sauvage — confère une résistance naturelle.","Vigueur compatissante — renforce le lien avec votre compagnon.","Volonté inébranlable — aide à résister aux effets de contrôle.","Langue : orc."}};
BAER_TEXT["frFR"]["OGRE"]={name="Ogre",zone="Durotar",info="Les ogres Cognepierre ont trouvé leur place au sein de la Horde. Leur force immense, leur peau épaisse, leur loyauté au clan et leur obstination légendaire en font de redoutables alliés.",abilities={"Puissance ogre — augmente brièvement la puissance d’attaque.","Peau épaisse — augmente les points de vie de base.","Lien du clan — vos familiers infligent davantage de dégâts.","Têtu comme la pierre — réduit la durée des étourdissements.","Langue : orc."}};
BAER_TEXT["frFR"]["DARKIRONDWARF"]={name="Nain sombrefer",zone="Dun Morogh",info="Forgés dans l’ombre du mont Rochenoire, les nains sombrefers sont des maîtres forgerons, tireurs et combattants des profondeurs. Leur retour au sein de l’Alliance apporte une volonté ardente et une résistance trempée dans les flammes.",abilities={"Sang-de-feu — Dissipe les effets néfastes et endurcit le corps.","Entraînement de l’Enclume noire — Améliore le maniement des armes à feu.","Forgé dans les flammes — Augmente la résistance au Feu.","Secrets des profondeurs — Révèle les trésors proches.","Langues : commun et nain."}};

BAER_TEXT["esES"]={
 WORGEN={name="Huargen",zone="Teldrassil",info="Tras la ferocidad de los huargen aún late un corazón humano. Han aprendido a dominar a la bestia interior y ponen su velocidad, instinto y determinación al servicio de la Alianza.",abilities={"Sañoso — aumenta la probabilidad de golpe crítico.","Huida oscura — aumenta mucho la velocidad de movimiento durante un breve periodo.","Aberración — reduce la duración de maldiciones y enfermedades.","Desollador — permite desollar con mayor rapidez.","Idioma: común."}},
 GOBLIN={name="Goblin",zone="Durotar",info="Para un goblin, una oportunidad puede valer más que el oro. Ingenieros brillantes y negociadores despiadados convierten velocidad, cohetes, química y comercio en ventajas letales para la Horda.",abilities={"El tiempo es oro — aumenta la velocidad de ataque y lanzamiento.","Salto con cohete — te impulsa hacia delante.","Tromba de cohetes — dispara cohetes explosivos.","Las mejores ofertas — garantiza los mejores precios.","Hobgoblin de carga — llama a un ayudante bancario.","Idioma: orco."}},
 HIGHELF={name="Alto elfo",zone="Bosque de Elwynn",info="Los quel'dorei que permanecieron leales a la Alianza se negaron a seguir a sus parientes elfos de sangre a la Horda. Disciplinados y versados en magia antigua, combinan la tradición thalassiana con los reflejos de los forestales.",abilities={"Meditación quel'dorei — restaura tu recurso de combate principal.","Presteza de los forestales — otorga la agilidad de los forestales altos elfos.","Idioma: thalassiano."}},
 MAGHAR={name="Orco Mag'har",zone="Durotar",info="Los Mag'har son los clanes orcos incorruptos que escaparon de la mácula vil. Orgullosos de su legado de Draenor, aportan a la Horda fuerza ancestral, resistencia y un espíritu de clan inquebrantable.",abilities={"Llamada ancestral — invoca la fuerza de tus antepasados.","Sangre salvaje — otorga resistencia natural.","Vigor afín — fortalece el vínculo con tu compañero.","Voluntad inquebrantable — ayuda a resistir efectos incapacitantes.","Idioma: orco."}},
 OGRE={name="Ogro",zone="Durotar",info="Los ogros Quebrantarrocas han encontrado su lugar en la Horda. Su enorme fuerza, piel gruesa, lealtad al clan y obstinación legendaria los convierten en aliados temibles.",abilities={"Poder de ogro — aumenta brevemente tu poder de ataque.","Piel gruesa — aumenta tu salud base.","Vínculo del clan — tus mascotas infligen más daño.","Terco como una piedra — reduce la duración de los aturdimientos.","Idioma: orco."}},
 DARKIRONDWARF={name="Enano Hierro Negro",zone="Dun Morogh",info="Los enanos Hierro Negro fueron templados por el fuego de Roca Negra. Maestros de la forja, las armas de fuego y la guerra subterránea, aportan su tenacidad a la Alianza.",abilities={"Sangre de fuego — elimina efectos perjudiciales.","Entrenamiento del Yunque Negro — mejora el uso de armas de fuego.","Forjado en llamas — aumenta la resistencia al Fuego.","Secretos de las profundidades — revela tesoros cercanos.","Idiomas: común y enánico."}}
};
BAER_TEXT["esMX"]=BAER_TEXT["esES"];
BAER_TEXT["ruRU"]={
 WORGEN={name="Ворген",zone="Тельдрассил",info="За звериной яростью воргенов всё ещё бьётся человеческое сердце. Они научились владеть внутренним зверем и служат Альянсу благодаря скорости, инстинктам и несгибаемой воле.",abilities={"Злобность — повышает вероятность критического удара.","Черный бег — значительно повышает скорость передвижения.","Аберрация — сокращает длительность проклятий и болезней.","Скорняк — ускоряет снятие шкур.","Язык: всеобщий."}},
 GOBLIN={name="Гоблин",zone="Дуротар",info="Для гоблина удачная возможность порой дороже золота. Гениальные инженеры и беспощадные торговцы превращают скорость, ракеты, химию и коммерцию в оружие Орды.",abilities={"Время — деньги — повышает скорость атаки и произнесения заклинаний.","Реактивный прыжок — бросает вас вперед.","Ракетный обстрел — выпускает взрывные ракеты.","Выгодные сделки — лучшие цены у торговцев.","Карманный хобгоблин — вызывает банковского помощника.","Язык: орочий."}},
 HIGHELF={name="Высший эльф",zone="Элвиннский лес",info="Кель'дорай, сохранившие верность Альянсу, отказались следовать за кровавыми эльфами в Орду. Древняя магия и традиции Талассии сочетаются в них с реакцией опытных следопытов.",abilities={"Медитация кель'дорай — восстанавливает основной боевой ресурс.","Стремительность следопытов — дарует ловкость высших эльфов.","Язык: талассийский."}},
 MAGHAR={name="Орк маг'хар",zone="Дуротар",info="Маг'хары — незапятнанные орочьи кланы, избежавшие скверны. Гордясь наследием Дренора, они несут Орде силу предков, выносливость и несокрушимый дух клана.",abilities={"Зов предков — призывает силу предков.","Дикая кровь — дает природную стойкость.","Родственная мощь — укрепляет связь со спутником.","Непоколебимая воля — помогает сопротивляться эффектам контроля.","Язык: орочий."}},
 OGRE={name="Огр",zone="Дуротар",info="Огры клана Каменного Молота нашли своё место в Орде. Огромная сила, толстая шкура, верность клану и легендарное упрямство делают их грозными союзниками.",abilities={"Сила огра — временно повышает силу атаки.","Толстая шкура — увеличивает базовый запас здоровья.","Узы клана — питомцы наносят больше урона.","Упрямство камня — сокращает длительность оглушения.","Язык: орочий."}},
 DARKIRONDWARF={name="Дворф Черного Железа",zone="Дун Морог",info="Дворфы Черного Железа закалены огнем Черной горы и славятся кузнечным делом, огнестрельным оружием и подземной войной.",abilities={"Огненная кровь — снимает вредоносные эффекты.","Школа Черной Наковальни — улучшает владение огнестрельным оружием.","Закаленный в пламени — повышает сопротивление огню.","Тайны глубин — помогают находить сокровища.","Языки: всеобщий и дворфийский."}}
};
BAER_TEXT["zhCN"]={
 WORGEN={name="狼人",zone="泰达希尔",info="狼人已经学会驾驭体内的野性，并以速度、直觉和坚定意志为联盟效力。",abilities={"恶意 — 提高暴击几率。","疾步夜行 — 短时间提高移动速度。","畸变 — 缩短诅咒和疾病持续时间。","剥皮专家 — 更快进行剥皮。","语言：通用语。"}},
 GOBLIN={name="地精",zone="杜隆塔尔",info="足智多谋的地精把工程、火箭、化学和贸易变成部落的致命优势。",abilities={"时间就是金钱 — 提高攻击和施法速度。","火箭跳 — 向前推进。","火箭弹幕 — 发射爆炸火箭。","最佳交易 — 获得更优惠的商店价格。","便携式地精 — 呼叫银行助手。","语言：兽人语。"}},
 HIGHELF={name="高等精灵",zone="艾尔文森林",info="忠于联盟的奎尔多雷保留着古老的萨拉斯传统，并以精湛魔法和游侠技艺作战。",abilities={"奎尔多雷冥想 — 恢复主要战斗资源。","游侠迅捷 — 获得高等精灵游侠的敏捷。","语言：萨拉斯语。"}},
 MAGHAR={name="玛格汉兽人",zone="杜隆塔尔",info="未受邪能腐化的玛格汉氏族将德拉诺的力量与荣耀带入部落。",abilities={"先祖召唤 — 借用先祖之力。","野性之血 — 获得天然韧性。","共鸣活力 — 强化与伙伴的联系。","坚定意志 — 抵抗控制效果。","语言：兽人语。"}},
 OGRE={name="食人魔",zone="杜隆塔尔",info="石槌氏族食人魔以强大力量、厚实皮肤、氏族忠诚和顽强意志效忠部落。",abilities={"食人魔之力 — 暂时提高攻击强度。","厚皮 — 提高基础生命值。","氏族纽带 — 宠物造成更多伤害。","顽如磐石 — 缩短昏迷持续时间。","语言：兽人语。"}},
 DARKIRONDWARF={name="黑铁矮人",zone="丹莫罗",info="黑铁矮人在黑石烈焰中淬炼，擅长锻造、火器与地下作战。",abilities={"火血 — 清除有害效果。","黑铁砧训练 — 强化火器战斗。","烈焰锻造 — 提高火焰抗性。","深处秘藏 — 感知附近宝藏。","语言：通用语和矮人语。"}}
};
BAER_TEXT["zhTW"]={
 WORGEN={name="狼人",zone="泰達希爾",info="狼人已學會駕馭體內的野性，並以速度、直覺與堅定意志為聯盟效力。",abilities={"惡意 — 提高致命一擊機率。","疾步夜行 — 短時間提高移動速度。","畸變 — 縮短詛咒與疾病持續時間。","剝皮專家 — 更快進行剝皮。","語言：通用語。"}},
 GOBLIN={name="哥布林",zone="杜隆塔爾",info="足智多謀的哥布林把工程、火箭、化學與貿易變成部落的致命優勢。",abilities={"時間就是金錢 — 提高攻擊與施法速度。","火箭跳 — 向前推進。","火箭彈幕 — 發射爆裂火箭。","最佳交易 — 獲得更優惠的商店價格。","隨身地精 — 呼叫銀行助手。","語言：獸人語。"}},
 HIGHELF={name="高等精靈",zone="艾爾文森林",info="忠於聯盟的奎爾多雷保留古老的薩拉斯傳統，並以精湛魔法與遊俠技藝作戰。",abilities={"奎爾多雷冥想 — 恢復主要戰鬥資源。","遊俠迅捷 — 獲得高等精靈遊俠的敏捷。","語言：薩拉斯語。"}},
 MAGHAR={name="瑪格哈獸人",zone="杜隆塔爾",info="未受邪能腐化的瑪格哈氏族將德拉諾的力量與榮耀帶入部落。",abilities={"先祖召喚 — 借用先祖之力。","野性之血 — 獲得天然韌性。","共鳴活力 — 強化與夥伴的聯繫。","堅定意志 — 抵抗控制效果。","語言：獸人語。"}},
 OGRE={name="食人魔",zone="杜隆塔爾",info="石槌氏族食人魔以強大力量、厚實皮膚、氏族忠誠與頑強意志效忠部落。",abilities={"食人魔之力 — 暫時提高攻擊強度。","厚皮 — 提高基礎生命力。","氏族羈絆 — 寵物造成更多傷害。","頑如磐石 — 縮短昏迷持續時間。","語言：獸人語。"}},
 DARKIRONDWARF={name="黑鐵矮人",zone="丹莫洛",info="黑鐵矮人在黑石烈焰中淬鍊，擅長鍛造、火器與地下作戰。",abilities={"火血 — 清除有害效果。","黑鐵砧訓練 — 強化火器戰鬥。","烈焰鍛造 — 提高火焰抗性。","深處秘藏 — 感知附近寶藏。","語言：通用語與矮人語。"}}
};

local T=BAER_TEXT[BAER_LOCALE] or BAER_TEXT.enUS;
local BAER_LABELS={
  enUS={start="Starting Area",traits="Racial Traits"},
  deDE={start="Startgebiet",traits="Volksfähigkeiten"},
  frFR={start="Zone de départ",traits="Traits raciaux"},
  esES={start="Zona inicial",traits="Rasgos raciales"},
  esMX={start="Zona inicial",traits="Rasgos raciales"},
  ruRU={start="Стартовая зона",traits="Расовые способности"},
  zhCN={start="起始区域",traits="种族特长"},
  zhTW={start="起始區域",traits="種族特長"}
};

for _,k in ipairs({"WORGEN","GOBLIN","HIGHELF","MAGHAR","OGRE","DARKIRONDWARF"}) do
  local e=(T and T[k]) or BAER_TEXT.enUS[k];
  _G["RACE_INFO_"..k]=e.info; _G["RACE_INFO_"..k.."_FEMALE"]=e.info;
  _G["LOCATION_INFO_"..k]=e.zone;
  for i,v in ipairs(e.abilities or {}) do _G["ABILITY_INFO_"..k..i]="- "..v; end
end
CHARACTER_FACING_INCREMENT = 2;
MAX_RACES = 16;
MAX_CLASSES_PER_RACE = 10;
NUM_CHAR_CUSTOMIZATIONS = 5;
MIN_CHAR_NAME_LENGTH = 2;
CHARACTER_CREATE_ROTATION_START_X = nil;
CHARACTER_CREATE_INITIAL_FACING = nil;

PAID_CHARACTER_CUSTOMIZATION = 1;
PAID_RACE_CHANGE = 2;
PAID_FACTION_CHANGE = 3;
PAID_SERVICE_CHARACTER_ID = nil;
PAID_SERVICE_TYPE = nil;

FACTION_BACKDROP_COLOR_TABLE = {
	["Alliance"] = {0.5, 0.5, 0.5, 0.09, 0.09, 0.19},
	["Horde"] = {0.5, 0.2, 0.2, 0.19, 0.05, 0.05},
};
FRAMES_TO_BACKDROP_COLOR = { 
	"CharacterCreateCharacterRace",
	"CharacterCreateCharacterClass",
--	"CharacterCreateCharacterFaction",
	"CharacterCreateNameEdit",
};
RACE_ICON_TCOORDS = {
	["HUMAN_MALE"]		= {0, 0.125, 0, 0.25},
	["DWARF_MALE"]		= {0.125, 0.25, 0, 0.25},
	["GNOME_MALE"]		= {0.25, 0.375, 0, 0.25},
	["NIGHTELF_MALE"]	= {0.375, 0.5, 0, 0.25},
	["DRAENEI_MALE"]	= {0.5, 0.625, 0, 0.25},
   	["WORGEN_MALE"]   	= {0.625, 0.750, 0, 0.25},
    ["HIGHELF_MALE"]    = {0.750, 0.875, 0, 0.25},
    ["DARKIRONDWARF_MALE"] = {0.125, 0.25, 0, 0.25},
	
	["TAUREN_MALE"]		= {0, 0.125, 0.25, 0.5},
	["SCOURGE_MALE"]	= {0.125, 0.25, 0.25, 0.5},
	["TROLL_MALE"]		= {0.25, 0.375, 0.25, 0.5},
	["ORC_MALE"]		= {0.375, 0.5, 0.25, 0.5},
	["BLOODELF_MALE"]	= {0.5, 0.625, 0.25, 0.5},
	["GOBLIN_MALE"]    	= {0.625, 0.750, 0.25, 0.5},
	["MAGHAR_MALE"]     = {0.750, 0.875, 0.25, 0.5},
	["OGRE_MALE"]       = {0.875, 1.0, 0.25, 0.5},

	["HUMAN_FEMALE"]	= {0, 0.125, 0.5, 0.75},  
	["DWARF_FEMALE"]	= {0.125, 0.25, 0.5, 0.75},
	["GNOME_FEMALE"]	= {0.25, 0.375, 0.5, 0.75},
	["NIGHTELF_FEMALE"]	= {0.375, 0.5, 0.5, 0.75},
	["DRAENEI_FEMALE"]	= {0.5, 0.625, 0.5, 0.75},
   	["WORGEN_FEMALE"]  	= {0.625, 0.750, 0.5, 0.75},
    ["HIGHELF_FEMALE"]  = {0.750, 0.875, 0.5, 0.75},
    ["DARKIRONDWARF_FEMALE"] = {0.125, 0.25, 0.5, 0.75},
	
	["TAUREN_FEMALE"]	= {0, 0.125, 0.75, 1.0},   
	["SCOURGE_FEMALE"]	= {0.125, 0.25, 0.75, 1.0}, 
	["TROLL_FEMALE"]	= {0.25, 0.375, 0.75, 1.0}, 
	["ORC_FEMALE"]		= {0.375, 0.5, 0.75, 1.0}, 
	["BLOODELF_FEMALE"]	= {0.5, 0.625, 0.75, 1.0}, 
   	["GOBLIN_FEMALE"]  	= {0.625, 0.750, 0.75, 1.0},
    ["MAGHAR_FEMALE"]   = {0.750, 0.875, 0.75, 1.0},
    ["OGRE_FEMALE"]     = {0.875, 1.0, 0.75, 1.0},
};
CLASS_ID_BY_FILE = {
	WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
	DEATHKNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, DRUID = 11,
};

CLASS_ICON_TCOORDS = {
	["WARRIOR"]	= {0, 0.25, 0, 0.25},
	["MAGE"]	= {0.25, 0.49609375, 0, 0.25},
	["ROGUE"]	= {0.49609375, 0.7421875, 0, 0.25},
	["DRUID"]	= {0.7421875, 0.98828125, 0, 0.25},
	["HUNTER"]	= {0, 0.25, 0.25, 0.5},
	["SHAMAN"]	= {0.25, 0.49609375, 0.25, 0.5},
	["PRIEST"]	= {0.49609375, 0.7421875, 0.25, 0.5},
	["WARLOCK"]	= {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"]	= {0, 0.25, 0.5, 0.75},
	["DEATHKNIGHT"]	= {0.25, 0.49609375, 0.5, 0.75},
};

function CharacterCreate_OnLoad(self)
	self:SetSequence(0);
	self:SetCamera(0);

	CharacterCreate.numRaces = 0;
	CharacterCreate.selectedRace = 0;
	CharacterCreate.numClasses = 0;
	CharacterCreate.selectedClass = 0;
	CharacterCreate.selectedGender = 0;

	SetCharCustomizeFrame("CharacterCreate");

	for i=1, NUM_CHAR_CUSTOMIZATIONS, 1 do
		_G["CharacterCustomizationButtonFrame"..i.."Text"]:SetText(_G["CHAR_CUSTOMIZATION"..i.."_DESC"]);
	end

	-- Color edit box backdrop
	local backdropColor = FACTION_BACKDROP_COLOR_TABLE["Alliance"];
	CharacterCreateNameEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	CharacterCreateNameEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
end

function CharacterCreate_OnShow()
	for i=1, MAX_CLASSES_PER_RACE, 1 do
		local button = _G["CharacterCreateClassButton"..i];
		button:Enable();
		SetButtonDesaturated(button, false)
	end
	for i=1, MAX_RACES, 1 do
		local button = _G["CharacterCreateRaceButton"..i];
		button:Enable();
		SetButtonDesaturated(button, false)
	end

	if ( PAID_SERVICE_TYPE ) then
		CustomizeExistingCharacter( PAID_SERVICE_CHARACTER_ID );
		CharacterCreateNameEdit:SetText( PaidChange_GetName() );
	else
		--randomly selects a combination
		ResetCharCustomize();
		CharacterCreateNameEdit:SetText("");
		CharCreateRandomizeButton:Show();
	end

	CharacterCreateEnumerateRaces(GetAvailableRaces());
	SetCharacterRace(GetSelectedRace());
	
	CharacterCreateEnumerateClasses(GetAvailableClasses());
	local_,_,index = GetSelectedClass();
	SetCharacterClass(index);

	SetCharacterGender(GetSelectedSex())
	
	-- Hair customization stuff
	CharacterCreate_UpdateHairCustomization();

	SetCharacterCreateFacing(-15);
	
	if ( ALLOW_RANDOM_NAME_BUTTON ) then
		CharacterCreateRandomName:Show();
	end
	
	-- setup customization
	CharacterChangeFixup();
end

function CharacterCreate_OnHide()
	PAID_SERVICE_CHARACTER_ID = nil;
	PAID_SERVICE_TYPE = nil;
end

function CharacterCreateFrame_OnMouseDown(button)
	if ( button == "LeftButton" ) then
		CHARACTER_CREATE_ROTATION_START_X = GetCursorPosition();
		CHARACTER_CREATE_INITIAL_FACING = GetCharacterCreateFacing();
	end
end

function CharacterCreateFrame_OnMouseUp(button)
	if ( button == "LeftButton" ) then
		CHARACTER_CREATE_ROTATION_START_X = nil
	end
end

function CharacterCreateFrame_OnUpdate()
	if ( CHARACTER_CREATE_ROTATION_START_X ) then
		local x = GetCursorPosition();
		local diff = (x - CHARACTER_CREATE_ROTATION_START_X) * CHARACTER_ROTATION_CONSTANT;
		CHARACTER_CREATE_ROTATION_START_X = GetCursorPosition();
		SetCharacterCreateFacing(GetCharacterCreateFacing() + diff);
	end
end

-- Fixed faction layout.  Button slots no longer depend on the order returned by
-- GetAvailableRaces(), so custom races cannot push Horde races onto the Alliance
-- banner (or disappear when another race is missing).
local BAER_RACE_BUTTON_SLOT = {
    HUMAN=1, DWARF=2, NIGHTELF=3, GNOME=4, DRAENEI=5, WORGEN=6, HIGHELF=7, DARKIRONDWARF=8,
    ORC=9, SCOURGE=10, TAUREN=11, TROLL=12, BLOODELF=13, GOBLIN=14, OGRE=15, MAGHAR=16,
};

function CharacterCreateEnumerateRaces(...)
    local gender = (GetSelectedSex() == SEX_FEMALE) and "FEMALE" or "MALE";
    local shown = 0;

    -- Clear every visual slot first.  This is important when changing sex or when
    -- the server exposes a different set/order of races.
    for slot=1,MAX_RACES do
        local button = _G["CharacterCreateRaceButton"..slot];
        button.selectionIndex = nil;
        button.raceFile = nil;
        button.name = nil;
        button.tooltip = nil;
        button:Hide();
    end

    local rawIndex = 1;
    for i=1, select("#", ...), 3 do
        local raceName = select(i, ...);
        local fileString = strupper(select(i+1, ...) or "");
        local enabled = select(i+2, ...);
        local slot = BAER_RACE_BUTTON_SLOT[fileString];
        if slot and slot <= MAX_RACES then
            local button = _G["CharacterCreateRaceButton"..slot];
            local coords = RACE_ICON_TCOORDS[fileString.."_"..gender];
            if coords then
                _G["CharacterCreateRaceButton"..slot.."NormalTexture"]:SetTexCoord(coords[1],coords[2],coords[3],coords[4]);
                _G["CharacterCreateRaceButton"..slot.."PushedTexture"]:SetTexCoord(coords[1],coords[2],coords[3],coords[4]);
            end
            button:Show();
            button.name = raceName;
            button.tooltip = raceName;
            button.selectionIndex = rawIndex;
            button.raceFile = fileString;
            if enabled == 1 then
                button.enable = true;
                button:Enable();
                SetButtonDesaturated(button);
            else
                button.enable = false;
                button:Disable();
                SetButtonDesaturated(button,1);
                button.tooltip = _G[fileString.."_DISABLED"] or raceName;
            end
            shown = shown + 1;
        end
        rawIndex = rawIndex + 1;
    end
    CharacterCreate.numRaces = shown;
end

function CharacterCreateEnumerateClasses(...)
	CharacterCreate.numClasses = select("#", ...)/3;
	if ( CharacterCreate.numClasses > MAX_CLASSES_PER_RACE ) then
		message("Too many classes!  Update MAX_CLASSES_PER_RACE");
		return;
	end
	local coords;
	local index = 1;
	local button;
	for i=1, select("#", ...), 3 do
		local classFile = strupper(select(i+1, ...));
		local classID = CLASS_ID_BY_FILE[classFile] or index;
		coords = CLASS_ICON_TCOORDS[classFile];
		_G["CharacterCreateClassButton"..index.."NormalTexture"]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		_G["CharacterCreateClassButton"..index.."PushedTexture"]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		button = _G["CharacterCreateClassButton"..index];
		button.classID = classID;
		button:Show();
		if ( select(i+2, ...) == 1 and IsRaceClassValid(GetSelectedRace(), classID) ) then
			button.enable = true;
			button:Enable();
			SetButtonDesaturated(button);
			button.name = select(i, ...)
			button.tooltip = select(i, ...);
			_G["CharacterCreateClassButton"..index.."DisableTexture"]:Hide();
		else
			button.enable = false;
			button:Disable();
			SetButtonDesaturated(button, 1);
			button.name = select(i, ...)
			button.tooltip = _G[strupper(select(i+1, ...).."_".."DISABLED")];
			_G["CharacterCreateClassButton"..index.."DisableTexture"]:Show();
		end
		index = index + 1;
	end
	for i=CharacterCreate.numClasses + 1, MAX_CLASSES_PER_RACE, 1 do
		_G["CharacterCreateClassButton"..i]:Hide();
	end
end

function SetCharacterRace(id)
	CharacterCreate.selectedRace = id;
	local selectedButton;
	for i=1, MAX_RACES, 1 do
		local button = _G["CharacterCreateRaceButton"..i];
		if ( button.selectionIndex and button.selectionIndex == id ) then
			_G["CharacterCreateRaceButton"..i.."Text"]:SetText(button.name);
			button:SetChecked(1);
			selectedButton = button;
		else
			_G["CharacterCreateRaceButton"..i.."Text"]:SetText("");
			button:SetChecked(0);
		end
	end

	-- Set Faction
	local name, faction = GetFactionForRace(CharacterCreate.selectedRace);

	-- Set Race
	local race, fileString = GetNameForRace();

	CharacterCreateRaceLabel:SetText(race);
	fileString = strupper(fileString);

	-- Baercraft: Dark Iron Dwarf is Alliance.  The custom race ID is outside
	-- Blizzard's original 3.3.5 race set, so some clients report the wrong
	-- Glue faction even though the server joins the character to Alliance.
	if ( fileString == "DARKIRONDWARF" ) then
		faction = "Alliance";
	end
	if ( GetSelectedSex() == SEX_MALE ) then
		gender = "MALE";
	else
		gender = "FEMALE";
	end
	local coords = RACE_ICON_TCOORDS[fileString.."_"..gender];
	if fileString == "DARKIRONDWARF" then
		CharacterCreateRaceIcon:SetTexture("Interface\\Icons\\INV_Hammer_04");
		CharacterCreateRaceIcon:SetTexCoord(0,1,0,1);
	else
		CharacterCreateRaceIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races");
		CharacterCreateRaceIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
	end
	local raceText = _G["RACE_INFO_"..fileString];
	local abilityIndex = 1;
	local tempText = _G["ABILITY_INFO_"..fileString..abilityIndex];
	abilityText = "";
	while ( tempText ) do
		abilityText = abilityText..tempText.."\n\n";
		abilityIndex = abilityIndex + 1;
		tempText = _G["ABILITY_INFO_"..fileString..abilityIndex];
	end

	CharacterCreateRaceScrollFrameScrollBar:SetValue(0);
	local customInfo=_G["RACE_INFO_"..fileString];
	if customInfo and customInfo ~= "" then CharacterCreateRaceText:SetText(customInfo.."|n|n"); else CharacterCreateRaceText:SetText(GetFlavorText("RACE_INFO_"..fileString,GetSelectedSex()).."|n|n"); end
	-- 6.2.1: location, racial traits and lore use separate Blizzard UI fields.
	local labels=BAER_LABELS[BAER_LOCALE] or BAER_LABELS.enUS;
	local location=_G["LOCATION_INFO_"..fileString] or "";
	if CharacterCreateRaceLocationText then
		if location ~= "" then
			CharacterCreateRaceLocationText:SetText("|cffffd100"..labels.start..":|r "..location);
		else
			CharacterCreateRaceLocationText:SetText("");
		end
	end
	local racePanel="";
	if abilityText and abilityText ~= "" then
		racePanel="|cffffd100"..labels.traits.."|r\n"..abilityText;
	end
	CharacterCreateRaceAbilityText:SetText(racePanel);

	-- Set backdrop colors based on faction
	local backdropColor = FACTION_BACKDROP_COLOR_TABLE[faction];
	local frame;
	for index, value in pairs(FRAMES_TO_BACKDROP_COLOR) do
		frame = _G[value];
		frame:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	end
	CharacterCreateConfigurationBackground:SetVertexColor(backdropColor[4], backdropColor[5], backdropColor[6]);

	local backgroundFilename = GetCreateBackgroundModel();
	SetBackgroundModel(CharacterCreate, backgroundFilename);
end

function SetCharacterClass(id)
	CharacterCreate.selectedClass = id;
	for i=1, CharacterCreate.numClasses, 1 do
		local button = _G["CharacterCreateClassButton"..i];
		if ( i == id ) then
			CharacterCreateClassName:SetText(button.name);
			button:SetChecked(1);
		else
			button:SetChecked(0);
		end
	end
	
	local className, classFileName, _, tank, healer, damage = GetSelectedClass();
	local abilityIndex = 0;
	local tempText = _G["CLASS_INFO_"..classFileName..abilityIndex];
	abilityText = "";
	while ( tempText ) do
		abilityText = abilityText..tempText.."\n\n";
		abilityIndex = abilityIndex + 1;
		tempText = _G["CLASS_INFO_"..classFileName..abilityIndex];
	end
	local coords = CLASS_ICON_TCOORDS[classFileName];
	CharacterCreateClassIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
	CharacterCreateClassLabel:SetText(className);
	CharacterCreateClassRolesText:SetText(abilityText);	
	CharacterCreateClassText:SetText(GetFlavorText("CLASS_"..strupper(classFileName), GetSelectedSex()).."|n|n");
	CharacterCreateClassScrollFrameScrollBar:SetValue(0);
end

function CharacterCreate_OnChar()
end

function CharacterCreate_OnKeyDown(key)
	if ( key == "ESCAPE" ) then
		CharacterCreate_Back();
	elseif ( key == "ENTER" ) then
		CharacterCreate_Okay();
	elseif ( key == "PRINTSCREEN" ) then
		Screenshot();
	end
end

function CharacterCreate_UpdateModel(self)
	UpdateCustomizationScene();
	self:AdvanceTime();
end

function CharacterCreate_Okay()
	if ( PAID_SERVICE_TYPE ) then
		GlueDialog_Show("CONFIRM_PAID_SERVICE");
	else
		CreateCharacter(CharacterCreateNameEdit:GetText());
	end
	PlaySound("gsCharacterCreationCreateChar");
end

function CharacterCreate_Back()
	PlaySound("gsCharacterCreationCancel");
	SetGlueScreen("charselect");
end

function CharacterClass_OnClick(id)
	PlaySound("gsCharacterCreationClass");
	local button = _G["CharacterCreateClassButton"..id];
	local classID = (button and button.classID) or id;
	local _,_,currClass = GetSelectedClass();
	if ( currClass ~= classID and IsRaceClassValid(GetSelectedRace(), classID) ) then
		SetSelectedClass(classID);
		SetCharacterClass(classID);
	 	SetCharacterRace(GetSelectedRace());
		CharacterChangeFixup();
	end
end

function CharacterRace_OnClick(self, id)
	PlaySound("gsCharacterCreationClass");
	if ( not self:GetChecked() ) then
		self:SetChecked(1);
		return;
	end
	local button = self or _G["CharacterCreateRaceButton"..id];
	local raceIndex = (button and button.selectionIndex) or id;
	if ( GetSelectedRace() ~= raceIndex ) then
		SetSelectedRace(raceIndex);
		SetCharacterRace(raceIndex);
		SetSelectedSex(GetSelectedSex());
		SetCharacterCreateFacing(-15);
		CharacterCreateEnumerateClasses(GetAvailableClasses());
		local _,_,classIndex = GetSelectedClass();
		if ( PAID_SERVICE_TYPE ) then
			classIndex = PaidChange_GetCurrentClassIndex();
		end
		SetCharacterClass(classIndex);
		
		-- Hair customization stuff
		CharacterCreate_UpdateHairCustomization();
			
		CharacterChangeFixup();
	end
end

function SetCharacterGender(sex)
	local gender;
	SetSelectedSex(sex);
	if ( sex == SEX_MALE ) then
		gender = "MALE";
		CharacterCreateGender:SetText(MALE);
		CharacterCreateGenderButtonMale:SetChecked(1);
		CharacterCreateGenderButtonFemale:SetChecked(nil);
	elseif ( sex == SEX_FEMALE ) then
		gender = "FEMALE";
		CharacterCreateGender:SetText(FEMALE);
		CharacterCreateGenderButtonMale:SetChecked(nil);
		CharacterCreateGenderButtonFemale:SetChecked(1);
	end

	-- Update race images to reflect gender
	CharacterCreateEnumerateRaces(GetAvailableRaces());
	CharacterCreateEnumerateClasses(GetAvailableClasses());
 	SetCharacterRace(GetSelectedRace());
	
	local _,_,classIndex = GetSelectedClass();
	if ( PAID_SERVICE_TYPE ) then
		classIndex = PaidChange_GetCurrentClassIndex();
	end
	SetCharacterClass(classIndex);

	CharacterCreate_UpdateHairCustomization();

	-- Update right hand race portrait to reflect gender change
	-- Set Race
	local race, fileString = GetNameForRace();
	CharacterCreateRaceLabel:SetText(race);
	fileString = strupper(fileString);
	local coords = RACE_ICON_TCOORDS[fileString.."_"..gender];
	if fileString == "DARKIRONDWARF" then
		CharacterCreateRaceIcon:SetTexture("Interface\\Icons\\INV_Hammer_04");
		CharacterCreateRaceIcon:SetTexCoord(0,1,0,1);
	else
		CharacterCreateRaceIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races");
		CharacterCreateRaceIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
	end
	
	CharacterChangeFixup();
end

function CharacterCustomization_Left(id)
	PlaySound("gsCharacterCreationLook");
	CycleCharCustomization(id, -1);
end

function CharacterCustomization_Right(id)
	PlaySound("gsCharacterCreationLook");
	CycleCharCustomization(id, 1);
end

function CharacterCreate_Randomize()
	PlaySound("gsCharacterCreationLook");
	RandomizeCharCustomization();
end

function CharacterCreateRotateRight_OnUpdate(self)
	if ( self:GetButtonState() == "PUSHED" ) then
		SetCharacterCreateFacing(GetCharacterCreateFacing() + CHARACTER_FACING_INCREMENT);
	end
end

function CharacterCreateRotateLeft_OnUpdate(self)
	if ( self:GetButtonState() == "PUSHED" ) then
		SetCharacterCreateFacing(GetCharacterCreateFacing() - CHARACTER_FACING_INCREMENT);
	end
end

function CharacterCreate_UpdateHairCustomization()
	CharacterCustomizationButtonFrame3Text:SetText(_G["HAIR_"..GetHairCustomization().."_STYLE"]);
	CharacterCustomizationButtonFrame4Text:SetText(_G["HAIR_"..GetHairCustomization().."_COLOR"]);
	CharacterCustomizationButtonFrame5Text:SetText(_G["FACIAL_HAIR_"..GetFacialHairCustomization()]);		
end

function SetButtonDesaturated(button, desaturated, r, g, b)
	if ( not button ) then
		return;
	end
	local icon = button:GetNormalTexture();
	if ( not icon ) then
		return;
	end
	local shaderSupported = icon:SetDesaturated(desaturated);

	if ( not desaturated ) then
		r = 1.0;
		g = 1.0;
		b = 1.0;
	elseif ( not r or not shaderSupported ) then
		r = 0.5;
		g = 0.5;
		b = 0.5;
	end
	
	icon:SetVertexColor(r, g, b);
end

function GetFlavorText(tagname, sex)
	local primary, secondary;
	if ( sex == SEX_MALE ) then
		primary = "";
		secondary = "_FEMALE";
	else
		primary = "_FEMALE";
		secondary = "";
	end
	local text = _G[tagname..primary];
	if ( (text == nil) or (text == "") ) then
		text = _G[tagname..secondary];
	end
	return text;
end

function CharacterCreate_DeathKnightSwap(self)
	local _, classFilename = GetSelectedClass();
	if ( classFilename == "DEATHKNIGHT" ) then
		if (self.currentModel ~= "DEATHKNIGHT") then
			self.currentModel = "DEATHKNIGHT";
			self:SetNormalTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Up-Blue");
			self:SetPushedTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Down-Blue");
			self:SetHighlightTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Highlight-Blue");
		end
	else
		if (self.currentModel == "DEATHKNIGHT") then
			self.currentModel = nil;
			self:SetNormalTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Up");
			self:SetPushedTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Down");
			self:SetHighlightTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Highlight");
		end
	end
end

function CharacterChangeFixup()
	if ( PAID_SERVICE_TYPE ) then
		for i=1, MAX_CLASSES_PER_RACE, 1 do
			if (CharacterCreate.selectedClass ~= i) then
				local button = _G["CharacterCreateClassButton"..i];
				button:Disable();
				SetButtonDesaturated(button, true)
			end
		end

		for i=1, MAX_RACES, 1 do
			local allow = false;
			if ( PAID_SERVICE_TYPE == PAID_FACTION_CHANGE ) then
				local faction = GetFactionForRace(PaidChange_GetCurrentRaceIndex());
				if ( (i == PaidChange_GetCurrentRaceIndex()) or ((GetFactionForRace(i) ~= faction) and (IsRaceClassValid(i,CharacterCreate.selectedClass))) ) then
					allow = true;
				end
			elseif ( PAID_SERVICE_TYPE == PAID_RACE_CHANGE ) then
				local faction = GetFactionForRace(PaidChange_GetCurrentRaceIndex());
				if ( (i == PaidChange_GetCurrentRaceIndex()) or ((GetFactionForRace(i) == faction) and (IsRaceClassValid(i,CharacterCreate.selectedClass))) ) then
					allow = true
				end
			elseif ( PAID_SERVICE_TYPE == PAID_CHARACTER_CUSTOMIZATION ) then
				if ( i == CharacterCreate.selectedRace ) then
					allow = true
				end
			end
			if (not allow) then
				local button = _G["CharacterCreateRaceButton"..i];
				button:Disable();
				SetButtonDesaturated(button, true)
			end
		end
	end
end

