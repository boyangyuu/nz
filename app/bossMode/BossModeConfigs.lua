local BossModeConfigs = class("BossModeConfigs", cc.mvc.ModelBase)

local BossConfigs = {}

BossConfigs["chapter1"] = {
	name = "丛林野战",
	desc = "决战吧！@小骚辉",
	weaponid = 2,
	weaponName = "怒火麒麟",
	weaponSkill = "多重攻击",
	weaponSkill = "weaponSkill!!!adifgaiousgfagiuawrfvbasg",
}

BossConfigs["chapter2"] = {
	name = "野战",
	desc = "决战吧！@大骚辉",
	weaponid = 3,
	weaponName = "怒火麒麟",
	weaponSkill = "多重攻击",
	weaponSkill = "ll!!!adifgaiousgfagiuawrfvbasg",
}

BossConfigs["chapter3"] = {
	name = "丛林",
	desc = "决战吧！@老骚辉",
	weaponid = 6,
	weaponName = "怒火麒麟",
	weaponSkill = "多重攻击",
	weaponSkill = "weSkill!!!adifgaiousgfagiuawrfvbasg",
}
 
function BossModeConfigs.getConfig(chapterId)
	assert(chapterId,"chapterId is nil")
	local chapterConfig = BossConfigs["chapter"..chapterId]
	return chapterConfig
end

return BossModeConfigs