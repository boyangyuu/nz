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


function LevelMapModel:getNextGroupAndLevel(gid, lid)
	local levelid = lid
	local groupid = gid
	-- local detailTable = getConfig("config/guanqia.json")
	local recordsGroup = getRecordByKey("config/guanqia.json","groupId",gid)
	local maxLevelRecord = recordsGroup[#recordsGroup]
	local maxLevel = maxLevelRecord["levelId"]

    local recordsLevel = getRecordByKey("config/guanqia.json","groupId",1)
    local groupNum = #recordsLevel
	if lid < maxLevel then
		levelid = levelid + 1
		return groupid,levelid
	elseif lid == maxLevel and gid < groupNum then
		groupid = groupid + 1
		levelid = 1
		return groupid,levelid
	elseif lid == maxLevel and gid == groupNum then
		return false --后面无关卡
	end
end

return LevelMapModel