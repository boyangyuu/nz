--[[
	读取关卡配置信息
	读取enemy配置信息
]]


local FightConfigs = class("FightConfigs", cc.mvc.ModelBase)

local p = "app.fight.fightConfigs"

--战斗常量

function FightConfigs:ctor(properties)
	FightConfigs.super.ctor(self, properties)
end

--返回当前战斗下 所有waves
function FightConfigs:getWaveConfig()
	self.fight = md:getInstance("Fight")
	local group = self.fight:getGroupId()
	local level = self.fight:getLevelId()
	
	local name_lua = "wave"..group.."_"..level
	local str_src = "."..name_lua
	local waveFight = require(p .. str_src).new()
	waveFight = require(p..".waveExample").new()
	return waveFight
end

--[[
	@param configName : boss配置表名
	@return boss的固定配置(boss分为固定配置和关卡配置)
]]
function FightConfigs:getBossConfig(configName)
	self.fight = md:getInstance("Fight")
	local group = self.fight:getGroupId()
	local level = self.fight:getLevelId()

	local name_lua = "wave"..group.."_"..level
	local str_src = "."..name_lua
	local config = require(p..str_src)
	dump(config, "getBossConfig")	
	return config
end

function FightConfigs:getFocusRange()
	return 20
end

return FightConfigs