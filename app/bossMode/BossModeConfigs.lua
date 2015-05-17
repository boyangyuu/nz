local BossModeConfigs = class("BossModeConfigs", cc.mvc.ModelBase)

local BossConfigs = {}

BossConfigs["chapter1"] = {
	name = "丛林野战",
	desc = "阵地射击，战地集结的号角一触即发！",
	weaponId = 9,
	weaponSkill = "多重攻击",
	reward1 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	reward2 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	reward3 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	reward4 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	reward5 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
}

-- BossConfigs["chapter2"] = {
-- 	name = "野战",
-- 	desc = "决战吧！@大骚辉",
-- 	weaponId = 10,
-- 	weaponSkill = "多重攻击",
	-- reward1 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	-- reward2 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	-- reward3 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	-- reward4 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	-- reward5 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
-- }

-- BossConfigs["chapter3"] = {
-- 	name = "丛林",
-- 	desc = "决战吧！@老骚辉",
-- 	weaponId = 11,
-- 	weaponSkill = "多重攻击",
	-- reward1 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	-- reward2 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	-- reward3 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	-- reward4 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
	-- reward5 = {{part = 1},{healthBag = 2},{lei = 3},{money = 65199}},
-- }
 
function BossModeConfigs.getConfig(chapterIndex)
	assert(chapterIndex,"chapterIndex is nil")
	local chapterConfig = BossConfigs["chapter"..chapterIndex]
	return chapterConfig
end

function BossModeConfigs.getConfigs()
	return BossConfigs
end

return BossModeConfigs