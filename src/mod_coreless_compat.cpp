#include "ScriptMgr.h"
#include "Player.h"
#include "Random.h"
#include "SpellScript.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "Creature.h"

#include <array>
#include <cstdint>

namespace
{
    constexpr uint8 RACE_GOBLIN_CUSTOM = 9;
    constexpr uint8 RACE_WORGEN_CUSTOM = 12;
    constexpr uint8 RACE_HIGH_ELF = 13;
    constexpr uint8 RACE_MAGHAR_ORC = 14;
    constexpr uint8 RACE_OGRE = 15;
    constexpr uint8 RACE_DARK_IRON = 16;
    constexpr uint8 RACE_ZANDALARI = 17;

    constexpr uint32 SPELL_TWO_FORMS = 68996;
    constexpr uint32 SPELL_DARKFLIGHT = 68992;
    constexpr uint32 HUMAN_MALE_DISPLAY = 19723;
    constexpr uint32 HUMAN_FEMALE_DISPLAY = 20464;

    enum ParentRace : uint8 { PARENT_NONE, PARENT_HUMAN, PARENT_ORC, PARENT_DWARF, PARENT_TROLL, PARENT_BLOODELF };

    ParentRace GetParentRace(uint8 race)
    {
        switch (race)
        {
            case RACE_WORGEN_CUSTOM: return PARENT_HUMAN;
            case RACE_HIGH_ELF: return PARENT_BLOODELF;
            case RACE_GOBLIN_CUSTOM:
            case RACE_MAGHAR_ORC:
            case RACE_OGRE: return PARENT_ORC;
            case RACE_DARK_IRON: return PARENT_DWARF;
            case RACE_ZANDALARI: return PARENT_TROLL;
            default: return PARENT_NONE;
        }
    }

    uint32 GenderDisplay(Player const* player, uint32 male, uint32 female)
    {
        return player->getGender() == GENDER_FEMALE ? female : male;
    }

    uint32 GetTransformDisplay(Player* player, uint32 spellId)
    {
        ParentRace parent = GetParentRace(player->getRace());
        if (parent == PARENT_NONE)
            return 0;

        switch (spellId)
        {
            case 16739: // Orb of Deception
                switch (parent)
                {
                    case PARENT_BLOODELF: return GenderDisplay(player, 17829, 17830);
                    case PARENT_ORC:      return GenderDisplay(player, 10139, 10140);
                    case PARENT_DWARF:    return GenderDisplay(player, 10141, 10142);
                    case PARENT_HUMAN:    return GenderDisplay(player, 10137, 10138);
                    case PARENT_TROLL:    return GenderDisplay(player, 10135, 10134);
                    default: return 0;
                }
            case 50517: // Dread Corsair
            case 51926: // Corsair Costume
            case 65528: // Pirates' Day
                switch (parent)
                {
                    case PARENT_BLOODELF: return GenderDisplay(player, 25032, 25043);
                    case PARENT_ORC:      return GenderDisplay(player, 25039, 25050);
                    case PARENT_DWARF:    return GenderDisplay(player, 25034, 25045);
                    case PARENT_HUMAN:    return GenderDisplay(player, 25037, 25048);
                    case PARENT_TROLL:    return GenderDisplay(player, 25041, 25052);
                    default: return 0;
                }
            case 65511: // Brewfest gossip appearance
                switch (parent)
                {
                    case PARENT_BLOODELF:
                        return urand(0, 1) ? GenderDisplay(player, 21839, 21838) : GenderDisplay(player, 21841, 21840);
                    case PARENT_ORC:
                        return urand(0, 1) ? GenderDisplay(player, 21867, 21866) : GenderDisplay(player, 21869, 21868);
                    case PARENT_DWARF:
                        return urand(0, 1) ? GenderDisplay(player, 21846, 21848) : GenderDisplay(player, 21847, 21849);
                    case PARENT_HUMAN:
                        return urand(0, 1) ? GenderDisplay(player, 21859, 21858) : GenderDisplay(player, 21861, 21860);
                    case PARENT_TROLL:
                        return urand(0, 1) ? GenderDisplay(player, 21875, 21874) : GenderDisplay(player, 21877, 21876);
                    default: return 0;
                }
            case 65522: // Winter Veil
                switch (parent)
                {
                    case PARENT_BLOODELF: return GenderDisplay(player, 18793, 18785);
                    case PARENT_ORC:      return GenderDisplay(player, 18805, 18804);
                    case PARENT_DWARF:    return GenderDisplay(player, 18797, 18796);
                    case PARENT_HUMAN:    return GenderDisplay(player, 18801, 18800);
                    case PARENT_TROLL:    return GenderDisplay(player, 18809, 18808);
                    default: return 0;
                }
            case 65523: // Default gossip appearance
                switch (parent)
                {
                    case PARENT_BLOODELF: return GenderDisplay(player, 19170, 19169);
                    case PARENT_ORC:      return GenderDisplay(player, 19182, 19181);
                    case PARENT_DWARF:    return GenderDisplay(player, 19174, 19173);
                    case PARENT_HUMAN:    return GenderDisplay(player, 19178, 19177);
                    case PARENT_TROLL:    return GenderDisplay(player, 19186, 19185);
                    default: return 0;
                }
            case 65524: // Lunar Festival
                switch (parent)
                {
                    case PARENT_BLOODELF: return GenderDisplay(player, 18841, 18840);
                    case PARENT_ORC:      return GenderDisplay(player, 18870, 18869);
                    case PARENT_DWARF:    return GenderDisplay(player, 18845, 18844);
                    case PARENT_HUMAN:    return GenderDisplay(player, 18860, 18858);
                    case PARENT_TROLL:    return GenderDisplay(player, 18874, 18873);
                    default: return 0;
                }
            case 65525: // Hallow's End
                switch (parent)
                {
                    case PARENT_BLOODELF: return GenderDisplay(player, 22361, 22360);
                    case PARENT_ORC:      return GenderDisplay(player, 22375, 22374);
                    case PARENT_DWARF:    return GenderDisplay(player, 22365, 22364);
                    case PARENT_HUMAN:    return GenderDisplay(player, 22371, 22370);
                    case PARENT_TROLL:    return GenderDisplay(player, 22379, 22378);
                    default: return 0;
                }
            case 65526: // Midsummer
                switch (parent)
                {
                    case PARENT_BLOODELF: return GenderDisplay(player, 21086, 21085);
                    case PARENT_ORC:      return GenderDisplay(player, 16438, 16436);
                    case PARENT_DWARF:    return GenderDisplay(player, 16413, 16434);
                    case PARENT_HUMAN:    return GenderDisplay(player, 16433, 16412);
                    case PARENT_TROLL:    return GenderDisplay(player, 16446, 16445);
                    default: return 0;
                }
            case 65527: // Spirit of Competition
                switch (parent)
                {
                    case PARENT_BLOODELF: return GenderDisplay(player, 24508, 24519);
                    case PARENT_ORC:      return GenderDisplay(player, 24515, 24526);
                    case PARENT_DWARF:    return GenderDisplay(player, 24510, 24521);
                    case PARENT_HUMAN:    return GenderDisplay(player, 24513, 24524);
                    case PARENT_TROLL:    return GenderDisplay(player, 24517, 24528);
                    default: return 0;
                }
            default: return 0;
        }
    }

