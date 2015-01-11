import("..includes.functionUtils")

local PropModel = class("PropModel", cc.mvc.ModelBase)

function PropModel:ctor(properties, events, callbacks)
	PropModel.super.ctor(self, properties)
end

function PropModel:getPropNum(nameid)
	local data = getUserData()
	local prop = data.prop[nameid]
	local propnum = prop.num
	return propnum
end

function PropModel:buyProp(nameid,buyNum)
	local data = getUserData()
	local prop = data.prop[nameid]
	local propnum = prop.num + buyNum
	data.prop[nameid].num = propnum
    setUserData(data)
end

function PropModel:costProp(nameid,costNum)
	local data = getUserData()
	local prop = data.prop[nameid]
	local propnum = prop.num - costNum
	data.prop[nameid].num = propnum
	setUserData(data)
    if device.platform == "android" then
        cc.UMAnalytics:use(nameid, costNum, 0)   
    end 

end


return PropModel