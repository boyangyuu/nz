import("..includes.functionUtils")

local StoreModel = class("StoreModel", cc.mvc.ModelBase)

function StoreModel:ctor(properties, events, callbacks)
	StoreModel.super.ctor(self, properties)
	self:initConfigTable()
end

function StoreModel:initConfigTable()
	self.xqconfig = getConfig("config/items_xq.json")
	self.bankconfig = getConfig("config/items_bank.json")
	self.fightconfig = getConfig("config/items_fight.json")
end

function StoreModel:getConfigTable(type)
	local newTable = {}
	if type == "prop" then
		newTable = self.fightconfig
	elseif type == "bank" then
		newTable = self.bankconfig
	elseif type == "inlay" then
		 local config = self.xqconfig
		newTable = self:orderByGold(config)
	end
	return newTable
end

function StoreModel:setGoldWeaponNum(goldNum)
	
	local data = getUserData()
	if data.prop.goldweapon.num == goldNum then
		return
	else
		data.prop.goldweapon.num = goldNum
	    setUserData(data)
	end
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


function StoreModel:buyDiamond()
	-- body
end

return StoreModel