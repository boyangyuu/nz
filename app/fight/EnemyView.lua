
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
        -- :addEventListener(Actor.FIRE_EVENT, handler(self, self.playFire))  
          
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
	if not self:canChangeState("stand") then return end
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function EnemyView:playFire()
	if not self:canChangeState("fire") then return end
	self.armature:getAnimation():play("fire" , -1, 1) 
end

function EnemyView:playWalk()
	if not self:canChangeState("walk") then return end
	self.armature:getAnimation():play("walkleft" , -1, 1) 
end

function EnemyView:playRoll()
	if not self:canChangeState("roll") then return end
	-- local frameCnts = self.armature:getAnimation():getMovementCount()
	-- local dis = 50
	-- self:runAction(cc.MoveBy:create(frameCnts/60, cc.p(dis, 0)))	
	self.armature:getAnimation():play("rollleft" , -1, 1) 
end

function EnemyView:playHitted(event)
	if not self:canChangeState("hit") then return end
	if not self.enemy:isDead()  then
		self.armature:getAnimation():play("hit" ,-1 , 1)
	end
end

function EnemyView:playKill(event)
	if not self:canChangeState("die") then return end
	self.armature:getAnimation():play("die" ,-1 , 1)
end


local stateConflicts = {
	hit = {"roll", "die", 
		checkFunc = function(self) 
			return self.enemy:canHitted()
		end,},
	fire = {"stand", "hit", "stand", "die"},
	walk = {"stand", "die"},
	roll = {"stand", "die"},
	stand = {"die"},	
	die = {},
}
function EnemyView:canChangeState(stateId)
	local id = self.armature:getAnimation():getCurrentMovementID()
	if stateId == id then return end
	local conflicts = stateConflicts[stateId] or {}
	for i,v in ipairs(conflicts) do
		if conflicts[tostring(id)] then 
			return false
		end
	end
	if conflicts.checkFunc then
		return conflicts.checkFunc(self) 
	else 
		return true	
	end
	return true
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
	--fire
	local randomSeed 
	randomSeed = math.random(1, kRateFire)
	if randomSeed > kRateFire - 1 then 
		self:playFire() 
		return
	end

	--walk
	randomSeed =  math.random(1, kRateWalk)
	if randomSeed > kRateWalk - 1 then 
		self:playWalk()
		return 
	end

	--roll
	randomSeed =  math.random(1, kRateRoll)
	if randomSeed > kRateRoll - 1 then 
		self:playRoll() 
		return
	end

	--检测死亡
	if self.enemy:getHp() == 0 then
		self:playKill()
	end
end

function EnemyView:test()
	--body
	local bodyNode = self.armature:getBone("Layer5"):getDisplayRenderNode()
	drawBoundingBox(self.armature, bodyNode, cc.c4f(1.0, 0.0, 0, 1.0))
	--
    drawBoundingBox(self.armature, self.armature, cc.c4f(1.0, 0.0, 0, 1.0))
end

function EnemyView:getDeadDone()
	return self.deadDone or false 
end

function EnemyView:setDeadDone()	
	self.deadDone = true
end

return EnemyView