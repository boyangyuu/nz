
--[[--

“英雄”的视图

]]

--import
local scheduler = require("framework.scheduler")
local Actor 	= import(".Actor")
local Hero 		= import(".Hero")
local Fight 	= import(".Fight")
local FightInlay= import(".FightInlay")
local Guide 	= import("..guide.GuideModel")
local Defence   = import(".defence") 

--kconfig
local kGoldActivate = 10
local kRemainSumTimes = 2
local kLeiDemage = 600.0
local kLeiW = 100.0

local HeroLayer = class("HeroLayer", function()
    return display.newLayer()
end)

function HeroLayer:ctor(properties)

	--instance
	self.hero 	= app:getInstance(Hero)
	self.guide 	= app:getInstance(Guide)
	self.inlay 	= app:getInstance(FightInlay)
	self.defence = app:getInstance(Defence)

	--注册英雄事件
	cc.EventProxy.new(self.hero, self)
		:addEventListener(Actor.HP_INCREASE_EVENT			, handler(self, self.onHeroHpChange))
		:addEventListener(Actor.HP_DECREASE_EVENT			, handler(self, self.onHurtEffect))
		:addEventListener(Hero.EFFECT_HURT_BOMB_EVENT		, handler(self, self.onHurtBombEffect))		
		:addEventListener(Hero.SKILL_ROBOT_START_EVENT		, handler(self, self.onShowRobot))

		:addEventListener(Hero.SKILL_GRENADE_START_EVENT	, handler(self, self.onThrowGrenade))		
		:addEventListener(Hero.ENEMY_KILL_ENEMY_EVENT		, handler(self, self.killEnemyCallBack))
		:addEventListener(Hero.ENEMY_KILL_HEAD_EVENT		, handler(self, self.effectPopupHead))		
		:addEventListener(Hero.GUN_RELOAD_EVENT				, handler(self, self.effectGunReload))
	
	cc.EventProxy.new(self.inlay, self)
		:addEventListener(FightInlay.INLAY_GOLD_BEGIN_EVENT	, handler(self, self.onActiveGold))
	
	cc.EventProxy.new(self.defence, self)
		:addEventListener(Defence.DEFENCE_SWITCH_EVENT	, handler(self, self.onSwitchDefence))
		:addEventListener(Defence.DEFENCE_RESUME_EVENT	, handler(self, self.onResumeDefence))
	--ui
	self:initUI()

	--data
	self:initData()
	
	self:setTouchEnabled(false) 
	self:setNodeEventEnabled(true)
end

function HeroLayer:initUI()
	self:loadCCS()
	self:initHeroHpNode()
	self:initDefenceNode()
	self:initKillTimerNode()

	scheduler.performWithDelayGlobal(handler(self, self.initGuide), 0.01)
end

function HeroLayer:initData()
	--robot

	--defence
	self.isDefenceAble = true
	self.crackSprites = {}
	self.behurtCount = 1

	--killtimer
	self.killCntKeep = 0
	self.killCntTotal = 0

	--hp
	self:updateHp()
end

--获得UI.ExportJson数据
function HeroLayer:loadCCS()
	self.ui = cc.uiloader:load("res/Fight/fightLayer/ui/heroUI.ExportJson")
	self:addChild(self.ui)
end

--初始化英雄血条
function HeroLayer:initHeroHpNode()
	self.hp = cc.uiloader:seekNodeByName(self.ui, "hp")
	self.robotNode = cc.uiloader:seekNodeByName(self.ui, "robot")


	self.robotNode:setVisible(false)	
end

--获得盾牌Ui节点
local defenceHeight = 0 --todo
function HeroLayer:initDefenceNode()
	self.isLaunchDefenceResume = false
	self.defenceNode = cc.uiloader:seekNodeByName(self.ui, "defence")
	self.defenceNode:setVisible(false)
	
	local upFrame = cc.uiloader:seekNodeByName(self.defenceNode, "upFrame")
	local downFrame = cc.uiloader:seekNodeByName(self.defenceNode, "downFrame")
	local upFrameHeight = upFrame:getCascadeBoundingBox().size.height
	local downFrameHeight = downFrame:getCascadeBoundingBox().size.height
	defenceHeight = downFrameHeight + upFrameHeight

	self.remainTimes = kRemainSumTimes


end

--初始化连杀倒计时节点
function HeroLayer:initKillTimerNode()
    self.killTimerBg = cc.uiloader:seekNodeByName(self.ui, "killTimerBg")
    self.killTimerBg:setVisible(false)

    self.killLabel = cc.uiloader:seekNodeByName(self.ui, "labelKillEnemyCount")
    self.killLabel:setVisible(false)

    self.killTimer = display.newProgressTimer("#huan_lv.png", display.PROGRESS_TIMER_RADIAL)
    self:addChild(self.killTimer)
    self.killTimer:setPosition(76, 420)
    self.killTimer:setReverseDirection(true)
    self.killTimer:setPercentage(100)
    self.killTimer:setVisible(false)
