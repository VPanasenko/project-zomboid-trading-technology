superSpiffoVanRefrigerator = {}
superSpiffoVanRefrigerator.Create = {}
superSpiffoVanRefrigerator.Init = {}
superSpiffoVanRefrigerator.Update = {}

function superSpiffoVanRefrigerator.Create.Fridge(vehicle, part)
    local invItem = VehicleUtils.createPartInventoryItem(part);
    part:getItemContainer():setType("fridge")
    part:getItemContainer():setActive(true)
end

function superSpiffoVanRefrigerator.Init.Fridge(vehicle, part)
    if vehicle:getBatteryCharge() > 0.1 then
        part:getItemContainer():setCustomTemperature(-1.0)
    else		
        part:getItemContainer():setCustomTemperature(1.0)
    end
end

function superSpiffoVanRefrigerator.Update.Fridge(vehicle, part, elapsedMinutes)
    local temp = part:getItemContainer():getTemprature()
    --print("superSpiffoVanRefrigerator.Update temp:"..temp)
    local tempMin = -1.0
    local tempMax = 1.0
    local battery = vehicle:getBattery()
    if battery and battery:getInventoryItem() and vehicle:getBatteryCharge() > 0.0 then
        if temp < tempMin then
            part:getItemContainer():setCustomTemperature(tempMin)
        elseif temp > tempMin then
            part:getItemContainer():setCustomTemperature(temp - elapsedMinutes / 20)
        end
    else
        if temp < tempMax then
            part:getItemContainer():setCustomTemperature(temp + elapsedMinutes / 20)
        elseif temp >= tempMax then
            part:getItemContainer():setCustomTemperature(tempMax)
        end
    end
end

-- custom engine update function to not disable part updates if the engine is stopped
function superSpiffoVanRefrigerator.Update.Engine(vehicle, part, elapsedMinutes)
    -- engine update function from Vehicles.lua
    Vehicles.Update.Engine(vehicle, part, elapsedMinutes)
    vehicle:setNeedPartsUpdate(true);
end