

local LevelMapModel = class("LevelMapModel", cc.mvc.ModelBase)

function LevelMapModel:ctor(properties, events, callbacks)
	LevelMapModel.super.ctor(self, properties)

end

function LevelMapModel:getConfig()
	local data = getUserData()
	local group = data.currentlevel.group
	local level = data.currentlevel.level
	assert(group, "group is nil")
	assert(level, "level is nil")
	return group,level
end

function LevelMapModel:getLevelNum(gid)
    local recordsGroup = getRecordByKey("config/guanqia.json","groupId",gid)
    local recordnum = #recordsGroup
    return recordnum
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
	assert(gid, "groupId")
	assert(lid, "levelId")

	local lid1, gid1
	local recordsGroup = getRecordByKey("config/guanqia.json","groupId",gid)
	local maxLevelRecord = recordsGroup[#recordsGroup]
	local maxLevel = maxLevelRecord["levelId"]

    local recordsLevel = getRecordByKey("config/guanqia.json","levelId",1)
    local groupNum = #recordsLevel

	if lid < maxLevel then
		lid1 = lid + 1
		gid1 = gid

		assert(gid1, "groupId")
		assert(lid1, "levelId")
		return gid1,lid1
	elseif lid == maxLevel and gid < groupNum then
		gid1 = gid + 1
		lid1 = 1
		return gid1,lid1
	end
end

function LevelMapModel:isCurGroupAndLevel(groupId,levelId)
	if self:isExistNextLevel(groupId,levelId) then
		local curGroupId,curLevelId = self:getNextGroupAndLevel(groupId,levelId)
		local curGroupId1,curLevelId1 = self:getConfig()
		if curGroupId == curGroupId1 and curLevelId == curLevelId1 then
			return true
		else
			return false
		end
	else
		return false		
	end
end

function LevelMapModel:isExistNextLevel(groupId, levelId)
	assert(groupId, "groupId")
	assert(levelId, "levelId")

	local recordsGroup = getRecordByKey("config/guanqia.json","groupId",groupId)
	local maxLevelRecord = recordsGroup[#recordsGroup]
	local maxLevel = maxLevelRecord["levelId"]

    local recordsLevel = getRecordByKey("config/guanqia.json","levelId",1)
    local groupNum = #recordsLevel

	if math.floor(levelId) < levelId then
		return false
	elseif groupId == 0 and levelId == 0 then
		return false
	elseif levelId == maxLevel and groupId == groupNum then
		return false --后面无关卡
	else
		return true
	end	
end

function LevelMapModel:hideGiftBagIcon()
	self:dispatchEvent({name = "HIDE_GIFTBAGICON_EVENT"})
end

function LevelMapModel:levelPass(groupId,levelId)
	assert(groupId, "groupId")
	assert(levelId, "levelId")
	local data = getUserData()
	local curGroupId = data.currentlevel.group
	local curLevelId = data.currentlevel.level

	local isOpenNext = groupId == curGroupId and levelId == curLevelId 	
	

	if groupId == 0 and levelId == 0 then
		return	
	elseif math.floor(levelId) < levelId then
		return

	--开启关卡
	elseif isOpenNext then
		if self:isExistNextLevel(groupId, levelId) then
			local nextgroup,nextlevel = self:getNextGroupAndLevel(groupId, levelId)

			--save user level
			local levelDetailModel = md:getInstance("LevelDetailModel")
			local levelRecord = levelDetailModel:getConfig(curGroupId,curLevelId)
			local userModel = md:getInstance("UserModel")
			userModel:setUserLevel(levelRecord["userLevel"])

			--save 关卡进度
			data.currentlevel.group = nextgroup
			data.currentlevel.level = nextlevel
			setUserData(data)	
		else
			print("通关")
		end
	end
end

return LevelMapModel