end

--player血条血量改变 
function HeroLayer:onHeroHpChange(event)
	   local per = self.hero:getHp() / self.hero:getMaxHp() * 100
	   self.hp:setPercent(per)
	-- local per1 = self.hero:getHp() / self.hero:getMaxHp() * 100
	-- local t1 = self.hp:getPercent()
	-- local tempHandler = nil

	-- local function checkHeroHp( dt )
	-- 	if t1 < per1 then
	-- 		scheduler.unscheduleGlobal(tempHandler)
	-- 		return
	-- 	end

	-- 	t1 = t1 - 0.4
	-- 	if t1 > 0 then
	-- 		self.hp:setPercent(t1)
	-- 	else
	-- 		scheduler.unscheduleGlobal(tempHandler)
	-- 	end
	-- end
	-- tempHandler = scheduler.scheduleGlobal(checkHeroHp, 0.05)
end

--杀死敌人后跳出3金币
function HeroLayer:killEnmeyGold(enemyPos)
	for i = 1, 3 do
		local armature = ccs.Armature:create("gold")
		armature:setPosition(enemyPos.x, enemyPos.y)
		armature:getAnimation():play("Animation1", -1, 1)
		armature:runAction(cc.Sequence:create(
			--todo 待优化
			cc.JumpBy:create(0.7, cc.p(i * 12, 0), 80, 1),
			cc.DelayTime:create(0.5 - i * 0.1),
			cc.MoveTo:create(0.5, cc.p(884, 591)), --todo
			cc.CallFunc:create(function ()
				if i == 1 then
					self.hero:dispatchEvent({name = "changeGold", 
						goldCount = self.killCntTotal * 50})
				end
				armature:removeFromParent()
			end)
		))
		self:addChild(armature)
	end
end

--触发黄金武器
function HeroLayer:onActiveGold(event)
	-- print("HeroLayer:onActiveGold(event)")
	self.hero:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, isPause = true})
	local armature = ccs.Armature:create("hjwq")
	addChildCenter(armature, self)
    local anim = armature:getAnimation()
	anim:playWithIndex(0)
    anim:setMovementEventCallFunc(
    	function ( armatureBack,movementType,movementId ) 
	    	if movementType == ccs.MovementEventType.complete then
				-- print("HeroLayer:activeGold() resume")
				self.hero:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, isPause = false})
				armature:removeFromParent()
	    	end 
    	end
    )
end

--杀掉敌人后的回调
local percent = 100
function HeroLayer:killEnemyCallBack( event )
	self.killLabel:setVisible(true)
	self.killTimerBg	:setVisible(true)
	self:killEnmeyGold(event.enemyPos)
	self.killCntKeep  = self.killCntKeep + 1
	self.killCntTotal = self.killCntTotal + 1
	local strKillEnemyCount = string.format("X %d", self.killCntKeep)
	self.killLabel:setString(strKillEnemyCount)

	--触发黄金武器
	if kGoldActivate <= self.killCntKeep then
		self.killCntKeep = 0
		self.hero:activeGold()
		return
	end

	-- body
	self.killTimer:setVisible(true)
	self.killTimer:setPercentage(100)
	percent = 100

	--如果发生连杀,在第二次倒计时的时候将上次倒计时的进度条关闭
	if self.killTimerHandler then 
		scheduler.unscheduleGlobal(self.killTimerHandler)
		self.killTimerHandler = nil
	end

    local function tick(dt)
        if 0 == percent then
        	scheduler.unscheduleGlobal(self.killTimerHandler)
        	self.killCntKeep = 0
    		self.killLabel:setVisible(false)
			self.killTimerBg:setVisible(false)
        end
        self.killTimer:setPercentage(percent - 1)
        percent = percent - 1
    end

    self.killTimerHandler = scheduler.scheduleGlobal(tick, 0.03)
end

--开启机甲
function HeroLayer:onShowRobot(event)
	--armature
	local armature = ccs.Armature:create("jijia")
	armature:setPosition(display.width/2 , display.height1/2)
	self:addChild(armature)
	local anim = armature:getAnimation()
	anim:play("jijia", -1 ,0)
	-- self.robotNode:setVisible(true)
end

--盾牌恢复完成的回调
function HeroLayer:onResumeDefence(event)
	self.isDefenceAble = true
end

--切换盾甲
function HeroLayer:onSwitchDefence(event)
	-- print("onShowDefence", self.isDefenceAble)
	if self.isDefenceAble == false then return end 

	local isDefend = event.isDefend
	if isDefend then
		print("self:showDefence()")
		self:showDefence()
	else
		print("self:hideDefence()")
		self:hideDefence()
	end
