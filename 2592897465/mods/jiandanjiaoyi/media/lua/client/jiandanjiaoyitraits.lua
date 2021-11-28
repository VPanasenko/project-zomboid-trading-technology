dropitemss = {}
dropitemsscloth = {}

local function initToadTraits()
    TraitFactory.addTrait("kuaidiyuan", getText("UI_trait_kuaidiyuan"), 5, getText("UI_trait_kuaidiyuandsc"), false, false)
    TraitFactory.addTrait("shihuangdashi", getText("UI_trait_shihuangdashi"), 12, getText("UI_trait_shihuangdashidsc"), false, false)
    TraitFactory.addTrait("tuhao", getText("UI_trait_tuhao"), 6, getText("UI_trait_tuhaodsc"), false, false)
    TraitFactory.addTrait("dagongren", getText("UI_trait_dagongren"), 4, getText("UI_trait_dagongrendsc"), false, false)
    TraitFactory.addTrait("morilailin", getText("UI_trait_mori"), -10, getText("UI_trait_moridsc"), false, false) 
end


local function initToadTraitsItems(_player)
    local player = _player
    local inv = player:getInventory()
    if player:HasTrait("kuaidiyuan") then
        inv:AddItem("tradestation")
        local aa = inv:AddItem("tt_moneybag")
        aa:setUsedDelta(0.06)
    end
    if player:HasTrait("tuhao") then
        local aa = inv:AddItem("tt_moneybag")
        aa:setUsedDelta(0.21)
    end
    _player:getModData().zidonghuoqv = 0
    getGameTime():getModData().Enabledropprompt = 0
    -- getGameTime():getModData().Disabledropprompt = 1
    getGameTime():getModData().EnableLoot = 1
    -- getGameTime():getModData().DisableLoot = 0
    if _player:HasTrait("shihuangdashi") then
        _player:getInventory():AddItem("dropitems.Dropcontroller")
        _player:getInventory():AddItem("tt_shihuangzhezhinan")
        _player:getInventory():AddItem("tt_pashoujuewu")
    end
    if getGameTime():getModData().chushengdianzuobiao ~= nil then
        _player:setX(getGameTime():getModData().chushengdianzuobiao[1])
        _player:setY(getGameTime():getModData().chushengdianzuobiao[2])
        _player:setZ(getGameTime():getModData().chushengdianzuobiao[3])
        _player:setLx(getPlayer():getX())
        _player:setLy(getPlayer():getY())
        _player:setLz(getPlayer():getZ())
        getGameTime():getModData().chushengdianzuobiao = nil
    end
    if player:HasTrait("dagongren") then
        _player:getModData().dagongrengongzi = 1
    end
    _player:getModData().yanglaobaoxian = 0

    if player:HasTrait("morilailin") then
        getGameTime():getModData().morilailin =true
    else
        getGameTime():getModData().morilailin =false
    end
end

local function weightinit()
    local player = getPlayer()
    
    if player:getModData().weightshuzhi == nil then
        player:getModData().weightshuzhi = 0
    end

    if player:getModData().weightMax ==nil then
        player:getModData().weightBase = player:getMaxWeightBase()
        player:getModData().weightMax = player:getMaxWeight()
    end
    
    player:setMaxWeight(player:getModData().weightMax)
    player:setMaxWeightBase(player:getModData().weightBase)

    local itemscript = getScriptManager():getAllItems()
    for i = 1,itemscript:size() do
        if itemscript:get(i-1):getActualWeight() < 2.1 and itemscript:get(i-1):getTypeString() ~= "Moveable" then
            table.insert(dropitemss, itemscript:get(i-1))
            if itemscript:get(i-1):getTypeString() == "Clothing" then
                table.insert(dropitemsscloth, itemscript:get(i-1))
            end
        end
    end

    if getWorld():getGameMode() == "Multiplayer" then
		local banrecipe = {"Base.Buy waste car","Base.Buy new original car","Base.Buy super sportscar"}
		for i=1,#banrecipe do
			ScriptManager.instance:getRecipe(banrecipe[i]):setNeedToBeLearn(true)
		end
	end

end

--------------------------------------------------------

local function dropitems(zombbiedropitem)
    local playera = getPlayer()
    if playera:HasTrait("shihuangdashi") then
        if getGameTime():getModData().EnableLoot == 1 then
            local zominv = zombbiedropitem:getInventory()
            local itemname = dropitemss[ZombRand(#dropitemss) + 1]
            if ZombRand(100) > 81 then
                if playera:getModData().zidonghuoqv == 0 then
                    zominv:AddItem(itemname:getModuleName() .. "." .. itemname:getName()) 
                else
                    playera:getInventory():AddItem(itemname:getModuleName() .. "." .. itemname:getName())
                end
                if getGameTime():getModData().Enabledropprompt == 1 then
                    getPlayer():Say(itemname:getDisplayName())
                end
            end
        end
    end
    if zombbiedropitem:getModData().super == "fuhuojiangshi" and ZombRand(10)>4 then
        zombbiedropitem:getInventory():AddItem("xiuchegongjv")
    end
end

----------------------------------------------------------
local function gongzijiesuan()
    local playerc = getPlayer()
    if playerc:getModData().dagongrengongzi == nil then
        playerc:getModData().dagongrengongzi = 0
        playerc:getModData().yanglaobaoxian = 0
    end
    if playerc:getModData().dagongrengongzi == 1 or playerc:HasTrait("dagongren") then
        playerc:getInventory():AddItems("Money",80)
        playerc:Say(getText("IGUI_dagongrengongzi"))
    end
    if playerc:getModData().yanglaobaoxian == 1 then
        playerc:getInventory():AddItems("Money",75)
        playerc:Say(getText("IGUI_yanglaobaoxian"))
    end
end


Events.OnZombieDead.Add(dropitems)
Events.OnGameStart.Add(weightinit)
Events.OnNewGame.Add(initToadTraitsItems)
Events.OnGameBoot.Add(initToadTraits)
Events.EveryDays.Add(gongzijiesuan)
