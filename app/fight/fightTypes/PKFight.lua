local Fight   = import(".Fight") 

local PKFight = class("PKFight", Fight)
function PKFight:ctor(properties)
	PKFight.super.ctor(self, properties)
end

return PKFight