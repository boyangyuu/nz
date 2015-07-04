local DataModel = class("DataModel", cc.mvc.ModelBase)

function DataModel:ctor()
    DataModel.super.ctor(self) 
end

function DataModel:checkData()
	local data = getUserData()
    -- dump(data)
	if data.versionId ~= __versionId then
		print(" function DataModel:checkData() unmatch!!!!!!!")
        print("data.versionId", data.versionId)
        print("__versionId", __versionId)
        self:setNewData()
    else
        print("match")
	end
end

function DataModel:setNewData()
    local data = getUserData()
    dump(data, "旧data")

    local bagsWeapon = clone(data.weapons.bags)
    local bagsInlay  = clone(data.inlay.bags)
    local money      = data.money
    local diamond    = data.diamond
    local currentlevel = data.currentlevel
    local user       = data.user

    myApp:createGameStateFile()
    local data          = getUserData()
    data.weapons.bags   = bagsWeapon
    data.inlay.bags     = bagsInlay
    data.money          = money
    data.diamond        = diamond
    data.currentlevel   = currentlevel
    data.user           = user

    --引导
    local guideModel = md:getInstance("Guide")
    guideModel:fillData()    
    
    dump(data, "新data")
    setUserData(data)
end

return DataModel