end

function HeroLayer:hideDefence()
	self.defenceNode:runAction( 
		cc.Sequence:create( 
			cc.MoveBy:create(0.5, cc.p(0, -defenceHeight)), 
			cc.CallFunc:create(
				function ()
					self.defenceNode:setVisible(false)
					self.defence:setIsDefending(false)
					self.defenceNode:setPositionY(-defenceHeight)
				end
			)
		)
	)	
end

function HeroLayer:showDefence()
	self.defenceNode:setPositionY(-defenceHeight)
	self.defenceNode:setVisible(true)
	self.defenceNode:runAction(cc.MoveBy:create(0.5, cc.p(0, defenceHeight * 1.56)))
end


--盾牌受伤效果
function HeroLayer:defenceBehurtEffect(event)
	-- print("oLayer:defenceBehurtEf self.isDefenceAble", self.isDefenceAble)
	if not self.isDefenceAble then return end --todo??

	--defence behurted action effect
	local tMove = cc.MoveBy:create(0.05, cc.p(-18, -20))
	self.defenceNode:runAction(cc.Sequence:create(tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse()))

	--defence behurted crack effect
	local crackSprite = display.newSprite("#hit_boli.png")
	local crackSize = crackSprite:getCascadeBoundingBox().size
	local bgSize = cc.uiloader:seekNodeByName(self.defenceNode, "upFrame"):getCascadeBoundingBox().size
	crackSprite:setPosition(
		math.random(-bgSize.width / 2 + crackSize.width / 2,
		 bgSize.width / 2 - crackSize.width / 2), 
		math.random(-bgSize.height / 2 + crackSize.height / 2 + 30,
		 bgSize.height / 2 - crackSize.height / 2)
	)

	self.defenceNode:addChild(crackSprite)

	self.crackSprites[self.behurtCount] = crackSprite
	self.behurtCount = self.behurtCount + 1
	self.remainTimes = self.remainTimes - 1
	local hurtedTimes = kRemainSumTimes - self.remainTimes
	if kRemainSumTimes <= hurtedTimes then
		--取消防御
		self.defence:switchStatus()

		--remove
		for k, v in pairs(self.crackSprites) do
			v:removeFromParent()
		end
		self.crackSprites = {}
		self.isDefenceAble = false
		self.remainTimes = kRemainSumTimes
	end
	local hurtedPercent = hurtedTimes / kRemainSumTimes
	self.hero:dispatchEvent({name = Hero.SKILL_DEFENCE_BEHURT_EVENT, hurtedPercent = hurtedPercent})
end

function HeroLayer:bloodBehurtEffect()
	local strAnim = nil
	if 1 >= math.random(0, 3) then 
		strAnim = "blood1"
	else
		strAnim = "blood2"
	end

    local armature = ccs.Armature:create(strAnim)
    local anim = armature:getAnimation()
	anim:playWithIndex(0)
    armature:setPosition(math.random(0, display.width1), math.random(0, display.height1))
    anim:setMovementEventCallFunc(
    	function ( armatureBack,movementType,movementI ) 
	    	if movementType == ccs.MovementEventType.complete then
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent() 
	    	end 
    	end
    )
    self:addChild(armature)
end

function HeroLayer:onHurtEffect(event)
	self:screenHurtedEffect()
	if true == self.defenceNode:isVisible() then 
		if false == self.isLaunchDefenceResume then 
			self:defenceBehurtEffect() 
		end
	else
	 	self:bloodBehurtEffect()
		self:onHeroHpChange(event)
	end
end

function HeroLayer:onHurtBombEffect()
	print("HeroLayer:onHurtBombEffect()")
	--svn\UI\ccs\Anim\effect\beizha_sl
end

