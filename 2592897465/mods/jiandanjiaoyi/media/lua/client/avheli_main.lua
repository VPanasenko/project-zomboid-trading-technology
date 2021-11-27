local tempVector2 = Vector3f.new()
local helizuobiao = {}
local zhuansu = {3,3}
local curr_z = nil
local bladeround = 1
local vehicle2 = nil
local function move_vehicle(vehicle, x_delta, y_delta, z_delta)
    local tmpTransform = getClassFieldVal(vehicle, getClassField(vehicle, 45))
    local wTranform = vehicle:getWorldTransform(tmpTransform)
    local originField = getClassFieldVal(wTranform, getClassField(wTranform, 1))
    originField:set(originField:x() + x_delta, originField:y() + y_delta, originField:z() + z_delta)
    vehicle:setWorldTransform(wTranform)
end

local function heliround(playerObj,vehicle)
    if vehicle2 == nil then return end
    curr_z = vehicle2:getWorldPos(0, 0, 0, tempVector2):z()
    local emi = vehicle2:getEmitter()
    if vehicle2:isEngineRunning() then
        if zhuansu[1] == 1 then
            if (curr_z <2 and playerObj:isGhostMode()) or vehicle == nil then
                playerObj:setGhostMode(false)
            end

            zhuansu[1] = zhuansu[2]
            local part = vehicle2:getPartById("heliblade")
            if part == nil then return end
            if bladeround == 1 then
                part:setModelVisible("blade8", false)
                part:setModelVisible("blade1", true)
                bladeround = 2
            elseif bladeround == 2 then
                part:setModelVisible("blade1", false)
                part:setModelVisible("blade2", true)
                bladeround = 3
            elseif bladeround == 3 then
                part:setModelVisible("blade2", false)
                part:setModelVisible("blade3", true)
                bladeround = 4
            elseif bladeround == 4 then
                part:setModelVisible("blade3", false)
                part:setModelVisible("blade4", true)
                bladeround = 5
            elseif bladeround == 5 then
                part:setModelVisible("blade4", false)
                part:setModelVisible("blade5", true)
                bladeround = 6
            elseif bladeround == 6 then
                part:setModelVisible("blade5", false)
                part:setModelVisible("blade6", true)
                bladeround = 7
            elseif bladeround == 7 then
                part:setModelVisible("blade6", false)
                part:setModelVisible("blade7", true)
                bladeround = 8
            elseif bladeround == 8 then
                part:setModelVisible("blade7", false)
                part:setModelVisible("blade8", true)
                bladeround = 1
            end
            vehicle2:update()
            if emi:isPlaying("HeliSound") then return end
            local songId = emi:playAmbientLoopedImpl("HeliSound")
            playerObj:getModData()["HeliSound"] = songId
            playerObj:getModData()["HeliSoundEmi"] = emi
            playerObj:getModData()["LastHeli"] = vehicle2
            emi:setVolume(songId, 0.9)
        else
            if zhuansu[2] == 0 or zhuansu[1] == 0 then
                zhuansu[2] = 2
                zhuansu[1] = 2
            end
            zhuansu[1] = zhuansu[1] - 1
        end

    else
        if emi:isPlaying("HeliSound")  then 
            emi:stopSoundByName("HeliSound") 
        end
        if emi:isPlaying("VehicleSkid") then
            emi:stopSoundByName("VehicleSkid")
        end
        
        if curr_z > 2 then
            zhuansu[2] = 2
            move_vehicle(vehicle2, 0, -0.06, 0)
        elseif curr_z > 0.8 then
            move_vehicle(vehicle2, 0, -0.1, 0)
            zhuansu[2] = 0
            if playerObj:isGhostMode() then
                playerObj:setGhostMode(false)
            end
        end
        if curr_z < 0.8 then
            vehicle2 = nil
        end
    end
    
