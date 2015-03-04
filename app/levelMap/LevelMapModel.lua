import("..includes.functionUtils")

local LevelMapModel = class("LevelMapModel", cc.mvc.ModelBase)

function LevelMapModel:ctor(properties)

end

function LevelMapModel:getConfig()
	local data = getUserData()
	local group = data.currentlevel.group
	local level = data.currentlevel.level
	dump(data, "data")
	assert(group, "group is nil")
	assert(level, "level is nil")
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
	local lid1, gid1
	-- local detailTable = getConfig("config/guanqia.json")
	local recordsGroup = getRecordByKey("config/guanqia.json","groupId",gid)
	local maxLevelRecord = recordsGroup[#recordsGroup]
	local maxLevel = maxLevelRecord["levelId"]

    local recordsLevel = getRecordByKey("config/guanqia.json","levelId",1)
    local groupNum = #recordsLevel
    if gid == 0 and lid == 0 then
		return false
	elseif math.floor(lid) < lid then
		return false
	end

	if lid < maxLevel then
		lid1 = lid + 1
		return gid1,lid1
	elseif lid == maxLevel and gid < groupNum then
		gid1 = gid + 1
		lid1 = 1
		return gid1,lid1
	elseif lid == maxLevel and gid == groupNum then
		return false --后面无关卡
	end
end

function LevelMapModel:isExistNextLevel(groupId, levelId)
	
end

return LevelMapModel