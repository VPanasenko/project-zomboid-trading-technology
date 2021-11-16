function Recipe.OnCreate.shezhikongtoudidian(items, result, player)
    if getGameTime():getModData().shuaguaiweizhi == nil then
        getGameTime():getModData().shuaguaiweizhi = {0,0,0}
    end
    getGameTime():getModData().jiuxv = 1
    local a = player:getCurrentSquare():getX()
    local b = player:getCurrentSquare():getY()
    local c = player:getCurrentSquare():getZ()
    getGameTime():getModData().shuaguaiweizhi[1] = a
    getGameTime():getModData().shuaguaiweizhi[2] = b
    getGameTime():getModData().shuaguaiweizhi[3] = c
    player:Say(getText("IGUI_shuaguaiweizhi") .. tostring(a)..",".. tostring(b).."," ..tostring(c))
end




function Recipe.OnTest.toufangjianshi(sourceItem, result)
    if getGameTime():getModData().jiuxv == 1 then
        return true
    end

end

function Recipe.OnCreate.toufangjianshi(items, result, player)
    getGameTime():getModData().jiuxv = 0
    local bbb = {}
    for i = 1,3 do
        bbb[i] = getGameTime():getModData().shuaguaiweizhi[i]
    end
    for i=1,5 do
        addZombieSitting(bbb[1],bbb[2],bbb[3])
    end
end
function Recipe.OnTest.qingqiqiucishu(sourceItem, result)
    if getGameTime():getModData().qingqiqiucishu == nil then
        getGameTime():getModData().qingqiqiucishu = 0
    end
    if getGameTime():getModData().qingqiqiucishu < 5 then
        return true
    end

end

function Recipe.OnCreate.qingqiqiucishu(items, result, player)
    if getGameTime():getModData().qingqiqiucishu == nil then
        getGameTime():getModData().qingqiqiucishu = 0
    end
    getGameTime():getModData().qingqiqiucishu = getGameTime():getModData().qingqiqiucishu + 1
end
