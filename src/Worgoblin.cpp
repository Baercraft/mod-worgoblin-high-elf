#include "worgoblin_loader.h"
#include "Chat.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "Config.h"

enum Spells
{
    BEST_DEALS_ANYWHERE = 69044,
};

enum WorgenRiding
{
    SPELL_APPRENTICE_RIDING  = 33388,
    SPELL_JOURNEYMAN_RIDING  = 33391,
    SPELL_RW_APPR_MALE       = 87840,
    SPELL_RW_APPR_FEMALE     = 87841,
    SPELL_RW_JOURN_MALE      = 110010,
    SPELL_RW_JOURN_FEMALE    = 110011,
};



enum WorgenForms
{
    SPELL_TWO_FORMS_MALE       = 68996,
    SPELL_TWO_FORMS_FEMALE     = 68995,
    SPELL_PRE_WORGEN_HUMAN_MALE   = 68994,
    SPELL_PRE_WORGEN_HUMAN_FEMALE = 110020,
    SPELL_DARKFLIGHT           = 68992,
};

enum CustomRaceIds
{
    CUSTOM_RACE_ID_HIGHELF       = 13,
    CUSTOM_RACE_ID_MAGHARORC     = 14,
    CUSTOM_RACE_ID_OGRE          = 15,
    CUSTOM_RACE_ID_DARKIRONDWARF = 16,
};

enum CustomRaceSkills
{
    CUSTOM_SKILL_LANGUAGE_COMMON     = 98,
    CUSTOM_SKILL_LANGUAGE_ORCISH     = 109,
    CUSTOM_SKILL_LANGUAGE_DWARVEN    = 111,
    CUSTOM_SKILL_LANGUAGE_THALASSIAN = 137,
};

enum CustomRaceLanguageSpells
{
    SPELL_LANGUAGE_COMMON     = 668,
    SPELL_LANGUAGE_ORCISH     = 669,
    SPELL_LANGUAGE_DWARVEN    = 672,
    SPELL_LANGUAGE_THALASSIAN = 813,
};

enum CustomRaceRacials
{
    SPELL_MAGHAR_ANCESTRAL_CALL   = 110001,
    SPELL_MAGHAR_SAVAGE_BLOOD     = 110002,
    SPELL_MAGHAR_SYMPATHETIC_VIGOR= 110003,
    SPELL_MAGHAR_UNWAVERING_WILL  = 110004,
    SPELL_HIGHELF_MEDITATION      = 110005,
    SPELL_HIGHELF_SWIFTNESS       = 110006,
    SPELL_HIGHELF_MEDITATION_DK   = 110007,
    SPELL_HIGHELF_BOW_SPEC        = 110008,
    SPELL_HIGHELF_ENCHANTING_SPEC = 110009,

    SPELL_OGRE_WAR_STOMP          = 20549,
    SPELL_OGRE_ENDURANCE          = 20550,
    SPELL_OGRE_HARDINESS          = 20573,
    SPELL_OGRE_COMMAND            = 20575,

    SPELL_DARKIRON_STONEFORM      = 20594,
    SPELL_DARKIRON_GUN_SPEC       = 20595,
    SPELL_DARKIRON_FROST_RES      = 20596,
    SPELL_DARKIRON_FIND_TREASURE  = 2481,
    SPELL_DARKIRON_MACE_SPEC      = 59224,
};

// Canonical level-1 weapon/armor proficiency spells from AzerothCore's native
// playercreateinfo skill setup.  These are used only as an additive safety net:
// native combinations already know them, while ARAC/custom-race combinations
// can otherwise miss the proficiency even when the DBC masks are correct.
enum StarterProficiencySpells
{
    SPELL_PROF_POLEARMS          = 200,
    SPELL_PROF_PLATE             = 750,
    SPELL_PROF_TWO_HANDED_SWORDS= 202,
    SPELL_PROF_MAIL              = 8737,
    SPELL_PROF_AXES              = 196,
    SPELL_PROF_TWO_HANDED_AXES   = 197,
    SPELL_PROF_SWORDS            = 201,
    SPELL_PROF_DUAL_WIELD        = 674,
    SPELL_PROF_SHIELD            = 9116,
    SPELL_PROF_WANDS             = 5009,
    SPELL_PROF_MACES             = 198,
    SPELL_PROF_LEATHER           = 9077,
    SPELL_PROF_STAVES            = 227,
};

