
local function superzombie(zombie)
    if zombie:getModData().super == nil then
        local random = ZombRand(100)
        if random < 20 then
            zombie:getModData().super = "putong"
            getSandboxOptions():set("ZombieLore.Speed",2)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:changeSpeed(2)
			zombie:DoZombieStats()
        elseif random <31 then
            zombie:getModData().super = "kulouputong"
            getSandboxOptions():set("ZombieLore.Speed",2)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:changeSpeed(2)
            zombie:setSkeleton(true)
			zombie:DoZombieStats()
        elseif random <35 then
            zombie:getModData().super = "paoshiputong"
            getSandboxOptions():set("ZombieLore.Speed",1)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:changeSpeed(1)
            zombie:DoZombieStats()
        elseif random <39 then
            zombie:getModData().super = "paoshikulou"
            getSandboxOptions():set("ZombieLore.Speed",1)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:setSkeleton(true)
            zombie:changeSpeed(1)
            zombie:DoZombieStats()
        elseif random < 50 then
            zombie:getModData().super = "ranshaoputong"
            getSandboxOptions():set("ZombieLore.Speed",2)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:setSkeleton(true)
            zombie:changeSpeed(2)
            zombie:SetOnFire()
            zombie:setHealth(10)
            zombie:DoZombieStats()
        elseif random < 53 then
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
        elseif random < 62 then
            zombie:getModData().super = "baozhapaoshi"
            getSandboxOptions():set("ZombieLore.Speed",1)
			getSandboxOptions():set("ZombieLore.Cognition",1)
			getSandboxOptions():set("ZombieLore.Toughness",1)
			getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:setSkeleton(true)
            zombie:changeSpeed(1)
            zombie:SetOnFire()
            zombie:setHealth(500)
            zombie:DoZombieStats()
        elseif random < 75 then
            zombie:getModData().super = "chaojiputong"
            getSandboxOptions():set("ZombieLore.Speed",3)
            getSandboxOptions():set("ZombieLore.Cognition",1)
            getSandboxOptions():set("ZombieLore.Toughness",1)
            getSandboxOptions():set("ZombieLore.Strength",1)
            zombie:changeSpeed(2)
            zombie:setHealth(500)
            zombie:DoZombieStats()
        else
            zombie:getModData().super = "fuhuojiangshi"
            getSandboxOptions():set("ZombieLore.Speed",3)
            getSandboxOptions():set("ZombieLore.Cognition",3)
            getSandboxOptions():set("ZombieLore.Toughness",3)
            getSandboxOptions():set("ZombieLore.Strength",3)
            zombie:changeSpeed(3)
            zombie:setHealth(2)
            zombie:DoZombieStats()
        end

    elseif zombie:getModData().super == "baozhapaoshi" then
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

local function checkmori(zombie)
    if getWorld():getGameMode() == "Multiplayer" then return end
    if getPlayer():getModData().morilailin then
        superzombie(zombie)
    end
end

Events.OnZombieUpdate.Add(checkmori)

