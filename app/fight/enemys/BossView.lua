
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Boss = import(".Boss")
local FightConfigs = import("..fightConfigs.FightConfigs")
local BossView = class("BossView", Attackable)

function BossView:ctor(property)
	BossView.super.ctor(self, property) 

	--config
	self.config = FightConfigs:getBossConfig(property.configName)

    --blood
    self:initBlood() 

	-- --play
	self.armature:getAnimation():play("stand" , -1, 1) 

    --event
    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.playFire))  

    self:initBody()

    self:playWeak(1)
    scheduler.performWithDelayGlobal(handler(self, self.playSaoShe), 0.001)
end

--ui
function BossView:initBlood()
    --add blood
    cc.FileUtils:getInstance():addSearchPath("res/Fight/fightLayer/ui")
    local node = cc.uiloader:load("heroUI.ExportJson")
    self.blood = cc.uiloader:seekNodeByName(node, "bossBlood")
    self.blood:removeFromParent()
    local bound = self.armature:getBoundingBox()
    self.blood:setPosition(0, bound.height * 0.85)
    self.armature:addChild(self.blood, 100)
end

function BossView:setBlood(scale)
	if scale == 0 then 
		self.blood:setVisible(false)
		return
	end

    local test = 1 / 3
    local bloodHp = nil
    if scale > test * 2 then
    	bloodHp = cc.uiloader:seekNodeByName(self.blood, "bossBlood1")
    	test = 100 - (1 - scale) * 3 * 100
    elseif scale > test and scale <= test * 2 then
    	bloodHp = cc.uiloader:seekNodeByName(self.blood, "bossBlood2")
    	cc.uiloader:seekNodeByName(self.blood, "bossBlood1"):setPercent(0)
    	test = 100 - (test * 2 - scale) * 3 * 100
    else
    	cc.uiloader:seekNodeByName(self.blood, "bossBlood2"):setPercent(0)
    	bloodHp = cc.uiloader:seekNodeByName(self.blood, "bossBlood3")
    	test = scale * 3 * 100
    end
    
    bloodHp:setPercent(test)
end

function BossView:playStand()
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function BossView:playFire()
	self.armature:getAnimation():play("fire" , -1, 1) 
	self.enemy:hit(self.hero)	
end

function BossView:playHitted(event)
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
		local action = self.config:getMoveRightAction(1)
		self.armature:runAction(cc.RepeatForever:create(action))	

	else
		self.armature:getAnimation():play("moveleft" , -1, 1) 
		local action = self.config:getMoveLeftAction(1)
		self.armature:runAction(cc.RepeatForever:create(action))		
	end	
end

function BossView:playKill(event)
	--clear
	self:clearPlayCache()
	self.armature:stopAllActions()
	self:clearWeak()
	self:testStop(true)

	--play dead
	self.armature:getAnimation():play("dead" ,-1 , 1)
end

function BossView:playSkill(skillName)
	-- print("BossView:playSkill: "..skillName)
	local str =  string.sub(skillName, 1, 4)
	print("skillName", str)
	if skillName == "moveLeftFire" then 
		self:play("moveLeftFire", handler(self, self.playMoveLeftFire))
	elseif skillName == "moveRightFire" then 
		self:play("moveRightFire", handler(self, self.playMoveRightFire))
	elseif skillName == "saoShe" then
		self:play("saoShe", handler(self, self.playSaoShe))
	elseif skillName == "daoDan" then
		self:play("daoDan", handler(self, self.playDaoDan))
	
	elseif string.sub(skillName, 1, 4) == "weak" then 
		local index = string.sub(skillName, 5, 5)
		-- print("index", index)
		self:playWeak(tonumber(index))
	end
end

