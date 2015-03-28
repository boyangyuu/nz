
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Boss = import(".Boss")
local FightConfigs = import("..fightConfigs.FightConfigs")
local BaseBossView = class("BaseBossView", Attackable)

function BaseBossView:ctor(property)
	BaseBossView.super.ctor(self, property) 

	--config
	self.attackType = "weak"
	self.zhaohuanIndex  = 1
	local index = property.id
	local waveConfig = FightConfigs:getWaveConfig()
    
    --blood
    self:initBlood()
    self.config  	= waveConfig:getBoss(index)
    self.isUnhurted = false

	--play
	self.armature:getAnimation():play("stand" , -1, 1) 

    --event
    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.playFire))  
    cc.EventProxy.new(self.hero, self)
    	:addEventListener(self.hero.ENEMY_KILL_CALL_EVENT, handler(self, self.onKillCall)) 

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
    print("self.blood scale", self.blood:getScale())
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
    newScale = newScale * define.kEnemyAnimScale
    bloodUp:setScaleX(newScale)
    transition.scaleTo(bloodDown, {scaleX = newScale, time = 0.1})
end

function BaseBossView:playStand()
	local animName = self.isUnhurted and "stand02" or "stand"
	self.armature:getAnimation():play(animName , -1, 1)
end

function BaseBossView:playHitted(event)
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	self:setBlood(hp/maxHp)	
end

function BaseBossView:playMove() 
	local pos = self:getPosInMapBg()
	local isLeft = math.random(1, 2)
	local time   = define.kBlueBossWalkTime	
	local width  = 200 * self:getScale()
	local direction = isLeft == 1 and 1 or -1
	local action
	if not self:checkPlace(width * direction) then return end
	
	--action
	if isLeft == 1 then 
		self.armature:getAnimation():play("moveright" , -1, 1) 
		action = self.config:getMoveRightAction()
	else
		self.armature:getAnimation():play("moveleft" , -1, 1) 
		action = self.config:getMoveLeftAction()
	end	

	self.enemy:beginWalkCd()
    self:runAction(cc.Sequence:create(action, 
    	cc.CallFunc:create(handler(self, self.restoreStand))
    	))
	self:setPauseOtherAnim(true)    		
end

function BaseBossView:playKill(event)
	BaseBossView.super.playKill(self, event)

	self:clearWeak()
	self.armature:getAnimation():play("die" ,-1 , 1)

	--bomb
	self:playBombEffects()
	local hero = md:getInstance("Hero")
	hero:dispatchEvent({name = hero.ENEMY_KILL_BOSS_EVENT})
	
	--blood
	self.blood:setVisible(false)
end

function BaseBossView:playBombEffects()
	for i=1, 20 do
		self:performWithDelay(handler(self, self.playBombEffect), 
			i * 0.08)
	end
end

