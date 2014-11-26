import("..includes.functionUtils")

local StoreModel = class("StoreModel", cc.mvc.ModelBase)

function StoreModel:ctor(properties, events, callbacks)
	StoreModel.super.ctor(self, properties)
end

function StoreModel:getInlayConfigTable()
	local config = getConfig("config/items_xq.json")
	local newTable = self:orderByGold(config)
	return newTable
end

function StoreModel:getPropConfigTable()
	local config = getConfig("config/items_fight.json")
	return config
end

function StoreModel:orderByGold(configtable)
	local gold = {}
	local silver = {}
	local bronze = {}
	local general = {}
	for k,v in pairs(configtable) do
		if v["property"] == "gold" then
			table.insert(gold, v)
		elseif v["property"] == "silver" then
			table.insert(silver, v)
		elseif v["property"] == "bronze" then
			table.insert(bronze, v)
		elseif v["property"] == "general" then
			table.insert(general, v)
		end
	end
	local newTable = {}
	for k,v in pairs(gold) do
		table.insert(newTable, v)
	end
	for k,v in pairs(silver) do
		table.insert(newTable, v)
	end
	for k,v in pairs(bronze) do
		table.insert(newTable, v)
	end
	for k,v in pairs(general) do
		table.insert(newTable, v)
	end
	return newTable
end

return StoreModel