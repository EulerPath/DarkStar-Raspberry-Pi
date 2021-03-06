-------------------------------------------------
--  Harvesting functions
--  Info from:
--      http://wiki.ffxiclopedia.org/wiki/Harvesting
-------------------------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/quests");

-------------------------------------------------
-- npcid and drop by zone
-------------------------------------------------

-- Zone, {npcid,npcid,npcid,..}
local npcid = {51, {16986725,16986726,16986727,16986728,16986729,16986730},  -- Wajaom Woodlands
               52, {16990607,16990608,16990609,16990610,16990611,16990612},  -- Bhaflau Thickets
               89, {17142545,17142546,17142547,17142548,17142549,17142550},  -- Grauberg [S]
               95, {17167162,17167163,17167164,17167165,17167166,17167167},  -- West Sarutabaruta [S]
               115,{17248841,17248842,17248843,17248844,17248845,17248846},  -- West Sarutabaruta
               123,{17281636,17281637,17281638},                             -- Yuhtunga Jungle
               124,{17285681,17285682,17285683},                             -- Yhoator Jungle
               145,{17371609,17371610,17371611,17371612,17371613,17371614},  -- Giddeus
               254,{17818220,17818221,17818222,17818223,17818224,17818225}}; -- Abyssea - Grauberg
-- Zone, {itemid,drop rate,itemid,drop rate,..}
-- Must be in ascending order by drop rate
local drop = {51, {0x05F2,0.1880,0x08BC,0.3410,0x08F7,0.4700,0x0874,0.5990,0x1124,0.6930,0x08DE,0.7750,0x0A55,0.8460,0x086C,0.9170,0x0735,0.9760,0x05F4,1.0000},
              52, {0x05F2,0.1520,0x08F7,0.3080,0x0874,0.4530,0x08BC,0.5650,0x086C,0.6720,0x08DE,0.7720,0x1124,0.8310,0x0735,0.8970,0x05F4,0.9410,0x03B7,0.9730,0x0A55,1.0000},
              89, {0x0341,0.2320,0x0735,0.4310,0x023D,0.5850,0x086B,0.6850,0x023C,0.7850,0x1613,0.8980,0x023F,1.0000},
              95, {0x05F2,0.1670,0x0341,0.3260,0x0342,0.4900,0x1613,0.5800,0x0735,0.6610,0x0343,0.7480,0x023D,0.8050,0x07BD,0.8610,0x05F4,0.9020,0x07BE,0.9350,0x023C,0.9620,0x023F,1.0000},
              115,{0x0341,0.1760,0x05F2,0.2840,0x0342,0.3960,0x0735,0.5050,0x0A99,0.6070,0x0343,0.6970,0x07BD,0.7470,0x11C1,0.8020,0x027B,0.8630,0x03B7,0.9010,0x023D,0.9390,0x023C,0.9620,0x0347,0.9810,0x023F,0.9920,0x05F4,1.0000},
              123,{0x1115,0.4000,0x1117,0.6000,0x1116,0.8000,0x115F,0.8700,0x1160,0.9400,0x1122,0.9700,0x07BF,1.0000},
              124,{0x1115,0.4000,0x1117,0.6000,0x1116,0.8000,0x115F,0.8700,0x1162,0.9400,0x1161,0.9700,0x07BF,1.0000},
              145,{0x0735,0.1410,0x05F2,0.2820,0x0A99,0.4230,0x0343,0.5430,0x0342,0.6480,0x0341,0.7320,0x027B,0.7940,0x11C1,0.8440,0x07BE,0.8870,0x03B7,0.9260,0x023F,0.9480,0x023C,0.9650,0x05F4,0.9760,0x0347,0.9930,0x023D,1.0000},
              254,{0x023D,0.0991,0x023F,0.2095,0x086B,0.3199,0x1544,0.4378,0x023C,0.5595,0x1613,0.6850,0x0735,0.8331,0x0341,1.0000}};
-- Define array of Colored Rocks, Do not reorder this array or rocks.
local rocks = {0x0301,0x0302,0x0303,0x0304,0x0305,0x0306,0x0308,0x0307};

function startHarvesting(player,zone,npc,trade,csid)
    if (trade:hasItemQty(1020,1) and trade:getItemCount() == 1) then
        local broke = sickleBreak(player,trade);
        local item = getHarvestingItem(player,zone);

        if (player:getFreeSlotsCount() == 0) then
            full = 1;
        else
            full = 0;
        end

        player:startEvent(csid,item,broke,full);

        if (item ~= 0 and full == 0) then
            player:addItem(item);
            SetServerVariable("[HARVESTING]Zone "..zone,GetServerVariable("[HARVESTING]Zone "..zone) + 1);
        end

        if (GetServerVariable("[HARVESTING]Zone "..zone) >= 3) then
            getNewHarvestingPositionNPC(player,npc,zone);
        end
        if (player:getQuestStatus(AHT_URHGAN,VANISHING_ACT) == QUEST_ACCEPTED and player:hasKeyItem(dsp.kis.RAINBOW_BERRY) == false and broke ~= 1 and zone == 51) then
           player:addKeyItem(dsp.kis.RAINBOW_BERRY);
           player:messageSpecial(KEYITEM_OBTAINED,dsp.kis.RAINBOW_BERRY);
        end
    else
        player:messageSpecial(HARVESTING_IS_POSSIBLE_HERE,1020);
    end
end

-----------------------------------
-- Determine if Sickle breaks
-----------------------------------

function sickleBreak(player,trade)
    local broke = 0;
    local sicklebreak = math.random();

    sicklebreak = sicklebreak + (player:getMod(MOD_HARVESTING_RESULT) / 1000);

    if (sicklebreak < HARVESTING_BREAK_CHANCE) then
        broke = 1;
        player:tradeComplete();
    end

    return broke;
end

-----------------------------------
-- Get an item
-----------------------------------

function getHarvestingItem(player,zone)
    local Rate = math.random();

    for zon = 1, #drop, 2 do
        if (drop[zon] == zone) then
            for itemlist = 1, #drop[zon + 1], 2 do
                if (Rate <= drop[zon + 1][itemlist + 1]) then
                    item = drop[zon + 1][itemlist];
                    break;
                end
            end
            break;
        end
    end

    --------------------
    -- Determine chance of no item mined
    -- Default rate is 50%
    --------------------

    Rate = math.random();

    if (Rate <= (1 - HARVESTING_RATE)) then
        item = 0;
    end

    return item;
end

-----------------------------------------
-- After 3 items he change the position
-----------------------------------------

function getNewHarvestingPositionNPC(player,npc,zone)
    local newnpcid = npc:getID();

    for u = 1, #npcid, 2 do
        if (npcid[u] == zone) then
            nbNPC = #npcid[u + 1];
            while newnpcid == npc:getID() do
                newnpcid = math.random(1,nbNPC);
                newnpcid = npcid[u + 1][newnpcid];
            end
            break;
        end
    end

    npc:setStatus(2);
    GetNPCByID(newnpcid):setStatus(0);
    SetServerVariable("[HARVESTING]Zone "..zone,0);
end