class worgoblin : public PlayerScript {

public:
    worgoblin() : PlayerScript("worgoblin") { }

    void OnPlayerLogin(Player* player) override
    {
        if (sConfigMgr->GetOption<bool>("Announce.enable", true))
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the Worgoblin and High Elf modules.");

        EnsureWorgenTwoForms(player);
        EnsureStarterClassProficiencies(player);
        EnsureCustomRaceArmorSkills(player);
        // FULLFIX 6.5.10: the core can revalidate/remove custom-race languages
        // after OnPlayerCreate. Re-check them after the character has fully
        // loaded. EnsureLanguage/EnsureSpell are idempotent, so this does not
        // duplicate valid spells or skills.
        EnsureCustomRaceLanguagesAndRacials(player);
    }

    void OnPlayerCreate(Player* player) override
    {
        EnsureWorgenTwoForms(player);
        EnsureStarterClassProficiencies(player);
        EnsureCustomRaceArmorSkills(player);
        EnsureCustomRaceLanguagesAndRacials(player);
    }

    void OnPlayerEnterCombat(Player* player, Unit* /*enemy*/) override
    {
        ForceWorgenCombatForm(player);
    }

    void OnPlayerSpellCast(Player* player, Spell* spell, bool /*skipCheck*/) override
    {
        if (!player || !spell || player->getRace() != RACE_WORGEN)
            return;

        if (spell->GetSpellInfo()->Id == SPELL_DARKFLIGHT)
            ForceWorgenCombatForm(player);
    }

    bool OnPlayerCanFlyInZone(Player* /*player*/, uint32 mapId, uint32 zoneId, SpellInfo const* /*bySpell*/) override
    {
        // patch-A keeps the Fly Anywhere-capable DBC set installed at all times.
        // This switch makes the feature runtime-configurable without swapping DBCs.
        if (sConfigMgr->GetOption<bool>("Worgoblin.FlyAnywhere.Enable", true))
            return true;

        // WotLK normally does not permit player-controlled flying in the classic
        // Eastern Kingdoms/Kalimdor world maps. Returning false here stops the
        // flight check before the permissive Fly Anywhere DBCs can allow it.
        if (mapId == 0 || mapId == 1)
            return false;

        // The Burning Crusade starting regions share map 530 with Outland but
        // were not normal flying zones in WotLK. zoneId is the parent zone id,
        // so this also covers their subareas.
        if (mapId == 530)
        {
            switch (zoneId)
            {
                case 3430: // Eversong Woods
                case 3433: // Ghostlands
                case 3487: // Silvermoon City
                case 3524: // Azuremyst Isle
                case 3525: // Bloodmyst Isle
                case 3557: // The Exodar
                case 4080: // Isle of Quel'Danas
                    return false;
                default:
                    break;
            }
        }

        // Outland/Northrend and all other maps continue through AzerothCore's
        // normal checks (riding skill, Cold Weather Flying, no-fly areas, etc.).
        return true;
    }

private:
    static void EnsureStarterClassProficiencies(Player* player)
    {
        if (!player)
            return;

        // Class masks are the same masks used by playercreateinfo_skills in the
        // stock WotLK/AzerothCore data.  We deliberately do not key this on race:
        // ARAC means an unusual race must receive the same starter proficiencies
        // as a native member of that class.  EnsureSpell is idempotent, so native
        // combinations are unchanged.
        uint32 classMask = 1u << (player->getClass() - 1);

        if (classMask & 32u) // Death Knight
        {
            EnsureSpell(player, SPELL_PROF_POLEARMS);
            EnsureSpell(player, SPELL_PROF_PLATE);
        }
        if (classMask & 35u) // Warrior, Paladin, Death Knight
        {
            EnsureSpell(player, SPELL_PROF_TWO_HANDED_SWORDS);
            EnsureSpell(player, SPELL_PROF_MAIL);
        }
        if (classMask & 37u) // Warrior, Hunter, Death Knight
        {
            EnsureSpell(player, SPELL_PROF_AXES);
            EnsureSpell(player, SPELL_PROF_TWO_HANDED_AXES);
        }
        if (classMask & 39u) // Warrior, Paladin, Hunter, Death Knight
            EnsureSpell(player, SPELL_PROF_SWORDS);
        if (classMask & 40u) // Rogue, Death Knight
            EnsureSpell(player, SPELL_PROF_DUAL_WIELD);
        if (classMask & 67u) // Warrior, Paladin, Shaman
            EnsureSpell(player, SPELL_PROF_SHIELD);
        if (classMask & 400u) // Priest, Mage, Warlock
            EnsureSpell(player, SPELL_PROF_WANDS);
        if (classMask & 1107u) // Warrior, Paladin, Priest, Shaman, Druid
            EnsureSpell(player, SPELL_PROF_MACES);
        if (classMask & 1135u) // Warrior, Paladin, Hunter, Rogue, DK, Shaman, Druid
            EnsureSpell(player, SPELL_PROF_LEATHER);
        if (classMask & 1488u) // Priest, Shaman, Mage, Warlock, Druid
            EnsureSpell(player, SPELL_PROF_STAVES);
    }

