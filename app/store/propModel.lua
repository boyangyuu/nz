import("..includes.functionUtils")

local PropModel = class("PropModel", cc.mvc.ModelBase)

function PropModel:ctor(properties, events, callbacks)
	PropModel.super.ctor(self, properties)
end

function PropModel:getPropNum(nameid)
	print(nameid)
	local data = getUserData()
	local prop = data.prop[nameid]
	local propnum = prop.num
	return propnum
end

function PropModel:buyProp(nameid)
	local data = getUserData()
	local prop = data.prop[nameid]
	local propnum = prop.num + 5
	data.prop[nameid].num = propnum
    setUserData(data)
    dump(GameState.load())
end

return PropModel