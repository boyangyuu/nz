
--[[--

“英雄”的视图

]]

--import
import("..includes.functionUtils")
local CCSUILoader = import("framework.cc.uiloader.CCSUILoader")
local scheduler = require("framework.scheduler")
local Actor 	= import(".Actor")
local Hero 		= import(".Hero")
local Fight 	= import(".Fight")
local FightInlay= import(".FightInlay")
local Guide 	= import("..guide.GuideModel")

--kconfig
local kGoldActivate = 1

local HeroView = class("HeroView", function()
    return display.newLayer()
end)

function HeroView:ctor(properties)

	--instance
	self.hero 	= app:getInstance(Hero)
	self.guide 	= app:getInstance(Guide)
	self.inlay 	= app:getInstance(FightInlay)

	self.crackSprites = {}
	self.behurtCount = 1
	self.isResumeDefence = false
	self.killCntKeep = 0
	self.killCntTotal = 0

	--注册英雄事件
	cc.EventProxy.new(self.hero, self)
		:addEventListener(Actor.HP_INCREASE_EVENT			, handler(self, self.onHeroHpChange))
		:addEventListener(Actor.HP_DECREASE_EVENT			, handler(self, self.onHurtEffect))

		:addEventListener(Hero.SKILL_ARMOURED_START_EVENT	, handler(self, self.onShowArmoured))
		:addEventListener(Hero.SKILL_DEFENCE_START_EVENT	, handler(self, self.onShowDefence))
		:addEventListener(Hero.SKILL_DEFENCE_RESUME_EVENT	, handler(self, self.onResumeDefence))
		:addEventListener(Hero.SKILL_GRENADE_START_EVENT	, handler(self, self.onThrowGrenade))		
		:addEventListener(Hero.ENEMY_KILL_ENEMY_EVENT		, handler(self, self.killEnemyCallBack))
		:addEventListener(Hero.ENEMY_KILL_HEAD_EVENT		, handler(self, self.effectPopupHead))		
		:addEventListener(Hero.GUN_RELOAD_EVENT				, handler(self, self.effectGunReload))
	
	cc.EventProxy.new(self.inlay, self)
		:addEventListener(FightInlay.INLAY_GOLD_BEGIN_EVENT	, handler(self, self.onActiveGold))
	--ui
	self:initUI()

	--
	self:updateHp()
	self:setNodeEventEnabled(true)
end

function HeroView:initUI()
	self:initUiRootNode()
	self:initHeroHpNode()
	self:initArmouredNode()
	self:initDefenceNode()
	self:initKillTimerNode()

	scheduler.performWithDelayGlobal(handler(self, self.initGuide), 0.01)
end

--获得UI.ExportJson数据
function HeroView:initUiRootNode()
	self.uiRootNode = cc.uiloader:load("res/Fight/fightLayer/ui/heroUI.ExportJson")
end

--初始化英雄血条
function HeroView:initHeroHpNode()
	self.loadingBarHeroHp = cc.uiloader:seekNodeByName(self.uiRootNode, "loadingBarHeroHp")
	self.loadingBarHeroHp:removeFromParent()
	self:addChild(self.loadingBarHeroHp)
end

--获得装备机甲Ui节点
function HeroView:initArmouredNode()
	-- print("fit Armoured")
	self.layerArmoured = cc.uiloader:seekNodeByName(self.uiRootNode, "armoured")
	self.layerArmoured:removeFromParent()
	self:addChild(self.layerArmoured)
	self.layerArmoured:setVisible(false)
end

--获得盾牌Ui节点
function HeroView:initDefenceNode()
	self.isLaunchDefenceResume = false
	self.defence = cc.uiloader:seekNodeByName(self.uiRootNode, "defence")
	self.defence:removeFromParent()
	self:addChild(self.defence)
	self.defence:setVisible(false)
	self.defenceHp = 100
end

