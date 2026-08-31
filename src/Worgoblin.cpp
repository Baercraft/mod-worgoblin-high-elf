#include "worgoblin_loader.h"
#include "Chat.h"
#include "Config.h"
#include "DBCStores.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellScript.h"

namespace
{
    constexpr uint8 RACE_WORGEN_CUSTOM = 12;
    constexpr uint8 RACE_HIGH_ELF_CUSTOM = 13;
    constexpr uint8 RACE_MAGHAR_CUSTOM = 14;

    constexpr uint32 SPELL_BEST_DEALS_ANYWHERE = 69044;

    constexpr uint32 SPELL_MAGHAR_ANCESTRAL_CALL = 110001;
    constexpr uint32 SPELL_MAGHAR_SAVAGE_BLOOD = 110002;
    constexpr uint32 SPELL_MAGHAR_SYMPATHETIC_VIGOR = 110003;
    constexpr uint32 SPELL_MAGHAR_UNWAVERING_WILL = 110004;
    constexpr uint32 SPELL_DARKFLIGHT = 68992;
    constexpr uint32 SPELL_TWO_FORMS_MALE = 68996;
    constexpr uint32 SPELL_TWO_FORMS_FEMALE = 68995;
    constexpr uint32 SPELL_HUMAN_FORM_MALE = 68994;
    constexpr uint32 SPELL_HUMAN_FORM_FEMALE = 110020;

    constexpr uint32 SPELL_APPRENTICE_RIDING = 33388;
    constexpr uint32 SPELL_JOURNEYMAN_RIDING = 33391;
    constexpr uint32 SPELL_RUNNING_WILD_MALE_60 = 87840;
    constexpr uint32 SPELL_RUNNING_WILD_FEMALE_60 = 87841;
    constexpr uint32 SPELL_RUNNING_WILD_MALE_100 = 110010;
    constexpr uint32 SPELL_RUNNING_WILD_FEMALE_100 = 110011;

    bool TwoFormsEnabled()
    {
        return sConfigMgr->GetOption<bool>("Worgen.TwoForms.Enable", true);
    }

    bool IsWorgen(Player const* player)
    {
        return player && player->getRace() == RACE_WORGEN_CUSTOM;
    }

    bool IsMaghar(Player const* player)
    {
        return player && player->getRace() == RACE_MAGHAR_CUSTOM;
    }

    void SyncMagharRacials(Player* player)
    {
        if (!IsMaghar(player))
            return;

        constexpr uint32 magharRacials[] =
        {
            SPELL_MAGHAR_ANCESTRAL_CALL,
            SPELL_MAGHAR_SAVAGE_BLOOD,
            SPELL_MAGHAR_SYMPATHETIC_VIGOR,
            SPELL_MAGHAR_UNWAVERING_WILL
        };

        for (uint32 spellId : magharRacials)
            if (!player->HasSpell(spellId))
                player->learnSpell(spellId, false);
    }

    void SyncInheritedReputationVisibility(Player* player)
    {
        // Mag'har inherits Orc reputation; High Elf inherits Night Elf reputation.
        // Faction.dbc carries the actual inherited RaceMasks. This refresh also repairs
        // already-created custom-race characters whose reputation pane was initialized
        // before those masks were installed.
        if (!player || (player->getRace() != RACE_MAGHAR_CUSTOM && player->getRace() != RACE_HIGH_ELF_CUSTOM))
            return;

        ReputationMgr& reputationMgr = player->GetReputationMgr();
        uint32 raceMask = player->getRaceMask();
        uint32 classMask = player->getClassMask();
        bool shouldRefresh = false;

        for (uint32 i = 1; i < sFactionStore.GetNumRows(); ++i)
        {
            FactionEntry const* factionEntry = sFactionStore.LookupEntry(i);
            if (!factionEntry || factionEntry->reputationListID < 0)
                continue;

            for (uint8 slot = 0; slot < 4; ++slot)
            {
                bool raceMatches = (factionEntry->BaseRepRaceMask[slot] & raceMask) ||
                    (factionEntry->BaseRepRaceMask[slot] == 0 && factionEntry->BaseRepClassMask[slot] != 0);
                bool classMatches = (factionEntry->BaseRepClassMask[slot] & classMask) ||
                    factionEntry->BaseRepClassMask[slot] == 0;

                if (raceMatches && classMatches && (factionEntry->ReputationFlags[slot] & FACTION_FLAG_VISIBLE))
                {
                    reputationMgr.SetVisible(factionEntry);
                    shouldRefresh = true;
                    break;
                }
            }
        }

        // Existing Mag'har characters created before the RaceMask fix can have an empty
        // reputation pane. Re-send the initialized faction state after repairing visibility.
        if (shouldRefresh)
            reputationMgr.SendInitialReputations();
    }

