-- getGameTime():getModData().Enabledropprompt = 1
-- getGameTime():getModData().Disabledropprompt = 0
-- getGameTime():getModData().EnableLoot = 1
-- getGameTime():getModData().DisableLoot = 0

function Recipe.OnTest.Enabledropprompt(sourceItem, result)
    if getGameTime():getModData().Enabledropprompt == 0  and getGameTime():getModData().EnableLoot == 1 then
        return true
    end
end

function Recipe.OnCreate.Enabledropprompt(items, result, player)
    getGameTime():getModData().Enabledropprompt = 1
    -- getGameTime():getModData().Disabledropprompt = 0
end

function Recipe.OnTest.Disabledropprompt(sourceItem, result)
    if getGameTime():getModData().Enabledropprompt == 1 and getGameTime():getModData().EnableLoot == 1 then
        return true
    end
end

function Recipe.OnCreate.Disabledropprompt(items, result, player)
    getGameTime():getModData().Enabledropprompt = 0
    -- getGameTime():getModData().Disabledropprompt = 1
end
-----------------------------------------------------------


function Recipe.OnTest.EnableLoot(sourceItem, result)
    if getGameTime():getModData().EnableLoot ==0 then
        return true
    end
end

function Recipe.OnCreate.EnableLoot(items, result, player)
    getGameTime():getModData().EnableLoot = 1
    -- getGameTime():getModData().DisableLoot = 0
end

function Recipe.OnTest.DisableLoot(sourceItem, result)
    if getGameTime():getModData().EnableLoot == 1 then
        return true
    end
end

function Recipe.OnCreate.DisableLoot(items, result, player)
    getGameTime():getModData().EnableLoot = 0
    -- getGameTime():getModData().DisableLoot = 1
end



------------------------------------------------------------


function Recipe.OnTest.EnableAutoLoot(sourceItem, result)
    if getWorld():getGameMode() == "Multiplayer" then return false end
    if getPlayer():getModData().zidonghuoqv == 0  and getGameTime():getModData().EnableLoot == 1 then
        return true
    end
end

function Recipe.OnCreate.EnableAutoLoot(items, result, player)
    player:getModData().zidonghuoqv = 1
end

function Recipe.OnTest.DisableAutoLoot(sourceItem, result)
    if getWorld():getGameMode() == "Multiplayer" then return false end
    if getPlayer():getModData().zidonghuoqv == 1  and getGameTime():getModData().EnableLoot == 1 then
        return true
    end
end

function Recipe.OnCreate.DisableAutoLoot(items, result, player)
    player:getModData().zidonghuoqv = 0
end

--------------------------------------------------------
function Recipe.OnTest.buyLootController(sourceItem, result)
    if getWorld():getGameMode() == "Multiplayer" then return false end
    if getPlayer():HasTrait("shihuangdashi") then
        return true
    end
end

----------------------------------------------------

function Recipe.OnCreate.yanglaobaoxian(items, result, player)
    player:getModData().yanglaobaoxian = 1
    player:Say(getText("IGUI_yanglaobaoxian2"))
end

function Recipe.OnTest.yanglaobaoxian(sourceItem, result)
    if getWorld():getGameMode() == "Multiplayer" then return false end
    if getPlayer():getModData().yanglaobaoxian == 0 or getPlayer():getModData().yanglaobaoxian == nil then
        return true
    end
end
