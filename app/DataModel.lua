local DataModel = class("DataModel", cc.mvc.ModelBase)

function DataModel:ctor()
    DataModel.super.ctor(self) 
end

function DataModel:checkData()
	local data = getUserData()
    -- dump(data)
	if data.versionId ~= "1.1.1" then
		print(" function DataModel:checkData() unmatch!!!!!!!")
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
    data.user = {level = 1}

    --引导fillData
    local guideModel = md:getInstance("Guide")
    guideModel:fillData()
    setUserData(data)
end

return DataModel