CHARACTER_FACING_INCREMENT = 2;
MAX_RACES = 14;


-- Baercraft custom-race localization.
-- Keep this in CharacterCreate.lua. The stock client loads its own localized
-- GlueStrings.lua first; patch-A intentionally does not override that file.
-- Only Baercraft custom-race strings are supplied here at runtime.
local function BaercraftDetectLocale()
    local locale;

    -- GetLocale() is the normal game API, but some 3.3.5a GlueXML builds
    -- expose locale information more reliably through the locale CVar.
    if ( GetLocale ) then
        locale = GetLocale();
    end
    if ( (not locale or locale == "" or locale == "enUS") and GetCVar ) then
        local cvarLocale = GetCVar("locale");
        if ( cvarLocale and cvarLocale ~= "" ) then
            locale = cvarLocale;
        end
    end

    if ( locale == "enGB" ) then
        locale = "enUS";
    end

    return locale or "enUS";
end

local BAERCRAFT_LOCALE = "ruRU"; -- locale MPQ: force this client locale
local BAERCRAFT_CUSTOM_TEXT = {
    enUS = {
        ABILITY_INFO_MAGHAR1 = "- Attack power and spell damage increased.",
        ABILITY_INFO_MAGHAR2 = "- Chance to resist Curse, Disease and Poison effects.",
        ABILITY_INFO_MAGHAR3 = "- Pets' maximum health increased.",
        ABILITY_INFO_MAGHAR4 = "- Reduced duration of Stun effects.",
        ABILITY_INFO_HIGHELF1 = "- May restore mana, energy, runic power, or rage.",
        ABILITY_INFO_HIGHELF2 = "- Agility increased by 2%.",
        ABILITY_INFO_HIGHELF3 = "- Increased critical chance with Bows.",
        ABILITY_INFO_HIGHELF4 = "- Enchanting skill increased.",
        ABILITY_INFO_GOBLIN1 = "- Always receive the best possible gold discount, regardless of faction.",
        ABILITY_INFO_GOBLIN2 = "- Alchemy skill increased by 15.",
        ABILITY_INFO_GOBLIN3 = "- Calls in your friend, Gobber, allowing you bank access for 1 min.",
        ABILITY_INFO_GOBLIN4 = "- Launches your belt rockets at an enemy, dealing fire damage.",
        ABILITY_INFO_GOBLIN5 = "- Activates your rocket belt to jump forward.",
        ABILITY_INFO_GOBLIN6 = "- Attack and casting speed increased by 1%.",
        ABILITY_INFO_WORGEN1 = "- Resistance to harmful Nature and Shadow effects increased.",
        ABILITY_INFO_WORGEN2 = "- Increases movement speed by 40% for 10 sec.",
        ABILITY_INFO_WORGEN3 = "- Switch between human and Worgen forms.",
        ABILITY_INFO_WORGEN4 = "- Skinning skill increased by 15 and skinning is faster.",
        ABILITY_INFO_WORGEN5 = "- Run on all fours as fast as a wild animal.",
        ABILITY_INFO_WORGEN6 = "- Change into your currently inactive form.",
        ABILITY_INFO_WORGEN7 = "- Critical strike chance increased by 1%.",
        RACE_INFO_MAGHAR = "The orc clans of Draenor never drank the demon blood that corrupted their distant kin. Proud and defiant, they remained uncorrupted as the Mag'har. With courage and a fierce sense of honor, the Mag'har now fight for their place on Azeroth.",
        RACE_INFO_HIGHELF = "Once the proud rulers of Quel'Thalas, the high elves drew strength from the Sunwell. After its destruction, some rejected the path taken by the blood elves and scattered across Azeroth. Few in number, they preserve their ancient traditions and wield magic with care.",
        RACE_INFO_GOBLIN = "Clever, inventive and always looking for profit, goblins have turned their talent for engineering, alchemy and trade into a place among the Horde. Their dangerous inventions are as famous as their sharp business sense.",
        RACE_INFO_WORGEN = "Behind the Greymane Wall, a terrible curse transformed many citizens of Gilneas into the beasts known as worgen. Having learned to control their feral nature, they now fight to defend their people and their place in the Alliance."
    },
    deDE = {
        ABILITY_INFO_MAGHAR1 = "- Angriffskraft und Zauberschaden sind erhöht.",
        ABILITY_INFO_MAGHAR2 = "- Erhöhte Chance, Fluch-, Krankheits- und Gifteffekten zu widerstehen.",
        ABILITY_INFO_MAGHAR3 = "- Die maximale Gesundheit von Begleitern ist erhöht.",
        ABILITY_INFO_MAGHAR4 = "- Die Dauer von Betäubungseffekten ist verringert.",
        ABILITY_INFO_HIGHELF1 = "- Kann Mana, Energie, Runenmacht oder Wut wiederherstellen.",
        ABILITY_INFO_HIGHELF2 = "- Beweglichkeit um 2% erhöht.",
        ABILITY_INFO_HIGHELF3 = "- Erhöhte kritische Trefferchance mit Bögen.",
        ABILITY_INFO_HIGHELF4 = "- Verzauberkunstfertigkeit erhöht.",
        ABILITY_INFO_GOBLIN1 = "- Erhält unabhängig von der Fraktion immer den bestmöglichen Goldrabatt.",
        ABILITY_INFO_GOBLIN2 = "- Alchemiefertigkeit um 15 erhöht.",
        ABILITY_INFO_GOBLIN3 = "- Ruft Gobber herbei und ermöglicht 1 Min. lang Zugriff auf die Bank.",
        ABILITY_INFO_GOBLIN4 = "- Feuert Gürtelraketen auf einen Gegner ab und verursacht Feuerschaden.",
        ABILITY_INFO_GOBLIN5 = "- Aktiviert den Raketengürtel und springt nach vorn.",
        ABILITY_INFO_GOBLIN6 = "- Angriffs- und Zaubertempo um 1% erhöht.",
        ABILITY_INFO_WORGEN1 = "- Widerstand gegen schädliche Natur- und Schatteneffekte erhöht.",
        ABILITY_INFO_WORGEN2 = "- Erhöht das Bewegungstempo 10 Sek. lang um 40%.",
        ABILITY_INFO_WORGEN3 = "- Wechselt zwischen Menschen- und Worgengestalt.",
        ABILITY_INFO_WORGEN4 = "- Kürschnereifertigkeit um 15 erhöht und schnelleres Kürschnern.",
        ABILITY_INFO_WORGEN5 = "- Läuft auf allen vieren so schnell wie ein wildes Tier.",
        ABILITY_INFO_WORGEN6 = "- Wechselt in die derzeit inaktive Gestalt.",
        ABILITY_INFO_WORGEN7 = "- Kritische Trefferchance um 1% erhöht.",
        RACE_INFO_MAGHAR = "Die Orcclans von Draenor tranken niemals das Dämonenblut, das ihre fernen Verwandten verdarb. Stolz und unbeugsam blieben sie als Mag'har unverdorben. Mit Mut und einem ausgeprägten Ehrgefühl kämpfen die Mag'har nun um ihren Platz auf Azeroth.",
        RACE_INFO_HIGHELF = "Einst herrschten die Hochelfen stolz über Quel'Thalas und schöpften ihre Kraft aus dem Sonnenbrunnen. Nach seiner Zerstörung lehnten einige den Weg der Blutelfen ab und verstreuten sich über Azeroth. Obwohl nur wenige geblieben sind, bewahren sie ihre alten Traditionen und gehen vorsichtig mit Magie um.",
        RACE_INFO_GOBLIN = "Gerissen, erfinderisch und stets auf Gewinn bedacht haben sich die Goblins mit ihrem Talent für Ingenieurskunst, Alchemie und Handel einen Platz in der Horde geschaffen. Ihre gefährlichen Erfindungen sind ebenso berühmt wie ihr Geschäftssinn.",
        RACE_INFO_WORGEN = "Hinter dem Graumähnenwall verwandelte ein schrecklicher Fluch viele Bewohner von Gilneas in die als Worgen bekannten Bestien. Nachdem sie gelernt haben, ihre wilde Natur zu beherrschen, kämpfen sie nun für ihr Volk und ihren Platz in der Allianz."
    },
    frFR = {
        ABILITY_INFO_MAGHAR1 = "- Puissance d'attaque et dégâts des sorts augmentés.",
        ABILITY_INFO_MAGHAR2 = "- Chances accrues de résister aux malédictions, maladies et poisons.",
        ABILITY_INFO_MAGHAR3 = "- Points de vie maximum des familiers augmentés.",
        ABILITY_INFO_MAGHAR4 = "- Durée des effets d'étourdissement réduite.",
        ABILITY_INFO_HIGHELF1 = "- Peut rendre du mana, de l'énergie, de la puissance runique ou de la rage.",
        ABILITY_INFO_HIGHELF2 = "- Agilité augmentée de 2%.",
        ABILITY_INFO_HIGHELF3 = "- Chances de coup critique avec les arcs augmentées.",
        ABILITY_INFO_HIGHELF4 = "- Compétence en enchantement augmentée.",
        ABILITY_INFO_GOBLIN1 = "- Bénéficie toujours de la meilleure réduction possible, quelle que soit la réputation.",
        ABILITY_INFO_GOBLIN2 = "- Compétence en alchimie augmentée de 15.",
        ABILITY_INFO_GOBLIN3 = "- Appelle Gobber et permet d'accéder à la banque pendant 1 min.",
        ABILITY_INFO_GOBLIN4 = "- Lance les roquettes de ceinture sur un ennemi et inflige des dégâts de Feu.",
        ABILITY_INFO_GOBLIN5 = "- Active la ceinture-fusée pour bondir vers l'avant.",
        ABILITY_INFO_GOBLIN6 = "- Vitesse d'attaque et d'incantation augmentée de 1%.",
        ABILITY_INFO_WORGEN1 = "- Résistance aux effets néfastes de Nature et d'Ombre augmentée.",
        ABILITY_INFO_WORGEN2 = "- Augmente la vitesse de déplacement de 40% pendant 10 s.",
        ABILITY_INFO_WORGEN3 = "- Permet d'alterner entre les formes humaine et worgen.",
        ABILITY_INFO_WORGEN4 = "- Compétence en dépeçage augmentée de 15 et dépeçage plus rapide.",
        ABILITY_INFO_WORGEN5 = "- Court à quatre pattes aussi vite qu'un animal sauvage.",
        ABILITY_INFO_WORGEN6 = "- Adopte la forme actuellement inactive.",
        ABILITY_INFO_WORGEN7 = "- Chances de coup critique augmentées de 1%.",
        RACE_INFO_MAGHAR = "Les clans orcs de Draenor n'ont jamais bu le sang démoniaque qui corrompit leurs lointains parents. Fiers et indomptables, les Mag'har sont restés préservés de cette corruption. Avec courage et honneur, ils combattent désormais pour leur place en Azeroth.",
        RACE_INFO_HIGHELF = "Autrefois fiers maîtres de Quel'Thalas, les hauts-elfes tiraient leur puissance du Puits de soleil. Après sa destruction, certains refusèrent la voie des elfes de sang et se dispersèrent en Azeroth. Peu nombreux, ils préservent leurs anciennes traditions et manient la magie avec prudence.",
        RACE_INFO_GOBLIN = "Rusés, inventifs et toujours en quête de profit, les gobelins ont gagné leur place dans la Horde grâce à leur talent pour l'ingénierie, l'alchimie et le commerce. Leurs inventions dangereuses sont aussi célèbres que leur sens des affaires.",
        RACE_INFO_WORGEN = "Derrière le mur de Grisetête, une terrible malédiction transforma de nombreux habitants de Gilnéas en créatures appelées worgens. Ayant appris à maîtriser leur nature sauvage, ils combattent désormais pour leur peuple et leur place au sein de l'Alliance."
    },
    esES = {
        ABILITY_INFO_MAGHAR1 = "- Poder de ataque y daño con hechizos aumentados.",
        ABILITY_INFO_MAGHAR2 = "- Mayor probabilidad de resistir maldiciones, enfermedades y venenos.",
        ABILITY_INFO_MAGHAR3 = "- Salud máxima de las mascotas aumentada.",
        ABILITY_INFO_MAGHAR4 = "- Duración de los efectos de aturdimiento reducida.",
        ABILITY_INFO_HIGHELF1 = "- Puede restaurar maná, energía, poder rúnico o ira.",
        ABILITY_INFO_HIGHELF2 = "- Agilidad aumentada un 2%.",
        ABILITY_INFO_HIGHELF3 = "- Probabilidad de golpe crítico con arcos aumentada.",
        ABILITY_INFO_HIGHELF4 = "- Habilidad de encantamiento aumentada.",
        ABILITY_INFO_GOBLIN1 = "- Siempre recibe el mejor descuento posible, sin importar la reputación.",
        ABILITY_INFO_GOBLIN2 = "- Habilidad de alquimia aumentada 15 p.",
        ABILITY_INFO_GOBLIN3 = "- Llama a Gobber y permite acceder al banco durante 1 min.",
        ABILITY_INFO_GOBLIN4 = "- Lanza los cohetes del cinturón contra un enemigo e inflige daño de Fuego.",
        ABILITY_INFO_GOBLIN5 = "- Activa el cinturón cohete para saltar hacia delante.",
        ABILITY_INFO_GOBLIN6 = "- Velocidad de ataque y lanzamiento aumentada un 1%.",
        ABILITY_INFO_WORGEN1 = "- Resistencia a efectos dañinos de Naturaleza y Sombras aumentada.",
        ABILITY_INFO_WORGEN2 = "- Aumenta la velocidad de movimiento un 40% durante 10 s.",
        ABILITY_INFO_WORGEN3 = "- Permite cambiar entre forma humana y forma huargen.",
        ABILITY_INFO_WORGEN4 = "- Habilidad de desuello aumentada 15 p. y desuello más rápido.",
        ABILITY_INFO_WORGEN5 = "- Corre a cuatro patas tan rápido como un animal salvaje.",
        ABILITY_INFO_WORGEN6 = "- Adopta la forma que esté inactiva en ese momento.",
        ABILITY_INFO_WORGEN7 = "- Probabilidad de golpe crítico aumentada un 1%.",
        RACE_INFO_MAGHAR = "Los clanes orcos de Draenor nunca bebieron la sangre demoníaca que corrompió a sus parientes lejanos. Orgullosos y desafiantes, los Mag'har permanecieron incorruptos. Con valor y un firme sentido del honor, ahora luchan por su lugar en Azeroth.",
        RACE_INFO_HIGHELF = "Antaño orgullosos gobernantes de Quel'Thalas, los altos elfos obtenían su poder de la Fuente del Sol. Tras su destrucción, algunos rechazaron el camino de los elfos de sangre y se dispersaron por Azeroth. Aunque son pocos, conservan sus antiguas tradiciones y usan la magia con cautela.",
        RACE_INFO_GOBLIN = "Astutos, inventivos y siempre en busca de beneficios, los goblins se han ganado un lugar en la Horda gracias a su talento para la ingeniería, la alquimia y el comercio. Sus peligrosos inventos son tan famosos como su olfato para los negocios.",
        RACE_INFO_WORGEN = "Tras el Muro de Cringris, una terrible maldición transformó a muchos habitantes de Gilneas en las bestias conocidas como huargen. Tras aprender a controlar su naturaleza salvaje, ahora luchan por su pueblo y por su lugar en la Alianza."
    },
    ruRU = {
        ABILITY_INFO_MAGHAR1 = "- Сила атаки и урон от заклинаний повышены.",
        ABILITY_INFO_MAGHAR2 = "- Повышена вероятность сопротивления проклятиям, болезням и ядам.",
        ABILITY_INFO_MAGHAR3 = "- Максимальный запас здоровья питомцев увеличен.",
        ABILITY_INFO_MAGHAR4 = "- Длительность эффектов оглушения сокращена.",
        ABILITY_INFO_HIGHELF1 = "- Может восполнять ману, энергию, силу рун или ярость.",
        ABILITY_INFO_HIGHELF2 = "- Ловкость повышена на 2%.",
        ABILITY_INFO_HIGHELF3 = "- Повышена вероятность критического удара при использовании луков.",
        ABILITY_INFO_HIGHELF4 = "- Навык наложения чар повышен.",
        ABILITY_INFO_GOBLIN1 = "- Всегда получает максимальную скидку независимо от репутации.",
        ABILITY_INFO_GOBLIN2 = "- Навык алхимии повышен на 15.",
        ABILITY_INFO_GOBLIN3 = "- Призывает Гоббера и на 1 мин. открывает доступ к банку.",
        ABILITY_INFO_GOBLIN4 = "- Выпускает поясные ракеты во врага, нанося урон от огня.",
        ABILITY_INFO_GOBLIN5 = "- Активирует ракетный пояс и совершает прыжок вперёд.",
        ABILITY_INFO_GOBLIN6 = "- Скорость атаки и произнесения заклинаний повышена на 1%.",
        ABILITY_INFO_WORGEN1 = "- Повышено сопротивление вредоносным эффектам сил природы и тьмы.",
        ABILITY_INFO_WORGEN2 = "- Скорость передвижения повышается на 40% на 10 сек.",
        ABILITY_INFO_WORGEN3 = "- Переключение между человеческим обликом и обликом воргена.",
        ABILITY_INFO_WORGEN4 = "- Навык снятия шкур повышен на 15, а снятие шкур происходит быстрее.",
        ABILITY_INFO_WORGEN5 = "- Бег на четвереньках со скоростью дикого зверя.",
        ABILITY_INFO_WORGEN6 = "- Переход в неактивный в данный момент облик.",
        ABILITY_INFO_WORGEN7 = "- Вероятность критического удара повышена на 1%.",
        RACE_INFO_MAGHAR = "Кланы орков Дренора не пили демоническую кровь и остались неосквернёнными маг'харами. Гордые и непреклонные, они сражаются за своё место в Азероте.",
        RACE_INFO_HIGHELF = "Высшие эльфы когда-то правили Кель'Таласом и черпали силу из Солнечного Колодца. После его разрушения часть из них отвергла путь эльфов крови и сохранила древние традиции.",
        RACE_INFO_GOBLIN = "Хитрые и изобретательные гоблины превратили любовь к инженерному делу, алхимии и торговле в прочное место в Орде.",
        RACE_INFO_WORGEN = "Проклятие превратило многих жителей Гилнеаса в воргенов. Научившись управлять своей звериной природой, они сражаются за свой народ и Альянс."
    },
    zhCN = {
        ABILITY_INFO_MAGHAR1 = "- 攻击强度和法术伤害提高。",
        ABILITY_INFO_MAGHAR2 = "- 抵抗诅咒、疾病和中毒效果的几率提高。",
        ABILITY_INFO_MAGHAR3 = "- 宠物的最大生命值提高。",
        ABILITY_INFO_MAGHAR4 = "- 昏迷效果的持续时间缩短。",
        ABILITY_INFO_HIGHELF1 = "- 可以恢复法力、能量、符文能量或怒气。",
        ABILITY_INFO_HIGHELF2 = "- 敏捷提高2%。",
        ABILITY_INFO_HIGHELF3 = "- 使用弓时的暴击几率提高。",
        ABILITY_INFO_HIGHELF4 = "- 附魔技能提高。",
        ABILITY_INFO_GOBLIN1 = "- 无论声望如何，总能获得最佳金币折扣。",
        ABILITY_INFO_GOBLIN2 = "- 炼金术技能提高15点。",
        ABILITY_INFO_GOBLIN3 = "- 召唤哥伯尔，使你可以使用银行1分钟。",
        ABILITY_INFO_GOBLIN4 = "- 向敌人发射腰带火箭，造成火焰伤害。",
        ABILITY_INFO_GOBLIN5 = "- 启动火箭腰带向前跃进。",
        ABILITY_INFO_GOBLIN6 = "- 攻击和施法速度提高1%。",
        ABILITY_INFO_WORGEN1 = "- 对有害自然和暗影效果的抗性提高。",
        ABILITY_INFO_WORGEN2 = "- 移动速度提高40%，持续10秒。",
        ABILITY_INFO_WORGEN3 = "- 在人类与狼人形态之间切换。",
        ABILITY_INFO_WORGEN4 = "- 剥皮技能提高15点，并且剥皮速度更快。",
        ABILITY_INFO_WORGEN5 = "- 四足奔跑，速度如同野兽。",
        ABILITY_INFO_WORGEN6 = "- 切换到当前未激活的形态。",
        ABILITY_INFO_WORGEN7 = "- 暴击几率提高1%。",
        RACE_INFO_MAGHAR = "德拉诺的兽人氏族从未饮下腐化远亲的恶魔之血，因此以未受污染的玛格汉之名延续至今。骄傲而坚定的他们如今为自己在艾泽拉斯的位置而战。",
        RACE_INFO_HIGHELF = "高等精灵曾是奎尔萨拉斯骄傲的统治者，并从太阳之井汲取力量。太阳之井毁灭后，一些人拒绝了血精灵选择的道路，继续守护古老传统。",
        RACE_INFO_GOBLIN = "聪明、富有创造力且永远追逐利润的地精，凭借工程学、炼金术和贸易才能在部落中占据了一席之地。",
        RACE_INFO_WORGEN = "可怕的诅咒将许多吉尔尼斯居民变成狼人。学会控制野性后，他们为自己的人民以及在联盟中的位置而战。"
    },
    zhTW = {
        ABILITY_INFO_MAGHAR1 = "- 攻擊強度和法術傷害提高。",
        ABILITY_INFO_MAGHAR2 = "- 抵抗詛咒、疾病和中毒效果的機率提高。",
        ABILITY_INFO_MAGHAR3 = "- 寵物的最大生命值提高。",
        ABILITY_INFO_MAGHAR4 = "- 昏迷效果的持續時間縮短。",
        ABILITY_INFO_HIGHELF1 = "- 可以恢復法力、能量、符文能量或怒氣。",
        ABILITY_INFO_HIGHELF2 = "- 敏捷提高2%。",
        ABILITY_INFO_HIGHELF3 = "- 使用弓時的致命一擊機率提高。",
        ABILITY_INFO_HIGHELF4 = "- 附魔技能提高。",
        ABILITY_INFO_GOBLIN1 = "- 無論聲望如何，總能獲得最佳金幣折扣。",
        ABILITY_INFO_GOBLIN2 = "- 鍊金術技能提高15點。",
        ABILITY_INFO_GOBLIN3 = "- 召喚哥伯爾，使你可以使用銀行1分鐘。",
        ABILITY_INFO_GOBLIN4 = "- 向敵人發射腰帶火箭，造成火焰傷害。",
        ABILITY_INFO_GOBLIN5 = "- 啟動火箭腰帶向前躍進。",
        ABILITY_INFO_GOBLIN6 = "- 攻擊和施法速度提高1%。",
        ABILITY_INFO_WORGEN1 = "- 對有害自然和暗影效果的抗性提高。",
        ABILITY_INFO_WORGEN2 = "- 移動速度提高40%，持續10秒。",
        ABILITY_INFO_WORGEN3 = "- 在人類與狼人形態之間切換。",
        ABILITY_INFO_WORGEN4 = "- 剝皮技能提高15點，並且剝皮速度更快。",
        ABILITY_INFO_WORGEN5 = "- 四足奔跑，速度如同野獸。",
        ABILITY_INFO_WORGEN6 = "- 切換到目前未啟用的形態。",
        ABILITY_INFO_WORGEN7 = "- 致命一擊機率提高1%。",
        RACE_INFO_MAGHAR = "德拉諾的獸人氏族從未飲下腐化遠親的惡魔之血，因此以未受污染的瑪格哈之名延續至今。驕傲而堅定的他們如今為自己在艾澤拉斯的位置而戰。",
        RACE_INFO_HIGHELF = "高等精靈曾是奎爾薩拉斯驕傲的統治者，並從太陽之井汲取力量。太陽之井毀滅後，一些人拒絕了血精靈選擇的道路，繼續守護古老傳統。",
        RACE_INFO_GOBLIN = "聰明、富有創造力且永遠追逐利潤的哥布林，憑藉工程學、鍊金術和貿易才能在部落中占有一席之地。",
        RACE_INFO_WORGEN = "可怕的詛咒將許多吉爾尼斯居民變成狼人。學會控制野性後，他們為自己的人民以及在聯盟中的位置而戰。"
    }
};
BAERCRAFT_CUSTOM_TEXT.esMX = BAERCRAFT_CUSTOM_TEXT.esES;
local baercraftText = BAERCRAFT_CUSTOM_TEXT[BAERCRAFT_LOCALE] or BAERCRAFT_CUSTOM_TEXT.enUS;
for key, value in pairs(baercraftText) do
    _G[key] = value;
