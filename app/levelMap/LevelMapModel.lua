import("..includes.functionUtils")

local LevelMapModel = class("LevelMapModel", cc.mvc.ModelBase)

function LevelMapModel:ctor(properties)

end

function LevelMapModel:getConfig()
	local data = getUserData()
	local group = data.currentlevel.group
	local level = data.currentlevel.level
	return group,level

end

function LevelMapModel:getNextGroupAndLevel()


	return false --后门无关卡
end

return LevelMapModel