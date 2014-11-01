import("..includes.functionUtils")

local ScrollViewCell = import("..includes.ScrollViewCell")

local WeaponListCell = class("listCell", ScrollViewCell)

-- local listCell = class("listCell", function()
--     return display.newScene("listCell")
-- end)

function WeaponListCell:ctor(weaponRecord)
	self:initCellUI(weaponRecord)
end

function WeaponListCell:initCellUI(weaponRecord)
	cc.FileUtils:getInstance():addSearchPath("res/WeaponList")
	local controlNode = cc.uiloader:load("gunzb_2.ExportJson")
	local weaponImg = cc.ui.UIImage.new(weaponRecord["name"]..".png")
	local weaponLayer = cc.uiloader:seekNodeByName(controlNode, "Panel_6")
	addChildCenter(weaponImg, weaponLayer)	
	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end

function WeaponListCell:onSelect( x,y )
	-- body
end

return WeaponListCell