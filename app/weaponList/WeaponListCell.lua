import("..includes.functionUtils")

local Color_GRAY = cc.c3b(150, 150, 150)
local Color_YELLOW = cc.c3b(255, 195, 0)
local Color_RED = cc.c3b(255, 0, 24)

local WeaponListCell = class("listCell",  function()
	return display.newNode()
end)

function WeaponListCell:ctor(properties)
    self.weaponListModel = md:getInstance("WeaponListModel")
    self.id = properties.weaponRecord["id"]
	self:initCellUI(properties)
end

function WeaponListCell:initCellUI(properties)
	local weaponRecord = properties.weaponRecord
	cc.FileUtils:getInstance():addSearchPath("res/WeaponList")
    local controlNode = cc.uiloader:load("cebiankuang.ExportJson")

	self.weaponImg = display.newSprite("#icon_"..weaponRecord["imgName"]..".png")
	local weaponLayer = cc.uiloader:seekNodeByName(controlNode, "imgpanel")
	self.weaponName = cc.uiloader:seekNodeByName(controlNode, "weapon")
	self.weaponSelect = cc.uiloader:seekNodeByName(controlNode, "select")
	self.panlwangge = cc.uiloader:seekNodeByName(self.weaponSelect, "panlwangge")
	self.panlwanggekuang = cc.uiloader:seekNodeByName(self.weaponSelect, "panlwanggekuang")
	self.panlwanggekuangtiao = cc.uiloader:seekNodeByName(self.weaponSelect, "panlwanggekuangtiao")
	self.panlwangge:setColor(Color_RED)
	self.panlwanggekuang:setColor(Color_GRAY)
	self.panlwanggekuangtiao:setColor(Color_RED)
	self.weaponImg:setScale(0.5)
	addChildCenter(self.weaponImg, weaponLayer)
	self.weaponName:setString(weaponRecord["name"])
	self:setOwned(self.id)
	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end

function WeaponListCell:setSelected(isSelected)
	if isSelected == true then
		self:setOpacity(255)
		self.panlwangge:setColor(Color_YELLOW)
		self.panlwanggekuang:setColor(Color_YELLOW)
		self.panlwanggekuangtiao:setColor(Color_YELLOW)
	else
		self.panlwangge:setColor(Color_RED)
		self.panlwanggekuang:setColor(Color_GRAY)
		self.panlwanggekuangtiao:setColor(Color_RED)
		self:setOwned(self.id)
	end
end

function WeaponListCell:setOwned()
	local isOwned = self.weaponListModel:isWeaponExist(self.id)
	if isOwned == false then
		self:setOpacity(130)
	else
		self:setOpacity(255)
	end
end

function WeaponListCell:setOpacity(params)
	self.weaponImg:setOpacity(params)
	self.panlwangge:setOpacity(params)
	self.panlwanggekuang:setOpacity(params)
	self.panlwanggekuangtiao:setOpacity(params)
	self.weaponName:setOpacity(params)
end



return WeaponListCell