local PopupWeaponBag = class("PopupWeaponBag", function()
	return display.newLayer()
end)

function PopupWeaponBag:ctor()
	self:loadCCS()
end

function PopupWeaponBag:loadCCS()
    -- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/WeaponList/wuqilan")
    local controlNode = cc.uiloader:load("wuqilan_1.ExportJson")
    -- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode)
end

return PopupWeaponBag