--初始化连杀倒计时节点
function HeroView:initKillTimerNode()
    self.killTimerBg = cc.uiloader:seekNodeByName(self.uiRootNode, "killTimerBg")
    self.killTimerBg:removeFromParent()
    self:addChild(self.killTimerBg)
    self.killTimerBg:setVisible(false)

    self.killLabel = cc.uiloader:seekNodeByName(self.uiRootNode, "labelKillEnemyCount")
    self.killLabel:removeFromParent()
    self:addChild(self.killLabel)
    self.killLabel:setVisible(false)

    self.killTimer = display.newProgressTimer("#huan_lv.png", display.PROGRESS_TIMER_RADIAL)
    self:addChild(self.killTimer)
    self.killTimer:setPosition(76, 420)
    self.killTimer:setReverseDirection(true)
    self.killTimer:setPercentage(100)
    self.killTimer:setVisible(false)
end

--player血条血量改变 
function HeroView:onHeroHpChange(event)
	   local per = self.hero:getHp() / self.hero:getMaxHp() * 100
	   self.loadingBarHeroHp:setPercent(per)
	-- local per1 = self.hero:getHp() / self.hero:getMaxHp() * 100
	-- local t1 = self.loadingBarHeroHp:getPercent()
	-- local tempHandler = nil

	-- local function checkHeroHp( dt )
	-- 	if t1 < per1 then
	-- 		scheduler.unscheduleGlobal(tempHandler)
	-- 		return
	-- 	end

	-- 	t1 = t1 - 0.4
	-- 	if t1 > 0 then
	-- 		self.loadingBarHeroHp:setPercent(t1)
	-- 	else
	-- 		scheduler.unscheduleGlobal(tempHandler)
	-- 	end
	-- end
	-- tempHandler = scheduler.scheduleGlobal(checkHeroHp, 0.05)
end

--杀死敌人后跳出3金币
function HeroView:killEnmeyGold(enemyPos)
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
function HeroView:onActiveGold(event)
	print("HeroView:onActiveGold(event)")
	self.hero:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, isPause = true})
	local armature = ccs.Armature:create("hjwq")
	addChildCenter(armature, self)
    local anim = armature:getAnimation()
	anim:playWithIndex(0)
    anim:setMovementEventCallFunc(
    	function ( armatureBack,movementType,movementId ) 
	    	if movementType == ccs.MovementEventType.complete then
				print("HeroView:activeGold() resume")
				self.hero:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, isPause = false})
				armature:removeFromParent()
	    	end 
    	end
    )
end

--杀掉敌人后的回调
local percent = 100
function HeroView:killEnemyCallBack( event )
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

--显示/隐藏机甲
function HeroView:onShowArmoured(event)
	if false == self.layerArmoured:isVisible() then
		self.layerArmoured:setVisible(true)
	else
		self.layerArmoured:setVisible(false)
	end
end

--盾牌恢复完成的回调
function HeroView:onResumeDefence(event)
	self.isResumeDefence = event.isResumeDefence
end

--显示/隐藏盾甲
function HeroView:onShowDefence(event)
	if false == self.isResumeDefence then

		--tood 待优化 可以放在一个node里就解决了
		local upFrame = cc.uiloader:seekNodeByName(self.defence, "upFrame")
		local downFrame = cc.uiloader:seekNodeByName(self.defence, "downFrame")
		local upFrameHeight = upFrame:getCascadeBoundingBox().size.height
		local downFrameHeight = downFrame:getCascadeBoundingBox().size.height
		local defenceHeight = downFrameHeight + upFrameHeight;

		if self.defence:isVisible() then
			self.defence:runAction( 
				cc.Sequence:create( 
					cc.MoveBy:create(0.5, cc.p(0, -defenceHeight)), 
					cc.CallFunc:create(
						function ()
							self.defence:setVisible(false)
							self.defence:setPositionY(-defenceHeight)
						end
					)
				)
			)
		else
			self.defence:setPositionY(-defenceHeight)
			self.defence:setVisible(true)
			self.defence:runAction(cc.MoveBy:create(0.5, cc.p(0, defenceHeight * 1.56)))
		end
	end
end

