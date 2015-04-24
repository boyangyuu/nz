local Fight   = import(".Fight") 

local LevelFight = class("LevelFight", Fight)
function LevelFight:ctor(properties)
	LevelFight.super.ctor(self, properties)
end

return LevelFight