local function chulicorseaction(worldobjects, player, corpse)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if corpse:getSquare() and luautils.walkAdj(playerObj, corpse:getSquare()) then
        -- if playerInv:containsTypeRecurse("Lighter") then
        --     ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), playerInv:getFirstTypeRecurse("Lighter"), true, false)
        -- elseif playerObj:getInventory():containsTypeRecurse("Matches") then
        --     ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), playerInv:getFirstTypeRecurse("Matches"), true, false)
        -- end
        -- ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), gasItem, false, false)
        -- ISTimedActionQueue.add(ISBurnCorpseAction:new(playerObj, corpse, 110));
        -- ISWorldObjectContextMenu.onGrabCorpseItem(worldobjects,corpse, player)
        -- corpse:removeFromWorld()
	    -- corpse:removeFromSquare()
        ISTimedActionQueue.add(ISchulijiangshi:new(playerObj, corpse, 50))
        -- local acontainerList = ArrayList.new()
        -- acontainerList:add(getPlayerLoot(0).inventoryPane.inventoryPage.backpacks[1].inventory)
        -- acontainerList:add(getPlayerInventory(0).inventoryPane.inventoryPage.backpacks[1].inventory)
        -- local recipe = ScriptManager.instance:getRecipe("Base.dissect zombie")
        -- local items = RecipeManager.getAvailableItemsNeeded(recipe,playerObj,acontainerList,nil,nil)
        -- local action = ISCraftAction:new(playerObj,items[1],recipe:getTimeToMake(),recipe,container,acontainerList)
        -- ISTimedActionQueue.add(action)
    end
end


local function Context_chuliCorpse(player, context, worldobjects, test)
    local square = clickedSquare
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if playerObj:isAsleep() then return end
    body = IsoObjectPicker.Instance:PickCorpse(square:getX(), square:getY()) or body
    if body then
        if (playerInv:containsTypeRecurse("BreadKnife") or playerInv:containsTypeRecurse("ButterKnife") or playerInv:containsTypeRecurse("HuntingKnife") or playerInv:containsTypeRecurse("KitchenKnife") or playerInv:containsTypeRecurse("zombieknife")) and playerInv:getItemCount("Base.CorpseMale") == 0 then
            if test == true then return true end
            context:addOption(getText("ContextMenu_chulishiti"), worldobjects, chulicorseaction, player , body);
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(Context_chuliCorpse)