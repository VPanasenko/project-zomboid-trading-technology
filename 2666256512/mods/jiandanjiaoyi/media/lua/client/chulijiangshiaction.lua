require "TimedActions/ISBaseTimedAction"

ISchulijiangshi = ISBaseTimedAction:derive("ISchulijiangshi");              
function ISchulijiangshi:isValid()                        
	return true
end

function ISchulijiangshi:update()                          
end

function ISchulijiangshi:start()
    self:setActionAnim("Forage")                     
end

function ISchulijiangshi:stop()                             
    ISBaseTimedAction.stop(self);
end

function ISchulijiangshi:perform()
	self.corpse:removeFromWorld()
	self.corpse:removeFromSquare()
    local bone = ZombRand(3)
    local skin = ZombRand(2)
    self.character:getInventory():AddItems("Base.zombiebone",bone)
    self.character:getInventory():AddItem("Base.st_zombiemeat")
    -- isarotten:setRotten(true)
    self.character:getInventory():AddItems("Base.zombieskin",skin)
	if ZombRand(100) > 75 then
        self.character:getInventory():AddItem("Base.zombiesstomach")
    end
	ISBaseTimedAction.perform(self);
end

function ISchulijiangshi:new(character, corpse, time)     
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time;
	o.timer = time / 5;
	o.tick = 0;
    o.corpse = corpse;
	return o;
end
