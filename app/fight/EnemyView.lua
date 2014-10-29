
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--k
local kRateFire = 200
local kRateRoll = 200
local kRateWalk = 200

--import
import("..includes.functionUtils")
local scheduler = require("framework.scheduler")
local Enemy = import(".Enemy")
local Hero = import(".Hero")
local Actor = import(".Actor")


local EnemyView = class("EnemyView", function()
    return display.newNode()
end)

function EnemyView:ctor()
	local id = "1"   -- todo 外界传

	--instance
	self.enemy = Enemy.new({id = id})
    self.hero = app:getInstance(Hero)

	--armature
    local src = "Fight/enemys/anim_enemy_001/anim_enemy_001.ExportJson"
    local armature = getArmature("anim_enemy_001", src) 
	self.armature = armature

	self.armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	
	--换肤
	self:addChild(armature)
	self:playIdle()

    --events
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()  
    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.playFire))  
          
    --test
    self:test()
end

---- event ----
function EnemyView:onHitted(demage)
	if self.enemy:canHitted() then
		self.enemy:decreaseHp(demage)
	end
end

---- state ----
function EnemyView:playIdle()
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function EnemyView:playFire(event)
	self.armature:getAnimation():play("fire" , -1, 1) 
end

function EnemyView:playWalk()
	self.armature:getAnimation():play("walk" , -1, 1) 
end

function EnemyView:playRoll()
	self.armature:getAnimation():play("roll" , -1, 1) 
end

function EnemyView:playHitted(event)
	if not self.enemy:isDead() then
		self.armature:getAnimation():play("hit" , -1, 1)
	end
end

function EnemyView:playKill(event)
	self.armature:getAnimation():play("die" , -1, 1)
end

function EnemyView:canChangeState(stateId)
	local id = self.armature:getAnimation():getCurrentMovementID()
	-- print("stateId", stateId)
	-- print("id", id)
	if stateId == "hit" then 
		local notConflict = id ~= "roll"
		return self.enemy:canHitted() and notConflict
	elseif stateId == "fire" then 
		local notConflict = id == "stand" or id == "hit"
		return notConflict
	elseif stateId == "walk" or "roll" then 
		local notConflict = id == "stand" 
		return  notConflict	
	end		
	return false
end

function EnemyView:animationEvent(armatureBack,movementType,movementID)
	-- print("animationEvent id ", movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		if movementID ~= "die" then
			-- print("animationEvent idle from ", movementID)
			armatureBack:stopAllActions()
			self:playIdle()
    	elseif movementID == "die" then 
    		-- print("died, remove")
    		armatureBack:stopAllActions()
    		self:setDeadDone()
    	end 
	end
end

----hited  ----
function EnemyView:getRange(rectName)
	assert(rectName, "invalid param")
  	return self.armature or nil
end

----attack----

--tick
function EnemyView:tick(t)
	--change state
	local randomSeed 
	if self:canChangeState("fire") then
		randomSeed = math.random(1, kRateFire)
		if randomSeed > kRateFire - 1 then 
			self.enemy:fire() 
			return
		end
	end
	if self:canChangeState("walk") then 
		randomSeed =  math.random(1, kRateWalk)
		if randomSeed > kRateWalk - 1 then 
			self:playWalk()
			return 
		end
	end
	if self:canChangeState("roll") then 
		randomSeed =  math.random(1, kRateRoll)
		if randomSeed > kRateRoll - 1 then 
			self:playRoll() 
			return
		end
	end
end

function EnemyView:test()
    drawBoundingBox(self, self.armature, cc.c4f(1.0, 0.0, 0, 1.0))
end

function EnemyView:getDeadDone()
	return self.deadDone or false 
end

function EnemyView:setDeadDone()	
	self.deadDone = true
end

return EnemyView