-----------------------------------------
-- ID: 5631
-- Item: Pumpkin Cake
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- TODO: Group Effect
-- HP Recovered while healing +2
-- MP Recovered while healing +5
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
    target:addStatusEffect(dsp.effects.FOOD,0,0,10800,5631);
end;

function onEffectGain(target, effect)
    target:addMod(MOD_HPHEAL, 2);
    target:addMod(MOD_MPHEAL, 5);
end;

function onEffectLose(target, effect)
    target:delMod(MOD_HPHEAL, 2);
    target:delMod(MOD_MPHEAL, 5);
end;
