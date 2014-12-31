
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
	
	self.isJu = false

	self:refreshFocus()

    --event
    cc.EventProxy.new(self.hero, self)
		 :addEventListener(self.hero.GUN_SWITCH_JU_EVENT, handler(self, self.switchJu))
		 :addEventListener(self.hero.GUN_RELOAD_EVENT, handler(self, self.stopFire))
		 :addEventListener(self.hero.GUN_CHANGE_EVENT, handler(self, self.refreshFocus))
	
	local inlay = md:getInstance("FightInlay")
	cc.EventProxy.new(inlay, self)
		:addEventListener(inlay.INLAY_GOLD_BEGIN_EVENT, handler(self, self.refreshFocus))
end

function FocusView:refreshFocus(event)
	--clear
	print("function FocusView:refreshFocus(event)")
	if self.armature then
		self.armature:removeFromParent()
	end

	if self.focusRange then 
		self.focusRange:removeFromParent()
	end

	--data
	self.playIndex = "stand"
	local gun = self.hero:getGun()

	--armature
	local config =  gun:getConfig()
	-- dump(config, "self FocusView config")
	local focusName = config.focusName
    self.armature = ccs.Armature:create(focusName) 
    self.armature:setAnchorPoint(0.5,0.5)
	self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
	self:addChild(self.armature)

	--range
	local isGold = md:getInstance("FightInlay"):getIsActiveGold()
	local scale  = isGold and config.goldRangeScale or 1.0
	local h = config.rangeHigh * scale
	local w = config.rangeWidth * scale
	self:setFocusRange(cc.size(w, h))
	
	self:playIdle()
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

    self.focusRange = display.newScale9Sprite()
    self.focusRange:setContentSize(size)
    addChildCenter(self.focusRange, self)

    drawBoundingBox(nil, self.focusRange, cc.c4f(1.0, 0.0, 0, 1.0))
end

function FocusView:getFocusRange()
	return self.focusRange
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
	if self.focusRange then 
		self.focusRange:removeFromParent()
	end

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