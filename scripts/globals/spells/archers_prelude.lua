-----------------------------------------
-- Spell: Archer's Prelude
-- Gives party members ranged attack accuracy
-----------------------------------------
require("scripts/globals/status");
require("scripts/globals/msg");
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0;
end;

function onSpellCast(caster,target,spell)
    local sLvl = caster:getSkillLevel(SKILL_SNG); -- Gets skill level of Singing
    local iLvl = caster:getWeaponSkillLevel(SLOT_RANGED);

    local power = 9;

    if (sLvl+iLvl > 130) then
        power = power + math.floor((sLvl+iLvl-200) / 10);
    end

    if (power >= 40) then
        power = 40;
    end

    local iBoost = caster:getMod(MOD_PRELUDE_EFFECT) + caster:getMod(MOD_ALL_SONGS_EFFECT);
    if (iBoost > 0) then
        power = power + 1 + (iBoost-1)*3;
    end


    if (caster:hasStatusEffect(dsp.effects.SOUL_VOICE)) then
        power = power * 2;
    elseif (caster:hasStatusEffect(dsp.effects.MARCATO)) then
        power = power * 1.5;
    end
    caster:delStatusEffect(dsp.effects.MARCATO);

    local duration = 120;
    duration = duration * ((iBoost * 0.1) + (caster:getMod(MOD_SONG_DURATION_BONUS)/100) + 1);

    if (caster:hasStatusEffect(dsp.effects.TROUBADOUR)) then
        duration = duration * 2;
    end

    if not (target:addBardSong(caster,dsp.effects.PRELUDE,power,0,duration,caster:getID(), 0, 2)) then
        spell:setMsg(msgBasic.MAGIC_NO_EFFECT);
    end

    return dsp.effects.PRELUDE;
end;
