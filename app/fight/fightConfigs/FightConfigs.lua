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
    if math.floor(level) < level then
        level = tostring(level)
        level = string.gsub(level, "%.", "_")
    end
	local name_lua = "wave"..group.."_"..level
	local str_src = "."..name_lua
	local waveFight = require(p .. str_src).new()
	-- waveFight = require(p..".waveExample").new()
	return waveFight
end

function FightConfigs:getWaveImages(gid, lid)
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

	for i,config in ipairs(waveConfig.bosses) do
		images[#images + 1] = config["image"]
	end

	return images
end

return FightConfigs