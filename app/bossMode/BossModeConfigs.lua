local BossModeConfigs = class("BossModeConfigs", cc.mvc.ModelBase)

local BossConfigs = {}

BossConfigs["chapter1"] = {
	bossplay = "boss02_1",
	desc = "第一章",
	weaponid = 2,
}

BossConfigs["chapter2"] = {
	bossplay = "boss01_2",
	desc = "第二章",
	weaponid = 3,
}

BossConfigs["chapter3"] = {
	bossplay = "dzboss",
	desc = "第三章",
	weaponid = 4,
}
 
function BossModeConfigs.getConfig(chapterId)
	assert(chapterId,"chapterId is nil")
	local chapterConfig = BossConfigs["chapter"..chapterId]
	return chapterConfig
end

return BossModeConfigs