 --[[--

“枪”的实体

]]

--includes
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
local Robot = class("Robot", cc.mvc.ModelBase)

--events
Robot.ROBOT_START_EVENT		 = "ROBOT_START_EVENT"
Robot.ROBOT_ENDTIME_EVENT	 = "ROBOT_ENDTIME_EVENT"
Robot.ROBOT_BEHURTED_EVENT 	 = "ROBOT_BEHURTED_EVENT"
Robot.ROBOT_FIRE_EVENT 		 = "ROBOT_FIRE_EVENT"
Robot.ROBOT_STOPFIRE_EVENT   = "ROBOT_STOPFIRE_EVENT"

function Robot:ctor()
    Robot.super.ctor(self)
    --instance
    self.isRoboting = false
	self.isCoolDone = true
    --event
end

function Robot:getIsRoboting()
	return self.isRoboting
end

function Robot:setIsRoboting(isRoboting_)
	self.isRoboting = isRoboting_
end

function Robot:getDemage()
	assert(define.kRobotDemage, "demage is nil")
	return define.kRobotDemage
end

function Robot:isCoolDownDone()
	return self.isCoolDone
end

function Robot:fire()
	self:coolDownFire()
	print("robot fire")
	self:dispatchEvent({name = Robot.ROBOT_FIRE_EVENT})
end

function Robot:stopFire()
	self:dispatchEvent({name = Robot.ROBOT_STOPFIRE_EVENT})
end

function Robot:coolDownFire()
	self.isCoolDone = false
	local kCoolDownTime = define.kRobotCoolDownTime
	local function cooldownDoneFunc()
		self.isCoolDone = true
	end
	scheduler.performWithDelayGlobal(cooldownDoneFunc, kCoolDownTime)
end

function Robot:onHitted()
	print("Robot is on hitted")
end

function Robot:startRobot()
	print("Robot:startRobot()")
	self.isRoboting = true

	--visible
	local fight = md:getInstance("Fight")
	local btns = {"btn"}
	fight:dispatchEvent({name = fight.CONTROL_HIDE_EVENT, btns = btns})
	fight:dispatchEvent({name = fight.INFO_HIDE_EVENT})

	--show robot
	self:dispatchEvent({name = Robot.ROBOT_START_EVENT})

	--sch endRobot
	local kTimeEnd = define.kRobotTime
	scheduler.performWithDelayGlobal(handler(self, self.endRobot), kTimeEnd) 
end

function Robot:endRobot()
	print("Robot:endRobot()")
	self.isRoboting = false
	self:dispatchEvent({name = Robot.ROBOT_ENDTIME_EVENT})

	--visible
	local fight = md:getInstance("Fight")
	fight:dispatchEvent({name = fight.CONTROL_SHOW_EVENT})
	fight:dispatchEvent({name = fight.INFO_SHOW_EVENT})
	--cooldown

end

return Robot