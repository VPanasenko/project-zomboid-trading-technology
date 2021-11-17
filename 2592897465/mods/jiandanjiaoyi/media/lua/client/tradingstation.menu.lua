function tradingstation.isGoodForTradingStation(selectedItem)
    if  selectedItem:getType() == "KeyRing" or
        selectedItem:isEquipped() or
        selectedItem:isFavorite()
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
        for i=0,recipeList:size() -1 do
            local recipe = recipeList:get(i);
            if (recipe:getName().find(tradingstation_category_buy) ~= nil){
                context:addSubMenu(getText("ContextMenu_category_buy"), context);
            }
            elseif (recipe:getName().find(tradingstation_category_sell) ~= nil){
                context:addSubMenu(getText("ContextMenu_category_sell"), context);
            }
            elseif (recipe:getName().find(tradingstation_category_make) ~= nil){
                context:addSubMenu(getText("ContextMenu_category_make"), context);
            }
            elseif (recipe:getName().find(tradingstation_category_lottery) ~= nil){
                context:addSubMenu(getText("ContextMenu_category_lottery"), context);
            }
            elseif (recipe:getName().find(tradingstation_category_refine) ~= nil){
                context:addSubMenu(getText("ContextMenu_category_refine"), context);
            }
            elseif (recipe:getName().find(tradingstation_category_inject) ~= nil){
                context:addSubMenu(getText("ContextMenu_category_inject"), context);
            }
            else{
                context:addSubMenu(getText("ContextMenu_category_other"), context);
            }
        end

        if (context and #context.options > 0) then
            context:addSubMenu(getText("ContextMenu_category"), context);
        end
    end

    baseISInventoryPaneContextMenu(selectedItem, context, recipeList, player, containerList);
end