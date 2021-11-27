function tradingstation.isGoodForTradingStation(selectedItem)
    if  selectedItem:getType() == "KeyRing" or
        selectedItem:isEquipped()
    then
        return false
    end

    return true;
end

local tradingstation_category_buy = "^Buy";
local tradingstation_category_sell = "^Sell";
local tradingstation_category_make = "^Make";
local tradingstation_category_lottery = "^Lottery";
local tradingstation_category_refine = "^Refine";
local tradingstation_category_inject = "^Inject";

local baseISInventoryPaneContextMenu = ISInventoryPaneContextMenu.addDynamicalContextMenu;
function ISInventoryPaneContextMenu.addDynamicalContextMenu(selectedItem, context, recipeList, player, containerList)

    if (tradingstation.isGoodForTradingStation(selectedItem)) then
        if (recipeList:size() > 0) then
            local tradingStationSubMenu = context:getNew(context);
            local tradingStationSubMenu_buy = context:getNew(context);
            local tradingStationSubMenu_sell = context:getNew(context);
            local tradingStationSubMenu_make = context:getNew(context);
            local tradingStationSubMenu_lottery = context:getNew(context);
            local tradingStationSubMenu_refine = context:getNew(context);
            local tradingStationSubMenu_inject = context:getNew(context);
            local tradingStationSubMenu_other = context:getNew(context);
            for i=0,recipeList:size() -1 do
                local recipe = recipeList:get(i);
                local option = nil;
                local subMenuCraft = nil;
                subMenuCraft = context:getNew(context);
                option = context:addOption(recipe:getName(), selectedItem, nil);
                context:addSubMenu(option, subMenuCraft);
                local subOption = subMenuCraft:addOption(getText("ContextMenu_One"), selectedItem, ISInventoryPaneContextMenu.OnCraft, recipe, player, false);

                if (recipe:getName():find(tradingstation_category_buy) ~= nil) then
                    tradingStationSubMenu_buy:addOption(recipe:getName(), selectedItem, nil);
                elseif (recipe:getName():find(tradingstation_category_sell) ~= nil) then
                    tradingStationSubMenu_sell:addOption(recipe:getName(), selectedItem, nil);
                elseif (recipe:getName():find(tradingstation_category_make) ~= nil) then
                    tradingStationSubMenu_make:addOption(recipe:getName(), selectedItem, nil);
                elseif (recipe:getName():find(tradingstation_category_lottery) ~= nil) then
                    tradingStationSubMenu_lottery:addOption(recipe:getName(), selectedItem, nil);
                elseif (recipe:getName():find(tradingstation_category_refine) ~= nil) then
                    tradingStationSubMenu_refine:addOption(recipe:getName(), selectedItem, nil);
                elseif (recipe:getName():find(tradingstation_category_inject) ~= nil) then
                    tradingStationSubMenu_inject:addOption(recipe:getName(), selectedItem, nil);
                else
                    tradingStationSubMenu_other:addOption(recipe:getName(), selectedItem, nil);
                end
            end

            if (tradingStationSubMenu_buy and #tradingStationSubMenu_buy.options > 0) then
                local tradingStationSubMenuBuyOption = tradingStationSubMenu:addOption(getText("ContextMenu_category_buy"));
                tradingStationSubMenu:addSubMenu(tradingStationSubMenuBuyOption, tradingStationSubMenu_buy);
            elseif (tradingStationSubMenu_sell and #tradingStationSubMenu_sell.options > 0) then
                local tradingStationSubMenuSellOption = tradingStationSubMenu:addOption(getText("ContextMenu_category_sell"));
                tradingStationSubMenu:addSubMenu(tradingStationSubMenuSellOption, tradingStationSubMenu_sell);
            elseif (tradingStationSubMenu_make and #tradingStationSubMenu_make.options > 0) then
                local tradingStationSubMenuMakeOption = tradingStationSubMenu:addOption(getText("ContextMenu_category_make"));
                tradingStationSubMenu:addSubMenu(tradingStationSubMenuMakeOption, tradingStationSubMenu_make);                
            elseif (tradingStationSubMenu_lottery and #tradingStationSubMenu_lottery.options > 0) then
                local tradingStationSubMenuLotteryOption = tradingStationSubMenu:addOption(getText("ContextMenu_category_lottery"));
                tradingStationSubMenu:addSubMenu(tradingStationSubMenuLotteryOption, tradingStationSubMenu_lottery);
            elseif (tradingStationSubMenu_refine and #tradingStationSubMenu_refine.options > 0) then
                local tradingStationSubMenuRefineOption = tradingStationSubMenu:addOption(getText("ContextMenu_category_refine"));
                tradingStationSubMenu:addSubMenu(tradingStationSubMenuRefineOption, tradingStationSubMenu_refine);
            elseif (tradingStationSubMenu_inject and #tradingStationSubMenu_inject.options > 0) then
                local tradingStationSubMenuInjectOption = tradingStationSubMenu:addOption(getText("ContextMenu_category_inject"));
                tradingStationSubMenu:addSubMenu(tradingStationSubMenuInjectOption, tradingStationSubMenu_inject);
            else
                local tradingStationSubMenuBuyOtherOption = tradingStationSubMenu:addOption(getText("ContextMenu_category_other"));
                tradingStationSubMenu:addSubMenu(tradingStationSubMenuBuyOtherOption, tradingStationSubMenu_other);                                                                
            end


            if (tradingStationSubMenu and #tradingStationSubMenu.options > 0) then
                local tradingStationSubMenuOption = context:addOption(getText("ContextMenu_category"));
                context:addSubMenu(tradingStationSubMenuOption, tradingStationSubMenu);
            end
        end
    end

    baseISInventoryPaneContextMenu(selectedItem, context, recipeList, player, containerList);
end