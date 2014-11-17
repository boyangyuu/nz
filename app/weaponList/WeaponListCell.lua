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
	local controlNode = cc.uiloader:load("gunzb_2.json")
	local weaponImg = cc.ui.UIImage.new(weaponRecord["imgName"]..".png")
	weaponImg:setLayoutSize(250, 100)
	local weaponLayer = cc.uiloader:seekNodeByName(controlNode, "Panel_6")
	local weaponName = cc.uiloader:seekNodeByName(controlNode, "label_name")
	self.weaponSelect = cc.uiloader:seekNodeByName(controlNode, "panl_gunbkhl")
	self.weaponCover = cc.uiloader:seekNodeByName(controlNode, "panl_gundi")
	self.weaponSelect:setVisible(false)
	addChildCenter(weaponImg, weaponLayer)
	weaponName:setString(weaponRecord["name"])	
	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end
function WeaponListCell:setSelected(isSelected)
	if isSelected == true then
		self.weaponSelect:setVisible(true)
		self.weaponCover:setVisible(false)
	else
		self.weaponSelect:setVisible(false)
		self.weaponCover:setVisible(true)
	end
	-- seekNodeByName(parent, name)
	-- visiable
end

return WeaponListCell