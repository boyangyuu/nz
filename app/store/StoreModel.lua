

local StoreModel = class("StoreModel", cc.mvc.ModelBase)
local JavaUtils = import("..includes.JavaUtils")

function StoreModel:ctor(properties, events, callbacks)
	StoreModel.super.ctor(self, properties)
end

function StoreModel:orderByGold(configtable)
	local gold = {}
	for k,v in pairs(configtable) do
		if v["property"] == 4 then
			table.insert(gold, v)
		end
	end
	local newTable = {}
	for k,v in pairs(gold) do
		table.insert(newTable,v)
	end
	return newTable
end

function StoreModel:equipedRobot()
	local data = getUserData()
	local propnum = data.prop.jijia.num
	if propnum == 0 then
		return false
	end
	data.prop.jijia.num = propnum - 1

    setUserData(data)
    self:refreshInfo("prop")
    return true
end

function StoreModel:refreshInfo(typename)

	--todo 只需要刷新内容（bankNode）即可 
	self:dispatchEvent({name = "REFRESH_STORE_EVENT",typename = typename})
end

return StoreModel