import("..includes.functionUtils")

local ScrollViewCell = import("..includes.ScrollViewCell")
local Color_GRAY = cc.c3b(150, 150, 150)
local Color_YELLOW = cc.c3b(255, 195, 0)
local Color_RED = cc.c3b(255, 0, 24)

local WeaponListCell = class("listCell", ScrollViewCell)

-- local listCell = class("listCell", function()
--     return display.newScene("listCell")
-- end)

function WeaponListCell:ctor(properties)
	-- local weaponRecord = properties.weaponRecord
	self:initCellUI(properties)
end

function WeaponListCell:initCellUI(properties)
	local weaponRecord = properties.weaponRecord
	cc.FileUtils:getInstance():addSearchPath("res/WeaponList")
    local controlNode = cc.uiloader:load("cebiankuang.ExportJson")

	local weaponImg = display.newSprite("#icon_"..weaponRecord["imgName"]..".png")
	local weaponLayer = cc.uiloader:seekNodeByName(controlNode, "imgpanel")
	local weaponName = cc.uiloader:seekNodeByName(controlNode, "weapon")
	self.weaponSelect = cc.uiloader:seekNodeByName(controlNode, "select")
	self.panlwangge = cc.uiloader:seekNodeByName(self.weaponSelect, "panlwangge")
	self.panlwanggekuang = cc.uiloader:seekNodeByName(self.weaponSelect, "panlwanggekuang")
	self.panlwanggekuangtiao = cc.uiloader:seekNodeByName(self.weaponSelect, "panlwanggekuangtiao")
	self.panlwangge:setColor(Color_RED)
	self.panlwanggekuang:setColor(Color_GRAY)
	self.panlwanggekuangtiao:setColor(Color_RED)
	weaponImg:setScale(0.35)
	addChildCenter(weaponImg, weaponLayer)
	weaponName:setString(weaponRecord["name"])	
	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end

function WeaponListCell:setSelected(isSelected)
	if isSelected == true then
		self.panlwangge:setColor(Color_YELLOW)
		self.panlwanggekuang:setColor(Color_YELLOW)
		self.panlwanggekuangtiao:setColor(Color_YELLOW)

	else
		self.panlwangge:setColor(Color_RED)
		self.panlwanggekuang:setColor(Color_GRAY)
		self.panlwanggekuangtiao:setColor(Color_RED)

	end
	-- seekNodeByName(parent, name)
	-- visiable
end

return WeaponListCell