
--[[--

“人质兵”的视图
1. 死亡达到关卡指定个数 杀死英雄
2. 左右移动范围大
]]

local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local DoctorEnemyView = class("DoctorEnemyView", BaseEnemyView)  

function DoctorEnemyView:ctor(property)
	--instance
	DoctorEnemyView.super.ctor(self, property) 

    -- --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 
end

function DoctorEnemyView:tick()
	local rollRate, isAble = self.enemy:getRollRate()
	assert(rollRate > 1, "invalid rollRate")	

	--roll
	if isAble then
		local randomSeed = math.random(1, rollRate)
		if randomSeed > rollRate - 1 then 
			self:play("roll", handler(self, self.playRun))
			self.enemy:beginRollCd()
		end
	end	
end

function DoctorEnemyView:playStartState(state)
	if state == "enterleft" then 
		self:playEnter("left")
	elseif state == "enterright" then
		self:playEnter("right")
	else 
		self:playStand()
	end

	--hp
	local skillCd = self.property["skillCd"] 
	self:schedule(handler(self, self.playSkillAddHp), skillCd)
end

function DoctorEnemyView:playEnter(direct)
	local isLeft = direct == "left" 
	local animName
	if isLeft then 
		animName = "runright"
	else
		animName = "runleft"
	end
	self.armature:getAnimation():play(animName , -1, 1) 
	local toPosx = self:getPositionX()

	local posInMapx = self:getPosInMap().x
	local srcPosX = 0 
	if isLeft then 
		srcPosX =  toPosx - posInMapx - 300
	else
		srcPosX = toPosx + (display.width - posInMapx) + 300
	end

	self:setPositionX(srcPosX)
	local distance = math.abs(toPosx - srcPosX)
	local time = distance / define.kHushiSpeed
	local action = cc.MoveTo:create(time, cc.p(toPosx, self:getPositionY()))
	local callfunc = function ()
		self:restoreStand()
	end
	self:setPauseOtherAnim(true)
    self:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))		
end

function DoctorEnemyView:playSkillAddHp()
	local value = self.property["skillValue"]
	local buffData = {
		name  = "jiaxue",
		value = value,
		time  = nil,
	}
	self.enemyM:doBuffAll_increaseHp(buffData)
end

function DoctorEnemyView:playRun()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:playRunAction(1)
	else
		self:playRunAction(-1)
	end
end

function DoctorEnemyView:playRunAction(direct)
	print("function DoctorEnemyView:playRunLeft():")
	local speed = define.kHushiSpeed
	local time = define.kHushiWalkTime
	local width = speed * time * self:getScale() * direct
	if not self:checkPlace(width) then 
		return 
	end

	local animName = direct == 1 and "runright" or "runleft"
	self.armature:getAnimation():play(animName , -1, 1) 
	local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(cc.Sequence:create(action, 
    	cc.CallFunc:create(handler(self, self.restoreStand))
    	))	 
end

function DoctorEnemyView:onHitted(targetData)
	DoctorEnemyView.super.onHitted(self, targetData)
    --sound
    local soundSrc  = "res/Music/fight/rz_bj.wav"
	audio.playSound(soundSrc,false)  	
end

function DoctorEnemyView:playHitted(event)
	self:playHittedEffect()
end

function DoctorEnemyView:playKill(event)
	--clear
	DoctorEnemyView.super.playKill(self, event)
	self.armature:getAnimation():play("die" ,-1 , 1)

	--sound
    local soundSrc  = "res/Music/fight/rz_die.wav"
    local audioId =  audio.playSound(soundSrc,false)   	
end

function DoctorEnemyView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete  then
		if movementID ~= "die" then
			self:doNextPlay()
    	elseif movementID == "die" then 
    		self:setDeadDone()
    	end 
	end
end

return DoctorEnemyView