    void RemoveKnownSpell(Player* player, uint32 spellId)
    {
        if (player->HasSpell(spellId))
            player->removeSpell(spellId, SPEC_MASK_ALL, false);
    }

    uint32 GenderedTwoForms(Player const* player)
    {
        return player->getGender() == GENDER_FEMALE ? SPELL_TWO_FORMS_FEMALE : SPELL_TWO_FORMS_MALE;
    }

    void RemoveHumanForm(Player* player)
    {
        player->RemoveAurasDueToSpell(SPELL_TWO_FORMS_MALE);
        player->RemoveAurasDueToSpell(SPELL_TWO_FORMS_FEMALE);
        player->RemoveAurasDueToSpell(SPELL_HUMAN_FORM_MALE);
        player->RemoveAurasDueToSpell(SPELL_HUMAN_FORM_FEMALE);
        player->DeMorph();
    }

    void SyncRunningWild(Player* player)
    {
        if (!IsWorgen(player))
            return;

        RemoveKnownSpell(player, SPELL_RUNNING_WILD_MALE_60);
        RemoveKnownSpell(player, SPELL_RUNNING_WILD_FEMALE_60);
        RemoveKnownSpell(player, SPELL_RUNNING_WILD_MALE_100);
        RemoveKnownSpell(player, SPELL_RUNNING_WILD_FEMALE_100);

        bool female = player->getGender() == GENDER_FEMALE;
        if (player->HasSpell(SPELL_JOURNEYMAN_RIDING))
            player->learnSpell(female ? SPELL_RUNNING_WILD_FEMALE_100 : SPELL_RUNNING_WILD_MALE_100, false);
        else if (player->HasSpell(SPELL_APPRENTICE_RIDING))
            player->learnSpell(female ? SPELL_RUNNING_WILD_FEMALE_60 : SPELL_RUNNING_WILD_MALE_60, false);
    }

    void SyncWorgenSpells(Player* player)
    {
        if (!IsWorgen(player))
            return;

        if (TwoFormsEnabled())
        {
            uint32 wanted = GenderedTwoForms(player);
            uint32 wrong = wanted == SPELL_TWO_FORMS_MALE ? SPELL_TWO_FORMS_FEMALE : SPELL_TWO_FORMS_MALE;
            RemoveKnownSpell(player, wrong);
            if (!player->HasSpell(wanted))
                player->learnSpell(wanted, false);
        }
        else
        {
            RemoveKnownSpell(player, SPELL_TWO_FORMS_MALE);
            RemoveKnownSpell(player, SPELL_TWO_FORMS_FEMALE);
            RemoveHumanForm(player);
        }

        SyncRunningWild(player);
    }

    bool IsStandardRaceClass(uint8 race, uint8 cls)
    {
        switch (race)
        {
            case 1:  return cls == 1 || cls == 2 || cls == 4 || cls == 5 || cls == 6 || cls == 8 || cls == 9;       // Human
            case 2:  return cls == 1 || cls == 3 || cls == 4 || cls == 6 || cls == 7 || cls == 9;                   // Orc
            case 3:  return cls == 1 || cls == 2 || cls == 3 || cls == 4 || cls == 5 || cls == 6;                   // Dwarf
            case 4:  return cls == 1 || cls == 3 || cls == 4 || cls == 5 || cls == 6 || cls == 11;                  // Night Elf
            case 5:  return cls == 1 || cls == 4 || cls == 5 || cls == 6 || cls == 8 || cls == 9;                   // Undead
            case 6:  return cls == 1 || cls == 3 || cls == 6 || cls == 7 || cls == 11;                              // Tauren
            case 7:  return cls == 1 || cls == 4 || cls == 6 || cls == 8 || cls == 9;                               // Gnome
            case 8:  return cls == 1 || cls == 3 || cls == 4 || cls == 5 || cls == 6 || cls == 7 || cls == 8;       // Troll
            case 9:  return cls == 1 || cls == 3 || cls == 4 || cls == 5 || cls == 6 || cls == 7 || cls == 8 || cls == 9; // Goblin
            case 10: return cls == 2 || cls == 3 || cls == 4 || cls == 5 || cls == 6 || cls == 8 || cls == 9;       // Blood Elf
            case 11: return cls == 1 || cls == 2 || cls == 3 || cls == 5 || cls == 6 || cls == 7 || cls == 8;       // Draenei
            case 12: return cls == 1 || cls == 3 || cls == 4 || cls == 5 || cls == 6 || cls == 8 || cls == 9 || cls == 11; // Worgen
            case 13: return cls == 1 || cls == 2 || cls == 3 || cls == 4 || cls == 5 || cls == 6 || cls == 8 || cls == 9;   // High Elf
            case 14: return cls == 1 || cls == 3 || cls == 4 || cls == 6 || cls == 7 || cls == 9;                   // Mag'har (Orc class set)
            default: return false;
        }
    }
}

