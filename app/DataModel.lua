local DataModel = class("DataModel", cc.mvc.ModelBase)

function DataModel:ctor()
    DataModel.super.ctor(self) 
end

function DataModel:fillData()
	local data = getUserData()
    dump(data)
	if data.versionId ~= "1.1.1" then
		print("unmatch")
        self:setNewData()
    else
        print("match")
	end
end

function DataModel:setNewData()
    local data = getUserData()

    --版本
    data.versionId = "1.1.1"

    --用户等级
    -- local group = data.currentlevel.group
    -- local level = data.currentlevel.level
    -- local levelDetailModel = md:getInstance("LevelDetailModel")
    -- local levelRecord = levelDetailModel:getConfig(group,level)
    -- data.user = {level = levelRecord["userLevel"]}

    -- --引导fillData
    -- local guideModel = md:getInstance("Guide")
    -- guideModel:fillData()
    -- setUserData(data)
    -- dump(data)
end

return DataModel