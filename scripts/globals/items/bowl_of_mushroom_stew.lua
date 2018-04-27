-----------------------------------------
-- ID: 4544
-- Item: mushroom_stew
-- Food Effect: 3hours, All Races
-----------------------------------------
-- Magic Points 40
-- Strength -1
-- Mind 4
-- MP Recovered While Healing 4
-- Enmity -4
-----------------------------------------
require("scripts/globals/status");
-----------------------------------------

function onItemCheck(target)
    local result = 0;
    if (target:hasStatusEffect(dsp.effects.FOOD) == true or target:hasStatusEffect(dsp.effects.FIELD_SUPPORT_FOOD) == true) then
        result = 246;
    end
    return result;
end;

function onItemUse(target)
    target:addStatusEffect(dsp.effects.FOOD,0,0,10800,4544);
end;

-----------------------------------------
-- onEffectGain Action
-----------------------------------------

function onEffectGain(target,effect)
    target:addMod(MOD_MP, 40);
    target:addMod(MOD_STR, -1);
    target:addMod(MOD_MND, 4);
    target:addMod(MOD_MPHEAL, 4);
    target:addMod(MOD_ENMITY, -4);
end;

function onEffectLose(target, effect)
    target:delMod(MOD_MP, 40);
    target:delMod(MOD_STR, -1);
    target:delMod(MOD_MND, 4);
    target:delMod(MOD_MPHEAL, 4);
    target:delMod(MOD_ENMITY, -4);
end;
