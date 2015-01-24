
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
local BaseBossView = class("BaseBossView", Attackable)

function BaseBossView:ctor(property)
	BaseBossView.super.ctor(self, property) 

	--config
	self.attackType = "weak"
	-- dump(property, "property")
	local index = property.id
	local waveConfig = FightConfigs:getWaveConfig()
	self.config  = waveConfig:getBoss(index)
	-- dump(self.config, "self.config")
    
    --blood
    self:initBlood()
    self.isRed = false
	--play
	self.armature:getAnimation():play("stand" , -1, 1) 

    --event
    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.playFire))  

    self:initBody()

    self:playWeak(1)
end

--ui
function BaseBossView:initBlood()
    --add blood
	self.blood = cc.uiloader:load("res/Fight/fightLayer/fightBlood/bossBlood.ExportJson")    
    
    --pos
    local boneBlood = self.armature:getBone("blood")
    local posBone = boneBlood:convertToWorldSpace(cc.p(0, 0))
    local posArm = self.armature:convertToWorldSpace(cc.p(0, 0))
    local destpos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)
    self.blood:setPosition(destpos.x, destpos.y)
    self.armature:addChild(self.blood)
    
    --value
    self:setBlood(1.0)
end

function BaseBossView:setBlood(scale)
	if scale == 0 then 
		self.blood:setVisible(false)
		return
	end

    local bloodUp, bloodDown = nil, nil
    local newScale = nil

    --visible
    local node1 = cc.uiloader:seekNodeByName(self.blood, "blood1")
    local node2 = cc.uiloader:seekNodeByName(self.blood, "blood2")
    local node3 = cc.uiloader:seekNodeByName(self.blood, "blood3")
    node1:setVisible(true)
    node2:setVisible(true)
    node3:setVisible(true) 
    
    -- 0.75 - 1
    if scale > 0.75 then
    	local node = node1
    	node1:setVisible(true)
    	bloodUp    = cc.uiloader:seekNodeByName(node, "bloodUp")
    	bloodDown  = cc.uiloader:seekNodeByName(node, "bloodDown")
    	newScale   = (scale - 0.75) / (1 - 0.75)
    	node3:setVisible(false)
    	
    -- 0.40 - 0.75
    elseif scale > 0.40 and scale <= 0.75 then
    	local node = node2
    	node2:setVisible(true)
    	bloodUp    = cc.uiloader:seekNodeByName(node, "bloodUp")
    	bloodDown  = cc.uiloader:seekNodeByName(node, "bloodDown")
    	newScale   = (scale - 0.40) / (0.75 - 0.40)
	    node1:setVisible(false)
    	
    -- 0 - 0.40
    else
    	local node = node3
    	node3:setVisible(true)
    	bloodUp    = cc.uiloader:seekNodeByName(node, "bloodUp")
    	bloodDown  = cc.uiloader:seekNodeByName(node, "bloodDown")
    	newScale   = scale / 0.40
		node1:setVisible(false)
	    node2:setVisible(false)
    end

    -- local newPer = newScale * 100
    -- bloodUp:setPercent(newPer)
    bloodUp:setScaleX(newScale)
    transition.scaleTo(bloodDown, {scaleX = newScale, time = 0.1})
end

function BaseBossView:playStand()
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function BaseBossView:playFire()
	self.armature:getAnimation():play("fire" , -1, 1) 
	self.enemy:hit(self.hero)	
end

function BaseBossView:playHitted(event)
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	self:setBlood(hp/maxHp)	
	-- self:playBombEffect(2)
end

function BaseBossView:playMove()  --改为onMove
	local isLeft = math.random(1, 2)
	local limitDis = 100
	local direction = isLeft == 1 and 1 or -1
	if not self:checkPlace(limitDis * direction) then return end
	
	if isLeft == 1 then 
		self.armature:getAnimation():play("moveright" , -1, 1) 
		local action = self.config:getMoveRightAction()
		self.armature:runAction(cc.RepeatForever:create(action))	

	else
		self.armature:getAnimation():play("moveleft" , -1, 1) 
		local action = self.config:getMoveLeftAction()
		self.armature:runAction(cc.RepeatForever:create(action))		
	end	
	self.enemy:beginWalkCd()
end

function BaseBossView:playKill(event)
	--clear TODO
	self:clearPlayCache()
	self.armature:stopAllActions()
	self:clearWeak()
	self:setPause({isPause = true})

	--play dead
	self.armature:getAnimation():play("die" ,-1 , 1)

	--bomb
	self:playBombEffects()
	local hero = md:getInstance("Hero")
	hero:dispatchEvent({name = hero.ENEMY_KILL_BOSS_EVENT})
	
	--blood
	self.blood:setVisible(false)
end

function BaseBossView:playBombEffects()
	for i=1,32 do
		local sch = scheduler.performWithDelayGlobal(
			handler(self, self.playBombEffect), i * 0.1)
		self:addScheduler(sch)
	end
