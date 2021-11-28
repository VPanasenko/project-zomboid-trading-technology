local function superzombie(zombie)
    if zombie:getModData().super == nil then
        local random = ZombRand(100)
        if random < 20 then -- 普通
            zombie:getModData().super = "putong"
            getSandboxOptions():set("ZombieLore.Speed",2)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:changeSpeed(2)
			zombie:DoZombieStats()
        elseif random <31 then --骷髅
            zombie:getModData().super = "kulouputong"
            getSandboxOptions():set("ZombieLore.Speed",2)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:changeSpeed(2)
            zombie:setSkeleton(true)
            -- zombie:getHumanVisual():setHairModel("")
		    -- zombie:getHumanVisual():setBeardModel("")
			zombie:DoZombieStats()
        elseif random <35 then --普通跑尸
            zombie:getModData().super = "paoshiputong"
            getSandboxOptions():set("ZombieLore.Speed",1)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:changeSpeed(1)
            zombie:DoZombieStats()
        elseif random <39 then --骷髅跑尸
            zombie:getModData().super = "paoshikulou"
            getSandboxOptions():set("ZombieLore.Speed",1)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:setSkeleton(true)
            zombie:changeSpeed(1)
            -- zombie:getHumanVisual():setHairModel("")
			-- zombie:getHumanVisual():setBeardModel("")
            zombie:DoZombieStats()
        elseif random < 50 then --燃烧僵尸
            zombie:getModData().super = "ranshaoputong"
            getSandboxOptions():set("ZombieLore.Speed",2)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:setSkeleton(true)
            zombie:changeSpeed(2)
            zombie:SetOnFire()
            zombie:setHealth(6)
            zombie:DoZombieStats()
        elseif random < 53 then --燃烧跑尸
            zombie:getModData().super = "ranshaopaoshi"
            getSandboxOptions():set("ZombieLore.Speed",1)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:setSkeleton(true)
            zombie:changeSpeed(1)
            zombie:SetOnFire()
            zombie:setHealth(3)
            zombie:DoZombieStats()
        elseif random < 55 then --爆炸僵尸
            zombie:getModData().super = "baozhapaoshi"
            getSandboxOptions():set("ZombieLore.Speed",2)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            -- zombie:setSkeleton(true)
            zombie:changeSpeed(2)
            zombie:SetOnFire()
            zombie:setHealth(15)
            -- zombie:setClothingItem_Torso("Base.SpiffoSuit")
            -- zombie:clothingItemChanged("50659e76-dc71-4398-9cc1-d3ab17bd8406")
            -- zombie:clothingItemChanged("5fe680b9-6c78-44a6-9037-2087be56404c")
            zombie:DoZombieStats()
        elseif random < 65 then -- 超级普通僵尸
            zombie:getModData().super = "chaojiputong"
            getSandboxOptions():set("ZombieLore.Speed",3)
            getSandboxOptions():set("ZombieLore.Cognition",1)
            getSandboxOptions():set("ZombieLore.Toughness",1)
            getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:changeSpeed(2)
            zombie:setHealth(20)
            zombie:DoZombieStats()
        else
            zombie:getModData().super = "fuhuojiangshi" -- 复活僵尸
            getSandboxOptions():set("ZombieLore.Speed",3)
            getSandboxOptions():set("ZombieLore.Cognition",3)
            getSandboxOptions():set("ZombieLore.Toughness",3)
            getSandboxOptions():set("ZombieLore.Strength",3)
            zombie:changeSpeed(3)
            zombie:setHealth(5)
            zombie:DoZombieStats()
        end

    elseif zombie:getModData().super == "baozhapaoshi" then -- 僵尸爆炸
        if zombie:isAttacking() == true then
            zombie:getCurrentSquare():explode()
            zombie:playSound("BigExplosion")
            addSound(null, (zombie:getX()), (zombie:getY()), (zombie:getZ()), 200,0)			
            WorldFlares.launchFlare(750, zombie:getX(), zombie:getY(), 5, 0, 1, 0, 0, 1, 0, 0);
            zombie:setHealth(0)
        end

    -- elseif zombie:getModData().super == "putong" then
    --     zombie:setReanimate(true)
    end

end
local trapnumber = 20
local function checkmori(zombie)

    

    if getWorld():getGameMode() ~= "Multiplayer" then
        if getGameTime():getModData().morilailin  then
            superzombie(zombie)
        end
    end

    local square = zombie:getSquare()
    local traps = square:getObjects()
    -- if traps == nil then return end
    for i=0, traps:size() - 1 do
        if traps:get(i):getSprite() == nil then
            break
        end
        local objectname = traps:get(i):getSprite():getName()
        -- print(objectname)
        if trapnumber ~= 60 then
            trapnumber = trapnumber + 1
        else
            trapnumber = 0
            if objectname == "jiandanjiaoyi_01_38" then
                zombie:setHealth(zombie:getHealth()-0.08)
                
            elseif objectname == "jiandanjiaoyi_01_39"  then
                zombie:setHealth(0)
                traps:get(i):removeFromSquare()
            end
            -- print("lalalal")
        end
    end

    
end

Events.OnZombieUpdate.Add(checkmori)

