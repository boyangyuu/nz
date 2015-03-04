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

function LevelMapModel:getLevelNum(gid)
    local recordsGroup = getRecordByKey("config/guanqia.json","groupId",gid)
    local recordnum = #recordsGroup
    local maxLevel = recordsGroup[recordnum]
    local levelNum = maxLevel["levelId"]
    return levelNum
end

function LevelMapModel:getGroupNum()
    local recordsLevel = getRecordByKey("config/guanqia.json","levelId",1)
    local groupNum = #recordsLevel
    return groupNum
end

function LevelMapModel:getGroupInfo(gid)
	local groupInfo = {}
    local recordsGroup = getRecordByKey("config/guanqia.json","groupId",gid)
    for i=1, #recordsGroup do
    	local record = recordsGroup[i]
    	groupInfo[i] = record["levelId"]
    end
    return groupInfo
end

function LevelMapModel:getNextGroupAndLevel(gid, lid)
	local levelid = lid
	local groupid = gid
	-- local detailTable = getConfig("config/guanqia.json")
	local recordsGroup = getRecordByKey("config/guanqia.json","groupId",gid)
	local maxLevelRecord = recordsGroup[#recordsGroup]
	local maxLevel = maxLevelRecord["levelId"]

    local recordsLevel = getRecordByKey("config/guanqia.json","levelId",1)
    local groupNum = #recordsLevel
    if groupId == 0 and levelId == 0 then
		return false
	elseif math.floor(levelId) < levelId then
		return false
	end

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