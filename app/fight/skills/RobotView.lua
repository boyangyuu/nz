
--[[--

“枪”的视图

]]
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
local Robot   = import(".Robot") 

local RobotView = class("RobotView", function()
    return display.newNode()
end)

function RobotView:ctor()
	--instance
	self.hero 	 = md:getInstance("Hero")
	self.robot 	 = md:getInstance("Robot")

	--event
	cc.EventProxy.new(self.robot, self)
		:addEventListener(Robot.ROBOT_START_EVENT	, handler(self, self.showRobot))
		:addEventListener(Robot.ROBOT_ENDTIME_EVENT	, handler(self, self.hideRobot))		
		:addEventListener(Robot.ROBOT_FIRE_EVENT	, handler(self, self.playFire))
		:addEventListener(Robot.ROBOT_STOPFIRE_EVENT, handler(self, self.stopFire))
		:addEventListener(Robot.ROBOT_BEHURTED_EVENT, handler(self, self.RobotBehurtEffect))

 	self:initData()
 	self:initUI()
end

function RobotView:initData()

end

function RobotView:initUI()
	--armature
	self.armature = ccs.Armature:create("jijia")
	self:addChild(self.armature)
	self.armature:getAnimation():setMovementEventCallFunc(
		handler(self, self.animationEvent))
	self:setVisible(false)	
end

function RobotView:hideRobot(event)
	self:setVisible(false)


	-- self.armature:getAnimation():play("jijia", -1, 1) --reverse
end

function RobotView:showRobot(event)
	print("function RobotView:showRobot()")
	self:setVisible(true)
	self.armature:getAnimation():play("jijia", -1, 1)


end

function RobotView:RobotBehurtEffect(event)
	--Robot behurted action effect
	local tMove = cc.MoveBy:create(0.05, cc.p(-18, -20))
	self:runAction(cc.Sequence:create(tMove, tMove:reverse(),
		 tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse()))
end

function RobotView:playStand()
	self.armature:getAnimation():play("jijia_chixu", -1, 1)	
end

function RobotView:playFire(event)
	self.armature:getAnimation():play("jijia_fire", -1, 1)
end

function RobotView:stopFire(event)
	self:playStand()
end

function RobotView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		if movementID ~= "jijia_fire" then
			print("self.armature:getAnimation():play")
			self:playStand()
    	else  

    	end 
	end
end

return RobotView