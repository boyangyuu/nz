--[[
	读取关卡配置信息
	读取enemy配置信息
]]
local Hero = import("..Hero")


local FightConfigs = class("FightConfigs", cc.mvc.ModelBase)

local p = "app.fight.fightConfigs"

function FightConfigs:ctor(properties)
	FightConfigs.super.ctor(self, properties)

end

--返回当前战斗下 所有waves
function FightConfigs:getWaveConfig()
	self.hero = app:getInstance(Hero)
	local group = self.hero:getGroupId()
	local level = self.hero:getLevelId()
	
	local name_lua = "wave"..group.."_"..level
	local str_src = "."..name_lua
	local waveFight = require(p .. str_src)
	waveFight = require(p..".waveExample") -- todotest
	dump(waveFight, "waveFight")
	return waveFight
end

--[[
	@param configName : boss配置表名
	@return boss的固定配置(boss分为固定配置和关卡配置)
]]
function FightConfigs:getBossConfig(configName)
	self.hero = app:getInstance(Hero)
	local group = self.hero:getGroupId()
	local level = self.hero:getLevelId()

	local name_lua = configName
	local str_src = "."..name_lua
	local config = require(p..str_src)
	-- dump(config, "getBossConfig")	
	return config
end

function FightConfigs:getFocusRange()
	return 20
end

return FightConfigs