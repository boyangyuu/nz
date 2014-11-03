import("..includes.functionUtils")
--[[--

“武器库”类

]]

local WeaponListModel = class("WeaponListModel", cc.mvc.ModelBase)

function WeaponListModel:ctor(properties)

end

function WeaponListModel:getConfig()
	getConfig("config/4.json")
end

return WeaponListModel