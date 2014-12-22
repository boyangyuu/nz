


local scheduler = require("framework.scheduler")
local Hero 		= import(".Hero")
local Fight 	= import(".Fight")

local InfoLayer = class("InfoLayer", function()
    return display.newLayer()
end)

function InfoLayer:ctor()
	--instance
	self.hero 	= md:getInstance("Hero")
	self.weaponModel = md:getInstance("WeaponListModel")

	cc.EventProxy.new(self.hero, self)
		:addEventListener(Hero.GUN_CHANGE_EVENT		, handler(self, self.onRefreshGun))
		:addEventListener(Hero.GUN_BULLET_EVENT 	, handler(self, self.onRefreshBullet))	

	self:loadCCS()
end

function InfoLayer:loadCCS()
	self.root = cc.uiloader:load("res/Fight/fightLayer/ui/infoUI.ExportJson")
	self:addChild(self.root)
	
	self:initGun()
	self:initBullet()
end

function InfoLayer:initGun()
	self.gunDisplay		= cc.uiloader:seekNodeByName(self.root, "gunDisplay")
	self:onRefreshGun({bagIndex = "bag1"})
end

function InfoLayer:initBullet()
	self.labelBulletNum = cc.uiloader:seekNodeByName(self.root, "labelBulletNum")	
	local record = self.weaponModel:getFightWeaponValue("bag1")
	self.labelBulletNum:setAnchorPoint(cc.p(0.5, 0.5))
	self:onRefreshBullet({num = record["bulletNum"]})
end

function InfoLayer:onRefreshGun(event)
	self.gunDisplay:removeAllChildren()
	local bagIndex = event.bagIndex
	local record = self.weaponModel:getFightWeaponValue(bagIndex)
	local icon = display.newSprite("#icon_"..record["imgName"]..".png")
	icon:setScaleX(0.05)
	icon:setScaleY(0.05)
	icon:scaleTo(0.30, 0.20)
	addChildCenter(icon, self.gunDisplay)
end

function InfoLayer:onRefreshBullet(event)
	local num = event.num
	assert(num, "num is nil") 

	self.labelBulletNum:setString(num)
	-- self.labelBulletNum:setScale(0.5)
	-- self.labelBulletNum:runAction(cc.Sequence:create(
	-- 	cc.ScaleBy:create(0.02, 1.3), 
	-- 	cc.ScaleTo:create(0.02, 1.0)))
end

return InfoLayer