    void NormalizeCustomRaceLanguages(Player* player)
    {
        // Language spells: Common 668, Orcish 669, Dwarven 672, Thalassian 813, Troll 7341.
        std::array<uint32, 5> const languages = { 668, 669, 672, 813, 7341 };
        bool wanted[5] = { false, false, false, false, false };

        switch (player->getRace())
        {
            case RACE_HIGH_ELF:  wanted[0] = true; wanted[3] = true; break;
            case RACE_MAGHAR_ORC:
            case RACE_OGRE:
            case RACE_GOBLIN_CUSTOM: wanted[1] = true; break;
            case RACE_DARK_IRON: wanted[0] = true; wanted[2] = true; break;
            case RACE_ZANDALARI: wanted[1] = true; wanted[4] = true; break;
            case RACE_WORGEN_CUSTOM: wanted[0] = true; break;
            default: return;
        }

        for (size_t i = 0; i < languages.size(); ++i)
        {
            if (wanted[i])
            {
                if (!player->HasSpell(languages[i]))
                    player->learnSpell(languages[i]);
            }
            else if (player->HasSpell(languages[i]))
                player->removeSpell(languages[i], SPEC_MASK_ALL, false);
        }
    }

    void EnsureCustomRaceRacials(Player* player)
    {
        auto LearnIfMissing = [player](uint32 spellId)
        {
            if (spellId && !player->HasSpell(spellId))
                player->learnSpell(spellId);
        };

        switch (player->getRace())
        {
            case RACE_WORGEN_CUSTOM:
                // Two Forms is handled entirely in C++ in FINAL FIX7.
                LearnIfMissing(SPELL_TWO_FORMS);
                break;

            case RACE_HIGH_ELF:
                // High Elf: class-specific meditation plus shared racials.
                LearnIfMissing(player->getClass() == CLASS_DEATH_KNIGHT ? 110007 : 110005);
                LearnIfMissing(110006); // Swiftness of the Rangers
                LearnIfMissing(110008); // Bow Specialization
                LearnIfMissing(110009); // Enchanting Specialization
                break;

            case RACE_MAGHAR_ORC:
                // Mag'har custom racial package.
                LearnIfMissing(110001); // Ancestral Call
                LearnIfMissing(110002); // Savage Blood
                LearnIfMissing(110003); // Sympathetic Vigor
                LearnIfMissing(110004); // Unwavering Will
                break;

            case RACE_OGRE:
                // Ogre uses the racial package shown in the character-creation UI:
                // War Stomp, Endurance, Hardiness and Command. Older module SQL
                // incorrectly granted the Mag'har package to Ogres, so remove it.
                for (uint32 spellId : std::array<uint32, 4>{ 110001, 110002, 110003, 110004 })
                    if (player->HasSpell(spellId))
                        player->removeSpell(spellId, SPEC_MASK_ALL, false);

                LearnIfMissing(20549); // War Stomp
                LearnIfMissing(20550); // Endurance
                LearnIfMissing(20573); // Hardiness
                LearnIfMissing(20574); // Command
                break;

            case RACE_DARK_IRON:
                // Dark Iron currently inherits the WotLK dwarf racial package.
                LearnIfMissing(20594); // Stoneform
                LearnIfMissing(20595); // Gun Specialization
                LearnIfMissing(20596); // Frost Resistance
                LearnIfMissing(2481);  // Find Treasure
                LearnIfMissing(59224); // Mace Specialization
                break;

            default:
                break;
        }
    }