end
local function heli_update()
    local playerObj = getPlayer()
    if playerObj == nil then return end
    local vehicle = playerObj:getVehicle()
    heliround(playerObj,vehicle)
    if vehicle == nil then return end
    if vehicle:getScript():getFullName() ~= "Base.advancedhelicopter" then return end
    vehicle2 = vehicle

    if not vehicle:isEngineRunning() then return end

    vehicle:getPartById("GasTank"):setContainerContentAmount(vehicle:getPartById("GasTank"):getContainerContentAmount() - 0.0003)
    curr_z = vehicle:getWorldPos(0, 0, 0, tempVector2):z()
    if curr_z > 1.5  then
        if not playerObj:isGhostMode() then
            playerObj:setGhostMode(true)
        end

        if helizuobiao == nil then
            helizuobiao = {0, vehicle:getAngleY(), 0,0,0,0}
            vehicle:setAngles(0, helizuobiao[2], 0)
        else
            if helizuobiao[6]> 0 then
                helizuobiao[6] = helizuobiao[6] - 0.0003
            end
            move_vehicle(vehicle, helizuobiao[6]*helizuobiao[4], 0.00005, helizuobiao[6]*helizuobiao[5])
            if (math.abs(helizuobiao[1]) ~= 180 and math.abs(helizuobiao[3]) ~= 180 ) or (math.abs(helizuobiao[1]) ~= 0 and math.abs(helizuobiao[3]) ~= 0 ) then
                if math.abs(helizuobiao[3]) ~= 0 then
                    helizuobiao[3] = helizuobiao[3] - 0.5*math.abs(helizuobiao[3])/helizuobiao[3]
                    vehicle:setAngles(helizuobiao[1], helizuobiao[2], helizuobiao[3])
                end
                if math.abs(helizuobiao[1]) ~= 0 then
                    helizuobiao[1] = helizuobiao[1]- 0.5*math.abs(helizuobiao[1])/helizuobiao[1]
                    vehicle:setAngles( helizuobiao[1],  helizuobiao[2],  helizuobiao[3])
                end
            end
        end

        if isKeyDown(Keyboard.KEY_UP) then
            helizuobiao[4] = math.sin(math.rad(helizuobiao[2]+90))
            helizuobiao[5] = math.cos(math.rad(helizuobiao[2]+90))
            if helizuobiao[3] > -40 then
                helizuobiao[3] = helizuobiao[3] - 0.6
                vehicle:setAngles(helizuobiao[1], helizuobiao[2], helizuobiao[3])
            end
            if helizuobiao[6] < 2.1 then
                helizuobiao[6] = helizuobiao[6]+0.001
            end
            zhuansu[2] = 1
        end
    
        if isKeyDown(Keyboard.KEY_DOWN) then
            helizuobiao[4] = math.sin(math.rad(helizuobiao[2]+90))
            helizuobiao[5] = math.cos(math.rad(helizuobiao[2]+90))
            if helizuobiao[3] < 40 then
                helizuobiao[3] = helizuobiao[3] + 0.8
                vehicle:setAngles(helizuobiao[1], helizuobiao[2], helizuobiao[3])
            end
            if helizuobiao[6] > -0.05 then
                helizuobiao[6] = helizuobiao[6] - 0.004
            end
            zhuansu[2] = 2
            
        end
    
        if isKeyDown(Keyboard.KEY_RIGHT) then
            if helizuobiao[2]~=-180 then
                helizuobiao[2]= helizuobiao[2] - 1
            else
                helizuobiao[2]=180
            end
            vehicle:setAngles(helizuobiao[1], helizuobiao[2], helizuobiao[3])
            zhuansu[2] = 1
        end
    
        if isKeyDown(Keyboard.KEY_LEFT) then
            if helizuobiao[2]~=180 then
                helizuobiao[2]= helizuobiao[2] + 1
            else
                helizuobiao[2]=-180
            end
            vehicle:setAngles(helizuobiao[1], helizuobiao[2], helizuobiao[3])
            zhuansu[2] = 1
        end

        if  curr_z < 7 then
            if isKeyDown(Keyboard.KEY_W) and vehicle:getRemainingFuelPercentage() > 0 then   
                move_vehicle(vehicle, 0, 0.04, 0)
                zhuansu[2] = 1
            end
        end
    else

        if isKeyDown(Keyboard.KEY_W) and vehicle:getRemainingFuelPercentage() > 0 then   
            move_vehicle(vehicle, 0, 0.04, 0)
        end
        zhuansu[2] = 1
        helizuobiao = nil
        if playerObj:isGhostMode() then
            playerObj:setGhostMode(false)
        end
    end

    if (isKeyDown(Keyboard.KEY_S) or vehicle:getRemainingFuelPercentage() <= 0 ) and curr_z > 0.6 then 
        move_vehicle(vehicle, 0, -0.03, 0)
        zhuansu[2] = 2
    end

end

Events.OnTick.Add(heli_update)









