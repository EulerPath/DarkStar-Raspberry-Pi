-----------------------------------------
-- ID: 5314
-- Toolbag Sanjaku-tenugui
-- When used, you will obtain one stack of Sanjaku-tenugui
-----------------------------------------

function onItemCheck(target)
    local result = 0;
    if (target:getFreeSlotsCount() == 0) then
        result = 308;
    end
    return result;
end;

function onItemUse(target)
    target:addItem(2553,99);
end;

