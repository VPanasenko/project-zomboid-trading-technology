--***********************************************************
--**                    ROBERT JOHNSON                     **
--**       Contextual menu for building when clicking somewhere on the ground       **
--***********************************************************
--**       Based on nh4no3 https://theindiestone.com/forums/index.php?/topic/21342-big-crates-mod-adds-6-tiered-crates-with-space-from-50-to-300/
--***********************************************************

TS_ISBuildMenuIC = {};

TS_ISBuildMenuIC.functions = TS_ISBuildMenuIC.functions or {}
TS_ISBuildMenuIC.functions.log = function(message, item)
	print(message)
end

TS_ISBuildMenuIC.Objects =
	{
		{name = "Crate Mk 1", description="Upgradable crate, capacity 50 units.", skill = 4, materials = { nails = 2, planks =2}, capacity = 50 , sprite = {sprite = "carpentry_01_19",north = "carpentry_01_20", eastSprite = "carpentry_01_21"}},
		{name = "Crate Mk 2", description="Upgradable crate, capacity 100 units.", skill = 5, materials = { nails = 4, planks =4}, capacity = 100 , sprite = {sprite = "carpentry_01_16",north = "carpentry_01_17", eastSprite = "carpentry_01_18"}},
		{name = "Crate Mk 3", description="Upgradable crate, capacity 150 units.", skill = 6, materials = { nails = 6, planks =6}, capacity = 150 , sprite = {sprite = "carpentry_01_16",north = "carpentry_01_17", eastSprite = "carpentry_01_18"}},
		{name = "Crate Mk 4", description="Upgradable crate, capacity 200 units.", skill = 7, materials = { nails = 8, planks =8}, capacity = 200 , sprite = {sprite = "carpentry_01_16",north = "carpentry_01_17", eastSprite = "carpentry_01_18"}},
		{name = "Crate Mk 5", description="Upgradable crate, capacity 250 units.", skill = 8, materials = { nails = 10, planks =10}, capacity = 250 , sprite = {sprite = "carpentry_01_16",north = "carpentry_01_17", eastSprite = "carpentry_01_18"}},
		{name = "Crate Mk 6", description="Upgradable crate, capacity 300 units.", skill = 9, materials = { nails = 12, planks =12}, capacity = 300 , sprite = {sprite = "carpentry_01_16",north = "carpentry_01_17", eastSprite = "carpentry_01_18"}},
	}
TS_ISBuildMenuIC.TestMode = false;
local console = TS_ISBuildMenuIC.functions

TS_ISBuildMenuIC.doBuildMenu = function(player, context, worldobjects, test)
	-- console.log("TS_ISBuildMenuIC.doBuildMenu", nil)
	if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return;
	end
	if(TS_ISBuildMenuIC.TestMode) then
		for index = 1 , #TS_ISBuildMenuIC.Objects do
			TS_ISBuildMenuIC.Objects[index].materials.nails = 0
			TS_ISBuildMenuIC.Objects[index].materials.planks = 0
			TS_ISBuildMenuIC.Objects[index].skill = 0
		end
		if( not getSpecificPlayer(player):getInventory():contains("Hammer")) then
			getSpecificPlayer(player):getInventory():AddItem("Base.Hammer");
		end
	end
	-- build menu
	-- if we have any thing to build in our inventory
	if TS_ISBuildMenuIC.haveToolsToBuild(player) then
		console.log("TS_ISBuildMenuIC.haveToolsToBuild start", nil)
        if test then return ISWorldObjectContextMenu.setTest() end
		local buildOption = context:addOption(getText("Build Crates"), worldobjects, nil);
		-- create a brand new context menu wich contain our different material (wood, stone etc.) to build
		local subMenu = context:getNew(context);
		-- We create the different option for this new menu (wood, stone etc.)
		-- we add the subMenu to our current option (Build)
		context:addSubMenu(buildOption, subMenu);
		------------------ WOODEN CRATE ------------------
		for index = 1 , #TS_ISBuildMenuIC.Objects do
			TS_ISBuildMenuIC.buildContainerMenu(subMenu, player,index);
		end
		-- console.log("TS_ISBuildMenuIC.haveToolsToBuild end", nil)
	end
end

function TS_ISBuildMenuIC.haveToolsToBuild(player)
	if TS_ISBuildMenuIC.cheat or TS_ISBuildMenuIC.TestMode then
		-- console.log("TS_ISBuildMenuIC.haveToolsToBuild cheat or TestMode", nil)
		return true;
	end
	TS_ISBuildMenuIC.hasHammer = getSpecificPlayer(player):getInventory():contains("Base.Hammer") or getSpecificPlayer(player):getInventory():contains("Base.HammerStone")
	if TS_ISBuildMenuIC.hasHammer then
		-- console.log("TS_ISBuildMenuIC.haveToolsToBuild true", nil)
		return true;
	else
		-- console.log("TS_ISBuildMenuIC.haveToolsToBuild false", nil)
		return false
	end
end

-- **********************************************
-- **               *CONTAINER*                **
-- **********************************************

