
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Boss = import(".Boss")
local BaseBossView = class("BaseBossView", Attackable)

local kBloodMaxN = 6

function BaseBossView:ctor(property)
	BaseBossView.super.ctor(self, property) 

	--config
	self.attackType = "weak"
	local index = property.id
	local fightConfigs  = md:getInstance("FightConfigs")
	local waveConfig = fightConfigs:getWaveConfig()	
	self.bloodNum = 4
    
    --blood
    self:initBlood()
    self.config  	= waveConfig:getBoss(index)
    self.isUnhurted = false
    self.zhaohuans = {}
    
	--play
	self.armature:getAnimation():play("stand" , -1, 1) 

    --event
    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_INCREASE_EVENT, handler(self, self.refreshBlood)) 
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.refreshBlood)) 

        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.playFire))  
    cc.EventProxy.new(self.hero, self)
    	:addEventListener(self.hero.ENEMY_KILL_CALL_EVENT, handler(self, self.onKillCall)) 

    self:initBody()

    self:playWeak(1)
end

--ui
function BaseBossView:initBlood()
	assert(self.bloodNum <= kBloodMaxN, "self.bloodNum is beyoud limit")
    
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
    self:refreshBlood({})
end
function BaseBossView:refreshBlood(event)
	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	local persent = hp/maxHp

	if persent == 0 then return end

	--guide
	if persent < define.kGuideActiveJijia then self:checkGuide1() end

	--init
	local isIncrease = event.name == Actor.HP_INCREASE_EVENT
	for i=1, kBloodMaxN do
		local node = cc.uiloader:seekNodeByName(self.blood, "blood" .. i)
		node:setVisible(false)
    	local up   = cc.uiloader:seekNodeByName(node, "bloodUp")
    	local down = cc.uiloader:seekNodeByName(node, "bloodDown")	
	end

	--data
	local offset    = 1.00 / self.bloodNum
	local bloodUp, bloodDown
	local showNum   = math.ceil(persent / offset) 
	local nodeScale = (persent - (showNum - 1) * offset ) / offset
	assert(showNum >= 1 and showNum <= kBloodMaxN)

	for i = 1, showNum do
		local node = cc.uiloader:seekNodeByName(self.blood, "blood" .. i)
		node:setVisible(true)
		if i == showNum then 
	    	bloodUp    = cc.uiloader:seekNodeByName(node, "bloodUp")
	    	bloodDown  = cc.uiloader:seekNodeByName(node, "bloodDown")			
    	else
    		up   = cc.uiloader:seekNodeByName(node, "bloodUp")
    		down = cc.uiloader:seekNodeByName(node, "bloodDown")	
    		up:setScaleX(1.0)
    		down:setScaleX(1.0)
    	end	
	end

    if isIncrease then 
	    bloodDown:setScaleX(nodeScale)
	    transition.scaleTo(bloodUp, {scaleX = nodeScale, time = 0.1})
	else
	    bloodUp:setScaleX(nodeScale)
	    transition.scaleTo(bloodDown, {scaleX = nodeScale, time = 0.1})			
    end	    	
end

function BaseBossView:playStand()
	local animName = self.isUnhurted and "stand02" or "stand"
	self.armature:getAnimation():play(animName , -1, 1)
end

function BaseBossView:playHitted(event)

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

	--sound
    local src = "res/Music/fight/bossbz.wav"
    audio.playSound(src, false)	
end

function BaseBossView:playBombEffects()
	for i=1, 10 do
		self:performWithDelay(handler(self, self.playBombEffect), 
			i * 0.2)
	end
end

