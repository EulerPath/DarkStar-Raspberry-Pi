-----------------------------------
-- Area: Upper Jeuno
-- NPC: Collet
-- Involved in Quests: A Clock Most Delicate, Save the Clock Tower
-- @zone 244
-- !pos -44 0 107
-----------------------------------
package.loaded["scripts/zones/Upper_Jeuno/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/shop");
require("scripts/globals/quests");
require("scripts/zones/Upper_Jeuno/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
    if (trade:hasItemQty(555,1) == true and trade:getItemCount() == 1) then
        a = player:getVar("saveTheClockTowerNPCz1"); -- NPC zone1
        if (a == 0 or (a ~= 2 and a ~= 3 and a ~= 6 and a ~= 10 and a ~= 18 and a ~= 7 and a ~= 26 and a ~= 11 and
           a ~= 22 and a ~= 14 and a ~= 19 and a ~= 15 and a ~= 23 and a ~= 27 and a ~= 30 and a ~= 31)) then
            player:startEvent(115,10 - player:getVar("saveTheClockTowerVar")); -- "Save the Clock Tower" Quest
        end
    end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
    if (player:getFameLevel(JEUNO) >= 5 and aClockMostdelicate == QUEST_AVAILABLE and player:getVar("aClockMostdelicateVar") == 0) then
        player:startEvent(112);
    elseif (player:getVar("saveTheClockTowerVar") >= 1) then
        player:startEvent(164);
    elseif (player:getQuestStatus(JEUNO,THE_CLOCKMASTER) == QUEST_COMPLETED) then
        player:startEvent(163);
    else
        player:startEvent(114);
    end
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 112) then
        player:setVar("aClockMostdelicateVar", 1);
    elseif (csid == 115) then
        player:setVar("saveTheClockTowerVar",player:getVar("saveTheClockTowerVar") + 1);
        player:setVar("saveTheClockTowerNPCz1",player:getVar("saveTheClockTowerNPCz1") + 2);
    end
end;