    static void EnsureSkill(Player* player, uint16 skillId)
    {
        if (!player->HasSkill(skillId))
            player->SetSkill(skillId, 0, 1, 1);
    }

    static void EnsureCustomRaceArmorSkills(Player* player)
    {
        if (!player || player->getRace() < CUSTOM_RACE_ID_HIGHELF || player->getRace() > CUSTOM_RACE_ID_DARKIRONDWARF)
            return;

        uint32 classMask = 1u << (player->getClass() - 1);

        // Cloth is a baseline armor proficiency for every playable class.
        EnsureSkill(player, 415);

        // These are the canonical playercreateinfo_skills class masks.
        // Explicitly setting the SkillLine is important: learning only the
        // proficiency spell does not reliably initialize the skill for custom races.
        if (classMask & 1135u) // Warrior, Paladin, Hunter, Rogue, DK, Shaman, Druid
            EnsureSkill(player, 414); // Leather
        if (classMask & 35u)   // Warrior, Paladin, DK
            EnsureSkill(player, 413); // Mail
        if (classMask & 32u)   // Death Knight
            EnsureSkill(player, 293); // Plate
        if (classMask & 67u)   // Warrior, Paladin, Shaman
            EnsureSkill(player, 433); // Shield
    }

    static void EnsureLanguage(Player* player, uint16 skillId, uint32 languageSpellId)
    {
        // AzerothCore checks both the language skill and the language spell.
        // Custom races therefore need both, just like the Blizzard races do.
        if (!player->HasSkill(skillId) || player->GetSkillValue(skillId) < 300)
            player->SetSkill(skillId, 0, 300, 300);

        if (!player->HasSpell(languageSpellId))
            player->learnSpell(languageSpellId);
    }

    static void EnsureSpell(Player* player, uint32 spellId)
    {
        if (!player->HasSpell(spellId))
            player->learnSpell(spellId);
    }

