import("..includes.functionUtils")

local FightResultModel = class("FightResultModel", cc.mvc.ModelBase)

function FightResultModel:ctor(properties)
	FightResultModel.super.ctor(self, properties)
end

function FightResultModel:getInlayrecordByID(inlayid)
	local record = getRecordByKey("config/items_xq.json", "id", inlayid)[1]
	return record
end


function FightResultModel:getRewardFall(grade)
	local giveTable = {}
	local lockTable = {}
	local itemsTable = {}
	local config = getConfig("config/inlayfall.json")
    local fightFactory =    md:getInstance("FightFactory")
    local fightModel  = fightFactory:getFight()
	local levelDetailModel = md:getInstance("LevelDetailModel")
	local weaponListModel = md:getInstance("WeaponListModel")
	local curGroup, curLevel = fightModel:getCurGroupAndLevel()
	local curRecord = levelDetailModel:getConfig(curGroup, curLevel)

	-- 武器碎片
	if curRecord["suipianid"] ~= "null" then
		local isWeaponAlreadyTogether = weaponListModel:isWeaponExist(curRecord["suipianid"])
		if isWeaponAlreadyTogether == false then
			table.insert(itemsTable,{id = curRecord["suipianid"],falltype = "suipian"})
			table.insert(giveTable,{id = curRecord["suipianid"],falltype = "suipian"})
		end
	end

	-- 狙击 & MP5
    if  curGroup == 0 and curLevel == 0 then
    	if not self:isGetAwarded(2) then
    		table.insert(itemsTable,{id = 6, falltype = "gun"}) 
		    table.insert(giveTable,{id = 2, falltype = "gun"})
			self:setAwardedId(2)
		end
    elseif curGroup == 1 and curLevel == 3 then
    	if not self:isGetAwarded(6) then
    		table.insert(itemsTable,{id = 6, falltype = "gun"}) 
		    table.insert(giveTable,{id = 6, falltype = "gun"})
			self:setAwardedId(6)
		end
	end

	-- 黄金镶嵌
	local rans = math.random(100)
	local sptable = getRecordByKey("config/inlayfall.json","type","special")
	local totals = 0
	local ran = math.random(1, 100)
	for k,v in pairs(sptable) do
		totals = totals + v["probability"]
		if totals >= rans then
			table.insert(itemsTable,{id = v["inlayid"], falltype = "inlay"})
			if grade == 6 - table.nums(lockTable) then
				table.insert(giveTable,{id = v["inlayid"], falltype = "inlay"})
			elseif ran < 5 and grade > table.nums(giveTable) then
				table.insert(giveTable,{id = v["inlayid"], falltype = "inlay"})
			elseif grade == 5 then
				table.insert(giveTable,{id = v["inlayid"], falltype = "inlay"})
			else
				table.insert(lockTable,{id = v["inlayid"], falltype = "inlay"})
			end
			break
		end
	end

	-- 普通镶嵌
	local giveNum = grade + 1 - table.nums(giveTable)
	local insertTable = {}
	local normalnum = 6 - table.nums(itemsTable)
	local index = 1
	for i=1,normalnum do
		local ran = math.random(100)
		local total = 0
		for k,v in pairs(config) do
			total = total + v["probability"]
			if total >= ran then
				insertTable = {id = v["inlayid"],falltype = "inlay"}
				table.insert(itemsTable,1,insertTable)
				if index <= giveNum then
					table.insert(giveTable,1,insertTable)
				else
					table.insert(lockTable,1,insertTable)
				end
				index = index + 1
				break
			end
		end
	end
	return giveTable,lockTable
end

function FightResultModel:getGrade(LeftPersent)
	if LeftPersent < 0.2 then
		return 3
	elseif LeftPersent < 0.6 then
		return 4
	else
		return 5
	end
end

function FightResultModel:isGetAwarded(weaponId)
	local data = getUserData()
	for k,v in pairs(data.weapons.awardedIds) do
		if data.weapons.awardedIds.isGet == nil then
			return false
		elseif data.weapons.awardedIds.isGet == weaponId then
			return true
		else
			return false
		end
	end
end

function FightResultModel:setAwardedId(weaponId)
	local data = getUserData()
	dump(data.weapons)
	data.weapons.awardedIds = {isGet = weaponId}
	setUserData(data)
	dump(data.weapons)
end

return FightResultModel