class worgoblin_account : public AccountScript
{
public:
    worgoblin_account() : AccountScript("worgoblin_account") { }

    bool CanAccountCreateCharacter(uint32 /*accountId*/, uint8 charRace, uint8 charClass) override
    {
        if (sConfigMgr->GetOption<bool>("ARAC.Enable", false))
            return charRace >= 1 && charRace <= 14 && charClass >= 1 && charClass <= 11 && charClass != 10;

        return IsStandardRaceClass(charRace, charClass);
    }
};

class worgoblin : public PlayerScript
{
public:
    worgoblin() : PlayerScript("worgoblin") { }

    void OnPlayerLogin(Player* player) override
    {
        if (sConfigMgr->GetOption<bool>("Announce.Enable", true))
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the Worgoblin, High Elf and Mag'har module.");

        SyncWorgenSpells(player);
        SyncMagharRacials(player);
        SyncInheritedReputationVisibility(player);
    }

    void OnPlayerCreate(Player* player) override
    {
        SyncWorgenSpells(player);
        SyncMagharRacials(player);
    }

    void OnPlayerLearnSpell(Player* player, uint32 spellId) override
    {
        if (!IsWorgen(player))
            return;

        if (spellId == SPELL_APPRENTICE_RIDING || spellId == SPELL_JOURNEYMAN_RIDING)
            SyncRunningWild(player);
    }

    void OnPlayerForgotSpell(Player* player, uint32 spellId) override
    {
        if (!IsWorgen(player))
            return;

        if (spellId == SPELL_APPRENTICE_RIDING || spellId == SPELL_JOURNEYMAN_RIDING)
            SyncRunningWild(player);
    }

    void OnPlayerResurrect(Player* player, float /*restorePercent*/, bool& /*applySickness*/) override
    {
        if (TwoFormsEnabled() && IsWorgen(player))
            RemoveHumanForm(player);
    }

    void OnPlayerEnterCombat(Player* player, Unit* /*enemy*/) override
    {
        if (TwoFormsEnabled() && sConfigMgr->GetOption<bool>("Worgen.TwoForms.CombatForceWorgen", true) && IsWorgen(player))
            RemoveHumanForm(player);
    }

    void OnPlayerSpellCast(Player* player, Spell* spell, bool /*skipCheck*/) override
    {
        if (!TwoFormsEnabled() || !IsWorgen(player) || !spell)
            return;

        // Darkflight is a Worgen combat racial: always expose the Worgen form.
        if (spell->GetSpellInfo()->Id == SPELL_DARKFLIGHT)
            RemoveHumanForm(player);
    }

    bool OnPlayerCanFlyInZone(Player* /*player*/, uint32 mapId, uint32 /*zoneId*/, SpellInfo const* /*bySpell*/) override
    {
        if (sConfigMgr->GetOption<bool>("FlyAnywhere.Enable", false))
            return true;

        // Stock WotLK: outdoor flying belongs to Outland (530) and Northrend (571).
        // Normal core checks still run afterwards (Cold Weather Flying, no-fly zones, etc.).
        return mapId == 530 || mapId == 571;
    }

    void OnPlayerGetReputationPriceDiscount(Player const* player, FactionTemplateEntry const* factionTemplate, float& discount) override
    {
        if (!factionTemplate || !factionTemplate->faction)
            return;
        if (player->HasSpell(SPELL_BEST_DEALS_ANYWHERE))
            discount *= 0.8f;
    }
};

class spell_rocket_barrage : public SpellScript
{
    PrepareSpellScript(spell_rocket_barrage);

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        int32 basePoints = caster->GetLevel() * 2;
        basePoints += caster->SpellBaseDamageBonusDone(GetSpellInfo()->GetSchoolMask()) * 0.429;
        basePoints += caster->GetTotalAttackPowerValue(caster->getClass() != CLASS_HUNTER ? BASE_ATTACK : RANGED_ATTACK) * 0.25;
        SetEffectValue(basePoints);
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_rocket_barrage::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

void Add_Worgoblin()
{
    new worgoblin_account();
    new worgoblin();
    RegisterSpellScript(spell_rocket_barrage);
}