--skill
function BossView:playMoveLeftFire()
	--自己的位置
	local posOri = cc.p(self:getPositionX(), self:getPositionY())
	local speed = 1000.0
	local isLeft = true

	--出发
	local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
	local bound = self.armature:getBoundingBox()
	local disOut = -(pWorld.x + bound.width / 2)
	local time = math.abs(disOut) / speed
	local desPos = cc.p(disOut, posOri.y)
	local actionOut = cc.MoveBy:create(time, desPos)

	--到右屏幕
	local disScreen = display.width + bound.width
	time = math.abs(disScreen) / speed
 	desPos = cc.p(disScreen, posOri.y)
	local actionScreen1 = cc.MoveBy:create(time, desPos)

	--到左屏幕
	local disScreen2 = -disScreen
	time = math.abs(disScreen2) / speed
	desPos = cc.p(disScreen2, posOri.y)
	local actionScreen2 = cc.MoveBy:create(time, desPos)

	--返回
	local disBack = - disOut
	desPos = cc.p(disBack, posOri.y)
	time = math.abs(disScreen2) / speed
	local actionBack = cc.MoveBy:create(time, desPos)
	local seq = nil
	
	--出发之前
	local callfuncBeforeOut = function ()
		self.armature:getAnimation():play("moveleft" , -1, 1) --todo改为move
		self.pauseOtherAnim = true
	end
	local beforeOutCall = cc.CallFunc:create(callfuncBeforeOut)

	--到右屏幕之前
	local callfuncBeforeRight = function ()
		self.armature:getAnimation():play("ksmoveright" , -1, 1) 
		self:playDaoDan1()
	end
	local beforeRightCall = cc.CallFunc:create(callfuncBeforeRight)
   
	--到左屏幕之前
	local callfuncBeforeLeft = function ()
		self.armature:getAnimation():play("ksmoveleft" , -1, 1)
		self:playDaoDan1()
	end
	local beforeLeftCall = cc.CallFunc:create(callfuncBeforeRight)

	--回去之前
	local callfuncBeforeBack = function ()
		self.armature:getAnimation():play("moveright" , -1, 1)
	end
	local beforeBackCall = cc.CallFunc:create(callfuncBeforeBack)

	--回去之后
	local callfuncAfterLeft = function ()
		self.pauseOtherAnim = false
	end	
	local afterLeftCall = cc.CallFunc:create(callfuncAfterLeft)

	--play
	if isLeft then 
		seq = cc.Sequence:create(
		beforeOutCall, actionOut,
		beforeRightCall, actionScreen1, 
		beforeLeftCall, actionScreen2, 
		beforeBackCall, actionBack, afterLeftCall)	
	else 
		seq = cc.Sequence:create(actionBack , actionScreen2, actionScreen1, actionOut)	
	end
	self:runAction(seq)
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

	--持续开枪 0.1
	local fireOffset = self.enemy:getFireOffset()
	self:continueFire(20, fireOffset)
	
end

function BossView:continueFire(sumTimes, fireOffset)
	
	local sumTimes = 5
	local handler
	function saosheFire()
		if sumTimes == 0 then 
			scheduler.unscheduleGlobal(handler)
		end
		self.enemy:hit(self.hero)
		sumTimes = sumTimes - 1
	end
	handler = scheduler.scheduleGlobal(saosheFire, fireOffset)
end

