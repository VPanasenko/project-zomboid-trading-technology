Events.OnPlayerUpdate.Add(function(player, vehicle, args)
    local vehicle = player.getVehicle and player:getVehicle() or nil
    if (vehicle and string.find( vehicle:getScriptName(), "Base.superSportsCar" )) then

	local tireFLc = vehicle:getPartById("TireFrontLeft")
    		if tireFLc:getCondition() < 100 then
				tireFLc:setCondition(100)
	end

		local tireFLp = vehicle:getPartById("TireFrontLeft")
			if tireFLp:getContainerContentAmount() < 100 then
					tireFLp:setContainerContentAmount(100)		
	end

	local tireFRc = vehicle:getPartById("TireFrontRight")
    		if tireFRc:getCondition() < 100 then
				tireFRc:setCondition(100)
	end

			local tireFRp = vehicle:getPartById("TireFrontRight")
			if tireFRp:getContainerContentAmount() < 100 then
					tireFRp:setContainerContentAmount(100)		
		end

	local tireRLc = vehicle:getPartById("TireRearLeft")
    		if tireRLc:getCondition() < 100 then
				tireRLc:setCondition(100)
	end

			local tireRLp = vehicle:getPartById("TireRearLeft")
			if tireRLp:getContainerContentAmount() < 100 then
					tireRLp:setContainerContentAmount(100)		
		end

	local tireRRc = vehicle:getPartById("TireRearRight")
    		if tireRRc:getCondition() < 100 then
				tireRRc:setCondition(100)
	end

			local tireRRp = vehicle:getPartById("TireRearRight")
			if tireRRp:getContainerContentAmount() < 100 then
					tireRRp:setContainerContentAmount(100)		
		end

	local doorFLc = vehicle:getPartById("DoorFrontLeft")
    		if doorFLc:getCondition() < 100 then
		doorFLc:setCondition(100)
	end

	local doorFRc = vehicle:getPartById("DoorFrontRight")
    		if doorFRc:getCondition() < 100  then
		doorFRc:setCondition(100)
	end

		local enDoorc = vehicle:getPartById("EngineDoor")
    		if enDoorc:getCondition() < 100 then
				enDoorc:setCondition(100)
	end

	local doorTc = vehicle:getPartById("TrunkDoor")
    		if doorTc:getCondition() < 100 then
		doorTc:setCondition(100)
	end

	local enCond = vehicle:getPartById("Engine")
    		if enCond:getCondition() < 100 then
				enCond:setCondition(100)
	end

	local winFLc = vehicle:getPartById("WindowFrontLeft")
    		if winFLc:getCondition() < 100 then
				winFLc:setCondition(100)
	end

	local winFRc = vehicle:getPartById("WindowFrontRight")
    		if winFRc:getCondition() < 100 then
				winFRc:setCondition(100)
	end

	--[[ local winRRc = vehicle:getPartById("WindowRearRight")
    		if winRRc:getCondition() < 100 then
		winRRc:setCondition(100)
	end ]]

	local windRc = vehicle:getPartById("WindshieldRear")
    		if windRc:getCondition() < 100 then
		windRc:setCondition(100)
	end

	local windc = vehicle:getPartById("Windshield")
    		if windc:getCondition() < 100 then
				windc:setCondition(100)
	end

	local tankCond = vehicle:getPartById("GasTank")
    		if tankCond:getCondition() < 100 then
				tankCond:setCondition(100)
	end

	local trunkc = vehicle:getPartById("TruckBed")
    		if trunkc:getCondition() < 100 then
		trunkc:setCondition(100)
	end

end

end)



function shasijiangshi(zombiea)
    local ran = ZombRand(10)
	local ran2 = ZombRand(10)


    if ran > 5 then
        local inv = getPlayer():getInventory()
        local dianshu = ZombRand(5) + 3
        local wanjia = getPlayer()
        if inv:contains("tt_pashoujuewu", true) then
            inv:AddItems("Money", dianshu)
            wanjia:Say(tostring(dianshu) .. getText("IGUI_chaopiao"))
        else
            zombiea:getInventory():AddItems("Money", dianshu + 2)
        end
    end

	if ran2 > 7 then
		zombiea:getInventory():AddItem("Base.tradecore")
	end



end

function refreshsolar()
	local solarlist = getGameTime():getModData().solarsquare
	if solarlist ~= nil then
		for i=1 , #solarlist do
			if solarlist[i] ~= 0 then
				local solarxyz = getCell():getGridSquare(solarlist[i][1],solarlist[i][2],solarlist[i][3])
			    -- print(solarxyz)
			    if solarxyz ~= nil then
				    local NewGenerator = IsoGenerator.new(nil,getCell(),solarxyz)
			        NewGenerator:setConnected(true)
                    NewGenerator:setFuel(100)
                    NewGenerator:setCondition(100)
                    NewGenerator:setActivated(true)
	                NewGenerator:setSurroundingElectricity()
                    NewGenerator:remove()
				end
			    -- print("solarrefresh")
			end
			-- print("nofresh11")		
		end
		-- print("nofresh")
		-- print(#solarlist)
		
	else
		-- print("nosloar")
	end
	-- print("solarok")

end

Events.EveryTenMinutes.Add(refreshsolar)
Events.OnZombieDead.Add(shasijiangshi)

function jiangshifuhuo(_object)
	local corpse = _object
	if corpse and instanceof(corpse, "IsoDeadBody") then
		if corpse:getContainer():contains("xiuchegongjv") then
			corpse:getContainer():Remove("xiuchegongjv")
			corpse:setReanimateTime(2)
		end
	end
end



Events.OnContainerUpdate.Add(jiangshifuhuo)
