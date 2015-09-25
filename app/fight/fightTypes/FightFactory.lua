
--[[--

“战斗工厂”

]]

local FightFactory = class("FightFactory", cc.mvc.ModelBase)

local LevelFight  = import(".LevelFight")
local BossFight   = import(".BossFight")
local NormalFight   = import(".NormalFight")
local PKFight     = import(".PKFight")
local JujiFight   = import(".JujiFight")

function FightFactory:ctor()
	self.fightType = nil
	self.fightInstance = nil
end

function FightFactory:refreshData(fightData)
    local isContinue = fightData["isContinue"]
    if isContinue then return end

	self.fightInstance = nil
	local fightType = fightData.fightType or "levelFight"
	self.fightType = fightType
	if self.fightType == "levelFight" then
		self.fightInstance = LevelFight.new(fightData)
	elseif self.fightType == "bossFight" then
		self.fightInstance = BossFight.new(fightData)
	elseif self.fightType == "jujiFight" then
		self.fightInstance = JujiFight.new(fightData)
	elseif self.fightType == "normalFight" then
		self.fightInstance = NormalFight.new(fightData)
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