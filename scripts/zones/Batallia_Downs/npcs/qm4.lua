-----------------------------------
-- Area: Batallia Downs
--  NPC: qm4 (???)
--
-----------------------------------
package.loaded["scripts/zones/Batallia_Downs/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Batallia_Downs/TextIDs");
require("scripts/globals/missions");
require("scripts/globals/keyitems");
-----------------------------------

function onTrigger(player,npc)
    local missionProgress = player:getVar("COP_Tenzen_s_Path")
    if (player:getCurrentMission(COP) == THREE_PATHS and missionProgress == 5) then
        player:startEvent(0);
    elseif (player:getCurrentMission(COP) == THREE_PATHS and (missionProgress == 6 or missionProgress == 7) and player:hasKeyItem(dsp.kis.DELKFUTT_RECOGNITION_DEVICE) == false) then
        player:addKeyItem(dsp.kis.DELKFUTT_RECOGNITION_DEVICE);
        player:messageSpecial(KEYITEM_OBTAINED,dsp.kis.DELKFUTT_RECOGNITION_DEVICE);
    end

end;

function onTrade(player,npc,trade)
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 0) then
       player:setVar("COP_Tenzen_s_Path",6);
    end
end;
