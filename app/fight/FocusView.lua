
--[[--

“准星”的视图

]]

--import
import("..includes.functionUtils")
local scheduler = require("framework.scheduler")
local FightConfigs = import(".fightConfigs.FightConfigs")
local Gun = import(".Gun")

local FocusView = class("FocusView", function()
	local node = display.newNode()
	node:setAnchorPoint(0.5,0.5)
    return node
end)

function FocusView:ctor(properties)
	--instance
	self.hero = md:getInstance("Hero")
	self.gun = self.hero:getGun()
	self.isJu = false

	--focus
	local gunId = 1   -- todo 外界传 Gun
	local focusId = gunId + 11
    local src = "Fight/focusAnim/anim_zunxin_sq/anim_zunxin_sq.ExportJson"
    self.armature = getArmature("anim_zunxin_sq", src) 
    self.armature:setAnchorPoint(0.5,0.5)
	
    --都配在武器表里 
	self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
	self:addChild(self.armature) 
	self:playIdle()
	local range = FightConfigs:getFocusRange() --todo 不要 fightConfigs 需要根据枪表来设置
	self:setFocusRange(cc.size(range, range))
	self.playIndex = "stand"

    -- test
    self:test()

    --event
     cc.EventProxy.new(self.hero, self)
		 :addEventListener(self.hero.GUN_SWITCH_JU_EVENT, handler(self, self.switchJu))
		 :addEventListener(self.hero.GUN_RELOAD_EVENT, handler(self, self.stopFire))
end

function FocusView:playIdle()
	self.playIndex = "stand"
	self.armature:getAnimation():play("stand" , -1, 1) 
end

function FocusView:playFire()
	if self.playIndex == "stand" then 
		self.armature:getAnimation():play("fire01" , -1, 1) 
		self.playIndex = "fire01"
	elseif self.playIndex == "fire01" or self.playIndex == "fire02" then 
		-- print("fire02")
		self.armature:getAnimation():play("fire02" , -1, 1) 
		self.playIndex = "fire02"
	end
end

function FocusView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		if id == "fire01" then
			
    	elseif id == "fire02" then

    	end
	end
end

function FocusView:stopFire()
	-- print("FocusView:stopFire()")
	self:playIdle()
end

function FocusView:setFocusRange(size)
	if self.focusRange then 
		self.focusRange:removeFromParent()
	end
    self.focusRange = display.newScale9Sprite()
    self.focusRange:setContentSize(size)
    addChildCenter(self.focusRange, self)
end

function FocusView:getFocusRange()
	return self.focusRange
end

function FocusView:test()
    drawBoundingBox(self, self.focusRange, cc.c4f(1.0, 0.0, 0, 1.0))
end

--狙击
function FocusView:switchJu(event)
	self.isJu = not self.isJu
	if self.isJu then 
		self:addJu()
	else
		self:removeJu()
	end
end

function FocusView:addJu()
	print("FocusView:addJu()")

	--zoom
	local destWorldPos = self:convertToNodeSpace(cc.p(0, 0))
	local scale = FightConfigs.kJuRange
	local time = 0.1
	self.hero:dispatchEvent({name = Hero.MAP_ZOOM_OPEN_EVENT,
		 destWorldPos = destWorldPos,
		 scale = scale, 
		 time = time})

	--add ju
	if self.juNode == nil then 
		self.juNode = cc.uiloader:load("res/Fight/fightLayer/gun_ju/ju.ExportJson")
		self.juNode:setAnchorPoint(0.5, 0.5)
		addChildCenter(self.juNode, self)
	end

	--hide
	self.armature:setVisible(false)
	self:setFocusRange(cc.size(5.0 , 5.0))
	self:test()
end

function FocusView:removeJu()
	print("FocusView:removeJu()")

	--zoom
	local time = 0.1
	self.hero:dispatchEvent({name = Hero.MAP_ZOOM_RESUME_EVENT,
		 time = time})
	
	--remove ju	
	self.juNode:removeFromParent()
	self.juNode = nil

	--hide
	self.armature:setVisible(true)
end

return FocusView