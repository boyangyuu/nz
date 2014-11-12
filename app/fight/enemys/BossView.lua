
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
import("...includes.functionUtils")
local AbstractEnemyView = import(".AbstractEnemyView")
local Actor = import("..Actor")
local Boss = import(".Boss")
local BossView = class("BossView", AbstractEnemyView)

function BossView:ctor(property)
	BossView.super.ctor(self, property) 

    -- --blood
    self:initBlood() 

	--play
	self.armature:getAnimation():play("stand" , -1, 1) 

    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.playFire))  
    
    --test
    self:test()
end

--ui
function BossView:initBlood()
    --add blood
    cc.FileUtils:getInstance():addSearchPath("res/Fight/fightLayer/ui")
    local node = cc.uiloader:load("UI.json")    
    self.blood = cc.uiloader:seekNodeByName(node, "enemyBlood")
    self.blood:removeFromParent()
    local bound = self.armature:getBoundingBox()
    self.blood:setPosition(0, bound.height/2 + 300)
    self.armature:addChild(self.blood) 
	self.bloodValueNode = cc.uiloader:seekNodeByName(self.blood , "blood")
	self:setBlood(1.0)
end

function BossView:setBlood(scale)
    local bloodBg = cc.uiloader:seekNodeByName(self.blood, "bloodBg")
    local oSize = bloodBg:getContentSize()
    self.bloodValueNode:setLayoutSize(oSize.width * scale, oSize.height)	
end

function BossView:playStand()
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function BossView:playFire()
	self.armature:getAnimation():play("fire" , -1, 1) 

	--fire 
	print("self.hero:getHp()", self.hero:getHp())
	print("self.enemy:getDemage()", self.enemy:getDemage())
	self.enemy:hit(self.hero)	
end

function BossView:playHitted(event)
	print("playHitted")
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	self:setBlood(hp/maxHp)	
end

function BossView:playMove()
	local randomSeed = math.random(1, 2)
	local limitDis = 100
	local scale = randomSeed == 1 and 1 or -1
	if not self:checkPlace(limitDis * scale) then return end
	if randomSeed == 1 then 
		self.armature:getAnimation():play("moveright" , -1, 1) 
	else
		self.armature:getAnimation():play("moveleft" , -1, 1) 
	end
	local dis = 5 * scale
	local action = cc.MoveBy:create(1/60, cc.p( dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))		
end

function BossView:playKill(event)
	self.armature:getAnimation():play("die" ,-1 , 1)
end

function BossView:test()
	--body
	local weakNode = self.armature:getBone("weak1"):getDisplayRenderNode()
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
	drawBoundingBox(self.armature, weakNode, "red") 
	drawBoundingBox(self.armature, bodyNode, "yellow")  
end

--接口
function BossView:animationEvent(armatureBack,movementType,movementID)
	-- print("animationEvent id ", movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		armatureBack:stopAllActions()
		if movementID ~= "die" then
			self:playStand()
    	elseif movementID == "die" then 
    		self:setDeadDone()
    	end 
	end
end

function BossView:tick(t)
	--change state
	local randomSeed 

	--fire
	local fireRate = self.enemy:getFireRate()
	
	randomSeed = math.random(1, fireRate)
	if randomSeed > fireRate - 1 then 
		self:play("fire", handler(self, self.playFire))
		return
	end

	--move
	local moveRate = self.enemy:getMoveRate()
	randomSeed =  math.random(1, moveRate)
	if randomSeed > moveRate - 1 then 
		self:play("move", handler(self, self.playMove))
		return 
	end

	--检测死亡
	if self.enemy:getHp() == 0 then
		self:play("die", handler(self, self.playKill))
	end
end

function BossView:checkSkill(demage)
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	local persentOrigin = (hp + demage) / maxHp
	local persent = hp / maxHp	
	
end

function BossView:onHitted(demage)
	if self.enemy:canHitted() then
		self.enemy:decreaseHp(demage)
	end

	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	local persent = hp/maxHp
	self:setBlood(persent)

	--血量触发技能
	self:checkSkill(demage)
end

function BossView:getEnemyArmature()
	if self.armature then return self.armature end 
	--armature
    local src = "Fight/enemys/boss01/boss01.ExportJson"
    local armature = getArmature("boss01", src) 
	armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	return armature
end

function BossView:getModel(id)
	return Boss.new({id = id})
end

function BossView:getStateMatches()
	local stateMatches = {
		stand = {"hit", "moveleft", "fire"},
		move = {"stand"},
		fire = {"stand","hit",},
		hit = {"walk", "stand", "fire",
			checkFunc = function(self) 
				return self.enemy:canHitted()  
			end,},
		die = {"stand", "hit", "walk", "fire"},
	}	
	return stateMatches
end

return BossView