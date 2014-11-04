import("..includes.functionUtils")
--[[--

“武器库”类

]]

local WeaponListModel = class("WeaponListModel", cc.mvc.ModelBase)

function WeaponListModel:ctor(properties)

end

function WeaponListModel:getWeaponRecord(index)
	local WeaponRecord = getConfigByID("config/weapon.json", index)
	return WeaponRecord
end

return WeaponListModel