end

function BaseBossView:playSkill(skillName)
	print("BaseBossView:playSkill: "..skillName)
	if skillName == "moveLeftFire" then 
		self:play("skill", handler(self, self.playMoveLeftDaoFire))
	elseif skillName == "moveRightFire" then 
		self:play("skill", handler(self, self.playMoveRightDaoFire))
	elseif skillName == "saoShe" then
		self:play("skill", handler(self, self.playSaoShe))
	elseif skillName == "daoDan" then
		self:play("skill", handler(self, self.playDaoDan))
	elseif skillName == "chongfeng" then
		self:play("skill", handler(self, self.playChongfeng))
	elseif skillName == "tieqiu" then
		self:play("skill", handler(self, self.playTieQiu))
	elseif string.sub(skillName, 1, 4) == "weak" then 
		local index = string.sub(skillName, 5, 5)
		-- print("index", index)
		self:playWeak(tonumber(index))
	elseif string.sub(skillName, 1, 6) == "demage" then 
		local num = string.sub(skillName, 7, 9)
		num = tonumber(num)
		print(" demage num", num)
		local per = num / 100
		self.enemy:setDemageScale(per)	
	end
end

--skill
function BaseBossView:playMoveLeftDaoFire()
	self:platMoveDaoFireAction(true)
end

function BaseBossView:playMoveRightDaoFire()
	self:platMoveDaoFireAction(false)
end

function BaseBossView:platMoveDaoFireAction(isLeft)
	local posOri = cc.p(self:getPositionX(), self:getPositionY())
	local speed = 1000.0
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
		cc.DelayTime:create(2.0),
		beforeLeftCall, actionScreen2, 
		beforeBackCall, actionBack, afterLeftCall)	
	else 
		seq = cc.Sequence:create(
		beforeOutCall, actionBack,
		beforeRightCall, actionScreen2, 
		cc.DelayTime:create(2.0),
		beforeLeftCall, actionScreen1, 
		beforeBackCall, actionOut, afterLeftCall)	
	end
	self:runAction(seq)
end

function BaseBossView:playMoveRightFire()
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

function BaseBossView:playSaoShe()
	self.armature:getAnimation():play("saoshe" , -1, 1)

	--持续开枪 0.1
	local fireOffset = self.config["saoFireOffset"]
	local fireTimes = self.config["saoFireTimes"]
	self:continueFire(fireTimes, fireOffset)
	
end

function BaseBossView:continueFire(sumTimes, fireOffset)
	local handler = nil
	local sumTimes = sumTimes
	function saosheFire()
		if sumTimes == 0 then 
			scheduler.unscheduleGlobal(handler)
		end
		self.enemy:hit(self.hero)
		sumTimes = sumTimes - 1
	end
	handler = scheduler.scheduleGlobal(saosheFire, fireOffset)
end

function BaseBossView:playDaoDan1()
	--todo 改为bone
	--导弹
	for i=1,7 do
		local delay = 0.1 + 0.15 * i
		local property = {
			type = "missile",
			srcScale = self:getScale() * 0.3, --导弹view用
			demageScale = self.enemy:getDemageScale(),
			id = self.property["enemyId"], 
		}
		local function callfuncAddDao()
			local boneName = "dao2"
			local bone = self.armature:getBone(boneName):getDisplayRenderNode()
			local srcPos = bone:convertToWorldSpace(cc.p(0.0,0.0))
			property.srcPos = srcPos
			property.destPos = srcPos
			self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, 
				property = property})
		end
		local sch = scheduler.performWithDelayGlobal(callfuncAddDao, delay)
	    self:addScheduler(sch)    
	end
end

function BaseBossView:playDaoDan()
	self.armature:getAnimation():play("daodan", -1, 1)

	local kDelayAnim = 0.6 		-- 导弹动画播放0.6s 再发导弹
	--导弹
	for i=1,2 do
		print("BaseBossView :getDemageScale(),",self.enemy:getDemageScale())
		local boneName = "dao"..i
		local bone = self.armature:getBone(boneName):getDisplayRenderNode()
		local delay = kDelayAnim
		local property = {
			type = "missile",
			srcScale = self:getScale() * 0.3, --导弹view用
			demageScale = self.enemy:getDemageScale(),
			id = self.property["enemyId"], 
		}
		local function callfuncAddDao()
			local srcPos = bone:convertToWorldSpace(cc.p(0.0,0.0))
			property.srcPos = srcPos
			property.destPos = srcPos			
			self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, 
				property = property})
		end
		local sch = scheduler.performWithDelayGlobal(callfuncAddDao, delay)
	    self:addScheduler(sch)    
	end	
end

