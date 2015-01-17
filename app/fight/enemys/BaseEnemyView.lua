
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
	
	--play
	self:playStand()
	
    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
    self:setNodeEventEnabled(true)
end

--ui
function BaseEnemyView:onEnter()
	BaseEnemyView.super.onEnter(self)
	self:initBlood()
end

function BaseEnemyView:initBlood()
    --add blood
    local node = cc.uiloader:load("res/Fight/fightLayer/fightBlood/enemyBlood.ExportJson")    
    self.blood = node
    local bound = self.armature:getBoundingBox()
    
    --pos
    local boneBlood = self.armature:getBone("blood")
    local posBone = boneBlood:convertToWorldSpace(cc.p(0, 0))
    local posArm = self.armature:convertToWorldSpace(cc.p(0, 0))
    local destpos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)
    self.blood:setPosition(destpos.x, destpos.y)
    self.armature:addChild(self.blood)
    
    --set
    self:setBlood(100)
    self.blood:setVisible(false)
end

function BaseEnemyView:setBlood(per)
	if per == 0 then 
		self.blood:setVisible(false) 
		return
	end

	-- --value
	local bloodUp 	= cc.uiloader:seekNodeByName(self.blood, "bloodUp")
	local bloodDown = cc.uiloader:seekNodeByName(self.blood, "bloodDown")
	bloodUp:setScaleX(per/100)
	transition.scaleTo(bloodDown, {scaleX = per/100, time = 0.1})

	--visible
	if self.bloodAction then 
		transition.removeAction(self.bloodAction)
		self.bloodAction = nil
	end
	self.blood:setVisible(true)
	local function hide()
		self.blood:setVisible(false)
	end
	self.bloodAction = self.blood:performWithDelay(hide, 1.0)

end

function BaseEnemyView:playAfterAlert(type,handler)
	self:showAlert()
	local alertAfterFunc = function ()
		self:play(type, handler)
	end
	self.alertAfter = scheduler.performWithDelayGlobal(alertAfterFunc, 2.0)
	self:addScheduler(self.alertAfter)
end

function BaseEnemyView:showAlert()
	--create
	if self.isShowAlerting then return end
	self.isShowAlerting = true
	local armature = ccs.Armature:create("tanhao")


    --add
    local bone = self.armature:getBone("alert")
    local posBone =  bone:convertToWorldSpace(cc.p(0.0,0.0))
    -- dump(posBone, "posBone")
    
    -- local destPos = self.armature:convertToNodeSpace(posBone)
    -- armature:setAnchorPoint(cc.p(0.0,0.0))
    local posArm = self.armature:convertToWorldSpace(cc.p(0, 0))
    local destPos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)    
    armature:setPosition(destPos)
    self.armature:addChild(armature) 

    --play
	armature:getAnimation():play("tanhao", -1, 0)
    local function alertAnimEvent(armatureBack,movementType,movementID)
        armature:removeFromParent()
        self.isShowAlerting = false
    end
    armature:getAnimation():setMovementEventCallFunc(alertAnimEvent)    
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
    local widthOffset = kWalkWidth * isLeft * self:getScale()
    local isAble = self:checkPlace(widthOffset)

    if not isAble then return end
	self.armature:getAnimation():play("walk" , -1, 1)
	local action = cc.MoveBy:create(1/60, cc.p(dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	
end

function BaseEnemyView:playHitted(event)
	local currentName = self.armature:getAnimation():getCurrentMovementID()
	print("function BaseEnemyView:playHitted(event)")
	--飘红
	self:playHittedEffect()

	--不重复播放
	if not self.enemy:isDead() and currentName ~= "hit" then
		self.armature:getAnimation():play("hit" ,-1 , 1)
	end
end

function BaseEnemyView:playKill(event)
	--clear
	self:clearPlayCache()
	self.armature:stopAllActions()
	self:setPause({isPause = true})

	
	--以防万一
	if self and self.setDeadDone then 
		scheduler.performWithDelayGlobal(handler(self, self.setDeadDone), 3.0)
	end

	self.armature:getAnimation():play("die" ,-1 , 1)
end

function BaseEnemyView:onHitted(targetData)
	-- print("BaseEnemyView:onHitted(targetData)")
	-- dump(targetData, "targetData")
	local demage 	 = targetData.demage
	local scale  	 = targetData.demageScale or 1.0
	local demageType = targetData.demageType
	if not(self.enemy:canHitted() and self:canHitted()) then
		return 
	end

	self.enemy:decreaseHp(demage * scale)

	--爆头
	if self.enemy:getHp() == 0 then 
		if demageType == "head" then 
			print("爆头")
			self.hero:dispatchEvent({
				name = self.hero.ENEMY_KILL_HEAD_EVENT})
		end
	end

	--hp
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	self:setBlood(hp/maxHp * 100)
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
	-- assert("required method, must implement me")
end

function BaseEnemyView:animationEvent(armatureBack,movementType,movementID)
	assert("required method, must implement me")	
end

return BaseEnemyView