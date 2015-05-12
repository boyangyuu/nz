local JujiModeConfigs = class("JujiModeConfigs", cc.mvc.ModelBase)

local JujiConfigs = {}

award = {
	{money = 1000},
	{money = 3000},
	{money = 5000},
	{diamond = 10},
	{diamond = 20},
	{diamond = 30},
}

groupAward = {
	{{healthBag = 2},{lei = 3},{money = 65199}}, --第一关
	{{healthBag = 2},{lei = 3},{money = 65199}},
	{{healthBag = 2},{lei = 3},{money = 65199}},
	{{healthBag = 2},{lei = 3},{money = 65199}},
	{{healthBag = 2},{lei = 3},{money = 65199}},
}

function JujiModeConfigs.getConfig(groupIndex)
	assert(groupIndex,"groupIndex is nil")
	local rewardConfig = groupAward[groupIndex]
	return rewardConfig
end

function JujiModeConfigs.getAward()
	return award
end

return JujiModeConfigs