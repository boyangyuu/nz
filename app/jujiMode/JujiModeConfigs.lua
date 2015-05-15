local JujiModeConfigs = class("JujiModeConfigs", cc.mvc.ModelBase)

local JujiConfigs = {}

scoreAward = {
	{score = 10000, diamond = 500},
	{score = 8000, diamond = 200},
	{score = 6000, diamond = 50},
	{score = 4000, money = 300000},
	{score = 2000, money = 150000},
	{score = 1000, money = 50000},
}

fightAward = {
	{{healthBag = 2},{lei = 3},{money = 65199}}, --第一关奖励
	{{healthBag = 2},{lei = 3},{money = 65199}},
	{{healthBag = 2},{lei = 3},{money = 65199}},
	{{healthBag = 2},{lei = 3},{money = 65199}},
	{{healthBag = 2},{lei = 3},{money = 65199}},
}

function JujiModeConfigs.getFightAward(levelIndex)
	assert(levelIndex, "关卡id is nil")
	local rewardConfig = fightAward[levelIndex]
	return rewardConfig
end

function JujiModeConfigs.getScoreAward(awardIndex)
	assert(awardIndex, "awardIndex is nil")
	local rewardConfig = scoreAward[awardIndex]
	return rewardConfig
end

return JujiModeConfigs