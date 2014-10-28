
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

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

--state
function EnemyView:playIdle()
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function EnemyView:playFire(event)
	self.armature:getAnimation():play("fire" , -1, 1) 
end

function EnemyView:playHitted(event)
	if not self.enemy:isDead() then
		self.armature:getAnimation():play("hit" , -1, 1)
	end
end

function EnemyView:playKill(event)
	self.armature:getAnimation():play("die" , -1, 1)
end



function EnemyView:animationEvent(armatureBack,movementType,movementID)
	print("animationEvent id ", movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		if movementID == "fire" or movementID == "hit" then
			print("animationEvent idle from ", movementID)
			armatureBack:stopAllActions()
			self:playIdle()
    	elseif movementID == "die" then 
    		print("died, remove")
    		armatureBack:stopAllActions()
    		self:setDeadDone()
			self:removeAllChildren()
    	end 
	end
end

----  ----
function EnemyView:getRect(rectName)
	assert(rectName, "invalid param")
	local bound 
	if rectName == "body" then
		bound = self.armature:getBoundingBox()
		local nodePoint = self.armature:convertToWorldSpace(
 		cc.p(bound.x, bound.y))
 		bound.x = nodePoint.x
  		bound.y = nodePoint.y	
  	end
  	return bound
end

--random create state

--tick
function EnemyView:tick(t)
	--change state
	local randomSeed = math.random(1, 200)
	if randomSeed > 199 and self.enemy:canFire() then
		self.enemy:fire()
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