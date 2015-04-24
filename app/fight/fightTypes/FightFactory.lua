
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

	fightType = property.fightType or "level"
	assert(fightType == "boss" or fightType == "pk" or fightType == "level")
	self.fightType = fightType

	if self.fightType == "level" then 
		self.fightInstance = LevelFight.new()
	elseif self.fightType == "boss" then 
		self.fightInstance = BossFight.new()
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