import("..includes.functionUtils")
--[[--

“关卡详情”类

]]

local LevelDetailModel = class("LevelDetailModel", cc.mvc.ModelBase)

function LevelDetailModel:ctor(properties)

end

function LevelDetailModel:getConfig(BigID,SmallID)
	local config = getConfig("config/levelDetail.json")
	local records = getRecord(config,"daguanqia",BigID)
	for k,v in pairs(records) do
		for k1,v1 in pairs(v) do
			if k1 == "xiaoguanqia" and v1==SmallID then
				dump(v)
				return v
			end
		end	
	end
	return nil
end

function LevelDetailModel:levelPass()
	local data = getUserData()
	local group = data.currentlevel.group
	local level = data.currentlevel.level
	local detailTable = getConfig("config/levelDetail.json")
	local recordsGroup = getRecord(detailTable,"daguanqia",group)
	local maxLevelRecord = recordsGroup[#recordsGroup]
	local maxLevel = maxLevelRecord["xiaoguanqia"]

    local recordsLevel = getRecord(detailTable,"xiaoguanqia",1)
    local groupNum = #recordsLevel
	if level < maxLevel then
		data.currentlevel.level = level + 1
	elseif level == maxLevel and group < groupNum then
		--todo
		data.currentlevel.group = group + 1
		data.currentlevel.level = 1
	end
	setUserData(data)
	dump(GameState.load())
end

return LevelDetailModel