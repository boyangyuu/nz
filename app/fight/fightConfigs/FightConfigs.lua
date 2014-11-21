local FightConfigs = class("FightConfigs", cc.mvc.ModelBase)
local p = "app.fight.FightConfigs"

function FightConfigs:ctor()
	self.hero = app:getInstance(Hero)
end

--返回当前战斗下 所有waves
function FightConfigs:getWaveConfig()
	local group = self.hero:getGroupId()
	local level = self.hero:getLevelId()
	
	local name_lua = "wave"..group.."_"..level
	local str_src = "."..name_lua
	local waveFight = require(p .. str_src)
	dump(waveFight, "waveFight")
	return waveFight
end

--[[
	@param configName : boss配置表名
]]
function FightConfigs:getBossConfig(configName)
	
end

function FightConfigs:getFocusRange()
	return 20
end

return FightConfigs