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

levelAward = {
	{healthBag = 2,lei = 3,money = 65199}, --第一关
	{healthBag = 2,lei = 3,money = 65199}, --第二关
	{healthBag = 2,lei = 3,money = 65199}, --
	{healthBag = 2,lei = 3,money = 65199},
}

function JujiModeConfigs.getConfig(chapterIndex)
	assert(chapterIndex,"chapterIndex is nil")
	local chapterConfig = JujiConfigs["chapter"..chapterIndex]
	return chapterConfig
end

function JujiModeConfigs.getConfigs()
	return JujiConfigs
end

return JujiModeConfigs