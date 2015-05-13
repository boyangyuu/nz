local WeaponListModel = class("WeaponListModel", cc.mvc.ModelBase)

WeaponListModel.WEAPON_UPDATE_EVENT 	= "WEAPON_UPDATE_EVENT"
WeaponListModel.WEAPON_STAR_ONE_EVENT   = "WEAPON_STAR_ONE_EVENT"
WeaponListModel.WEAPON_STAR_FULL_EVENT  = "WEAPON_STAR_FULL_EVENT"

function WeaponListModel:ctor(properties)
	WeaponListModel.super.ctor(self, properties)
	self:initConfigTable()
end

function WeaponListModel:initConfigTable()
	self.config = getConfig("config/weapon_weapon.json")
	-- dump(self.config)
end

function WeaponListModel:getWeaponRecord(index)
	local WeaponRecord = getRecordByID("config/weapon_weapon.json",index)
	-- local WeaponRecord = getRecordFromTable(self.config,
	-- 	"id", index)
	dump(WeaponRecord)
	return WeaponRecord
end

--已强化等级
function WeaponListModel:getIntenlevel(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		if v.weaponid == weaponid then
			return v["intenlevel"]
		end
	end
	return 0
end

function WeaponListModel:getWeaponNameByID(weaponid)
	local record = getRecordByKey("config/weapon_weapon.json", "id", weaponid)
	local WeaponName = record[1]["name"]
	return WeaponName
end

function WeaponListModel:getWeaponImgByID(weaponid)
	local record = getRecordByKey("config/weapon_weapon.json", "id", weaponid)
	local imgName = record[1]["imgName"]
	return imgName
end

--[[
	@param : weaponid
	@param : levelParam ("nextLevel" or "maxLevel" or "minLevel", nil)
	
	@return: {bulletNum = 100,accuracy  = 100,reloadTime = 100,demage = 100 }
]]
function WeaponListModel:getWeaponProperity(weaponid, levelParam)
	--bullet accuracy reload damage
	local record = getRecordByKey("config/weapon_weapon.json", "id", weaponid)
	local growTableName = record[1]["growTable"]
	local level
	if levelParam == nil then
		level = self:getIntenlevel(weaponid)
	elseif levelParam == "nextLevel" then
		level = self:getIntenlevel(weaponid)
		if level == 10 then
			level = 10
		else
			level =self:getIntenlevel(weaponid)+1
		end
	elseif levelParam == "maxLevel" then
		level = 10
	elseif levelParam == "minLevel" then 
		level = 3	
	end
	local growtableStr = "config/weapon_"..growTableName..".json"
	local intenlevelData = getRecordByKey(growtableStr,"level",level)[1]
	local bulletNum = intenlevelData["bulletNum"]
	local accuracy = intenlevelData["accuracy"]
	local reloadTime = intenlevelData["reloadTime"]
	local demage = intenlevelData["demage"]
	local upgradecost = intenlevelData["cost"]
	local property = {bulletNum = bulletNum,accuracy  = accuracy,reloadTime = reloadTime,
		demage = demage,upgradecost = upgradecost}
	return property
end

function WeaponListModel:buyWeapon(weaponid)
	if self:isWeaponExist(weaponid)  then
        print("已拥有")
    else
    	local intensify = {weaponid = weaponid,intenlevel = 0}
	    local data = getUserData()
	    table.insert(data.weapons.bags, intensify)
	    setUserData(data)
    end
    self:refreshData()
end

function WeaponListModel:intensify(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		if v.weaponid == weaponid then
			if data.weapons.bags[k].intenlevel < 10 then
				--todo 成长表
				data.weapons.bags[k].intenlevel = data.weapons.bags[k].intenlevel + 1
			    setUserData(data)
		    else
		    	print("已满级")
			end
		end
	end
	self:refreshData()
	self:dispatchEvent({name = WeaponListModel.WEAPON_STAR_ONE_EVENT})
end

function WeaponListModel:onceFull(weaponId)
	local data = getUserData()
	local lastLevel
	for k,v in pairs(data.weapons.bags) do
		if v.weaponid == weaponId then
			if data.weapons.bags[k].intenlevel < 10 then
				lastLevel = data.weapons.bags[k].intenlevel
				data.weapons.bags[k].intenlevel = 10
				setUserData(data)
			else
		    	print("已满级")
		    	lastLevel = 10
			end
		end
	end
	self:refreshData()
	self:dispatchEvent({name = WeaponListModel.WEAPON_STAR_FULL_EVENT, 
		lastLevel = lastLevel, weaponId = weaponId})
end

--isWeInBag
function WeaponListModel:isWeaponExist(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		if v.weaponid == weaponid then
			return true
		end
	end
	return false
end

function WeaponListModel:isRecomWeaponed(weaponid)
	local weaponStatus = self:getWeaponStatus(weaponid)
	if weaponStatus == 1 or weaponStatus == 2 or weaponStatus == 3 then
		return true
	else
		return false
	end
end

--[[
	return 1(in bag1), 2(in bag2), 3(in bag3), 0(not in bag)
]]
function WeaponListModel:getWeaponStatus(weaponid)
	local data = getUserData()
	-- dump(data.weapons, "data.weapons")
	if data.weapons.weaponed.bag1.weaponid == weaponid then
		return 1
	elseif data.weapons.weaponed.bag2.weaponid == weaponid then
		return 2
	elseif data.weapons.weaponed.bag3.weaponid == weaponid then
		return 3
	else
		return 0
	end
end

--isFullLevel
function WeaponListModel:isFull(weaponid)
	local data = getUserData()
	local kFullLevel = 10
	for k,v in pairs(data.weapons.bags) do
		if v.weaponid == weaponid then
			if data.weapons.bags[k].intenlevel == kFullLevel then
		    	return true
			end
		end
	end
	return false
end

----- weaponBag 
function WeaponListModel:getWeaponInBag()
	local data = getUserData()
	local threeWeapon={}
	table.insert(threeWeapon,data.weapons.weaponed.bag1)
	table.insert(threeWeapon,data.weapons.weaponed.bag2)
	if table.nums(data.weapons.weaponed.bag3) ~= 0 then
		table.insert(threeWeapon,data.weapons.weaponed.bag3)
	end
	return threeWeapon
end

function WeaponListModel:equipBag(weaponid, index)
	local isWeaponExist = self:isWeaponExist(weaponid)
	assert(isWeaponExist, "no this gun in bag:" .. weaponid)
	
	local data = getUserData()
	if self:getWeaponStatus(weaponid) == 0 then
		for k,v in pairs(data.weapons.bags) do
			if v.weaponid == weaponid then
				if index == 1 then
					data.weapons.weaponed.bag1 = v
				elseif index == 2 then
					data.weapons.weaponed.bag2 = v
				elseif index == 3 then
					data.weapons.weaponed.bag3 = v
				end
				setUserData(data)
			end
		end
	elseif self:getWeaponStatus(weaponid) == index then
		print("已装备包1")
	else
		local x = nil
		x = data.weapons.weaponed.bag1
		data.weapons.weaponed.bag1 = data.weapons.weaponed.bag2
		data.weapons.weaponed.bag2 = x
	end

	self:refreshData()
end

function WeaponListModel:refreshData()
	self:dispatchEvent({name = WeaponListModel.WEAPON_UPDATE_EVENT})
end
--[[
	@param : 
	@return: {demage = 100, }
]]
function WeaponListModel:getFightWeaponValue(configId, isHelpGun)
	local param = isHelpGun and "minLevel" or nil 
	local weaponValue = self:getWeaponProperity(configId, param) 
	assert(weaponValue, "weaponValue is nil id :"..configId)
	--cooldown
	local record = getRecordByID("config/weapon_weapon.json", configId)
	assert(record, "record is nil configId:"..configId)
	table.merge(weaponValue, record)
	return weaponValue
end

function WeaponListModel:getAllWeapon()
	self:initConfigTable()
	local weapontable = {}
	for k,v in pairs(self.config) do
		table.insert(weapontable,v["id"])
	end
	return weapontable
end

return WeaponListModel