--手雷
function HeroLayer:onThrowGrenade(event)

	local armature = ccs.Armature:create("shoulei")
	self:addChild(armature)
	armature:setPosition(display.width / 2, 0)
	armature:setScale(2.0)
	armature:getAnimation():play("lei", -1, 1)
	
	--destrect
	local destPos = event.throwPos
	-- dump(destPos, "destPos")
	local destRect = cc.rect(destPos.x, 
						destPos.y ,
						kLeiW,kLeiW)
	destRect.x = destPos.x - kLeiW / 2
	destRect.y = destPos.y - kLeiW / 2
	-- dump(destRect, "destRect")
	--lei
	local function playThrowBomb()
		local armature = ccs.Armature:create("baozhasl_y")
		armature:setPosition(destPos.x, destPos.y)
		self:addChild(armature)
		print("playThrowBomb")
		armature:getAnimation():playWithIndex(0)
		armature:getAnimation():setMovementEventCallFunc(
	    	function (armatureBack,movementType,movementId) 
		    	if movementType == ccs.MovementEventType.loopComplete then
					armature:removeFromParent()
		    	end 
	    	end)
	end

	local seq =  cc.Sequence:create(
					cc.Spawn:create(cc.JumpTo:create(1, event.throwPos, 300, 1), cc.ScaleTo:create(1, 0.3)),
				 	cc.CallFunc:create(
				 		function ()
		                    local targetData = {demage = kLeiDemage, demageType = "lei"}
		                    self.hero:dispatchEvent({name = Hero.SKILL_GRENADE_ARRIVE_EVENT, 
		                    	targetData = targetData, destPos = destPos,destRect = destRect })
							armature:removeFromParent()
							playThrowBomb()
						end)
					 )
	armature:runAction(seq)

	-- shadow
	local shadow = display.newSprite("#btn_dun03.png")
	shadow:setOpacity(100)
	shadow:setSkewY(70)
	shadow:setPosition(display.width / 2, 0)
	self:addChild(shadow)
	local seq2 = cc.Sequence:create(
					cc.MoveTo:create(1, cc.p(event.throwPos)),
					cc.CallFunc:create(
						function () 
							shadow:removeFromParent()
					 	end
					))
	shadow:runAction(seq2)
end

function HeroLayer:updateHp(event)
	if self.hpUpdateHandler then 
		scheduler.unscheduleGlobal(self.hpUpdateHandler)
		self.hpUpdateHandler = nil
	end

	local function updateHpFunc()
		-- print("updateHpFunc()")
		--inlay
		local value = 0.0
		local scale, isInlayed = self.inlay:getInlayedValue("helper") 
		local maxHp = self.hero:getMaxHp()
		if isInlayed then 
			value =  maxHp * scale
		else 
			value = 0.0
		end
		if self.hero:isDead() then 
			scheduler.unscheduleGlobal(self.hpUpdateHandler)
			return
		end
		if value == 0 then return end
		self.hero:increaseHp(value)
	end
	self.hpUpdateHandler = scheduler.scheduleGlobal(updateHpFunc, 1.0)
end

--英雄受到伤害时,屏幕闪红效果
function HeroLayer:screenHurtedEffect()
	local armature = ccs.Armature:create("avatarhit")
    local ani = armature:getAnimation()
	ani:play("avatarhit" , -1, 1)
    armature:setAnchorPoint(0, 0)
    ani:setMovementEventCallFunc(
    	function (armatureBack,movementType,movement) 
	    	if movementType == ccs.MovementEventType.loopComplete then
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent() 
	    	end 
    	end
    )
    self:addChild(armature)
end

function HeroLayer:effectPopupHead()
	local baotou = ccs.Armature:create("baotou")
	baotou:getAnimation():play("baotou" , -1, 1)
    baotou:setPosition(display.width1 / 2, 150)
    baotou:getAnimation():setMovementEventCallFunc(
    	function ( armatureBack,movementType,movement) 
	    	if movementType == ccs.MovementEventType.loopComplete then
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent() 
	    	end 
    	end
    )
    self:addChild(baotou)
end


function HeroLayer:effectGunReload(event)
	-- print("HeroLayer:effectGunReload()")
	local armature = ccs.Armature:create("huanzidan")
	armature:getAnimation():play("zidan" , -1, 1)
    armature:setPosition(display.width / 2, display.height1 / 2)
    armature:getAnimation():setSpeedScale(event.speedScale)
    armature:getAnimation():setMovementEventCallFunc(
    	function ( armatureBack,movementType,movement) 
	    	if movementType == ccs.MovementEventType.loopComplete then
	    		-- print("HeroLayer:effectGunReload done()")
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent()
	    	end 
    	end
    )
    self:addChild(armature)	
end

function HeroLayer:initGuide()
    local isDone = self.guide:check("fight")
    if isDone then return end
	
	local rect = self.hp:getBoundingBox()
	rect.height = rect.height * 3
	rect.y = rect.y - rect.height * 0.5
	--blood
    local data1 = {
        id = "fight_blood",
        groupId = "fight",
        rect = rect,
        endfunc = function (touchEvent)
        	
        end
    }
    self.guide:addClickListener(data1)  
end

function HeroLayer:onEnter()
	self.inlay:checkNativeGold()
	-- scheduler.performWithDelayGlobal(function()
	-- 	self.guide:startGuide("fight")
	-- end, 0.2)
end

function HeroLayer:onExit()
	print("function HeroLayer:onExit()")

	if self.killTimerHandler then 
		scheduler.unscheduleGlobal(self.killTimerHandler)
		self.killTimerHandler = nil
	end
	if self.hpUpdateHandler then
		scheduler.unscheduleGlobal(self.hpUpdateHandler)
		self.hpUpdateHandler = nil
	end
end


return HeroLayer
