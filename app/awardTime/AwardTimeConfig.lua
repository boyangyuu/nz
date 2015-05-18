local AwardTimeConfig = class("AwardTimeConfig", cc.mvc.ModelBase)

local configs = {}

award = {	
	{time = 60 * 1, money = 500},
	{time = 60 * 3, money = 1000},
	{time = 60 * 6, money = 1500},
	{time = 60 * 10, money = 2000},
	{time = 60 * 20, money = 2500},
	{time = 60 * 30, money = 3000},
}

function AwardTimeConfig.getConfig(id)
	local config = award[id]
	return config
end

function AwardTimeConfig.getAwardNum()
	local num = #award
	return num
end

return AwardTimeConfig