-- function ISInventoryPaneContextMenu.addDynamicalContextMenu(selectedItem, context, recipeList, player, containerList)

--     if (esBundler.isGoodToPack(selectedItem)) then
--         local rawStack = esCommonBundler:getItemStackByFullType(selectedItem:getFullType(), selectedItem:getContainer());
--         local stack = LuaList:new();

--         for i = 0, rawStack:size() - 1 do
--             local item = rawStack:get(i);
--             if (esBundler.isGoodToPack(item)) then
--                 stack:add(item);
--             end
--         end

--         -- bundle Volumes
--         local itemW = selectedItem:getActualWeight();
--         local maxW = esBundler.getMaxSheetRopes();
--         local units = { 1, 5, 10, 25, 50, 100, 150, 250, 500 };
--         local bundlerSubMenu;

--         if (stack:size() > 0 and maxW >= itemW) then bundlerSubMenu = context:getNew(context); end

--         for u = 1, #units do
--             if (stack:size() >= units[u] and maxW >= itemW * units[u]) then
--                 local stackRecipe = esBundler.getBundleItems(selectedItem, stack, units[u], 'ESBundler.esBag5')
--                 bundlerSubMenu:addOption(stackRecipe[1], stackRecipe[2], esBundler.deflate, stackRecipe[3], stackRecipe[4], units[u]);
--             else
--                 break;
--             end
--         end

--         if (bundlerSubMenu and #bundlerSubMenu.options > 0) then
--             context:addSubMenu(context:addOption('Bundler:'), bundlerSubMenu);
--         end
--     end

--     if (selectedItem:getFullType() == 'ESBundler.esBag5') then
--         local recipeName = 'Unpack ' .. selectedItem:getDisplayName();
--         context:addOption(recipeName, selectedItem, esBundler.inflate);
--     end

--     baseISInventoryPaneContextMenu(selectedItem, context, recipeList, player, containerList);
-- end

function tradingstation.isGoodForTradingStation(selectedItem)
    if  selectedItem:getType() == "KeyRing" or
        selectedItem:isEquipped()
    then
        return false
    end

    return true;
end

local tradingstation_category_buy <const> = "^Buy";
local tradingstation_category_sell <const> = "^Sell";
local tradingstation_category_make <const> = "^Make";
local tradingstation_category_lottery <const> = "^Lottery";
local tradingstation_category_refine <const> = "^Refine";
local tradingstation_category_inject <const> = "^Inject";

local baseISInventoryPaneContextMenu = ISInventoryPaneContextMenu.addDynamicalContextMenu;
function ISInventoryPaneContextMenu.addDynamicalContextMenu(selectedItem, context, recipeList, player, containerList)

    if (tradingstation.isGoodForTradingStation(selectedItem)) then
        if (recipeList:size() > 0) then
            for i=0,recipeList:size() -1 do
                local recipe = recipeList:get(i);
                if (recipe:getName().find(tradingstation_category_buy) ~= nil){
                    context:addSubMenu(context:addOption(getText("ContextMenu_category_buy")), context);
                }
                elseif (recipe:getName().find(tradingstation_category_sell) ~= nil){
                    context:addSubMenu(context:addOption(getText("ContextMenu_category_sell")), context);
                }
                elseif (recipe:getName().find(tradingstation_category_make) ~= nil){
                    context:addSubMenu(context:addOption(getText("ContextMenu_category_make")), context);
                }
                elseif (recipe:getName().find(tradingstation_category_lottery) ~= nil){
                    context:addSubMenu(context:addOption(getText("ContextMenu_category_lottery")), context);
                }
                elseif (recipe:getName().find(tradingstation_category_refine) ~= nil){
                    context:addSubMenu(context:addOption(getText("ContextMenu_category_refine")), context);
                }
                elseif (recipe:getName().find(tradingstation_category_inject) ~= nil){
                    context:addSubMenu(context:addOption(getText("ContextMenu_category_inject")), context);
                }
                else{
                    context:addSubMenu(context:addOption(getText("ContextMenu_category_other")), context);
                }
            end
        end

        if (selectedItem:getDisplayName() == "Pager"){
            context:addSubMenu(context:addOption("Pager:"), context);
        }

        if (context and #context.options > 0) then
            context:addSubMenu(context:addOption(getText("ContextMenu_category")), context);
        end
    end

    baseISInventoryPaneContextMenu(selectedItem, context, recipeList, player, containerList);
end

-- TradingStation.Event = TradingStation.Event or {
--     currentPlayerId = nil,
--     currentPlayer = nil,
-- };

-- function TradingStation.Event.onRespawn(playerId, player)
--     TradingStation.Event.currentPlayer = player or getPlayer();
--     TradingStation.Event.currentPlayerId = TradingStation.Event.currentPlayer:getID();
-- end

-- function TradingStation.Event:isFiredByPlayer(player)
--     return TradingStation.Event.currentPlayerId == player:getID();
-- end

-- function TradingStation.Event.onCreateContextMenu(player, contextMenu, worldobjects, test)
--     player = getSpecificPlayer(player);

--     if TradingStation.Event:isFiredByPlayer(player)
--     then
--         local btMenu = Bikinitools:addContextMenuSubMenu(contextMenu,
--             "TradingStation", nil, nil, {
--                 icon = true
--             }
--         );

--         Bikinitools.Options.createConfigContextMenu(btMenu, player);
--     end
-- end

-- function TradingStation.Event.initialize()
--     TradingStation.Event.onRespawn();

--     --Events.OnPlayerDeath.Add(Bikinitools.Event.onDeath);
--     Events.OnCreatePlayer.Add(TradingStation.Event.onRespawn);

--     Events.OnFillWorldObjectContextMenu.Add(TradingStation.Event.onCreateContextMenu);
-- end

-- Events.OnGameStart.Add(TradingStation.Event.initialize);