function BaseBossView:playSkill(skillName, index)
	if skillName == "moveLeftFire" then 
		self:play("skill", handler(self, self.playMoveLeftDaoFire))
	elseif skillName == "moveRightFire" then 
		self:play("skill", handler(self, self.playMoveRightDaoFire))
	elseif skillName == "chongfeng" then
		self:play("skill", handler(self, self.playChongfeng))
	elseif skillName == "tieqiu" then
		self:play("skill", handler(self, self.playTieQiu))
	elseif skillName == "zhaohuan" then
		local function zhanHuanCallfunc()
			self:playZhanHuan(index)
		end
		self:play("skill", zhanHuanCallfunc)
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
	print("platMoveDaoFireAction(isLeft)")
	self:setPauseOtherAnim(true)
	local posOri = cc.p(self:getPositionX(), self:getPositionY())
	local speed = 1000.0

	--向左/右出发
	local bound = self.armature:getBoundingBox() 
	if bound.width > 1500 then bound.width = 1500 end

	local pos = self:getPosInMapBg()
	local disOut = isLeft and  -bound.width or 1560
	local time1 = math.abs(posOri.x - disOut) / speed
	print("向左/右出发", time1)
	local desPos = cc.p(disOut, posOri.y)
	local actionOut = cc.MoveTo:create(time1, desPos)

	--到右屏幕 (isLeft)
	local desPosRight = cc.p(1560 + bound.width, posOri.y)
	local time2 = math.abs(1560 + bound.width) / speed
	print("1560 + bound.width", 1560 + bound.width)
	print("到右屏幕", time2)
	local actionScreen1 = cc.MoveTo:create(time2, desPosRight)

	--到左屏幕 (not isLeft)
	local desPosLeft = cc.p(- bound.width - 200, posOri.y)
	local time3 = math.abs(1560 + bound.width) / speed	
	print("到左屏幕", time3)
	local actionScreen2 = cc.MoveTo:create(time3, desPosLeft)

	--返回
	local fromPos = isLeft and desPosRight or desPosLeft
	
	local time4 = math.abs(posOri.x - fromPos.x) / speed
	local actionBack = cc.MoveTo:create(time4, posOri)
	local seq = nil
	print("返回", time)

	--出发之前
	local callfuncBeforeOut = function ()
		print("callfuncBeforeOut")
		self.armature:getAnimation():play("moveleft" , -1, 1) --todo改为move
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
		print("callfuncAfterBack")
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
			level = self.property["missileLevel"],
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
    local offset = config.timeOffset or 0.1
    local id     = config.id
    local type   = config.type
    for i=1, #config.offsetPoses do

    	local srcPos = cc.p(0,0)
    	if config.srcPoses then 
    		srcPos = config.srcPoses[i]
    	end

        local delay = offset * i 
        local property = {
            srcPos = cc.pAdd(pWorldBone ,srcPos),
            srcScale = self:getScale() * 0.4,
            destScale = 1.0,
            destPos = pWorldBone,
            offset = config.offsetPoses[i],
            flyTime = config.flyTime,
            id = id,
            type = type,
            demageScale = self.enemy:getDemageScale(),
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
    local scaleSrc = self:getScaleX()
    local pWorld = self:convertToWorldSpace(cc.p(0,0))
    local posOri = cc.p(self:getPositionX(), self:getPositionY())
    local distanceY = desY - pWorld.y
    local time = math.abs(distanceY) /speed
    local desPos = cc.p(0, distanceY)
    local actionAhead = cc.MoveBy:create(time, desPos)
    local actionScale = cc.ScaleTo:create(time, scaleSrc * 2)

    --callfunc
    local aheadEndFunc = function ()
  		--demage
        local destDemage = self.config["chongfengDemage"] 
        	* self.enemy:getDemageScale()
        self.enemy:hit(self.hero, destDemage)
        self:setPosition(posOri)
        self:scaleTo(0.01, scaleSrc)
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

function BaseBossView:playZhanHuan(index)
	self.armature:getAnimation():play("zhaohuan", -1, 1)
	self:zhaohuan(index)
end

function BaseBossView:zhaohuan(index)
	local name     = "enemys"..index
	if self.zhaohuans[name] then 
		return 
	end
	dump(self.zhaohuans, "self.zhaohuans")
	print("name", name)
	self.zhaohuans[name] = true
	dump(self.zhaohuans, "self.zhaohuans")
	local waveData = self.config[name]
	assert(waveData, "config is invalid, no wave, zhaohuanIndex:" .. index)
	self.enemysCallNum = 0
	for i,group in ipairs(waveData) do
		local bossId = self.property["id"]
		group.property["deadEventData"] = {name = self.hero.ENEMY_KILL_CALL_EVENT, 
											bossId = bossId}
		self.enemysCallNum = self.enemysCallNum + group.num
	end

	self.hero:dispatchEvent({name = self.hero.ENEMY_WAVE_ADD_EVENT, 
		waveData = waveData})
end

function BaseBossView:onKillCall(event)
	if self.enemysCallNum == nil then return end --todo 需要修改
	if self.property["id"] ~= event.bossId then return end
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
	-- print("persentO", persentO)
	-- print("persentC", persentC)

	local skilltrigger = self.config["skilltrigger"]
	for skillName,persents in pairs(skilltrigger) do
		for i, v in ipairs(persents) do
			local v = v * maxHp
			if persentC < v and v <= persentO then 
				-- print("v", v)
				local function callfuncSkill()
					self:playSkill(skillName, i)
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

	--血量触发技能
	self:checkSkill(destDemage)
	
	self:playHittedEffect()
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
	end
	return range, isValid
end

function BaseBossView:getModel(property)
	return Boss.new(property)
end

function BaseBossView:onEnter()
	BaseBossView.super.onEnter(self)
end

function BaseBossView:checkGuide1()
	local guide = md:getInstance("Guide")
	local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
	local gid = fight:getGroupId()
	local lid = fight:getLevelId()	
	local isGuideLevel = gid == 0 and lid == 0
	if not guide:isDone("fight01_jijia") and not self.isGuidedJijia 
		and isGuideLevel then 
		local isWillGuide = guide:check("fight01_jijia")
		if isWillGuide then
			self.isGuidedJijia = true
			local fightFactory = md:getInstance("FightFactory")
		    local fight = fightFactory:getFight()
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