    static void EnsureCustomRaceLanguagesAndRacials(Player* player)
    {
        if (!player)
            return;

        switch (player->getRace())
        {
            case CUSTOM_RACE_ID_HIGHELF:
                // Alliance High Elves speak Common and retain Thalassian.
                EnsureLanguage(player, CUSTOM_SKILL_LANGUAGE_COMMON, SPELL_LANGUAGE_COMMON);
                EnsureLanguage(player, CUSTOM_SKILL_LANGUAGE_THALASSIAN, SPELL_LANGUAGE_THALASSIAN);

                // Only one active Meditation variant: DK uses runic power, all others use the normal version.
                if (player->getClass() == CLASS_DEATH_KNIGHT)
                {
                    if (player->HasSpell(SPELL_HIGHELF_MEDITATION))
                        player->removeSpell(SPELL_HIGHELF_MEDITATION, SPEC_MASK_ALL, false);
                    EnsureSpell(player, SPELL_HIGHELF_MEDITATION_DK);
                }
                else
                {
                    if (player->HasSpell(SPELL_HIGHELF_MEDITATION_DK))
                        player->removeSpell(SPELL_HIGHELF_MEDITATION_DK, SPEC_MASK_ALL, false);
                    EnsureSpell(player, SPELL_HIGHELF_MEDITATION);
                }
                EnsureSpell(player, SPELL_HIGHELF_SWIFTNESS);
                EnsureSpell(player, SPELL_HIGHELF_BOW_SPEC);
                EnsureSpell(player, SPELL_HIGHELF_ENCHANTING_SPEC);
                break;

            case CUSTOM_RACE_ID_MAGHARORC:
                EnsureLanguage(player, CUSTOM_SKILL_LANGUAGE_ORCISH, SPELL_LANGUAGE_ORCISH);
                EnsureSpell(player, SPELL_MAGHAR_ANCESTRAL_CALL);
                EnsureSpell(player, SPELL_MAGHAR_SAVAGE_BLOOD);
                EnsureSpell(player, SPELL_MAGHAR_SYMPATHETIC_VIGOR);
                EnsureSpell(player, SPELL_MAGHAR_UNWAVERING_WILL);
                break;

            case CUSTOM_RACE_ID_OGRE:
                EnsureLanguage(player, CUSTOM_SKILL_LANGUAGE_ORCISH, SPELL_LANGUAGE_ORCISH);
                EnsureSpell(player, SPELL_OGRE_WAR_STOMP);
                EnsureSpell(player, SPELL_OGRE_ENDURANCE);
                EnsureSpell(player, SPELL_OGRE_HARDINESS);
                EnsureSpell(player, SPELL_OGRE_COMMAND);
                break;

            case CUSTOM_RACE_ID_DARKIRONDWARF:
                EnsureLanguage(player, CUSTOM_SKILL_LANGUAGE_COMMON, SPELL_LANGUAGE_COMMON);
                EnsureLanguage(player, CUSTOM_SKILL_LANGUAGE_DWARVEN, SPELL_LANGUAGE_DWARVEN);
                EnsureSpell(player, SPELL_DARKIRON_STONEFORM);
                EnsureSpell(player, SPELL_DARKIRON_GUN_SPEC);
                EnsureSpell(player, SPELL_DARKIRON_FROST_RES);
                EnsureSpell(player, SPELL_DARKIRON_FIND_TREASURE);
                EnsureSpell(player, SPELL_DARKIRON_MACE_SPEC);
                break;

            default:
                break;
        }
    }

    static uint32 GetTwoFormsSpell(Player const* player)
    {
        return player->getGender() == GENDER_FEMALE ? SPELL_TWO_FORMS_FEMALE : SPELL_TWO_FORMS_MALE;
    }

    static void EnsureWorgenTwoForms(Player* player)
    {
        if (!player || player->getRace() != RACE_WORGEN)
            return;

        uint32 spellId = GetTwoFormsSpell(player);
        if (!player->HasSpell(spellId))
            player->learnSpell(spellId);
    }

    static void ForceWorgenCombatForm(Player* player)
    {
        if (!player || player->getRace() != RACE_WORGEN)
            return;

        // Two Forms is implemented as a transform aura. Removing any human-form
        // variant lets the core restore the player's native Worgen display.
        player->RemoveAurasDueToSpell(SPELL_TWO_FORMS_MALE);
        player->RemoveAurasDueToSpell(SPELL_TWO_FORMS_FEMALE);
        player->RemoveAurasDueToSpell(SPELL_PRE_WORGEN_HUMAN_MALE);
        player->RemoveAurasDueToSpell(SPELL_PRE_WORGEN_HUMAN_FEMALE);
    }

public:
    void OnPlayerGetReputationPriceDiscount(Player const* player, FactionTemplateEntry const* factionTemplate, float& discount) override
    {
        if (!factionTemplate || !factionTemplate->faction)
            return;

        if (player->HasSpell(BEST_DEALS_ANYWHERE))
            discount *= 0.8;
    }
};