end
-- CharacterCreate uses gender-specific race flavor keys when available.
RACE_INFO_MAGHAR_FEMALE = RACE_INFO_MAGHAR;
RACE_INFO_HIGHELF_FEMALE = RACE_INFO_HIGHELF;
RACE_INFO_GOBLIN_FEMALE = RACE_INFO_GOBLIN;
RACE_INFO_WORGEN_FEMALE = RACE_INFO_WORGEN;
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
	
	["TAUREN_MALE"]		= {0, 0.125, 0.25, 0.5},
	["SCOURGE_MALE"]	= {0.125, 0.25, 0.25, 0.5},
	["TROLL_MALE"]		= {0.25, 0.375, 0.25, 0.5},
	["ORC_MALE"]		= {0.375, 0.5, 0.25, 0.5},

	["HUMAN_FEMALE"]	= {0, 0.125, 0.5, 0.75},  
	["DWARF_FEMALE"]	= {0.125, 0.25, 0.5, 0.75},
	["GNOME_FEMALE"]	= {0.25, 0.375, 0.5, 0.75},
	["NIGHTELF_FEMALE"]	= {0.375, 0.5, 0.5, 0.75},
	
	["TAUREN_FEMALE"]	= {0, 0.125, 0.75, 1.0},   
	["SCOURGE_FEMALE"]	= {0.125, 0.25, 0.75, 1.0}, 
	["TROLL_FEMALE"]	= {0.25, 0.375, 0.75, 1.0}, 
	["ORC_FEMALE"]		= {0.375, 0.5, 0.75, 1.0}, 

	["BLOODELF_MALE"]	= {0.5, 0.625, 0.25, 0.5},
	["BLOODELF_FEMALE"]	= {0.5, 0.625, 0.75, 1.0}, 
	["DRAENEI_MALE"]	= {0.5, 0.625, 0, 0.25},
	["DRAENEI_FEMALE"]	= {0.5, 0.625, 0.5, 0.75},

   	["GOBLIN_MALE"]     	= {0.625, 0.750, 0.25, 0.5},
   	["GOBLIN_FEMALE"]   	= {0.625, 0.750, 0.75, 1.0},
   	["WORGEN_MALE"]     	= {0.625, 0.750, 0, 0.25},
   	["WORGEN_FEMALE"]   	= {0.625, 0.750, 0.5, 0.75},

    ["HIGHELF_MALE"]        = {0.750, 0.875, 0, 0.25},
    ["HIGHELF_FEMALE"]    = {0.750, 0.875, 0.5, 0.75},
	["MAGHAR_MALE"]        = {0.750, 0.875, 0.25, 0.5},
    ["MAGHAR_FEMALE"]    = {0.750, 0.875, 0.75, 1.0},
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

