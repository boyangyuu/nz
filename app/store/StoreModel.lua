import("..includes.functionUtils")

local StoreModel = class("StoreModel", cc.mvc.ModelBase)

function StoreModel:ctor(properties, events, callbacks)
	StoreModel.super.ctor(self, properties)
end

function StoreModel:getConfigTable(type)
	local newTable = {}
	if type == "prop" then
		newTable = getConfig("config/items_fight.json")
	elseif type == "bank" then
		newTable = getConfig("config/items_bank.json")
	elseif type == "inlay" then
		 local config = getConfig("config/items_xq.json")
		newTable = self:orderByGold(config)

	end
	return newTable
end


function StoreModel:orderByGold(configtable)
	local gold = {}
	-- local silver = {}
	-- local bronze = {}
	-- local general = {}
	for k,v in pairs(configtable) do
		if v["property"] == 4 then
			table.insert(gold, v)
		-- elseif v["property"] == "silver" then
		-- 	table.insert(silver, v)
		-- elseif v["property"] == "bronze" then
		-- 	table.insert(bronze, v)
		-- elseif v["property"] == "general" then
		-- 	table.insert(general, v)
		end
	end
	local newTable = {}
	for k,v in pairs(gold) do
		table.insert(newTable, v)
	end
	-- for k,v in pairs(silver) do
	-- 	table.insert(newTable, v)
	-- end
	-- for k,v in pairs(bronze) do
	-- 	table.insert(newTable, v)
	-- end
	-- for k,v in pairs(general) do
	-- 	table.insert(newTable, v)
	-- end
	return newTable
end


function StoreModel:buyDiamond()
	-- body
end

return StoreModel