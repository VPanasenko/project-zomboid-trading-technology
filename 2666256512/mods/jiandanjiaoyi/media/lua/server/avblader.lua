blade = {}
blade.Create = {}
blade.Init = {}
function blade.Create.blader(vehicle, part)
	part = vehicle:getPartById("heliblade")
    part:setModelVisible("blade1", true)
	part:setModelVisible("blade2", false)
    part:setModelVisible("blade3", false)
    part:setModelVisible("blade4", false)
    part:setModelVisible("blade5", false)
    part:setModelVisible("blade6", false)
    part:setModelVisible("blade7", false)
    part:setModelVisible("blade8", false)
end
function blade.Init.blader(vehicle, part)
	part = vehicle:getPartById("heliblade")
    part:setModelVisible("blade1", true)
	part:setModelVisible("blade2", false)
    part:setModelVisible("blade3", false)
    part:setModelVisible("blade4", false)
    part:setModelVisible("blade5", false)
    part:setModelVisible("blade6", false)
    part:setModelVisible("blade7", false)
    part:setModelVisible("blade8", false)
end