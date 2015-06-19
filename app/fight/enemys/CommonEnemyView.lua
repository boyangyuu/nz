
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local CommonEnemyView = class("CommonEnemyView", BaseEnemyView)

function CommonEnemyView:ctor(property)
	CommonEnemyView.super.ctor(self, property) 
end

---- state ----
function CommonEnemyView:playStartState(state)
	if state == "rollleft" then 
		self:playRollLeft()
	elseif state == "rollright" then
		self:playRollRight()	
	elseif state == "san" then 
		self:playSan()
	else 
		self:playStand()
	end
end

function CommonEnemyView:playKill(event)
	CommonEnemyView.super.playKill(self, event)
	self.armature:getAnimation():play("die" ,-1 , 1)
	
	--sound
	local soundSrc  = "res/Music/fight/die02.wav"
	self.audioId =  audio.playSound(soundSrc,false)	
end

function CommonEnemyView:playThrow()
	self.armature:getAnimation():play("throw", -1, 1)
	local pos = cc.p(self:getPositionX(), self:getPositionY() + 220)
	self.enemy:hit(self.hero)
end

function CommonEnemyView:playSan()
	self:setIsFlying(true)
    self:setPositionY(display.height)

    --action
    local speed = define.kLeiEnemySanSpeed 
    local destPosY = self:getPlaceNode():getPositionY()
    local distance = display.height - destPosY
    local time = distance / speed 
    local action = cc.MoveBy:create(time, cc.p(0, -distance))

    local function fallEnd()
    	self:restoreStand()	
    	self:setIsFlying(false)
    end
    local seq = cc.Sequence:create(action, 
        cc.CallFunc:create(fallEnd))    
    self:runAction(seq)

    --play
    self.armature:getAnimation():play("jiangluo" , -1, 1) 

    self:setPauseOtherAnim(true) 
end

function CommonEnemyView:playRoll()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:play("playRollLeft", handler(self, self.playRollLeft))
	else
		self:play("playRollRight", handler(self, self.playRollRight))
	end
end

function CommonEnemyView:playRollLeft()
	if not self:checkPlace(-define.kEnemyRollWidth * self:getScale()) then return end
	self.armature:getAnimation():play("rollleft" , -1, 1) 
	local speed = define.kEnemyRollSpeed  * self:getScale() 

	local action = cc.MoveBy:create(1/60, cc.p(-speed, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))
	self.enemy:beginRollCd()	
end

function CommonEnemyView:playRollRight()
	if not self:checkPlace(define.kEnemyRollWidth * self:getScale()) then return end
	self.armature:getAnimation():play("rollright" , -1, 1) 
	local speed = define.kEnemyRollSpeed  * self:getScale() 

	local action = cc.MoveBy:create(1/60, cc.p(speed, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))		
	self.enemy:beginRollCd()	
end

--Attackable interface
function CommonEnemyView:tick(t)
	--change state
	--fire
	local fireRate, isAble = self.enemy:getFireRate()
	
	if isAble then 
		assert(fireRate > 1, "invalid fireRate")
		randomSeed = math.random(1, fireRate)
		if randomSeed > fireRate - 1 then 
			self:playAfterAlert("skill", handler(self, self.playFire))
			self.enemy:beginFireCd()
		end
	end

	--walk
	local walkRate, isAble = self.enemy:getWalkRate()
	
	if isAble then
		assert(walkRate > 1, "invalid walkRate")
		randomSeed =  math.random(1, walkRate)
		if randomSeed > walkRate - 1 then 
			self:play("playWalk", handler(self, self.playWalk))
		end
	end

	--roll
	local rollRate, isAble = self.enemy:getRollRate()
	if isAble then 
		assert(rollRate > 1, "invalid rollRate")
		randomSeed =  math.random(1, rollRate)
		if randomSeed > rollRate - 1 then 
			self:playRoll()
		end
	end
end

function CommonEnemyView:playHitted(event)
	local curID = self:getCurrentMovementID()
	--飘红
	self:playHittedEffect()

	--不重复播放
	if not self.enemy:isDead() and curID ~= "hit"
		and not self:getIsFlying() then
		self.armature:getAnimation():play("hit" ,-1 , 1)
	end
end

--throw 
function CommonEnemyView:canHitted()
	local curID = self:getCurrentMovementID()	--无敌
	if curID == "rollleft" 
		or curID == "rollright" then 
		return false
	end
	return true
end

function CommonEnemyView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		armatureBack:stopAllActions()
		if movementID ~= "die" and not self:getPauseOtherAnim() then
			self:doNextPlay()
    	elseif movementID == "die" then 
    		print("CommonEnemyView die")
    		self:setDeadDone()
    	end 
	end
end

return CommonEnemyView