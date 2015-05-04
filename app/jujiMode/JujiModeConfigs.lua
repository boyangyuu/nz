local BossModeConfigs = class("BossModeConfigs", cc.mvc.ModelBase)

local BossConfigs = {}

BossConfigs["chapter1"] = {
	name = "丛林野战",
	desc = "决战吧！@小骚辉",
	weaponId = 9,
	weaponSkill = "多重攻击",
}

BossConfigs["chapter2"] = {
	name = "野战",
	desc = "决战吧！@大骚辉",
	weaponId = 10,
	weaponSkill = "多重攻击",
}

BossConfigs["chapter3"] = {
	name = "丛林",
	desc = "决战吧！@老骚辉",
	weaponId = 11,
	weaponSkill = "多重攻击",
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