
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = class("BaseEnemyView", Attackable)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local kWalkWidth = 20
local kRollWidth = 100

function BaseEnemyView:ctor(property)
	BaseEnemyView.super.ctor(self, property) 

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
end

--ui
function BaseEnemyView:initBlood()
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

function BaseEnemyView:setBlood(scale)
    local bloodBg = cc.uiloader:seekNodeByName(self.blood, "bloodBg")
    local oSize = bloodBg:getContentSize()
    self.bloodValueNode:setLayoutSize(oSize.width * scale, oSize.height)	
end

---- state ----
function BaseEnemyView:playStand()
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function BaseEnemyView:playFire()
	self.armature:getAnimation():play("fire" , -1, 1) 
	self.enemy:hit(self.hero)
end

function BaseEnemyView:playWalk()
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

function BaseEnemyView:playHitted(event)
	if not self.enemy:isDead()  then
		self.armature:getAnimation():play("hit" ,-1 , 1)
	end
end

function BaseEnemyView:playKill(event)
	--clear
	self:clearPlayCache()
	self.armature:stopAllActions()

	--play

	--以防万一
	if self and self.setDeadDone then 
		scheduler.performWithDelayGlobal(handler(self, self.setDeadDone), 0.5)
	end

	self.armature:getAnimation():play("die" ,-1 , 1)
end

function BaseEnemyView:onHitted(demage)
	if self.enemy:canHitted() and self:canHitted() then
		self.enemy:decreaseHp(demage)
	end

	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	self:setBlood(hp/maxHp)
end

function BaseEnemyView:getModel(property)
	return Enemy.new(property)
end

--BaseEnemyView interface
function BaseEnemyView:playStartState(state)
	assert("required method, must implement me")	
end

function BaseEnemyView:tick(t)
	assert("required method, must implement me")	
end

function BaseEnemyView:canHitted()
	return true
end

function BaseEnemyView:animationEvent(armatureBack,movementType,movementID)
	assert("required method, must implement me")	
end

function BaseEnemyView:getEnemyArmature()
	assert("required method, must implement me")	
end

return BaseEnemyView