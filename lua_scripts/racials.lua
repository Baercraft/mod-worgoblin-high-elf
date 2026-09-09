--[[
    Worgen "Running Wild" speed-spell teacher
    ------------------------------------------

    Synchronizes the custom Running Wild speed spell with
    the player's riding tier.

    Two Forms (68996) and Darkflight form handling are
    implemented entirely in C++ starting with FINAL FIX7.
]]

local RACE_WORGEN = 12
local CLASS_DEATH_KNIGHT = 6

local RIDE_APPRENTICE_SPELL = 33388
local RIDE_JOURNEYMAN_SPELL = 33391

local WORGEN_APPRENTICE_MALE   = 87840
local WORGEN_APPRENTICE_FEMALE = 87841
local WORGEN_JOURNEYMAN_MALE   = 110010
local WORGEN_JOURNEYMAN_FEMALE = 110011


-- GENDER_MALE = 0
-- GENDER_FEMALE = 1
local function GetGenderedSpells(player)
    local isMale = (player:GetGender() == 0)

    return {
        apprentice = isMale
            and WORGEN_APPRENTICE_MALE
            or WORGEN_APPRENTICE_FEMALE,

        journeyman = isMale
            and WORGEN_JOURNEYMAN_MALE
            or WORGEN_JOURNEYMAN_FEMALE
    }
end


local function GetTargetTier(player)

    -- Death Knights already start with riding skill 150.
    if player:GetClass() == CLASS_DEATH_KNIGHT then
        return "journeyman"
    end

    if player:HasSpell(RIDE_JOURNEYMAN_SPELL) then
        return "journeyman"
    end

    if player:HasSpell(RIDE_APPRENTICE_SPELL) then
        return "apprentice"
    end

    return nil
end


local function SyncRunningWild(player)

    if not player then
        return
    end

    if player:GetRace() ~= RACE_WORGEN then
        return
    end

    local targetTier = GetTargetTier(player)

    if not targetTier then
        return
    end

    local spells = GetGenderedSpells(player)

    local wantSpell
    local wrongSpell

    if targetTier == "journeyman" then
        wantSpell  = spells.journeyman
        wrongSpell = spells.apprentice
    else
        wantSpell  = spells.apprentice
        wrongSpell = spells.journeyman
    end

    local hasWanted = player:HasSpell(wantSpell)
    local hasWrong  = player:HasSpell(wrongSpell)

    -- Already exactly correct.
    if hasWanted and not hasWrong then
        return
    end

    if hasWrong then
        player:RemoveSpell(wrongSpell)
    end

    if not hasWanted then

        player:RegisterEvent(
            function(eventId, delay, repeats, plr)

                if not plr then
                    return
                end

                if not plr:IsInWorld() then
                    return
                end

                if plr:GetRace() ~= RACE_WORGEN then
                    return
                end

                if not plr:HasSpell(wantSpell) then
                    plr:LearnSpell(wantSpell)
                end
            end,

            250,
            1
        )
    end
end


-- Called when a riding spell is learned.
local function OnLearnSpell(event, player, spellId)

    if spellId == RIDE_APPRENTICE_SPELL
        or spellId == RIDE_JOURNEYMAN_SPELL
    then
        SyncRunningWild(player)
    end
end


-- Also watch the actual riding-spell cast because Journeyman
-- does not always trigger the learn event reliably.
local function OnCastRidingSpell(event, caster, spell, skipCheck)

    if not caster then
        return
    end

    local player = caster

    if caster.ToPlayer then
        player = caster:ToPlayer()
    end

    if player then
        SyncRunningWild(player)
    end
end


-- Safety net and Death Knight handling.
local function OnLogin(event, player)
    SyncRunningWild(player)
end


RegisterSpellEvent(
    RIDE_APPRENTICE_SPELL,
    2,
    OnCastRidingSpell
)

RegisterSpellEvent(
    RIDE_JOURNEYMAN_SPELL,
    2,
    OnCastRidingSpell
)

RegisterPlayerEvent(
    44,
    OnLearnSpell
)

RegisterPlayerEvent(
    3,
    OnLogin
)