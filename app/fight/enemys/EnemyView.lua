
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
local AbstractEnemyView = import(".AbstractEnemyView")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local EnemyView = class("EnemyView", AbstractEnemyView)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local kWalkWidth = 20
local kRollWidth = 100

function EnemyView:ctor(property)
	EnemyView.super.ctor(self, property) 

    --blood
    self:initBlood() 

	--play
	self:playStand()
	local function start()
		self:playStartState(property.startState)
	end
	scheduler.performWithDelayGlobal(start, 0.000)
	

    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
    --test
    self:test()
end

--ui
function EnemyView:initBlood()
    --add blood
    cc.FileUtils:getInstance():addSearchPath("res/Fight/fightLayer/ui")
    local node = cc.uiloader:load("heroUI.ExportJson")    
    self.blood = cc.uiloader:seekNodeByName(node, "enemyBlood")
    self.blood:removeFromParent()
    local bound = self.armature:getBoundingBox()
    self.blood:setPosition(0, bound.height/2 + 100)
    self.armature:addChild(self.blood) 
	self.bloodValueNode = cc.uiloader:seekNodeByName(self.blood , "blood")
	self:setBlood(1.0)
end

function EnemyView:setBlood(scale)
    local bloodBg = cc.uiloader:seekNodeByName(self.blood, "bloodBg")
    local oSize = bloodBg:getContentSize()
    self.bloodValueNode:setLayoutSize(oSize.width * scale, oSize.height)	
end

---- state ----
function EnemyView:playStartState(state)
	if state == "rollleft" then 
		self:play("playRollLeft", handler(self, self.playRollLeft))
	elseif state == "rollright" then
		self:play("playRollRight", handler(self, self.playRollRight))
	else 
		self:play("playStand", handler(self, self.playStand))
	end
end

function EnemyView:playStand()
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function EnemyView:playFire()
	self.armature:getAnimation():play("fire" , -1, 1) 
	self.enemy:hit(self.hero)
	-- self:playThrow()
end

function EnemyView:playThrow()
	self.armature:getAnimation():play("throw", -1, 1)
	local pos = cc.p(self:getPositionX(), self:getPositionY() + 220)
	local function test( )
		print("hello world")
	end
	self.enemy:hit(self.hero)
end

function EnemyView:playWalk()
	local isLeft = 1
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then isLeft = -1 end
	local dis = 5 * isLeft * self:getScale()
    local widthOffset = kWalkWidth * isLeft
    local isAble = self:checkPlace(widthOffset * self:getScale())

    if not isAble then return end
	self.armature:getAnimation():play("walk" , -1, 1)
	local action = cc.MoveBy:create(1/60, cc.p(dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	
end

function EnemyView:playRoll()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:play("playRollLeft", handler(self, self.playRollLeft))
	else
		self:play("playRollRight", handler(self, self.playRollRight))
	end
end

function EnemyView:playRollLeft()
	if not self:checkPlace(-kRollWidth * self:getScale()) then return end
	self.armature:getAnimation():play("rollleft" , -1, 1) 
	local dis = 8 * self:getScale() 

	local action = cc.MoveBy:create(1/60, cc.p(-dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	
end

function EnemyView:playRollRight()
	if not self:checkPlace(kRollWidth * self:getScale()) then return end
	self.armature:getAnimation():play("rollright" , -1, 1) 
	local dis = 8 * self:getScale() 

	local action = cc.MoveBy:create(1/60, cc.p(dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))			
end

function EnemyView:playHitted(event)
	if not self.enemy:isDead()  then
		self.armature:getAnimation():play("hit" ,-1 , 1)
	end
end

function EnemyView:playKill(event)
	--clear
	self:clearPlayCache()
	self.armature:stopAllActions()

	--play
	self.armature:getAnimation():play("die" ,-1 , 1)
end


function EnemyView:test()
	--body
	local weakNode = self.armature:getBone("weak1"):getDisplayRenderNode()
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
-- 	drawBoundingBox(self.armature, weakNode, "red") 
-- 	drawBoundingBox(self.armature, bodyNode, "yellow") 
end

--AbstractEnemyView interface
function EnemyView:tick(t)
	--change state
	--fire
	local fireRate = self.enemy:getFireRate()
	local randomSeed  
	math.newrandomseed()
	randomSeed = math.random(1, fireRate)
	if randomSeed > fireRate - 1 then 
		self:play("playFire", handler(self, self.playFire))
		return
	end

	--walk
	local walkRate = self.enemy:getWalkRate()
	randomSeed =  math.random(1, walkRate)
	if randomSeed > walkRate - 1 then 
		self:play("playWalk", handler(self, self.playWalk))
		return 
	end

	--roll
	local rollRate = self.enemy:getRollRate()/4
	randomSeed =  math.random(1, rollRate)
	if randomSeed > rollRate - 1 then 
		self:playRoll()
		return
	end

	--throw 
end

--throw 

function EnemyView:onHitted(demage)
	if self.enemy:canHitted() then
		self.enemy:decreaseHp(demage)
	end

	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	self:setBlood(hp/maxHp)
end

function EnemyView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		print("animationEvent id ", movementID)
		armatureBack:stopAllActions()
		if movementID ~= "die" then
			local playCache = self:getPlayCache()
			if playCache then 
				playCache()
			else 					
				self:playStand()
			end
    	elseif movementID == "die" then 
    		self:setDeadDone()
    	end 
	end
end

function EnemyView:getEnemyArmature()
	if self.armature then return self.armature end 
	--armature
    local src = "Fight/enemys/anim_enemy_002/anim_enemy_002.ExportJson"
    local armature = getArmature("anim_enemy_002", src) 
	armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	return armature
end

function EnemyView:getModel(property)
	return Enemy.new(property)
end

return EnemyView