 --[[--

“枪”的实体

]]

--includes

local Robot = class("Robot", cc.mvc.ModelBase)

--events
Robot.Robot_START_EVENT = "Robot_START_EVENT"
Robot.Robot_TIMEEND_EVENT = "Robot_TIMEEND_EVENT"
Robot.Robot_BEHURTED_EVENT = "Robot_BEHURTED_EVENT"

function Robot:ctor()
    Robot.super.ctor(self)
    --instance
    self.isDefending = false
	self:refreshHp()
    --event
end

function Robot:getIsDefending()
	return self.isDefending
end

function Robot:setIsDefending(isDefending_)
	self.isDefending = isDefending_
end

function Robot:refreshHp()
	local hero = md:getInstance("Hero")
	self.maxHp = hero:getMaxHp()
	self.hp = hero:getMaxHp()
end

function Robot:startRobot()
	print("Robot:startRobot()")
	self.isDefending = true
	local fight = md:getInstance("Fight")
	local btns = {"btn"}
	self:dispatchEvent({name = fight.CONTROL_HIDE_EVENT, btns = btns})
	self:dispatchEvent({name = Robot.Robot_START_EVENT, isStart = true})
end

function Robot:endRobot()
	print("Robot:endRobot()")
	self.isDefending = false
	self:dispatchEvent({name = Robot.Robot_SWITCH_EVENT, isStart = false})
end

return Robot