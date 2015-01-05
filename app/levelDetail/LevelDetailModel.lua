import("..includes.functionUtils")
--[[--

“关卡详情”类

]]
local WeaponListModel = import("..weaponList.WeaponListModel")

local LevelDetailModel = class("LevelDetailModel", cc.mvc.ModelBase)

function LevelDetailModel:ctor(properties)
	-- self.weaponListModel = md:getInstance("WeaponListModel")
end

function LevelDetailModel:getConfig(BigID,SmallID)
	local records = getRecordByKey("config/guanqia.json","groupId",BigID)
	for k,v in pairs(records) do
		for k1,v1 in pairs(v) do
			if k1 == "levelId" and v1==SmallID then
				return v
			end
		end	
	end
	return nil
end

function LevelDetailModel:setCurGroupAndLevel(gid, lid)
	print("gid"..gid)
	self.curGroupId = gid
	self.curLevelId = lid
end

function LevelDetailModel:getCurGroupAndLevel()
	return self.curGroupId, self.curLevelId
end

function LevelDetailModel:getCurLevelType()
    local record = self:getConfig(self.curGroupId, self.curLevelId)
    assert(record, "")
    local type = record["type"]
    assert(type, "")
    return type	
end

function LevelDetailModel:isJujiFight()
    return self:getCurLevelType() == "juji"
end

function LevelDetailModel:setsuipian(weaponid)
	-- local data = getUserData()
	-- if self.weaponListModel:isWeaponExist(weaponid) then
	-- 	print("已拥有武器，你的碎片没的用")
	-- else
	-- 	if self:isBagsExistSuipian(weaponid)  then
	-- 		for k,v in pairs(data.weaponsuipian) do
	-- 			if v.weaponid == weaponid then
	-- 				data.weaponsuipian[k].number = data.weaponsuipian[k].number + 1
	-- 				if data.weaponsuipian[k].number == 5 then
	-- 					self:weapontogether(weaponid)
	-- 				end
	-- 			end
	-- 		end
	-- 	else
	-- 		local weaponsuipian = {weaponid = weaponid, number = 1}
	-- 	    table.insert(data.weaponsuipian, weaponsuipian)
	-- 	end
	--     setUserData(data)
	--     dump(GameState.load())
	-- end
end

function LevelDetailModel:isBagsExistSuipian(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weaponsuipian) do
		if v.weaponid == weaponid then
			return true
		end
	end
	return false
end

function LevelDetailModel:getSuiPianNum(weaponid)
	local data = getUserData()
	if self:isBagsExistSuipian(weaponid)  then
		for k,v in pairs(data.weaponsuipian) do
			if v.weaponid == weaponid then
				return data.weaponsuipian[k].number
			end
		end
	else
		return 0
	end
end

function LevelDetailModel:weapontogether(weaponid)
	-- local data = getUserData()
	-- for k,v in pairs(data.weaponsuipian) do
	-- 	if v.weaponid == weaponid then
	-- 		table.remove(data.weaponsuipian,k)
	-- 		self.weaponListModel:setWeapon(weaponid)
	-- 	end
	-- end
end

return LevelDetailModel