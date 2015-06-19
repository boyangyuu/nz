import("..includes.functionUtils")

local StoreModel = class("StoreModel", cc.mvc.ModelBase)

function StoreModel:ctor(properties, events, callbacks)
	StoreModel.super.ctor(self, properties)
	self:initConfigTable()
end

function StoreModel:initConfigTable()
	self.moneyconfig = getConfig("config/items_mm.json")
	self.bankconfig = getConfig("config/items_bank.json")
	self.fightconfig = getConfig("config/items_fight.json")
	local isDX = isDefendDX()
	if isDX then
		for i,v in ipairs(self.bankconfig) do
			if v["price"] == 30 then
				table.remove(self.bankconfig,i)
			end
		end
	end
end

function StoreModel:getConfigTable(type)
	local newTable = {}
	if type == "prop" then
		newTable = self.fightconfig
	elseif type == "bank" then
		newTable = self.bankconfig
			dump(self.bankconfig)
	elseif type == "money" then
		 newTable = self.moneyconfig
		 dump(newTable)
	end
	return newTable
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
	self:dispatchEvent({name = "REFRESH_STORE_EVENT",typename = typename})
end

return StoreModel