
--[[--

“enemy”的视图
1. 小怪基类
2. 有基础动画逻辑 : walk stand hit die 
3. 有血条逻辑
4. 有弱点逻辑 爆头等

]]

--import
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")

local BaseEnemyView = class("BaseEnemyView", Attackable)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local kWalkWidth = 20

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
    self.blood:setPosition(0, bound.height * 0.85)
    self.armature:addChild(self.blood) 
	self.bloodValueNode = cc.uiloader:seekNodeByName(self.blood , "blood")
	self:setBlood(1.0)
end

function BaseEnemyView:setBlood(scale)
	if scale == 0 then 
		self.blood:setVisible(false) 
	end
    local bloodBg = cc.uiloader:seekNodeByName(self.blood, "bloodBg")
    local oSize = bloodBg:getContentSize()
    self.bloodValueNode:setLayoutSize(oSize.width * scale, oSize.height)	
end

function BaseEnemyView:showAlert()
	--create
	if self.isShowAlerting then return end
	self.isShowAlerting = true
	local src = "res/Fight/uiAnim/tanhao/tanhao.ExportJson"
	local armature = getArmature("tanhao", src)
	armature:getAnimation():play("tanhao", -1, 0)
    local function alertAnimEvent(armatureBack,movementType,movementID)
        armature:removeFromParent()
        self.isShowAlerting = false
    end
    armature:getAnimation():setMovementEventCallFunc(alertAnimEvent)

    --add
    local bound = self.armature:getBoundingBox()
    armature:setPosition(bound.width * 0.1, bound.height* 0.85 )
    self.armature:addChild(armature) 
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

function BaseEnemyView:onHitted(targetData)
	local demage 	 = targetData.demage
	local scale  	 = targetData.demageScale
	local demageType = targetData.demageType
	if self.enemy:canHitted() and self:canHitted() then
		self.enemy:decreaseHp(demage * scale)
	end

	--爆头
	if self.enemy:getHp() == 0 then 
		if demageType == "head" then 
			print("爆头")
			self.hero:dispatchEvent({
				name = self.hero.ENEMY_KILL_HEAD_EVENT})
		end
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