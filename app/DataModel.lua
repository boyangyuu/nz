local DataModel = class("DataModel", cc.mvc.ModelBase)

function DataModel:ctor()
    DataModel.super.ctor(self) 
end

function DataModel:checkData()
	local data = getUserData()
    -- dump(data)
	if data.versionId ~= __versionId then
		print(" function DataModel:checkData() unmatch!!!!!!!")
        self:setNewData()
    else
        print("match")
	end
end

function DataModel:setNewData()
    local data = getUserData()

    --版本
    data.versionId = __versionId

    --用户等级
    data.user = {level = 1, 
    fightedGroupId = 0, 
    fightedlevelId = 0}

    data.weapons.awardedIds = {}

    --引导
    local guideModel = md:getInstance("Guide")
    guideModel:fillData()
    setUserData(data)
end

return DataModel