function BaseBossView:playSkill(skillName)
	if skillName == "moveLeftFire" then 
		self:play("skill", handler(self, self.playMoveLeftDaoFire))
	elseif skillName == "moveRightFire" then 
		self:play("skill", handler(self, self.playMoveRightDaoFire))
	elseif skillName == "chongfeng" then
		self:play("skill", handler(self, self.playChongfeng))
	elseif skillName == "tieqiu" then
		self:play("skill", handler(self, self.playTieQiu))
	elseif skillName == "zhaohuan" then
		self:play("skill", handler(self, self.playZhanHuan))
	elseif skillName == "wudi" then
		self:play("skill", handler(self, self.playWudi))		
				
	elseif string.sub(skillName, 1, 4) == "weak" then 
		local index = string.sub(skillName, 5, 5)
		-- print("index", index)
		self:playWeak(tonumber(index))
	elseif string.sub(skillName, 1, 6) == "demage" then 
		local num = string.sub(skillName, 7, 9)
		num = tonumber(num)
		-- print(" demage num", num)
		local per = num / 100
		self.enemy:setDemageScale(per)	
	elseif string.sub(skillName, 1, 6) == "daoDan" then 
        local function callfuncDao()
            self:playDaoDan(skillName)
        end
        self:play("skill",callfuncDao)	
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

	--向左/右出发
	local bound = self.armature:getCascadeBoundingBox() 
	local pos = self:getPosInMapBg()
	local disOut = isLeft and  -bound.width or 1560
	local time = math.abs(posOri.x - disOut) / speed
	local desPos = cc.p(disOut, posOri.y)
	local actionOut = cc.MoveTo:create(time, desPos)

	--到右屏幕 (isLeft)
	local desPosRight = cc.p(1560 + bound.width, posOri.y)
	local time = math.abs(1560 + bound.width) / speed
	local actionScreen1 = cc.MoveTo:create(time, desPosRight)

	--到左屏幕 (not isLeft)
	local desPosLeft = cc.p(- bound.width - 200, posOri.y)
	local time = math.abs(1560 + bound.width) / speed	
	local actionScreen2 = cc.MoveTo:create(time, desPosLeft)

	--返回
	local fromPos = isLeft and desPosRight or desPosLeft
	local time = math.abs(posOri.x - fromPos.x) / speed
	local actionBack = cc.MoveTo:create(time, posOri)
	local seq = nil

	--出发之前
	local callfuncBeforeOut = function ()
		self.armature:getAnimation():play("moveleft" , -1, 1) --todo改为move
		self:setPauseOtherAnim(true)
		self:setUnhurted(true)
	end
	local beforeOutCall = cc.CallFunc:create(callfuncBeforeOut)

	--到右屏幕之前
	local callfuncBeforeRight = function ()
		self.armature:getAnimation():play("ksmoveright" , -1, 1) 
		self:playMoveDaoDan()
	end
	local beforeRightCall = cc.CallFunc:create(callfuncBeforeRight)
   
	--到左屏幕之前
	local callfuncBeforeLeft = function ()
		self.armature:getAnimation():play("ksmoveleft" , -1, 1)
		self:playMoveDaoDan()
	end
	local beforeLeftCall = cc.CallFunc:create(callfuncBeforeRight)

	--回去之后
	local callfuncAfterBack = function ()
		self:setPauseOtherAnim(false)
		self:setUnhurted(false)
	end	
	local afterBackCall = cc.CallFunc:create(callfuncAfterBack)

	--play
	if isLeft then 
		seq = cc.Sequence:create(
		beforeOutCall, actionOut,
		beforeRightCall, actionScreen1, 
		cc.DelayTime:create(1.0),
		actionBack, afterBackCall)	
	else 
		seq = cc.Sequence:create(
		beforeOutCall, actionOut,
		beforeLeftCall, actionScreen2, 
		cc.DelayTime:create(1.0),
		actionBack, afterBackCall)	
	end
	self:runAction(seq)
end

function BaseBossView:playMoveDaoDan()
	--导弹
	for i=1,4 do
		local delay = 0.6 + 0.10 * i
		local property = {
			type = "missile",
			srcScale = self:getScale() * 0.3, --导弹view用
			demageScale = self.enemy:getDemageScale(),
			id = self.property["missileId"], 
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
		self:performWithDelay(callfuncAddDao, delay)  
	end
end

function BaseBossView:playDaoDan(skillName)
	self.armature:getAnimation():play("daodan", -1, 1)

    --pos
    local config = self.config[skillName] 
    local boneDao = self.armature:getBone("dao1"):getDisplayRenderNode()
    local pWorldBone = boneDao:convertToWorldSpace(cc.p(0, 0))
    
    --play
    local offset = self.config.daoDanTimeOffset or 0.6
    for i=1, #config.offsetPoses do
        local delay = offset * i 
        local property = {
            srcPos = pWorldBone,
            srcScale = self:getScale() * 0.4,
            destScale = 1.5,
            destPos = pWorldBone,
            offset = config.offsetPoses[i],
            type = "missile",
            id = self.property["missileId"],
            demageScale = self.enemy:getDemageScale(),
            missileType = "daodan",
        }
        local function callfuncDaoDan()
             self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, property = property})
        end
        self:performWithDelay(callfuncDaoDan, delay)       
    end 
end

function BaseBossView:playChongfeng()
	self.armature:getAnimation():play("chongfeng", -1, 1)

    --ahead begin
    local speed = 400
    local desY = -180
    local scale = 2.0
    local pWorld = self:convertToWorldSpace(cc.p(0,0))
    local posOri = cc.p(self:getPositionX(), self:getPositionY())
    local distanceY = desY - pWorld.y
    local time = math.abs(distanceY) /speed
    local desPos = cc.p(0, distanceY)
    local actionAhead = cc.MoveBy:create(time, desPos)
    local actionScale = cc.ScaleBy:create(time, scale)

    --callfunc
    local aheadEndFunc = function ()
  		--demage
        local destDemage = self.config["chongfengDemage"] 
        	* self.enemy:getDemageScale()
        self.enemy:hit(self.hero, destDemage)
        self:setPosition(posOri)
        self:scaleBy(0.01, 1/scale)
        local map = md:getInstance("Map")
        map:playEffect("shake")
        --restore
	    self:restoreStand()
    end

    local afterAhead = cc.CallFunc:create(aheadEndFunc)
    local seq = cc.Sequence:create(actionAhead, afterAhead)
    self:runAction(seq)
    self:setPauseOtherAnim(true)
    self:runAction(actionScale)	