function BaseBossView:playChongfeng()
	self.armature:getAnimation():play("chongfeng", -1, 1)
    --前进
    self.isAheading = true
    local speed = 400
    local desY = -180
    local scale = 2.0

    local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
    -- dump(pWorld, "pWorld")
    local posOri = cc.p(self:getPositionX(), self:getPositionY())
    
    local distanceY = desY - pWorld.y
    local time = math.abs(distanceY) /speed
    local desPos = cc.p(0, distanceY)
    local actionAhead = cc.MoveBy:create(time, desPos)
    local actionScale = cc.ScaleBy:create(time, scale)

    --
    local aheadEndFunc = function ()
        -- print("aheadEnd")
        self.isAheading = false
        local destDemage = self.property["chongfengDemage"]
        self.enemy:hit(self.hero, destDemage)
        self:setPosition(posOri)
        self:scaleBy(0.01, 1/scale)
        local map = md:getInstance("Map")
        map:playEffect("shake")
    end
    local afterAhead = cc.CallFunc:create(aheadEndFunc)
    local seq = cc.Sequence:create(actionAhead, afterAhead)
    self:runAction(seq)

    self:runAction(actionScale)	
end

function BaseBossView:clearWeak()
	--clear weaks
	for i,weakData in pairs(self.weakNode) do
		local anim = weakData["anim"]
		anim:setVisible(false)
		weakData.valid = false
	end
end

function BaseBossView:playWeak(index)
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


--接口 BaseBossView:
function BaseBossView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		if self.pauseOtherAnim and movementID ~= "die" then 
			return 
		end		
		-- print("animationEvent id ", movementID)
		armatureBack:stopAllActions()
		if movementID ~= "die" then
			local playCache = self:getPlayCache()
            if self.isAheading then 
                print("禁止")
                return
            end			
			if playCache then 
				playCache()
			else 					
				self:playStand()
			end
    	elseif movementID == "die" then 
    		self:setDeadDone(true)
    	end 
	end
end

function BaseBossView:tick(t)
	if self.pauseOtherAnim then return end 
	--change state
	local randomSeed 

	--fire
	local fireRate, isAble = self.enemy:getFireRate()
	assert(fireRate > 1, "invalid fireRate")
	if isAble then 
		randomSeed = math.random(1, fireRate)
		if randomSeed > fireRate - 1 then 
			self:play("playFire", handler(self, self.playFire))
			self.enemy:beginFireCd()
		end
	end

	--walk
	local walkRate, isAble = self.enemy:getWalkRate()
	assert(walkRate > 1, "invalid walkRate")

	if isAble then
		randomSeed =  math.random(1, walkRate)
		if randomSeed > walkRate - 1 then 
			self:play("playWalk", handler(self, self.playMove))
		end
	end
end

function BaseBossView:checkSkill(demage)
	if not demage then demage = 0 end 
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	local persentO = (hp + demage)
	local persentC = hp
	local skilltrigger = self.config["skilltrigger"]
	for skillName,persents in pairs(skilltrigger) do
		print("skillName：", skillName)
		print("persents", persents)

		for i, v in ipairs(persents) do
			print("i:"..i.."	v:"..v)
			local v = v * maxHp
			if persentC < v and v <= persentO then 
				print("v", v)

				print("persentC", persentC)
				print("persentO", persentO)

				print("playSKill:"..skillName)
				local function callfuncSkill()
					self:playSkill(skillName)
				end
				scheduler.performWithDelayGlobal(callfuncSkill, 0.01)
			end
		end
	end
end

 
function BaseBossView:onHitted(targetData)
	local demage 	 = targetData.demage
	local scale  	 = targetData.demageScale
	local destDemage = demage * scale
	assert(scale, "")
	local demageType = targetData.demageType
	
	--血量
	if self.enemy:canHitted() then
		self.enemy:decreaseHp(destDemage)
	end

	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	local persent = hp/maxHp
	self:setBlood(persent)

	--血量触发技能
	self:checkSkill(destDemage)
	
	--red
	if self.isRed then return end
	local function callfunc()
		if self.isRed then 
			-- print("回复")
			self.armature:setColor(cc.c3b(255,255,255))
			
		end
	end

	local function callfuncRestore()
		self.isRed = false
	end

	-- print("变红")
	self.isRed = true
	self.armature:setColor(cc.c3b(255,50,5))
	local sch1 = scheduler.performWithDelayGlobal(callfunc, 20/60)
	local sch2 = scheduler.performWithDelayGlobal(callfuncRestore, 60/60)
	self:addScheduler(sch1)
	self:addScheduler(sch2)
end

function BaseBossView:initBody()
	--body
	self.weakNode = {}
	local index = 1
	while(true) do 
		local boneName = "weak"..index
		local bone = self.armature:getBone(boneName)
		if bone == nil then break end
		
		--node
		local weakNode = bone:getDisplayRenderNode()

		--anim
		local animWeak = ccs.Armature:create("ruodiangj")
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

function BaseBossView:getRange(rectName)
	-- print("rectName", rectName)
	local range, isValid = BaseBossView.super.getRange(self, rectName)
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

function BaseBossView:getModel(property)
	return Boss.new(property)
end

return BaseBossView