    bool IsHumanWorgenDisplay(Player const* player)
    {
        uint32 displayId = player->GetDisplayId();
        return displayId == HUMAN_MALE_DISPLAY || displayId == HUMAN_FEMALE_DISPLAY;
    }

    void ForceWorgenForm(Player* player)
    {
        if (!player || player->getRace() != RACE_WORGEN_CUSTOM)
            return;

        if (IsHumanWorgenDisplay(player))
            player->SetDisplayId(player->GetNativeDisplayId());
    }

    void ToggleTwoForms(Player* player)
    {
        if (!player || player->getRace() != RACE_WORGEN_CUSTOM)
            return;

        // Worgen cannot remain in human form while in combat.
        if (player->IsInCombat())
        {
            ForceWorgenForm(player);
            return;
        }

        if (IsHumanWorgenDisplay(player))
            player->SetDisplayId(player->GetNativeDisplayId());
        else
            player->SetDisplayId(GenderDisplay(player, HUMAN_MALE_DISPLAY, HUMAN_FEMALE_DISPLAY));
    }

    void EnsureStartTaxi(Player* player)
    {
        uint32 node = 0;
        switch (player->getRace())
        {
            case RACE_HIGH_ELF: node = 2; break;
            case RACE_GOBLIN_CUSTOM:
            case RACE_MAGHAR_ORC:
            case RACE_OGRE:
            case RACE_ZANDALARI: node = 23; break;
            case RACE_DARK_IRON: node = 6; break;
            case RACE_WORGEN_CUSTOM:
                player->m_taxi.SetTaximaskNode(26);
                player->m_taxi.SetTaximaskNode(27);
                return;
            default: return;
        }
        if (node)
            player->m_taxi.SetTaximaskNode(node);
    }
}

class coreless_custom_race_player : public PlayerScript
{
public:
    coreless_custom_race_player() : PlayerScript("coreless_custom_race_player") { }

    void OnPlayerCreate(Player* player) override
    {
        // Character creation runs before the Player is attached to a Map.
        // Only touch the taxi mask here; learnSpell/removeSpell can reach
        // map-dependent code and must wait until OnPlayerLogin.
        EnsureStartTaxi(player);
    }

    void OnPlayerLogin(Player* player) override
    {
        // At this point the player is fully placed in the world. This is the
        // safe place for language normalization and also covers race/faction
        // changes, which require a relog before normal play continues.
        EnsureStartTaxi(player);
        NormalizeCustomRaceLanguages(player);
        EnsureCustomRaceRacials(player);
    }

    void OnPlayerSpellCast(Player* player, Spell* spell, bool /*skipCheck*/) override
    {
        if (!player || !spell || player->getRace() != RACE_WORGEN_CUSTOM)
            return;

        SpellInfo const* spellInfo = spell->GetSpellInfo();
        if (!spellInfo)
            return;

        if (spellInfo->Id == SPELL_TWO_FORMS)
            ToggleTwoForms(player);
        else if (spellInfo->Id == SPELL_DARKFLIGHT)
            ForceWorgenForm(player);
    }

    void OnPlayerEnterCombat(Player* player, Unit* /*enemy*/) override
    {
        ForceWorgenForm(player);
    }
};

class spell_coreless_parent_race_transform : public AuraScript
{
    PrepareAuraScript(spell_coreless_parent_race_transform);

    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* player = GetUnitOwner()->ToPlayer();
        if (!player)
            return;

        if (uint32 displayId = GetTransformDisplay(player, GetId()))
            player->SetDisplayId(displayId);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_coreless_parent_race_transform::AfterApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

class spell_coreless_high_elf_dk_initiate : public SpellScript
{
    PrepareSpellScript(spell_coreless_high_elf_dk_initiate);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Creature* target = GetHitCreature();
        if (!target)
            return;

        switch (target->GetDisplayId())
        {
            case 33924: target->CastSpell(target, 51552, true); target->LoadEquipment(); break; // High Elf female
            case 33925: target->CastSpell(target, 51551, true); target->LoadEquipment(); break; // High Elf male
            default: break;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_coreless_high_elf_dk_initiate::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_mod_coreless_compat()
{
    new coreless_custom_race_player();
    RegisterSpellScript(spell_coreless_parent_race_transform);
    RegisterSpellScript(spell_coreless_high_elf_dk_initiate);
}
