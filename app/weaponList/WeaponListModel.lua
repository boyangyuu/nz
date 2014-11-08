import("..includes.functionUtils")
--[[--

“武器库”类

]]

local WeaponListModel = class("WeaponListModel", cc.mvc.ModelBase)

function WeaponListModel:ctor(properties, events, callbacks)
	WeaponListModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function WeaponListModel:getWeaponRecord(index)
	local WeaponRecord = getConfigByID("config/weapon.json", index)
	return WeaponRecord
end

function WeaponListModel:buyWeapon(weaponrecord)
	-- self:dispatchEvent({name = "BUYWEAPON_EVENT",weaponID = weaponID})
	if self:isWeaponExist(weaponrecord)  then
        print("已购买")
    else
    	local intensify = {weaponid = weaponrecord["id"],intenlevel = 1}
	    local data = getUserData()
	    table.insert(data.weapons.bags, intensify)
	    setUserData(data)
	    dump(GameState.load())
    end 
end

function WeaponListModel:isWeaponExist(weaponrecord)
	for k,v in pairs(getUserData().weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponrecord["id"] then
				return true
			end
		end
	end
	return false
end

return WeaponListModel