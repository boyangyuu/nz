
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
import("...includes.functionUtils")
import(".BossConfigs")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local AbstractEnemyView = import(".AbstractEnemyView")
local Actor = import("..Actor")
local Boss = import(".Boss")
local BossView = class("BossView", AbstractEnemyView)


function BossView:ctor(property)
	BossView.super.ctor(self, property) 

	--config
	self.config = getBoss(1,1)

    --blood
    self:initBlood() 

	--play
	self.armature:getAnimation():play("stand" , -1, 1) 

    --event
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
    self.blood:setPosition(0, bound.height/2 + 150)
    self.armature:addChild(self.blood, 100) 
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
	self.enemy:hit(self.hero)	
end

function BossView:playHitted(event)
	-- print("playHitted")
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	self:setBlood(hp/maxHp)	
end

function BossView:playMove()  --改为onMove
	local isLeft = math.random(1, 2)
	local limitDis = 100
	local direction = isLeft == 1 and 1 or -1
	if not self:checkPlace(limitDis * direction) then return end
	
	if isLeft == 1 then 
		self.armature:getAnimation():play("moveright" , -1, 1) 
		local action = getMoveRightAction(1)
		self.armature:runAction(cc.RepeatForever:create(action))	

	else
		self.armature:getAnimation():play("moveleft" , -1, 1) 
		local action = getMoveLeftAction(1)
		self.armature:runAction(cc.RepeatForever:create(action))		
	end	
end

function BossView:playKill(event)
	self.armature:getAnimation():play("die" ,-1 , 1)
end

function BossView:playSkill(skillName)
	print("BossView:playSkill: "..skillName)
	if skillName == "moveLeftFire" then 
		self:play("skill", handler(self, self.playMoveLeftFire))
	elseif skillName == "moveRightFire" then 
		self:play("skill", handler(self, self.playMoveRightFire))
	elseif skillName == "saoShe" then
		self:play("skill", handler(self, self.playSaoShe))
	elseif skillName == "daoDan" then
		self:play("skill", handler(self, self.playDaoDan))
	end
end

--skill
function BossView:playMoveLeftFire()
	local dis = 2 
    local widthOffset = 100 
    local isAble = self:checkPlace(-widthOffset)
    if not isAble then return end

	self.armature:getAnimation():play("moveleftfire" , -1, 1)
	local action = cc.MoveBy:create(1/60, cc.p(-dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	

	self.enemy:hit(self.hero)
end

function BossView:playMoveRightFire()
	local dis = 2 
    local widthOffset = 100 
    local isAble = self:checkPlace(widthOffset)
    if not isAble then return end

	self.armature:getAnimation():play("moverightfire" , -1, 1)
	local action = cc.MoveBy:create(1/60, cc.p(dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	

	self.enemy:hit(self.hero)
end

function BossView:playSaoShe()
	self.armature:getAnimation():play("saoshe" , -1, 1)

	self.enemy:hit(self.hero)
end

function BossView:playDaoDan()
	self.armature:getAnimation():play("daodan", -1, 1)

	--导弹
    local enemys = {}
	for i=1,7 do
		local xPos = 30 + i * 120
		local data = {
			placeName = "place3",
			pos = cc.p(xPos, 10),
			delayOffset = 0.4,
			property = {
					type = "missile",
					id = 1,
					},
			}
		enemys[#enemys + 1] = data
	end
    self.hero:dispatchEvent({name = "ENEMY_ADD", enemys = enemys})
end

--skillEnd

function BossView:test()
	--body
	local weakNode = self.armature:getBone("weak1"):getDisplayRenderNode()
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
	drawBoundingBox(self.armature, weakNode, "red") 
	drawBoundingBox(self.armature, bodyNode, "yellow")  
end

--接口
function BossView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		-- print("animationEvent id ", movementID)
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

function BossView:tick(t)
	--change state
	local randomSeed 
	math.newrandomseed()

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
	local persentO = (hp + demage) / maxHp
	local persentC = hp / maxHp
	local skilltrigger = self.config.skilltrigger
	for skillName,persents in pairs(skilltrigger) do
		for i, v in ipairs(persents) do
			if persentC < v and v <= persentO then 
				print("playSKill:"..skillName)
				local function callfuncSkill()
					self:playSkill(skillName)
				end
				scheduler.performWithDelayGlobal(callfuncSkill, 2)
				return 
			end
		end
	end
end

local isRed = false
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
	
	--red
	if isRed then return end
	local function callfunc()
		if isRed then 
			print("回复")
			self.armature:setColor(cc.c3b(255,255,255))
			
		end
	end

	local function callfuncRestore()
		isRed = false
	end

	if not isRed then 
		print("变红")
		isRed = true
		self.armature:setColor(cc.c3b(255,50,5))
		scheduler.performWithDelayGlobal(callfunc, 20/60)
		scheduler.performWithDelayGlobal(callfuncRestore, 60/60)
	end
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
return BossView