function BossView:playDaoDan1()
	--导弹
    local enemys = {}
	for i=1,7 do
		local xPos = 30 + i * 120
		local data = {
			placeName = "place3",
			pos = cc.p(xPos, 10),
			delay = 0.4 * i,
			property = {
					type = "missile",
					id = 1,
					},
			}
		enemys[#enemys + 1] = data
	end
    self.hero:dispatchEvent({name = "ENEMY_ADD_EVENT", enemys = enemys})
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
			delay = 0.4 * i,
			property = {
					type = "missile",
					id = 1,
					},
			}
		enemys[#enemys + 1] = data
	end
    self.hero:dispatchEvent({name = "ENEMY_ADD_EVENT", enemys = enemys})
end

function BossView:clearWeak()
	--clear weaks
	for i,weakData in pairs(self.weakNode) do
		local anim = weakData["anim"]
		anim:setVisible(false)
		weakData.valid = false
	end

end

function BossView:playWeak(index)
	self:clearWeak()

	--play
	local weakData = self.weakNode["weak"..index]
	assert(weakData, "invalid index :"..index)
	local anim = weakData["anim"]
	weakData.valid = true
	anim:setVisible(true)
	anim:getAnimation():play("pre", -1, 1)

	local function animationWeak(armatureBack,movementType,movementID)
        if movementType == ccs.MovementEventType.loopComplete then
            if movementID == "pre" then
                armatureBack:stopAllActions()
                armatureBack:getAnimation():play("idle")
            end
        end
	end
	anim:getAnimation():setMovementEventCallFunc(animationWeak)
end


--接口 BossView:
function BossView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		if self.pauseOtherAnim then return end
		print("animationEvent id ", movementID)
		armatureBack:stopAllActions()
		if movementID ~= "dead" then
			local playCache = self:getPlayCache()
			if playCache then 
				playCache()
			else 					
				self:playStand()
			end
    	elseif movementID == "dead" then 
    		self:setDeadDone()
    	end 
	end
end

function BossView:tick(t)
	if self.pauseOtherAnim then return end 
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
end

function BossView:checkSkill(demage)
	if not demage then demage = 0 end 
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	local persentO = (hp + demage)
	local persentC = hp
	local skilltrigger = self.config.skilltrigger
	local skilltrigger = self.enemy:getSkillTrigger()
	for skillName,persents in pairs(skilltrigger) do
		for i, v in ipairs(persents) do
			local v = v * maxHp
			if persentC < v and v <= persentO then 
				-- print("v", v)
				-- print("persentC", persentC)
				-- print("persentO", persentO)
				print("playSKill:"..skillName)
				local function callfuncSkill()
					self:playSkill(skillName)
				end
				scheduler.performWithDelayGlobal(callfuncSkill, 1)
			end
		end
	end
end

local isRed = false
function BossView:onHitted(demage)

	--血量
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
			-- print("回复")
			self.armature:setColor(cc.c3b(255,255,255))
			
		end
	end

	local function callfuncRestore()
		isRed = false
	end

	-- print("变红")
	isRed = true
	self.armature:setColor(cc.c3b(255,50,5))
	local sch1 = scheduler.performWithDelayGlobal(callfunc, 20/60)
	local sch2 = scheduler.performWithDelayGlobal(callfuncRestore, 60/60)
	self:addScheduler(sch1)
	self:addScheduler(sch2)
end

function BossView:initBody()
	--body
	self.weakNode = {}
	local index = 1
	while(true) do 
		local boneName = "weak"..index
		local bone = self.armature:getBone(boneName)
		if bone == nil then break end
		
		--node
		local weakNode = bone:getDisplayRenderNode()
		local srcName = "Fight/uiAnim/ruodiangj/ruodiangj.ExportJson"
		
		--anim
		local animWeak = getArmature("ruodiangj", srcName)
		animWeak:getAnimation():play("idle" , -1, 1)
		local cbb = weakNode:getCascadeBoundingBox()
		animWeak:setPosition(cbb.origin.x + cbb.size.width/2,
					cbb.origin.y + cbb.size.height/2)
		animWeak:setVisible(false)
		self.armature:addChild(animWeak, 1000)

		--data
		local weakData = {node = weakNode , anim = animWeak, valid = false}
		self.weakNode[boneName] = weakData
		drawBoundingBox(self.armature, weakNode, "red") 
		index = index + 1
	end

	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
	drawBoundingBox(self.armature, bodyNode, "yellow")  
end

function BossView:getEnemyArmature()
	if self.armature then return self.armature end 
	--armature
    local src = "Fight/enemys/boss01/boss01.ExportJson"
    local armature = getArmature("boss01", src) 
	armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	return armature
end

function BossView:getRange(rectName)
	-- print("rectName", rectName)
	local range, isValid = BossView.super.getRange(self, rectName)
	if range == nil then return nil, false end
	local str =  string.sub(rectName, 1, 4)
	if str == "weak" then 
		local weakData = self.weakNode[rectName]
		assert(weakData, "weakData is nil" .. rectName) 
		isValid = weakData["valid"]
		-- print("isValid", isValid)
	end
	return range, isValid
end

function BossView:getModel(property)
	return Boss.new(property)
end

return BossView