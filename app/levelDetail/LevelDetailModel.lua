import("..includes.functionUtils")
--[[--

“关卡详情”类

]]
local WeaponListModel = import("..weaponList.WeaponListModel")

local LevelDetailModel = class("LevelDetailModel", cc.mvc.ModelBase)

function LevelDetailModel:ctor(properties)
	self.weaponListModel = app:getInstance(WeaponListModel)
end

function LevelDetailModel:getConfig(BigID,SmallID)
	local config = getConfig("config/guanqia.json")
	local records = getRecord(config,"groupId",BigID)
	for k,v in pairs(records) do
		for k1,v1 in pairs(v) do
			if k1 == "levelId" and v1==SmallID then
				dump(v)
				return v
			end
		end	
	end
	return nil
end

function LevelDetailModel:levelPass(groupId,levelId)
	local data = getUserData()
	local group = data.currentlevel.group
	local level = data.currentlevel.level
	if groupId == group and levelId ==level then
		local detailTable = getConfig("config/guanqia.json")
		local recordsGroup = getRecord(detailTable,"groupId",group)
		local maxLevelRecord = recordsGroup[#recordsGroup]
		local maxLevel = maxLevelRecord["levelId"]

	    local recordsLevel = getRecord(detailTable,"groupId",1)
	    local groupNum = #recordsLevel
		if level < maxLevel then
			data.currentlevel.level = level + 1
		elseif level == maxLevel and group < groupNum then
			--todo
			data.currentlevel.group = group + 1
			data.currentlevel.level = 1
		end
		setUserData(data)
		dump(GameState.load())
	end
end

function LevelDetailModel:setsuipian(weaponid)
	local data = getUserData()
	if self.weaponListModel:isWeaponExist(weaponid) then
		print("已拥有武器，你的碎片没的用")
	else
		if self:isBagsExistSuipian(weaponid)  then
			for k,v in pairs(data.weaponsuipian) do
				if v.weaponid == weaponid then
					data.weaponsuipian[k].number = data.weaponsuipian[k].number + 1
					if data.weaponsuipian[k].number == 5 then
						self:weapontogether(weaponid)
					end
				end
			end
		else
			local weaponsuipian = {weaponid = weaponid, number = 1}
		    table.insert(data.weaponsuipian, weaponsuipian)
		end
	    setUserData(data)
	    dump(GameState.load())
	end
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
	local data = getUserData()
	for k,v in pairs(data.weaponsuipian) do
		if v.weaponid == weaponid then
			table.remove(data.weaponsuipian,k)
			self.weaponListModel:setWeapon(weaponid)
		end
	end
end

return LevelDetailModel