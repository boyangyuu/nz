
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
	self.map = md:getInstance("Map")
	self:refreshFocus()

    --event
    cc.EventProxy.new(self.hero, self)
		 :addEventListener(self.hero.GUN_SWITCH_JU_EVENT, handler(self, self.switchJu))
		 :addEventListener(self.hero.GUN_RELOAD_EVENT, handler(self, self.stopFire))
		 :addEventListener(self.hero.GUN_CHANGE_EVENT, handler(self, self.refreshFocus))

	local robot = md:getInstance("Robot")
	cc.EventProxy.new(robot, self)
		:addEventListener(robot.ROBOT_START_EVENT	, handler(self, self.onShowRobot))
		:addEventListener(robot.ROBOT_ENDTIME_EVENT	, handler(self, self.onHideRobot))

	local inlay = md:getInstance("FightInlay")
	cc.EventProxy.new(inlay, self)
		:addEventListener(inlay.INLAY_GOLD_BEGIN_EVENT, handler(self, self.refreshFocus))
end

function FocusView:refreshFocus(event)
	--clear
	event = event or {}
	-- print("function FocusView:refreshFocus(event)")
	if self.armature then
		self.armature:removeFromParent()
	end

	--data
	self.playIndex = "stand"
	local gun = self.hero:getGun()

	--armature
	local config =  gun:getConfig()
	local focusName = event.focusName or config.focusName
    self.armature = ccs.Armature:create(focusName) 
    self.armature:setAnchorPoint(0.5,0.5)
	self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
	self:addChild(self.armature)
	--range

	local isGold = md:getInstance("FightInlay"):getIsActiveGold()

	local rangeHigh = event.rangeHigh or config.rangeHigh
	local rangeWidth = event.rangeWidth or config.rangeWidth

	local h, w 
	if isGold then 
		h = config["goldWidth"]
		w = config["goldHeight"]
	end
	self:setFocusRange(cc.size(w, h))
	
	self:playIdle()
end

function FocusView:onShowRobot(event)
	local eventData = {focusName = "jijia_zx",
				rangeWidth = define.kRobotRangeW,
				rangeHigh = define.kRobotRangeH	}
	self:refreshFocus(eventData)
end

function FocusView:onHideRobot(event)
	self:refreshFocus()
end

function FocusView:playIdle()
	self.playIndex = "stand"
	self.armature:getAnimation():play("stand" , -1, 1) 
end

function FocusView:playFire()
	if self.playIndex == "stand" then
		-- print("	if self.playIndex  then") 
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
  		local playIndex = self.playIndex
  		if movementID == "fire01" then 
  			self:playIdle()
  		else 
  			self.armature:getAnimation():play(playIndex , -1, 1) 
		end
	end
end

function FocusView:stopFire()
	self.playIndex = "stand"
end

function FocusView:setFocusRange(size)
	if self.focusRange then 
		self.focusRange:removeFromParent()
	end

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

	local isJu = not self.map:getIsJu()
	if isJu then 
		self:addJu()
	else
		self:removeJu()
	end
end

function FocusView:addJu()
	print("FocusView:addJu()")

	--zoom
	local destWorldPos = self:convertToNodeSpace(cc.p(0, 0))
	local scale = define.kJuRange
	local time = 0.1
	local map = md:getInstance("Map")
	map:dispatchEvent({name = map.MAP_ZOOM_OPEN_EVENT,
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

	self.map:changeJuStatus()	
end

function FocusView:removeJu()
	print("FocusView:removeJu()")
	--
	local map = md:getInstance("Map")
	map:setIsJuAble(false)
	--anim
	local time1 = 0.15
	local time2 = 0.4
	local scale = 1.3
	local moveAction1 = cc.ScaleBy:create(time1, scale)
	local moveAction2 = cc.ScaleBy:create(time2, 1/scale)	
	local callfunc = cc.CallFunc:create(handler(self,self.removeJuEnd))

	self.juNode:runAction(cc.Sequence:create(moveAction1, moveAction2, 
		cc.DelayTime:create(0.4), callfunc))

	--map 下移
	local map = md:getInstance("Map")
	map:dispatchEvent({name = map.EFFECT_JUSHAKE_EVENT, time1 = time1, time2 = time2}) 

end

function FocusView:removeJuEnd()
	local map = md:getInstance("Map")
	map:setIsJuAble(true)
	--zoom
	local time = 0.1
	local map = md:getInstance("Map")
	map:dispatchEvent({name = map.MAP_ZOOM_RESUME_EVENT,
		 time = time})
	
	--remove ju	
	self.juNode:removeFromParent()
	self.juNode = nil

	--hide
	self.armature:setVisible(true)

	self.map:changeJuStatus()
end


return FocusView