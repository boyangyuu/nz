
--[[--

“准星”的视图

]]

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
		 :addEventListener(self.hero.GUN_RELOAD_EVENT, handler(self, self.stopFire))
		 :addEventListener(self.hero.GUN_CHANGE_EVENT, handler(self, self.refreshFocus))

	local robot = md:getInstance("Robot")
	cc.EventProxy.new(robot, self)
		:addEventListener(robot.ROBOT_START_EVENT	, handler(self, self.onShowRobot))
		:addEventListener(robot.GOLDROBOT_START_EVENT, handler(self, self.onShowRobot))
		:addEventListener(robot.ROBOT_ENDTIME_EVENT	, handler(self, self.onHideRobot))

	local inlay = md:getInstance("FightInlay")
	cc.EventProxy.new(inlay, self)
        :addEventListener(inlay.INLAY_GOLD_BEGIN_EVENT, handler(self, self.refreshFocus))
        :addEventListener(inlay.INLAY_GOLD_END_EVENT,	 handler(self, self.refreshFocus))
	
	local map = md:getInstance("Map")		
    cc.EventProxy.new(map, self)
		 :addEventListener(map.GUN_OPEN_JU_EVENT, handler(self, self.addJu))
		 :addEventListener(map.GUN_CLOSE_JU_EVENT, handler(self, self.removeJu))
end

function FocusView:refreshFocus(event)
	--clear
	event = event or {}
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

	if isGold then 
		rangeHigh = config["goldHeight"]
		rangeWidth = config["goldWidth"]
	end
	self:setFocusRange(cc.size(rangeWidth, rangeHigh))
	
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
	local map = md:getInstance("Map")
	local isJu = map:getIsOpenJu()
	if not isJu then 
		self:playNormalFire()
	else
		self:playJuFire()
	end
end

function FocusView:playNormalFire()
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

function FocusView:playJuFire()
	--
	local map = md:getInstance("Map")
	map:setIsJuAble(false)
	--anim
	local time1 = 0.15
	local time2 = 0.4
	local scale = 1.3
	local moveAction1 = cc.ScaleTo:create(time1, scale)
	local moveAction2 = cc.ScaleTo:create(time2, 1)	

	self.juNode:runAction(cc.Sequence:create(moveAction1, moveAction2, 
		cc.DelayTime:create(0.4)))

	--map 下移
	local map = md:getInstance("Map")
	map:dispatchEvent({name = map.EFFECT_JUSHAKE_EVENT, time1 = time1, time2 = time2}) 
	
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

    -- dump(size, "function FocusView:setFocusRange(size)")
    drawBoundingBox(nil, self.focusRange, cc.c4f(1.0, 0.0, 0, 1.0))
end

function FocusView:getFocusRange()
	return self.focusRange
end

function FocusView:addJu(event)
	print("FocusView:addJu()")

	local x, y = self:getParent():getPosition()
	
	--zoom
	--todo
	local destWorldPos = self:convertToNodeSpace(cc.p(0, 0))
	local destWorldPos = event.pos
	local scale = define.kJuRange
	local time = 0.1
	local map = md:getInstance("Map")
	map:dispatchEvent({name = map.MAP_ZOOM_OPEN_EVENT,
		 destWorldPos = destWorldPos,
		 scale = scale, 
		 time = time})

	--add ju
	if self.juNode == nil then 

		--todo!!
		self.juNode = cc.uiloader:load("res/Fight/fightLayer/gun_ju/ju.ExportJson")
		self.juNode:setAnchorPoint(0.5, 0.5)
		addChildCenter(self.juNode, self)
	end

	--hide
	self.armature:setVisible(false)

	self.map:changeJuStatus()	
end

function FocusView:removeJu(event)
	-- local ox, oy = self.oriJuPos.x, self.oriJuPos.y
	-- local cx, cy = self:getParent():getPosition()
	-- local destPos = cc.p(ox + (cx - ox)/4 , oy + (cy - oy)/4 )

	-- self:getParent():setPosition(destPos.x, destPos.y)
	self:removeJuEnd()
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