TS_ISBuildMenuIC.buildContainerMenu = function(subMenu, player, index)
    local sprite = TS_ISBuildMenuIC.Objects[index].sprite ;
	local option = subMenu:addOption(TS_ISBuildMenuIC.Objects[index].name, worldobjects, TS_ISBuildMenuIC.onCreateObject, sprite, player, index);
	local toolTip = TS_ISBuildMenuIC.canBuild(TS_ISBuildMenuIC.Objects[index].materials.planks,TS_ISBuildMenuIC.Objects[index].materials.nails, index, option, player);
	toolTip:setName(TS_ISBuildMenuIC.Objects[index].name);
	toolTip.description = TS_ISBuildMenuIC.Objects[index].description .. toolTip.description;
	toolTip:setTexture(sprite.sprite);
	if not TS_ISBuildMenuIC.hasHammer and not TS_ISBuildMenuIC.cheat and not TS_ISBuildMenuIC.TestMode then
		option.notAvailable = true
		option.onSelect = nil
	end
end

TS_ISBuildMenuIC.onCreateObject = function(worldobjects, sprite, player, index)
	-- sprite, northSprite
	local object = ISWoodenContainer:new(sprite.sprite, sprite.northSprite, TS_ISBuildMenuIC.Objects[index].capacity);
	object.renderFloorHelper = true
	object.canBeAlwaysPlaced = true;
	object.modData["need:Base.Plank"] = TS_ISBuildMenuIC.Objects[index].materials.planks;
	object.modData["need:Base.Nails"] = TS_ISBuildMenuIC.Objects[index].materials.nails;
	object:setEastSprite(sprite.eastSprite);
	object.player = player
	getCell():setDrag(object, player);
end

-- **********************************************
-- **                  OTHER                   **
-- **********************************************

TS_ISBuildMenuIC.addToolTip = function()
	local toolTip = ISToolTip:new();
	toolTip:initialise();
	toolTip:setVisible(false);
	return toolTip;
end

-- Create our toolTip, depending on the required material
TS_ISBuildMenuIC.canBuild = function(planksNeeded, nailsNeeded, index, option,  player)
	local availablePlanks = TS_ISBuildMenuIC.countMaterial(player, "Base.Plank")
	local availableNails = TS_ISBuildMenuIC.countMaterial(player, "Base.Nails")
	local tooltip = TS_ISBuildMenuIC.addToolTip();

	-- add it to our current option
	option.toolTip = tooltip;
	local result = true;
	if TS_ISBuildMenuIC.cheat then
		return tooltip;
	end
	tooltip.description = "<LINE> <LINE>" .. getText("Tooltip_craft_Needs") .. " : <LINE>";
	-- now we gonna test all the needed material, if we don't have it, they'll be in red into our toolip
	if availablePlanks < planksNeeded then
		tooltip.description = tooltip.description .. " <RGB:1,0,0>" .. getItemText("Plank") .. " " .. availablePlanks .. "/" .. planksNeeded .. " <LINE>";
		result = false;
	else
		tooltip.description = tooltip.description .. " <RGB:1,1,1>" .. getItemText("Plank") .. " " .. planksNeeded .. " <LINE>";
	end
	if availableNails < nailsNeeded then
		tooltip.description = tooltip.description .. " <RGB:1,0,0>" .. getItemText("Nails") .. " " .. availableNails .. "/" .. nailsNeeded .. " <LINE>";
		result = false;
	else
		tooltip.description = tooltip.description .. " <RGB:1,1,1>" .. getItemText("Nails") .. " " .. nailsNeeded .. " <LINE>";
	end
	if getSpecificPlayer(player):getPerkLevel(Perks.Woodwork) < TS_ISBuildMenuIC.Objects[index].skill then
		tooltip.description = tooltip.description .. " <RGB:1,0,0>" .. getText("IGUI_perks_Carpentry") .. " " .. getSpecificPlayer(player):getPerkLevel(Perks.Woodwork) .. "/" .. TS_ISBuildMenuIC.Objects[index].skill .. " <LINE>";
		result = false;
	else
		tooltip.description = tooltip.description .. " <RGB:1,1,1>" .. getText("IGUI_perks_Carpentry") .. " " .. TS_ISBuildMenuIC.Objects[index].skill .. " <LINE>";
	end
	if not result then
		option.onSelect = nil;
		option.notAvailable = true;
	end
	return tooltip;
end

TS_ISBuildMenuIC.countMaterial = function(player, fullType)
	TS_ISBuildMenuIC.materialOnGround = buildUtil.checkMaterialOnGround(getSpecificPlayer(player):getCurrentSquare())
    local inv = getSpecificPlayer(player):getInventory()
    local count = inv:getItemCount(fullType)
    local type = string.split(fullType, "\\.")[2]
    for k,v in pairs(TS_ISBuildMenuIC.materialOnGround) do
        if k == type then count = count + v end
    end
    return count
end



local function TS_func_Init()
	-- For future updates that may include java container capacity set methods. 
	-- Events.OnFillWorldObjectContextMenu.Add(TS_ISBuildMenuIC.doBuildMenu);
end

Events.OnGameStart.Add(TS_func_Init)