function CharacterCreateEnumerateRaces(...)
	CharacterCreate.numRaces = select("#", ...)/3;
	if ( CharacterCreate.numRaces > MAX_RACES ) then
		message("Too many races!  Update MAX_RACES");
		return;
	end
	local coords;
	local index = 1;
	local button;
	local gender;
	local selectedSex = GetSelectedSex();
	if ( selectedSex == SEX_MALE ) then
		gender = "MALE";
	elseif ( selectedSex == SEX_FEMALE ) then
		gender = "FEMALE";
	end
	for i=1, select("#", ...), 3 do
		coords = RACE_ICON_TCOORDS[strupper(select(i+1, ...).."_"..gender)];
		_G["CharacterCreateRaceButton"..index.."NormalTexture"]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		_G["CharacterCreateRaceButton"..index.."PushedTexture"]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		button = _G["CharacterCreateRaceButton"..index];
		button:Show();
		if ( select(i+2, ...) == 1 ) then
			button.enable = true;
			SetButtonDesaturated(button);
			button.name = select(i, ...)
			button.tooltip = select(i, ...);
		else
			button.enable = false;
			SetButtonDesaturated(button, 1);
			button.name = select(i, ...)
			button.tooltip = _G[strupper(select(i+1, ...).."_".."DISABLED")];
		end
		index = index + 1;
	end
	for i=CharacterCreate.numRaces + 1, MAX_RACES, 1 do
		_G["CharacterCreateRaceButton"..i]:Hide();
	end
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
		coords = CLASS_ICON_TCOORDS[strupper(select(i+1, ...))];
		_G["CharacterCreateClassButton"..index.."NormalTexture"]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		_G["CharacterCreateClassButton"..index.."PushedTexture"]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		button = _G["CharacterCreateClassButton"..index];
		button:Show();
		if ( (select(i+2, ...) == 1) and (IsRaceClassValid(CharacterCreate.selectedRace, index)) ) then
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
	for i=1, CharacterCreate.numRaces, 1 do
		local button = _G["CharacterCreateRaceButton"..i];
		if ( i == id ) then
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
	if ( GetSelectedSex() == SEX_MALE ) then
		gender = "MALE";
	else
		gender = "FEMALE";
	end
	local coords = RACE_ICON_TCOORDS[fileString.."_"..gender];
	CharacterCreateRaceIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
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
	CharacterCreateRaceText:SetText(GetFlavorText("RACE_INFO_"..strupper(fileString), GetSelectedSex()).."|n|n");
	if ( abilityText and abilityText ~= "" ) then
		CharacterCreateRaceAbilityText:SetText(abilityText);
	else
		CharacterCreateRaceAbilityText:SetText("");
	end

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
	local _,_,currClass = GetSelectedClass();
	if ( currClass ~= id and IsRaceClassValid(GetSelectedRace(), id) ) then
		SetSelectedClass(id);
		SetCharacterClass(id);
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
	if ( GetSelectedRace() ~= id ) then
		SetSelectedRace(id);
		SetCharacterRace(id);
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
	CharacterCreateRaceIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
	
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

