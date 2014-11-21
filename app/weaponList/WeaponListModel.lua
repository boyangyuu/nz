import("..includes.functionUtils")
--[[--

“武器库”类

]]
local WeaponListModel = class("WeaponListModel", cc.mvc.ModelBase)

WeaponListModel.REFRESHBTN_EVENT = "REFRESHBTN_EVENT"

function WeaponListModel:ctor(properties, events, callbacks)
	WeaponListModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function WeaponListModel:getWeaponRecord(index)
	local WeaponRecord = getConfigByID("config/weapon_weapon.json", index)
	return WeaponRecord
end

function WeaponListModel:getIntenlevel(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				return v["intenlevel"]
			end
		end
	end
	return 0
end

function WeaponListModel:getWeaponProperity(weaponid)
	--bullet accuracy reload damage
	local record = getRecord(getConfig("config/weapon_weapon.json"), "id", weaponid)
	local growTableName = record[1]["growTable"]
	local level = self:getIntenlevel(weaponid)
	local growtable = getConfig("config/weapon_"..growTableName..".json")
	local intenlevelData = getRecord(growtable,"level",level)
	local bulletNum = intenlevelData[1]["bulletNum"]
	local accuracy = intenlevelData[1]["accuracy"]
	local reloadTime = intenlevelData[1]["reloadTime"]
	local demage = intenlevelData[1]["demage"]
	local intenNextlevelData
	if level == 10 then
		intenNextlevelData = getRecord(growtable,"level",level)
	else
		intenNextlevelData = getRecord(growtable,"level",level+1)
	end
	local bulletNumNext = intenNextlevelData[1]["bulletNum"]
	local accuracyNext = intenNextlevelData[1]["accuracy"]
	local reloadTimeNext = intenNextlevelData[1]["reloadTime"]
	local demageNext = intenNextlevelData[1]["demage"]
	local demageMax = getRecord(growtable,"level",10)[1]["demage"]
	return bulletNum,accuracy,reloadTime,demage,bulletNumNext,
		   accuracyNext,reloadTimeNext,demageNext,demageMax
end

function WeaponListModel:buyWeapon(weaponid)
	if self:isWeaponExist(weaponid)  then
        print("已购买")
    else
    	local intensify = {weaponid = weaponid,intenlevel = 0}
	    local data = getUserData()
	    table.insert(data.weapons.bags, intensify)
	    setUserData(data)
	    dump(GameState.load())
    end 
	self:dispatchEvent({name = WeaponListModel.REFRESHBTN_EVENT})
end

function WeaponListModel:strengthen(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				if data.weapons.bags[k].intenlevel < 10 then
					--todo 成长表
					data.weapons.bags[k].intenlevel = data.weapons.bags[k].intenlevel + 1
				    setUserData(data)
			    else
			    	print("已满级")
				end
			end
		end
	end
	self:dispatchEvent({name = WeaponListModel.REFRESHBTN_EVENT})
end

function WeaponListModel:onceFull(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				if data.weapons.bags[k].intenlevel < 10 then
					data.weapons.bags[k].intenlevel = 10
					setUserData(data)
				else
			    	print("已满级")
				end
			end
		end
	end
	self:dispatchEvent({name = WeaponListModel.REFRESHBTN_EVENT})
end

function WeaponListModel:isWeaponExist(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				return true
			end
		end
	end
	return false
end

function WeaponListModel:isWeaponed(weaponid)
	local data = getUserData()
	dump(data.weapons, "data.weapons")
	if data.weapons.weaponed.bag1.weaponid == weaponid then
		return 1
	elseif data.weapons.weaponed.bag2.weaponid == weaponid then
		return 2
	else
		return 0
	end
end

function WeaponListModel:isFull(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				if data.weapons.bags[k].intenlevel == 10 then
			    	return true
				end
			end
		end
	end
	return false
end


----- weaponBag
function WeaponListModel:getGun()
	local data = getUserData()
	dump(data)
	local twoWeapon={}
	table.insert(twoWeapon,data.weapons.weaponed.bag1)
	table.insert(twoWeapon,data.weapons.weaponed.bag2)
	return twoWeapon
end

function WeaponListModel:equipBag( weaponid, index )
	local data = getUserData()
	if self:isWeaponed(weaponid) == 0 then
		for k,v in pairs(data.weapons.bags) do
			for k1,v1 in pairs(v) do
				if k1 == "weaponid" and v1 == weaponid then
					if index == 1 then
						data.weapons.weaponed.bag1 = v
					else
						data.weapons.weaponed.bag2 = v
					end
					setUserData(data)
					dump(data)
				end
			end
		end
	elseif self:isWeaponed(weaponid) == index then
		print("已装备包1")
	else
		local x = nil
		x = data.weapons.weaponed.bag1
		data.weapons.weaponed.bag1 = data.weapons.weaponed.bag2
		data.weapons.weaponed.bag2 = x
	end
	self:dispatchEvent({name = WeaponListModel.REFRESHBTN_EVENT})
	dump(data)
end




return WeaponListModel