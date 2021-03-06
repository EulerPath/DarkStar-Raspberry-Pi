-----------------------------------
-- Area: Batallia Downs
--  MOB: Goblin Shaman
-----------------------------------
package.loaded["scripts/zones/Batallia_Downs/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/fieldsofvalor");
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/zones/Batallia_Downs/TextIDs");
-----------------------------------

function onMobDeath(mob, player, isKiller)
    checkRegime(player,mob,74,2);

    if (ENABLE_ACP == 1 and (player:hasKeyItem(dsp.kis.BOWL_OF_BLAND_GOBLIN_SALAD) == false) and player:getCurrentMission(ACP) >= THE_ECHO_AWAKENS) then
        -- Guesstimating 15% chance
        if (math.random(1,100) >= 85) then
            player:addKeyItem(dsp.kis.BOWL_OF_BLAND_GOBLIN_SALAD);
            player:messageSpecial(KEYITEM_OBTAINED,dsp.kis.BOWL_OF_BLAND_GOBLIN_SALAD);
        end
    end

end;