--***********************************************************
--**                          金色喵球                          **
--***********************************************************

--处理尸体
function Recipe.OnCreate.zombiecorpse(items, result, player)
    local inv = player:getInventory()
    local bone = ZombRand(3)
    local skin = ZombRand(2)
    inv:AddItems("Base.zombiebone",bone)
    inv:AddItem("Base.st_zombiemeat")
    -- isarotten:setRotten(true)
    inv:AddItems("Base.zombieskin",skin)
    if ZombRand(100) > 75  then
        inv:AddItem("Base.zombiesstomach")
    end
end

function Recipe.OnCreate.jiangshichangzi(items, result, player)
    local scwzmh = {}
    scwzmh[1]={"Base.DeadRabbit","Base.DeadMouse","Base.DeadSquirrel","Base.DeadRat","Base.DeadBird"}
    scwzmh[2]={"WhiskeyEmpty","WineEmpty","WineEmpty2","BeerEmpty","BandageDirty","PopBottleEmpty","SmashedBottle","Garbagebag"}
    if ZombRand(100)> 81 then
        player:getInventory():AddItem(scwzmh[1][ZombRand(#scwzmh[1])+1])
    end
    if ZombRand(10)> 6 then
        player:getInventory():AddItem(scwzmh[2][ZombRand(#scwzmh[2])+1])
    end
    if ZombRand(10)> 4 then
        player:getInventory():AddItem("Base.Worm")
    end
    if ZombRand(10)> 5 then
        player:getInventory():AddItem("Base.Cockroach")
    end
    if ZombRand(10)> 6 then
        player:getInventory():AddItem("Base.Cricket")
    end
    if ZombRand(100)> 89 then
        local itemname = dropitemss[ZombRand(#dropitemss + 1)]
        player:getInventory():AddItem(itemname:getModuleName() .. "." .. itemname:getName())
    end
end



function Recipe.OnCreate.tiaoweiliao(items, result, player)
    local scwzmh={"Base.Pepper","Base.Salt","Base.Vinegar","Base.Sugar","Base.Mustard","Base.Marinara","Base.Ketchup","farming.RemouladeFull","farming.MayonnaiseFull"};
    local ranran = ZombRand(#scwzmh);
    local ranran2 = ZombRand(#scwzmh);
    local a = player:getInventory():AddItem(scwzmh[ranran + 1]);
    local b = player:getInventory():AddItem(scwzmh[ranran2 + 1]);
    player:Say(a:getDisplayName())
    player:Say(b:getDisplayName())
end

function Recipe.OnCreate.chataozhuang(items, result, player)
    local scwzmh = {}
    scwzmh[1]={"Base.Mugl","Base.MugRed","Base.MugWhite","Base.Bowl"};
    scwzmh[2] = {"Coffee2","Teabag2"}
    scwzmh[3] = {"Honey","Sugar"}
    scwzmh[4] = {"OatsRaw","Popcorn","Cereal"}
    scwzmh[5] = {"Base.Spoon"}
    for i = 1,#scwzmh do
        local a = player:getInventory():AddItem(scwzmh[i][ZombRand(#scwzmh[i])+1])
        player:Say(a:getDisplayName())
    end
end

function Recipe.OnCreate.youyongchi(items, result, player)
    local inv = player:getInventory()
    inv:AddItems("tt_water3",4)
    inv:AddItem("tt_water",ZombRand(3) + 1)
end
function Recipe.OnCreate.FloorFloor(items, result, player)
    local inv = player:getInventory()
    inv:AddItems("tt_floor"..tostring(ZombRand(16)+1) ,9)
end

function Recipe.OnCreate.zombieoil(items, result, player)
    local aa = ZombRand(2)
    player:getInventory():AddItems("Base.zombietissue", aa)
    player:getInventory():AddItems("Base.zombiebone", 1)
    local bb = ZombRand(2)
    player:getInventory():AddItems("Base.tt_shiyoukuai", bb)
end
function Recipe.OnCreate.zombieoil2(items, result, player)
    if ZombRand(2) > 0 then
        player:getInventory():AddItem("Base.zombiebutter")
    end
end

--组装汽车
function Recipe.OnCreate.hezhuangqichea(items, result, player)
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "hezhuangqiche" then
            local qicheliebiao = getScriptManager():getAllVehicleScripts()
            local qichelist = {}
            for i = 1,qicheliebiao:size() do
                local abc = qicheliebiao:get(i-1):getFullName()
                table.insert(qichelist , abc)
            end
            local qiche = ZombRand(#qichelist)
            if not player:isOutside() or player:getZ() > 0 then
                player:Say(getText("IGUI_zuzhuangshibai"))
                player:getInventory():AddItem("hezhuangqiche")
            else
                local randomdir = {IsoDirections.E,IsoDirections.S,IsoDirections.W,IsoDirections.N}
                local qichebianhao = addVehicleDebug(qichelist[qiche + 1],randomdir[ZombRand(4) + 1],-1,getSquare(player:getX(), player:getY(),player:getZ()))
                if qichebianhao:getCurrentKey() ~= nil then player:getInventory():AddItem(qichebianhao:getCurrentKey()) else player:getInventory():AddItem(qichebianhao:createVehicleKey()) end
                player:Say(getText("IGUI_zuzhuangchenggong"))
            end
        elseif item:getType() == "hezhuangqiche2" then
            local qichelist = {"Base.SmallCar", "Base.CarStationWagon2", "Base.OffRoad", "Base.SmallCar02", "Base.SportsCar", "Base.CarNormal", 
            "Base.CarLights","Base.CarLightsPolice", "Base.CarTaxi", "Base.CarTaxi2", "Base.CarLuxury", "Base.ModernCar02", "Base.ModernCar", 
            "Base.SUV","Base.StepVan", "Base.StepVanMail", "Base.PickUpVan","Base.PickUpVanLights", "Base.PickUpVanLightsFire", 
            "Base.PickUpVanMccoy", "Base.Van", "Base.VanSpiffo", "Base.VanSeats", "Base.VanAmbulance","Base.VanRadio", "Base.Van",
            "Base.PickUpTruck", "Base.PickUpTruckMccoy", "Base.PickUpTruckLights"}
            local qiche = ZombRand(#qichelist)
            if not player:isOutside() or player:getZ() > 0 then
                player:Say(getText("IGUI_zuzhuangshibai"))
                player:getInventory():AddItem("hezhuangqiche2")
            else
                local randomdir = {IsoDirections.E,IsoDirections.S,IsoDirections.W,IsoDirections.N}
                local qichebianhao = addVehicleDebug(qichelist[qiche + 1],randomdir[ZombRand(4) + 1],-1,getSquare(player:getX(), player:getY(),player:getZ()))
                qichebianhao:repair()
                if qichebianhao:getCurrentKey() ~= nil then player:getInventory():AddItem(qichebianhao:getCurrentKey()) else player:getInventory():AddItem(qichebianhao:createVehicleKey()) end
                player:Say(getText("IGUI_zuzhuangchenggong"))
            end
        elseif item:getType() == "hezhuangqiche3" then
            if not player:isOutside() or player:getZ() > 0 then
                player:Say(getText("IGUI_zuzhuangshibai"))
                player:getInventory():AddItem("hezhuangqiche3")
            else
                local randomdir = {IsoDirections.E,IsoDirections.S,IsoDirections.W,IsoDirections.N}
                local qichebianhao = addVehicleDebug("Base.superSportsCar",randomdir[ZombRand(4) + 1],-1,getSquare(player:getX(), player:getY(),player:getZ()))
                qichebianhao:repair()
                if qichebianhao:getCurrentKey() ~= nil then player:getInventory():AddItem(qichebianhao:getCurrentKey()) else player:getInventory():AddItem(qichebianhao:createVehicleKey()) end
                player:Say(getText("IGUI_zuzhuangchenggong"))
            end
        end
    end
end
function Recipe.OnCreate.mangheshengcunwuzi(items, result, player)
    local scwzmh={"Bag_NormalHikingBag","Base.PropaneTank","Base.Hammer","Base.Saw","Base.BlowTorch","Base.Bleach","Base.WeldingRods","Base.WeldingMask","camping.TentPeg","camping.CampingTentKit",
    "FishingTackle","FishingTackle2","FishingLine","Base.DuctTape","Base.Woodglue","FishingRod","FishingNet","Twine","Battery","Matches","Lighter","Cigarettes","HuntingKnife","Base.Wrench"};
    local ranran = ZombRand(#scwzmh);
    local ranran2 = ZombRand(#scwzmh);
    local a = player:getInventory():AddItem(scwzmh[ranran + 1]);
    local b = player:getInventory():AddItem(scwzmh[ranran2 + 1]);
    player:Say(a:getDisplayName())
    player:Say(b:getDisplayName())
    
end
function Recipe.OnCreate.manghefangkuai(items, result, player)
    local scwzmh={"tt_yuanmukuai","tt_caofangkuai","tt_hejinlifangti","tt_touminghejinlifangti","Mov_chinaflag","tt_shazi","tt_xiangshuyezi"};
    local ranran = ZombRand(#scwzmh);
    local ranran2 = ZombRand(#scwzmh);
    local a = player:getInventory():AddItem(scwzmh[ranran + 1]);
    local b = player:getInventory():AddItem(scwzmh[ranran2 + 1]);
    player:Say(a:getDisplayName())
    player:Say(b:getDisplayName())
end



function Recipe.OnCreate.manghejiu(items, result, player)
    local scwzmh={"WhiskeyFull","Wine","Wine2","BeerCan","BeerBottle","Milk","WaterBottleFull","Pop","Pop2","Pop3"};
    local ranran = ZombRand(#scwzmh);
    local a = player:getInventory():AddItem(scwzmh[ranran + 1]);
    player:Say(a:getDisplayName())

end
function Recipe.OnCreate.manghejunhuo(items, result, player)
    local scwzmh={"HolsterSimple","HolsterDouble","Nightstick","Shotgun","DoubleBarrelShotgun","Revolver","Revolver_Long","HuntingKnife","Radio.WalkieTalkie4","Radio.WalkieTalkie5","Pistol","Pistol2","Pistol3","x2Scope","x4Scope","x8Scope","AmmoStraps",
    "Sling","HuntingRifle","VarmintRifle","RecoilPad","Glasses_Shooting","9mmClip","45Clip","44Clip","223Clip","308Clip","M14Clip","556Clip","Vest_Hunting_Grey","AssaultRifle","AssaultRifle2"};
    local ranran2 = ZombRand(#scwzmh);            
    local ranran = ZombRand(#scwzmh);
    local a = player:getInventory():AddItem(scwzmh[ranran + 1]);
    local b = player:getInventory():AddItem(scwzmh[ranran2 + 1]);
    player:Say(a:getDisplayName())
    player:Say(b:getDisplayName())

end
function Recipe.OnCreate.manghexiyouwuzi(items, result, player)
    local scwzmh={"jiandanjiaoyi_huazi","maotai","Katana","Machete","Axe","Sledgehammer2","brick_brick","tt_yaobaozhengmian"};
    local ranran = ZombRand(#scwzmh);
    local aaa = player:getInventory():AddItem(scwzmh[ranran + 1]);
    player:Say(aaa:getDisplayName())
    
    
    
    local ranran3 = ZombRand(40)
    if ranran3 == 0 then

        local scwzmh2 = {"axe_diamond","pickaxe_diamond","shovel_diamond","sword_diamond","axe_stone","pickaxe_stone","shovel_stone","sword_stone"}
        local ranran2 = ZombRand(#scwzmh2)
        local bbb = player:getInventory():AddItem(scwzmh2[ranran2 + 1]);
        player:Say(bbb:getDisplayName())
    end


end

function Recipe.OnCreate.manghejianzhucailiao(items, result, player)
    local scwzmh={"Base.NailsBox","Base.Sandbag","Base.Gravelbag","Base.Stone","Base.Dirtbag","ConcretePowder","Base.SheetMetal","Base.SmallSheetMetal","Base.MetalPipe"};
    local ranran = ZombRand(#scwzmh);
    local cishu = 1;
    local aaa
    if ranran == 3 then
        cishu = 5;
    elseif ranran > 5 then
        cishu = 6;
    end
    for i = 1 , cishu do
        aaa = player:getInventory():AddItem(scwzmh[ranran + 1]);
    end
    
    player:Say(aaa:getDisplayName())
    
end
function Recipe.OnCreate.manghejinengzazhi(items, result, player)
    local scwzmh={"Base.BookCarpentry1","Base.BookCarpentry2","Base.BookCarpentry3","Base.BookCarpentry4","Base.BookCarpentry5",
    "Base.BookCooking1","Base.BookCooking2","Base.BookCooking3","Base.BookCooking4","Base.BookCooking5",
    "Base.BookElectrician1","Base.BookElectrician2","Base.BookElectrician3","Base.BookElectrician4","Base.BookElectrician5",
    "Base.BookFarming1","Base.BookFarming2","Base.BookFarming3","Base.BookFarming4","Base.BookFarming5",
    "Base.BookFirstAid1","Base.BookFirstAid2","Base.BookFirstAid3","Base.BookFirstAid4","Base.BookFirstAid5",
    "Base.BookFishing1","Base.BookFishing2","Base.BookFishing3","Base.BookFishing4","Base.BookFishing5",
    "Base.BookForaging1","Base.BookForaging2","Base.BookForaging3","Base.BookForaging4","Base.BookForaging5",
    "Base.BookMechanic1","Base.BookMechanic2","Base.BookMechanic3","Base.BookMechanic4","Base.BookMechanic5",
    "Base.BookMetalWelding1","Base.BookMetalWelding2","Base.BookMetalWelding3","Base.BookMetalWelding4","Base.BookMetalWelding5",
    "Base.BookTailoring1","Base.BookTailoring2","Base.BookTailoring3","Base.BookTailoring4","Base.BookTailoring5",
    "Base.BookTrapping1","Base.BookTrapping2","Base.BookTrapping3","Base.BookTrapping4","Base.BookTrapping5",
    "Base.ElectronicsMag1","Base.ElectronicsMag2","Base.ElectronicsMag3","Base.ElectronicsMag4","Base.ElectronicsMag5",
    "Base.EngineerMagazine1","Base.EngineerMagazine2","Base.FishingMag1","Base.FishingMag2","Base.HerbalistMag","Base.HuntingMag1","Base.HuntingMag2","Base.HuntingMag3","Base.MechanicMag1","Base.MechanicMag2","Base.MechanicMag3",
    "Base.MetalworkMag1","Base.MetalworkMag2","Base.MetalworkMag3","Base.MetalworkMag4","Radio.RadioMag1","Radio.RadioMag2","Radio.RadioMag3","Base.CookingMag1","Base.CookingMag1"};
    for i = 1 , 3 do
        local ranran = ZombRand(#scwzmh)
        local aaa = player:getInventory():AddItem(scwzmh[ranran + 1])
        player:Say(aaa:getDisplayName())
    end

end

function Recipe.OnCreate.mangheshiwu(items, result, player)
    local scwzmh={"Base.CannedBolognese","Base.CannedCarrots2","Base.CannedChili","Base.CannedCorn","CannedCornedBeef","CannedMushroomSoup","Base.CannedPeas","Base.CannedPotato2","Base.CannedSardines","Base.CannedTomato2",
    "Chicken","Steak","PorkChop","MeatPatty","Ham","Tofu","Zucchini","Pineapple","Avocado","Worm","Grapes","Leek","Eggplant","Corn",
    "Lemon","Onion","MuttonChop","Ketchup","Mustard","BellPepper","Peach","Pickles","Lettuce","Cherry","Banana","Orange",
    "Apple","EggCarton","Butter","Broccoli","Watermelon"};
    local ranran2 = ZombRand(#scwzmh);            
    local ranran = ZombRand(#scwzmh);
    local a = player:getInventory():AddItem(scwzmh[ranran + 1]);
    local b = player:getInventory():AddItem(scwzmh[ranran2 + 1]);
    player:Say(a:getDisplayName())
    player:Say(b:getDisplayName())

end

function Recipe.OnCreate.mangheyifu(items, result, player)
    local scwzmh={"Shirt_Baseball_KY","Shirt_Baseball_Rangers","Shirt_Baseball_Z","Shirt_CamoDesert","Shirt_CamoGreen","Shirt_CamoUrban","Shirt_Denim",
    "Shirt_FormalTINT","Shirt_FormalWhite","Shirt_FormalWhite_ShortSleeve","Shirt_FormalWhite_ShortSleeveTINT","Shirt_HawaiianRed","Shirt_HawaiianTINT",
    "Shirt_Jockey01","Shirt_Jockey02","Shirt_Jockey03","Shirt_Jockey04","Shirt_Jockey05","Shirt_Jockey06","Shirt_Lumberjack","Shirt_OfficerWhite",
    "Shirt_PoliceBlue","Shirt_PoliceGrey","Shirt_Priest","Shirt_PrisonGuard","Shirt_Ranger","Shirt_Scrubs","Shirt_Workman","Shorts_CamoGreenLong",
    "Shorts_CamoUrbanLong","Shorts_LongDenim","Shorts_LongSport","Shorts_LongSport_Red","Shorts_ShortDenim","Shorts_ShortFormal","Shorts_ShortSport",
    "Skirt_Knees","Skirt_Long","Skirt_Normal","Skirt_Short","Socks_Ankle","Socks_Long","SpiffoSuit","SpiffoTail","Suit_Jacket","Suit_JacketTINT",
    "SwimTrunks_Blue","SwimTrunks_Green","SwimTrunks_Red","SwimTrunks_Yellow","Swimsuit_TINT","Trousers","Trousers_Black","Trousers_CamoDesert",
    "Trousers_ArmyService","Trousers_CamoGreen","Trousers_CamoUrban","Trousers_Chef","Trousers_DefaultTEXTURE","Trousers_DefaultTEXTURE_HUE",
    "Trousers_DefaultTEXTURE_TINT","Trousers_Denim","Trousers_Fireman","Trousers_JeanBaggy","Trousers_NavyBlue","Trousers_Padded","Trousers_Police",
    "Trousers_PoliceGrey","Trousers_PrisonGuard","Trousers_Ranger","Trousers_Santa","Trousers_SantaGReen","Trousers_Scrubs","Trousers_Suit",
    "Trousers_SuitTEXTURE","Trousers_SuitWhite","Trousers_WhiteTEXTURE","Trousers_WhiteTINT","Tshirt_ArmyGreen","Tshirt_BusinessSpiffo",
    "Tshirt_CamoDesert","Tshirt_CamoGreen","Tshirt_CamoUrban","Tshirt_DefaultDECAL","Tshirt_DefaultDECAL_TINT","Tshirt_DefaultTEXTURE",
    "Tshirt_DefaultTEXTURE_TINT","Tshirt_Fossoil","Tshirt_Gas2Go","Tshirt_IndieStoneDECAL","Tshirt_McCoys","Tshirt_PileOCrepe","Tshirt_PizzaWhirled",
    "Tshirt_PoliceBlue","Tshirt_PoliceGrey","Tshirt_PoloStripedTINT","Tshirt_PoloTINT","Tshirt_Profession_FiremanBlue","Tshirt_Profession_FiremanRed",
    "Tshirt_Profession_FiremanRed02","Tshirt_Profession_FiremanWhite","Tshirt_Profession_PoliceBlue","Tshirt_Profession_PoliceWhite",
    "Tshirt_Profession_RangerBrown","Tshirt_Profession_RangerGreen","Tshirt_Profession_VeterenGreen","Tshirt_Profession_VeterenRed",
    "Tshirt_Ranger","Tshirt_Rock","Tshirt_Scrubs","Tshirt_SpiffoDECAL","Tshirt_Sport","Tshirt_SportDECAL","Tshirt_ThunderGas",
    "Tshirt_ValleyStation","Tshirt_WhiteLongSleeve","Tshirt_WhiteLongSleeveTINT","Tshirt_WhiteTINT","Underwear1","Underwear2",
    "Vest_DefaultTEXTURE","Vest_DefaultTEXTURE_TINT","Vest_BulletArmy","Vest_BulletCivilian","Vest_BulletPolice","Vest_Foreman",
    "Vest_HighViz","Vest_Hunting_Camo","Vest_Hunting_CamoGreen","Vest_Hunting_Grey","Vest_Hunting_Orange","Vest_Hunting_Orange",
    "Vest_WaistcoatTINT","Vest_Waistcoat_GigaMart","WeddingDress","WeddingJacket"};
    local ranran2 = ZombRand(#scwzmh);        
    local ranran = ZombRand(#scwzmh);
    local a = player:getInventory():AddItem(scwzmh[ranran + 1]);
    local b = player:getInventory():AddItem(scwzmh[ranran2 + 1]);
    player:Say(a:getDisplayName())
    player:Say(b:getDisplayName())

end


function Recipe.OnCreate.lanseyaoji(items, result, player)
    local aaaa = 1 - ( (1 - player:getStats():getHunger() )* 0.5 )
    local bbbb = 1 - ( (1 - player:getStats():getThirst() )* 0.5 )
    -- print(aaaa,bbbb)
    
    player:getBodyDamage():RestoreToFullHealth()
    
    
    player:getStats():setHunger(aaaa)
    player:getStats():setThirst(bbbb)
    player:getStats():setFatigue(1)

    player:Say(getText("IGUI_lanseyaoji"))
    
end
function Recipe.OnCreate.liancujinshu(items, result, player)
	local guijinshu = ZombRand(10)
    local tong = ZombRand(10)
    local xikuai = ZombRand(10)
    local qiankuai = ZombRand(10)

    for i=1,4 do
        if guijinshu > 6 then
            player:getInventory():AddItem("tt_feiqiguijinshu")
        end
        if tong < 5 then
            player:getInventory():AddItem("tt_tongkuai")
        end
        if xikuai < 3 then
            player:getInventory():AddItem("tt_qiankuai")
        end
        if qiankuai < 4 then
            player:getInventory():AddItem("tt_xikuai")
        end
    end

end

function Recipe.OnCreate.jiushiwan(items, result, player)
    player:getStats():setBoredom(player:getStats():getBoredom() - 0.2 * player:getStats():getBoredom())
    player:Say(getText("IGUI_jiushiwan"))
    
    
    -- addVehicle("Base.superSportsCar")


    
    -- print(player:getStats():getFitness())
end

function Recipe.OnCreate.lvseyaoji(items, result, player)
    player:getXp():AddXP(Perks.Strength,1500 + player:getXp():getXP(Perks.Strength))
    player:getXp():AddXP(Perks.Fitness,1500 + player:getXp():getXP(Perks.Fitness))
    player:Say(getText("IGUI_lvseyaoji"))
end
function Recipe.OnCreate.dubodubo(items, result, player)
    local ranran2 = ZombRand(100)

    if ranran2 > 52 then
        player:Say(getText("IGUI_dubodubo"))
        player:getInventory():AddItems("Money",2000)
    else
        player:Say(getText("IGUI_duboshibai"))
    end
end
function Recipe.OnCreate.fangruyiqianyuan(items, result, player)
    result:setUsedDelta(0.1)
end

function Recipe.OnCreate.fangruwubaiyuan(items, result, player)
    for i=0, items:size()-1 do
        if items:get(i):getType() == "tt_moneybag" then
            if items:get(i):getUsedDelta() == 1 then
                player:getInventory():AddItems("Money",500)
            else
                if items:get(i):getUsedDelta() == 0 then
                    result:setUsedDelta(0.06)
                else
                    result:setUsedDelta(items:get(i):getUsedDelta() + 0.05)
                end


                
            end


            
            
        end    
    end
end

--[[ function Recipe.OnTest.fangruwubaiyuan(sourceItem, result)

	if sourceItem:getType() == "tt_moneybag" then
		return sourceItem:getUsedDelta() ~= 1
    end

	return true
end ]]

function Recipe.OnCreate.goumaiqiandaizi(items, result, player)
    result:setUsedDelta(0.01)
end

function Recipe.OnCreate.hongseyaoji(items, result, player)

    if not player:getTraits():contains("Desensitized") then
        player:getTraits():add("Desensitized")
    end
    player:getStats():setFatigue(1)
    player:Say(getText("IGUI_hongseyaoji"))
end

function Recipe.OnCreate.ziseyaoji(items, result, player)
    if player:getModData().weightshuzhi == nil then
        player:getModData().weightshuzhi = 0
    end

    
    player:getModData().weightshuzhi = player:getModData().weightshuzhi +1
    if player:getModData().weightshuzhi < 6 then
        player:setMaxWeight(player:getMaxWeight() + 2)
        player:setMaxWeightBase(player:getMaxWeightBase() + 2)
        player:Say(getText("IGUI_lvseyaoji"))
        player:getModData().weightBase = player:getMaxWeightBase()
        player:getModData().weightMax = player:getMaxWeight()
    end

end

function Recipe.OnCreate.solargenerator2(items, result, player)
    if getGameTime():getModData().solarsquare ~= 0 then
        local iiii = 0
        for i=0, items:size()-1 do
            if items:get(i):getType() == "tt_solargenerator2" then
                iiii = items:get(i):getModData().number
            end
        end
        
        getGameTime():getModData().solarsquare[iiii] = 0
        local gg = 0
        local eeee = getGameTime():getModData().solarsquare
        for i=1,#eeee do
            if eeee[i] ~=0 then
                gg=gg+1
            end
        end
        player:Say(getText("IGUI_yiyichu") .. tostring(iiii).. getText("IGUI_detaiyangneng"))
        player:Say(getText("IGUI_yunxingzhong") ..tostring(gg)  .. getText("IGUI_taishu"))
        local solarnuml = getGameTime():getModData().solarnum
        getGameTime():getModData().solarnum = solarnuml - 1
    
    
    
        local NewGenerator = IsoGenerator.new(nil,player:getCell(),player:getCurrentSquare())                            
        NewGenerator:setConnected(false)
        NewGenerator:setFuel(0)
        NewGenerator:setCondition(0)
        NewGenerator:setActivated(false)
        NewGenerator:remove()
    end


    


end

function Recipe.OnCreate.solargenerator1(items, result, player)
    if(player:isOutside()) then
        local NewGenerator = IsoGenerator.new(nil,player:getCell(),player:getCurrentSquare())
        NewGenerator:setConnected(true)
        NewGenerator:setFuel(100)
        NewGenerator:setCondition(100)
        NewGenerator:setActivated(true)
	    NewGenerator:setSurroundingElectricity()
        NewGenerator:remove()
        local solardata = player:getCurrentSquare():AddWorldInventoryItem( "tt_solargenerator2" ,0.5,0.5,0)
        

        if getGameTime():getModData().solarsquare == nil then
            getGameTime():getModData().solarsquare = {0}
        end
        if getGameTime():getModData().solarnum == nil then
            getGameTime():getModData().solarnum = 0
        end

        local solarpos = {player:getCurrentSquare():getX(),player:getCurrentSquare():getY(),player:getCurrentSquare():getZ()}

        local eeee = getGameTime():getModData().solarsquare
        local r = 0
        for i=1,#eeee do
            if eeee[i] == 0 then
                getGameTime():getModData().solarsquare[i] = solarpos
                solardata:getModData().number = i
                r = 1
                local solarnuml = getGameTime():getModData().solarnum
                getGameTime():getModData().solarnum = solarnuml + 1
                player:Say(getText("IGUI_bianhao") .. tostring(i))
                break
            end
        end
        if r == 0 then
            table.insert(getGameTime():getModData().solarsquare,solarpos)
            eeee = getGameTime():getModData().solarsquare
            solardata:getModData().number=#eeee
            local solarnumll = getGameTime():getModData().solarnum
            getGameTime():getModData().solarnum = solarnumll + 1
            player:Say(getText("IGUI_bianhao") .. tostring(#eeee))
        end
        local gg = 0
        for i=1,#eeee do
            if eeee[i] ~=0 then
                gg=gg+1
            end
        end
        player:Say(getText("IGUI_yunxingzhong") ..tostring(gg)  .. getText("IGUI_taishu"))
        player:Say("debug:" .. tostring(getGameTime():getModData().solarnum))
        print(#eeee)

    else
        player:Say(getText("IGUI_zuzhuangshibai"))
		player:getInventory():AddItem("tt_solargenerator")
    end
end

-- function Recipe.OnCreate.solargenerator3(items, result, player)
--     local NewGenerator = IsoGenerator.new(nil,player:getCell(),player:getCurrentSquare())
--     NewGenerator:setConnected(true)
--     NewGenerator:setFuel(100)
--     NewGenerator:setCondition(100)
--     NewGenerator:setActivated(true)
-- 	NewGenerator:setSurroundingElectricity()
--     NewGenerator:remove()
--     player:getCurrentSquare():AddWorldInventoryItem( "tt_solargenerator2" ,0.5,0.5,0)
-- end

function Recipe.OnCreate.manghedanyao(items, result, player)
    local scwzmh={"223Box","308Box","556Box","Bullets38Box","Bullets44Box","Bullets45Box","Bullets9mmBox","ShotgunShellsBox"}
    local ranran2 = ZombRand(#scwzmh);            
    local ranran = ZombRand(#scwzmh);
    local a = player:getInventory():AddItem(scwzmh[ranran + 1]);
    local b = player:getInventory():AddItem(scwzmh[ranran2 + 1]);
    player:Say(a:getDisplayName())
    player:Say(b:getDisplayName())

end



function Recipe.OnCreate.ttgserum(items, result, player)
    local goodtra = {}
    local badtra = {}



    for i=0, TraitFactory.getTraits():size()-1 do
        
        local traita = TraitFactory.getTraits():get(i)
        
        if not player:getTraits():contains(traita:getType()) and traita:getCost() >= 0 then
            table.insert(goodtra, traita)
        end
        
        if player:getTraits():contains(traita:getType()) and traita:getCost() < 0 then
            table.insert(badtra, traita)
        end
    end

    
    
    
    
    local goodtraaa = goodtra[ZombRand(#goodtra) + 1]
    
    local badtraaa = badtra[ZombRand(#badtra) + 1]
    
    local randomn = ZombRand(2)

    if #goodtra > 0 and #badtra > 0 and randomn == 0 then
        
        player:getTraits():add(goodtraaa:getType())
        player:Say("+ " .. goodtraaa:getLabel())



    end

    if #goodtra > 0 and #badtra > 0 and randomn == 1 then
        player:getTraits():remove(badtraaa:getType())
        
        player:Say("- " .. badtraaa:getLabel())
    end

    if #goodtra == 0 and #badtra > 0 then
        player:getTraits():remove(badtraaa:getType())
        player:Say("- " .. badtraaa:getLabel())
    end

    if #goodtra > 0 and #badtra == 0 then
        player:getTraits():add(goodtraaa:getType())
        player:Say("+ " .. goodtraaa:getLabel())
    end

    -- player:getBodyDamage():setOverallBodyHealth(0.8 * player:getBodyDamage():getOverallBodyHealth())
    local aaaa = 1 - ( (1 - player:getStats():getHunger() )* 0.9 )
    local bbbb = 1 - ( (1 - player:getStats():getThirst() )* 0.9 )
    
    
    
    player:getStats():setHunger(aaaa)
    player:getStats():setThirst(bbbb)

    getPlayer(player):getNutrition():setWeight(getPlayer(player):getNutrition():getWeight() - 2)

    player:Say(getText("IGUI_Gserum"))



end

function Recipe.OnCreate.nongsuoniguding(items, result, player)
    local statsa = player:getStats()

    player:getBodyDamage():setUnhappynessLevel(0)
    player:getBodyDamage():setBoredomLevel(0)
    statsa:setFatigue(statsa:getFatigue() * 0.7)
    statsa:setStress(0)
    statsa:setStressFromCigarettes(0)
    player:setTimeSinceLastSmoke(0)
    local aaaaa = 1 - ( (1 - statsa:getHunger() )* 0.85 )
    local bbbbb = 1 - ( (1 - statsa:getThirst() )* 0.85 )
    statsa:setHunger(aaaaa)
    statsa:setThirst(bbbbb)


    if not player:HasTrait("Smoker") then
        player:getTraits():add("Smoker")
    end

    player:Say(getText("IGUI_nongsuoniguding"))
    
    
end

function Recipe.OnCreate.leidakongzhiqi(items, result, player)
    -- local leida = StreamMapWindow:new(0, 0, 700+200, 700)
    -- leida:initialise()
    -- leida:addToUIManager()


    -- if recipe_leida == nil then
    --     recipe_leida = 0
    -- end

    -- if recipe_leida == 1 then
    --     UIManager.RemoveUI(recipe_leidaweizhi)
    --     recipe_leida = 0    
    -- end

    -- if recipe_leida == 0 then
    --     recipe_leidaweizhi = RadarPanel.new(0)
    --     UIManager.AddUI(recipe_leidaweizhi)
    --     recipe_leida = 1
    -- end
    UIManager.AddUI(RadarPanel.new(0))


end


function Recipe.OnCreate.yishu(items, result, player)
    getGameTime():getModData().chushengdianzuobiao  = {player:getCurrentSquare():getX(),player:getCurrentSquare():getY(),player:getCurrentSquare():getZ()}
    player:Say(getText("IGUI_chushengdian") .. tostring(getGameTime():getModData().chushengdianzuobiao[1])..",".. tostring(getGameTime():getModData().chushengdianzuobiao[2]).."," ..tostring(getGameTime():getModData().chushengdianzuobiao[3]))
end
