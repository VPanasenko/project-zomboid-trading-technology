Heli_spawn_points = {
    {5593, 12465},
    {5593, 12445},
    {7746, 11802},
    {12850, 6427}
}


local function spawnHeli(x, y)
    local sq = getSquare(x, y, 0)
    if sq then
        addVehicleDebug("Base.advancedhelicopter", nil, nil, sq)
    end
end

local function dist(x, y, player)
    local dx = player:getX() - x
    local dy = player:getY() - y
    local dist = math.sqrt( dx*dx + dy*dy )
    return dist
end

local function spawnHelicopters()
    local pl = getPlayer()
    if pl == nil then return end    

    for i, p in ipairs(Heli_spawn_points) do
        if pl:getModData()["SpawnedHeli"] == nil then
            pl:getModData()["SpawnedHeli"] = {}
        end 
        if pl:getModData()["SpawnedHeli"][i] == nil and dist(p[1], p[2], pl) < 100 then
            if getSquare(p[1], p[2], 0) then    
                pl:getModData()["SpawnedHeli"][i] = true
                spawnHeli(p[1], p[2])
            end
        end
    end
end

Events.EveryTenMinutes.Add(spawnHelicopters)