class spell_rocket_barrage : public SpellScript
{
    PrepareSpellScript(spell_rocket_barrage);

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        int32 basePoints = 0 + caster->GetLevel() * 2;
        basePoints += caster->SpellBaseDamageBonusDone(GetSpellInfo()->GetSchoolMask()) * 0.429; //BM=0.429 here, don't ask me how.
        basePoints += caster->GetTotalAttackPowerValue(caster->getClass() != CLASS_HUNTER ? BASE_ATTACK : RANGED_ATTACK) * 0.25; // 0.25=BonusCoefficient, hardcoding it here
        SetEffectValue(basePoints);
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_rocket_barrage::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class player_worgen_running_wild : public PlayerScript
{
public:
    player_worgen_running_wild() : PlayerScript("player_worgen_running_wild") { }

    void OnPlayerLogin(Player* player) override { HandleWorgen(player); }
    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override { HandleWorgen(player); }

private:
    void HandleWorgen(Player* player)
    {
        if (player->getRace() != RACE_WORGEN)
            return;

        // riding-skill spells don't reliably show up on AC for DKs, so give them the fast RW at creation
        if (player->getClass() == CLASS_DEATH_KNIGHT)
        {
            uint32 rwSpell    = GetRWSpell(player, true);
            uint32 otherSpell = GetRWSpell(player, false);

            if (player->HasSpell(otherSpell))
                player->removeSpell(otherSpell, SPEC_MASK_ALL, false);

            if (!player->HasSpell(rwSpell))
                player->learnSpell(rwSpell);

            return;
        }

        uint8 level = player->GetLevel();

        // Check the actual Riding skill as well as the spell. Existing characters can
        // have 33388/33391 persisted in character_spell while HasSpell() is false
        // during login initialization; relearning then causes duplicate-key writes.
        constexpr uint16 SKILL_RIDING_ID = 762;
        uint16 ridingValue = player->GetSkillValue(SKILL_RIDING_ID);

        if (sConfigMgr->GetOption<bool>("Worgoblin.RunningWild.FreeApprentice", true)
            && level >= 20 && ridingValue < 75 && !player->HasSpell(SPELL_APPRENTICE_RIDING))
            player->learnSpell(SPELL_APPRENTICE_RIDING);

        if (sConfigMgr->GetOption<bool>("Worgoblin.RunningWild.FreeJourneyman", true)
            && level >= 40 && ridingValue < 150 && !player->HasSpell(SPELL_JOURNEYMAN_RIDING))
            player->learnSpell(SPELL_JOURNEYMAN_RIDING);

        SyncRunningWild(player);
    }

    uint32 GetRWSpell(Player* player, bool journeyman) const
    {
        bool isMale = player->getGender() == GENDER_MALE;
        if (journeyman)
            return isMale ? SPELL_RW_JOURN_MALE : SPELL_RW_JOURN_FEMALE;
        return isMale ? SPELL_RW_APPR_MALE : SPELL_RW_APPR_FEMALE;
    }

    void SyncRunningWild(Player* player)
    {
        // Only reached for non-DKs, so these HasSpell checks are trustworthy here.
        bool hasJourneyman = player->HasSpell(SPELL_JOURNEYMAN_RIDING);
        bool hasApprentice = player->HasSpell(SPELL_APPRENTICE_RIDING);

        if (!hasJourneyman && !hasApprentice)
            return; // no riding skill yet, nothing to sync

        uint32 wantSpell  = GetRWSpell(player, hasJourneyman);
        uint32 otherSpell = GetRWSpell(player, !hasJourneyman);

        if (player->HasSpell(wantSpell) && !player->HasSpell(otherSpell))
            return; // already correct

        if (player->HasSpell(otherSpell))
            player->removeSpell(otherSpell, SPEC_MASK_ALL, false);

        if (!player->HasSpell(wantSpell))
            player->learnSpell(wantSpell);
    }
};

void Add_Worgoblin()
{
    new worgoblin();
    RegisterSpellScript(spell_rocket_barrage);
    new player_worgen_running_wild();
}