--盾牌受伤效果
function HeroView:defenceBehurtEffect(event)

	if self.isResumeDefence then return end

	--defence behurted action effect
	local tMove = cc.MoveBy:create(0.05, cc.p(-18, -20))
	self.defence:runAction(cc.Sequence:create(tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse()))

	--defence behurted crack effect
	local crackSprite = display.newSprite("#hit_boli.png")
	local crackSize = crackSprite:getCascadeBoundingBox().size
	local bgSize = cc.uiloader:seekNodeByName(self.defence, "upFrame"):getCascadeBoundingBox().size
	crackSprite:setPosition(
		math.random(-bgSize.width / 2 + crackSize.width / 2,
		 bgSize.width / 2 - crackSize.width / 2), 
		math.random(-bgSize.height / 2 + crackSize.height / 2 + 30,
		 bgSize.height / 2 - crackSize.height / 2)
	)

	self.defence:addChild(crackSprite)

	self.crackSprites[self.behurtCount] = crackSprite
	self.behurtCount = self.behurtCount + 1

	self.defenceHp = self.defenceHp - 10
	local tCurrentHp = 100 - self.defenceHp
	if 100 <= tCurrentHp then
		self:onShowDefence()
		for k, v in pairs(self.crackSprites) do
			v:removeFromParent()
		end
		self.crackSprites = {}
		self.isResumeDefence = true
		self.defenceHp = 100
	end
	self.hero:dispatchEvent({name = Hero.SKILL_DEFENCE_BEHURT_EVENT, damage = tCurrentHp})
end

function HeroView:bloodBehurtEffect()
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

function HeroView:onHurtEffect(event)

	self:screenHurtedEffect()
	if true == self.defence:isVisible() then
		if false == self.isLaunchDefenceResume then self:defenceBehurtEffect() end
	else
	 	self:bloodBehurtEffect()
		self:onHeroHpChange(event)
	end
end

--手雷
function HeroView:onThrowGrenade(event)

	local armature =ccs.Armature:create("shoulei")
	self:addChild(armature)
	armature:setPosition(display.width / 2, 0)
	armature:setScale(2.0)
	armature:getAnimation():play("lei", -1, 1)
	
	--destrect
    local kGrenadeW = 100.0
	local destPos = event.throwPos
	local destRect = cc.rect(destPos.x - kGrenadeW/2, 
						destPos.y - kGrenadeW/2, 
						kGrenadeW,kGrenadeW)
	
	--lei
	local seq =  cc.Sequence:create(
					cc.Spawn:create(cc.JumpTo:create(1, event.throwPos, 300, 1), cc.ScaleTo:create(1, 0.3)),
				 	cc.CallFunc:create(
				 		function ()
		                    local targetData = {demage = 600, demageType = "lei"}
		                    self.hero:dispatchEvent({name = Hero.SKILL_GRENADE_ARRIVE_EVENT, 
		                    	targetData = targetData, destPos = destPos,destRect = destRect })
							armature:removeFromParent()
						end
					)
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

function HeroView:updateHp(event)
	if self.hpUpdateHandler then 
		scheduler.unscheduleGlobal(self.hpUpdateHandler)
		self.hpUpdateHandler = nil
	end

	local function updateHpFunc()
		print("updateHpFunc()")
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
function HeroView:screenHurtedEffect()
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

function HeroView:effectPopupHead()
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


function HeroView:effectGunReload(event)
	print("HeroView:effectGunReload()")
	local armature = ccs.Armature:create("huanzidan")
	armature:getAnimation():play("zidan" , -1, 1)
    armature:setPosition(display.width / 2, display.height1 / 2)
    armature:getAnimation():setSpeedScale(event.speedScale)
    armature:getAnimation():setMovementEventCallFunc(
    	function ( armatureBack,movementType,movement) 
	    	if movementType == ccs.MovementEventType.loopComplete then
	    		print("HeroView:effectGunReload done()")
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent()
	    	end 
    	end
    )
    self:addChild(armature)	
end

function HeroView:initGuide()
    local isDone = self.guide:check("fight")
    if isDone then return end
	
	local rect = self.loadingBarHeroHp:getBoundingBox()
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

function HeroView:onEnter()
	-- scheduler.performWithDelayGlobal(function()
	-- 	self.guide:startGuide("fight")
	-- end, 0.2)
end

function HeroView:onExit()
	print("function HeroView:onExit()")

	if self.killTimerHandler then 
		scheduler.unscheduleGlobal(self.killTimerHandler)
		self.killTimerHandler = nil
	end
	if self.hpUpdateHandler then
		scheduler.unscheduleGlobal(self.hpUpdateHandler)
		self.hpUpdateHandler = nil
	end
end


return HeroView
