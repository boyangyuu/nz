local BossModeConfigs = class("BossModeConfigs", cc.mvc.ModelBase)

local BossConfigs = {}

BossConfigs["chapter1"] = {
	name = LanguageManager.getStringForKey("string_hint9"),
	desc = LanguageManager.getStringForKey("string_hint10"),
	weaponId = 9,
	weaponSkill = LanguageManager.getStringForKey("string_hint11"),
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