
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--k
local kRateFire = 200
local kRateRoll = 400
local kRateWalk = 400
local isAdded = false
--import
import("..includes.functionUtils")
local scheduler = require("framework.scheduler")
local Enemy = import(".Enemy")
local Hero = import(".Hero")
local Actor = import(".Actor")


local EnemyView = class("EnemyView", function()
    return display.newNode()
end)

function EnemyView:ctor(property)
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

function EnemyView:checkPlace(widthOffset)
	print("isAdded", isAdded)
	local x1, x2 = self.placeBound.x , self.placeBound.x + self.placeBound.width
	print("self.placeBound %d %d",x1, x2) 
	if self.placeBound == nil return false end
	local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
	local bound = self.armature:getCascadeBoundingBox()
	bound.x, bound.y = pWorld.x, bound.y
	print("self.armature %d %d",bound.x, bound.y)
	local destx =  bound.x + widthOffset
	return x1 < destx and x2 > destx
end

function EnemyView:playWalk()
	if not self:canChangeState("walk") then return end
	local isLeft = 1
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then isLeft = -1 end
	local dis = 2 * isLeft
    local widthOffset = 100 * isLeft
    local isAble = self:checkPlace(widthOffset)

    if not isAble then return end
	self.armature:getAnimation():play("walk" , -1, 1)
	local action = cc.MoveBy:create(1/60, cc.p(dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	
end



function EnemyView:playRoll()
	local isLeft = 1
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:playRollLeft()
	else
		self:playRollRight()
	end
end

function EnemyView:playRollLeft()
	if not self:canChangeState("rollleft") then return end
	if not self:checkPlace(-150) then return end
	self.armature:getAnimation():play("rollleft" , -1, 1) 
	local dis = 5 

	local action = cc.MoveBy:create(1/60, cc.p(-dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	
end

function EnemyView:playRollRight()
	if not self:canChangeState("rollright") then return end
	if not self:checkPlace(150) then return end
	self.armature:getAnimation():play("rollright" , -1, 1) 
	local dis = 5

	local action = cc.MoveBy:create(1/60, cc.p(dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))			
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

local stateMatches = {
	stand = {"rollleft", "rollright", "hit", "walk", "fire"},
	walk = {"stand"},
	rollleft = {"stand"},
	rollright = {"stand"},	
	fire = {"stand","hit",},
	hit = {"walk", "stand", "fire",
		checkFunc = function(self) 
			return self.enemy:canHitted()  
		end,},
	die = {"stand", "rollleft", "rollright", "hit", "walk", "fire"},
}
function EnemyView:canChangeState(stateId)
	local id = self.armature:getAnimation():getCurrentMovementID()
	if id == "" then return true end
	if stateId == id then return false end
	print("canChangeState? from", id, "to", stateId)
	local matchs = stateMatches[stateId] 
	assert(matchs, "")
	for i,v in ipairs(matchs) do
		-- print(i,v)
		if v == tostring(id) then 
			if matchs.checkFunc then
				return matchs.checkFunc(self) 
			else 
				return true
			end
		end
	end
	return false
end

function EnemyView:animationEvent(armatureBack,movementType,movementID)
	-- print("animationEvent id ", movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		armatureBack:stopAllActions()
		self.armature:stopAllActions()
		if movementID ~= "die" then
			self:playIdle()
    	elseif movementID == "die" then 
    		self:setDeadDone()
    	end 
	end
end

----hited  ----
function EnemyView:getRange(rectName)
	assert(rectName, "invalid param")
	local bone = self.armature:getBone(rectName)
	if not bone then return end
	return bone:getDisplayRenderNode() or {}
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
	local weakNode = self.armature:getBone("weak1"):getDisplayRenderNode()
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
	drawBoundingBox(self.armature, weakNode, "red") 
	drawBoundingBox(self.armature, bodyNode, "yellow") 
    -- drawBoundingBox(self, self, "white") 
end

function EnemyView:getDeadDone()
	return self.deadDone or false 
end

function EnemyView:setDeadDone()	
	self.deadDone = true
end


function EnemyView:setPlaceBound(bound)
	assert(bound, self.id)
	isAdded = true
	print("isAdded", isAdded)
	self.placeBound = bound
end

function EnemyView:getPlaceBound()
	return self.placeBound 
end

return EnemyView