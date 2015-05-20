local BossModeConfigs = class("BossModeConfigs", cc.mvc.ModelBase)

local BossConfigs = {}

BossConfigs["chapter1"] = {
	name = "BOSS竞技场",
	desc = "挑战胜利后获得极品武器、医疗包、手雷及大量金币奖励！",
	weaponId = 9,
	weaponSkill = "麒麟之怒",
	reward1 = {{part = 1},{healthBag = 1},{lei = 5},{money = 20000}},
	reward2 = {{part = 1},{healthBag = 1},{lei = 5},{money = 20000}},
	reward3 = {{part = 1},{healthBag = 1},{lei = 10},{money = 30000}},
	reward4 = {{part = 1},{healthBag = 1},{lei = 10},{money = 30000}},
	reward5 = {{part = 1},{healthBag = 5},{lei = 20},{money = 50000}},
}


function BossModeConfigs.getConfig(chapterIndex)
	assert(chapterIndex,"chapterIndex is nil")
	local chapterConfig = BossConfigs["chapter"..chapterIndex]
	return chapterConfig
end

function BossModeConfigs.getConfigs()
	return BossConfigs
end

return BossModeConfigs