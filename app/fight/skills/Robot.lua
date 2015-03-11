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
Robot.ROBOT_STOPFIRE_EVENT   = "ROBOT_STOPFIRE_EVE                                                                                                                                                                                                                                                                                                                                                                                                         NT"

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
	-- print("robot fire")
	local soundSrc  = "res/Music/weapon/m134fire.wav"
	self.audioId1 =  audio.playSound(soundSrc,false)	
		
	self:dispatchEvent({name = Robot.ROBOT_FIRE_EVENT})
end

function Robot:stopFire()
	if self.isRoboting == false then return end
	-- print("function Robot:stopFire()")
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

function Robot:startRobot(time)
	print("Robot:startRobot()")
    local levelModel = md:getInstance("LevelDetailModel")
    local isju = levelModel:isJujiFight() 
    if isju then return end	
    
    --um
    local fight = md:getInstance("Fight")
    local levelInfo = fight:getLevelInfo() 
    assert(levelInfo, "levelInfo is nil") 
    local umData = {}
    umData[levelInfo] = "机甲"
    um:event("关卡道具使用", umData) 	

	--data
	self.isRoboting = true
	
	--visible
	local fight = md:getInstance("Fight")
	fight:dispatchEvent({name = fight.CONTROL_HIDE_EVENT})
	fight:dispatchEvent({name = fight.INFO_HIDE_EVENT})

	--show robot
	self:dispatchEvent({name = Robot.ROBOT_START_EVENT})

	--cancell dun
	local defence = md:getInstance("Defence")
	defence:endDefence()

	--check guide
	local guide = md:getInstance("Guide")
	local curGuideId = guide:getCurGuideId()
	if curGuideId == "fight01_jijia" and  guide:getIsGuiding() then 
		--引导的时候 机甲一直在
		return 
	end
	
	--sch endRobot
	local time = time or define.kRobotTime 
	scheduler.performWithDelayGlobal(handler(self, self.endRobot), time) 
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