--[[
	读取关卡配置信息
	读取enemy配置信息
]]


local FightConfigs = class("FightConfigs", cc.mvc.ModelBase)

local p = "app.fight.fightConfigs"

--战斗常量

function FightConfigs:ctor(properties)
	FightConfigs.super.ctor(self, properties)
	print("function FightConfigs:ctor(properties)")
	self:initWaveConfig()
end

--返回当前战斗下 所有waves
function FightConfigs:initWaveConfig()
    local fightFactory = md:getInstance("FightFactory")
    self.fight  = fightFactory:getFight()
	local group = self.fight:getGroupId()
	local level = self.fight:getLevelId()
    if math.floor(level) < level then
        level = tostring(level)
        level = string.gsub(level, "%.", "_")
    end
	local name_lua = "wave"..group.."_"..level
	local str_src = "."..name_lua
	self.waveConfig = require(p .. str_src).new()
	assert(self.waveConfig, "self.waveConfig is nil")
end

--返回当前战斗下 所有waves
function FightConfigs:getWaveConfig()
	assert(self.waveConfig ~= nil, "self.waveConfig is nil")
	return self.waveConfig
end

function FightConfigs.getWaveImages(gid, lid)
	print("FightConfigs:getWaveImages", lid)
    if math.floor(lid) < lid then
        lid = tostring(lid)
        lid = string.gsub(lid, "%.", "_")
    end

	local images = {}
	local name_lua = "wave"..gid.."_"..lid
	local str_src = "."..name_lua
	local waveConfig = require(p..str_src).new()
	for i,config in ipairs(waveConfig.enemys) do
		images[#images + 1] = config["image"]
	end

	if waveConfig.bosses then 
		for i,config in ipairs(waveConfig.bosses) do
			images[#images + 1] = config["image"]
		end
	end
	
	return images
end

return FightConfigs