end

function BaseBossView:playZhanHuan()
	self.armature:getAnimation():play("zhaohuan", -1, 1)
	self:zhaohuan()
end

function BaseBossView:zhaohuan()
	local waveData = self.config["enemys"..self.zhaohuanIndex]
	assert(waveData, "config is invalid, no enemys")
	self.enemysCallNum = 0
	for i,group in ipairs(waveData) do
		group.property["deadEventData"] = {name = "ENEMY_KILL_CALL_EVENT"}
		self.enemysCallNum = self.enemysCallNum + group.num
	end

	self.hero:dispatchEvent({name = self.hero.ENEMY_WAVE_ADD_EVENT, 
		waveData = waveData})

	self.zhaohuanIndex = self.zhaohuanIndex + 1
end

function BaseBossView:onKillCall(event)
	if self.enemysCallNum == nil then return end --todo 需要修改
	self.enemysCallNum = self.enemysCallNum  - 1
	if self.enemysCallNum == 0 then 
		self:onKillLastCall()
	end
end

function BaseBossView:onKillLastCall()

end

function BaseBossView:setUnhurted(isUnhurted)
	self.isUnhurted = isUnhurted
end

function BaseBossView:playWudi()
	if self.wudiAnim ~= nil then return end
	self.isUnhurted = true
	self.wudiAnim = ccs.Armature:create("wdhd")
	self.wudiAnim:getAnimation():play("wdhd", -1, 1)
	self.wudiAnim:setPosition(cc.p(0, 141))
	self.wudiAnim:setScale(1.3)
	self.armature:addChild(self.wudiAnim, 10000)
    self:performWithDelay(handler(self, self.endWudi), 
            self.config["wudiTime"])	
end

function BaseBossView:endWudi()
    self.isUnhurted = false
    if self.wudiAnim then 
	    self.wudiAnim:removeSelf()    
	    self.wudiAnim = nil
	end
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


function BaseBossView:tick(t)
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

		for i, v in ipairs(persents) do
			local v = v * maxHp
			if persentC < v and v <= persentO then 
				local function callfuncSkill()
					self:playSkill(skillName)
				end
				self:performWithDelay(callfuncSkill, 0.01)
			end
		end
	end 
end

function BaseBossView:canHitted()
	if self.isUnhurted then 
		return false
	end
	return true
end
 
function BaseBossView:onHitted(targetData)
	local demage 	 = targetData.demage
	local scale  	 = targetData.demageScale
	local destDemage = demage * scale
	assert(scale, "")
	local demageType = targetData.demageType
	
	--血量
	if not( self.enemy:canHitted() and self:canHitted() ) then
		return
	end
	self.enemy:decreaseHp(destDemage)

	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	local persent = hp/maxHp
	self:setBlood(persent)

	--血量触发技能
	self:checkSkill(destDemage)
	
	if persent < define.kGuideActiveJijia then self:checkGuide1() end

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
	self:performWithDelay(callfunc, 20/60)
	self:performWithDelay(callfuncRestore, 60/60)
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

function BaseBossView:onEnter()
	BaseBossView.super:onEnter(self)
end

function BaseBossView:checkGuide1()
	local guide = md:getInstance("Guide")
	local fight = md:getInstance("Fight")
	local gid = fight:getGroupId()
	local lid = fight:getLevelId()	
	local isGuideLevel = gid == 0 and lid == 0
	if not guide:isDone("fight01_jijia") and not self.isGuidedJijia 
		and isGuideLevel then 
		local isWillGuide = guide:check("fight01_jijia")
		if isWillGuide then
			self.isGuidedJijia = true
			local fight = md:getInstance("Fight")
			fight:stopFire()	

			--show jijia
			local data = {label_jijiaNum = true,  btnRobot = true}
			fight:dispatchEvent({name = fight.CONTROL_SET_EVENT,comps = data})			
		
			--show guide
			local hero = md:getInstance("Hero")
			hero:dispatchEvent({name = hero.EFFECT_GUIDE_EVENT, animName = "wudi"})
		end		
	end
end

return BaseBossView