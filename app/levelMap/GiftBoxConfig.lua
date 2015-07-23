local GiftBoxConfig = class("GiftBoxConfig", cc.mvc.ModelBase)

local GiftBoxConfigs = {}

GiftBoxConfigs["group1"] = {
	level2 = {"a"}
}

GiftBoxConfigs["group2"] = {
	level3 = {"a"}
}

GiftBoxConfigs["group3"] = {
	level3 = {"a"}
}

GiftBoxConfigs["group4"] = {
	level3 = {"a"}
}

GiftBoxConfigs["group5"] = {
	level3 = {"a"}
}

GiftBoxConfigs["group6"] = {
	level3 = {"a"}
}

GiftBoxConfigs["group7"] = {
	level3 = {"a"}
}

GiftBoxConfigs["group8"] = {
	level3 = {"a"}
}

GiftBoxConfigs["group9"] = {
	level3 = {"a"}
}

GiftBoxConfigs["group10"] = {
	level3 = {"a"}
}

function GiftBoxConfig.getConfig(groupId,levelId)
	assert(groupId, "groupId is nil")
	assert(levelId, "levelId is nil")
	local groupIndex = "group"..groupId
	local levelIndex = "level"..levelId
	local groupDetail = GiftBoxConfigs[groupIndex]
	return groupDetail[levelIndex]
end

return GiftBoxConfig