
--[[--

“战斗工厂”

]]

local FightFactory = class("FightFactory", cc.mvc.ModelBase)

local LevelFight  = import(".LevelFight")
local BossFight   = import(".BossFight")
local PKFight     = import(".PKFight")   
local JujiFight   = import(".JujiFight")   

function FightFactory:ctor()
	self.fightType = nil
	self.fightInstance = nil
end

function FightFactory:refreshData(property)
	fightType = property.fightType or "levelFight"
	self.fightType = fightType
	if self.fightType == "levelFight" then 
		self.fightInstance = LevelFight.new()
	elseif self.fightType == "bossFight" then 
		self.fightInstance = BossFight.new()
	elseif self.fightType == "jujiFight" then 
		self.fightInstance = JujiFight.new()		
	else
		assert(false)
	end	
end

function FightFactory:getFight()
	return self.fightInstance
end

function FightFactory:getFightType()
	assert(self.fightType, "")
	return self.fightType
end

return FightFactory