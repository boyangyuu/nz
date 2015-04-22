
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local JuEnemyView = class("JuEnemyView", BaseEnemyView)

function JuEnemyView:ctor(property)
	JuEnemyView.super.ctor(self, property) 
	self.focusTime = define.kJujiEnemyFocusTime
end

---- state ----
function JuEnemyView:playStartState(state)
	if state == "rollleft" then 
		self:playRollLeft()
	elseif state == "rollright" then
		self:playRollRight()
	else 
		self:playStand()
	end
end

function JuEnemyView:playStand()
	self.armature:getAnimation():play("stand" , -1, 1) 
end

function JuEnemyView:playEffectFocus()
	local pWorld = self:getRange("weak1"):convertToWorldSpace(cc.p(0,0))
	local map    = md:getInstance("Map")
	map:dispatchEvent({name = map.EFFECT_FOCUS_EVENT, enemyPos = 
		pWorld, time = self.focusTime})
end

function JuEnemyView:playKill(event)
	JuEnemyView.super.playKill(self, event)
	self.armature:getAnimation():play("die" ,-1 , 1)
	
	--sound
	local soundSrc  = "res/Music/fight/die.wav"
	self.audioId =  audio.playSound(soundSrc,false)	
end

function JuEnemyView:playJu()
	--focus rotate
	self:playEffectFocus()
	self:setPauseOtherAnim(true)

	local function focusEnd()
		self:setPauseOtherAnim(false)
		self:playFire()
	end
	self:performWithDelay(focusEnd, self.focusTime)
end

function JuEnemyView:playFire()
	self.armature:getAnimation():play("fire" , -1, 1) 
	self.enemy:hit(self.hero)	
end

function JuEnemyView:playRoll()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:play("playRollLeft", handler(self, self.playRollLeft))
	else
		self:play("playRollRight", handler(self, self.playRollRight))
	end
end

function JuEnemyView:playRollLeft()
	if not self:checkPlace(-define.kEnemyRollWidth * self:getScale()) then return end
	self.armature:getAnimation():play("rollleft" , -1, 1) 
	local speed = define.kEnemyRollSpeed  * self:getScale() 

	local action = cc.MoveBy:create(1/60, cc.p(-speed, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))
	self.enemy:beginRollCd()	
end

function JuEnemyView:playRollRight()
	if not self:checkPlace(define.kEnemyRollWidth * self:getScale()) then return end
	self.armature:getAnimation():play("rollright" , -1, 1) 
	local speed = define.kEnemyRollSpeed  * self:getScale() 

	local action = cc.MoveBy:create(1/60, cc.p(speed, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))		
	self.enemy:beginRollCd()	
end

--Attackable interface
function JuEnemyView:tick(t)
	--change state
	--fire
	local fireRate, isAble = self.enemy:getFireRate()
	if isAble then 
		assert(fireRate > 1, "invalid fireRate")
		randomSeed = math.random(1, fireRate)
		if randomSeed > fireRate - 1 then 
			self:playAfterAlert("skill", handler(self, self.playJu))
			self.enemy:beginFireCd()
		end
	end
end

function JuEnemyView:playHitted(event)
	--飘红
	
	self:playHittedEffect()
end

function JuEnemyView:canHitted()
	return true
end

function JuEnemyView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		armatureBack:stopAllActions()
		if movementID ~= "die" and not self:getPauseOtherAnim() then
			self:doNextPlay()
    	elseif movementID == "die" then 
    		self:setDeadDone()
    	end 
	end
end

return JuEnemyView