
--[[--

“枪”的视图

]]
local Robot   = import(".Robot") 

local RobotView = class("RobotView", function()
    return display.newNode()
end)

function RobotView:ctor()
	--instance
	self.robot 	 = md:getInstance("Robot")

	--event
	cc.EventProxy.new(self.robot, self)
		:addEventListener(Robot.ROBOT_START_EVENT	, handler(self, self.showRobot))
		:addEventListener(Robot.ROBOT_ENDTIME_EVENT	, handler(self, self.hideRobot))		
		:addEventListener(Robot.ROBOT_FIRE_EVENT	, handler(self, self.playFire))
		:addEventListener(Robot.ROBOT_STOPFIRE_EVENT, handler(self, self.stopFire))
		:addEventListener(Robot.ROBOT_BEHURTED_EVENT, handler(self, self.RobotBehurtEffect))

 	self:clearUI()
end

function RobotView:clearUI()
	--armature
	if self.armature then 
		self.armature:removeSelf()
	end
	self.armature = ccs.Armature:create("jijia")
	self:addChild(self.armature)
	self.armature:getAnimation():setMovementEventCallFunc(
		handler(self, self.animationEvent))
	self:setVisible(false)
end

function RobotView:hideRobot(event)
	self:stopFire()
	self.armature:getAnimation():play("jijia_shou", -1, 1) --reverse

	--effect
	local soundSrc  = "res/Music/fight/jijia_close.wav"
	self.audioId1 =  audio.playSound(soundSrc,false)		
end

function RobotView:showRobot(event)
	self:clearUI()
	self:setVisible(true)
	self.armature:getAnimation():play("jijia", -1, 1)

	--effect
	local soundSrc  = "res/Music/fight/jijia_open.wav"
	self.audioId2 =  audio.playSound(soundSrc,false)		
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
	local soundSrc  = "res/Music/weapon/m134fire.wav"
	self.audioId2 =  audio.playSound(soundSrc,false)	

	if self.isFiring then return end
	self.isFiring = true
	self.armature:getAnimation():play("jijia_fire", -1, 1)
end

function RobotView:stopFire(event)
	self.isFiring = false
	self:playStand()
end

function RobotView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
    	if movementID == "jijia_shou" then
			self:clearUI()
		elseif movementID ~= "jijia_fire" then
			self:playStand() 
		end 
	end
end

return RobotView