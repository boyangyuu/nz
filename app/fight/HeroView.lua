
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
local Guide 	= import("..guide.GuideModel")

--kconfig
local kGoldActivate = 10

local HeroView = class("HeroView", function()
    return display.newNode()
end)

function HeroView:ctor(properties)

	--instance
	self.hero = app:getInstance(Hero)
	self.guide = app:getInstance(Guide)
	self.crackTable = {}
	self.behurtCount = 1
	self.isResumeDefence = false
	self.keepKillEnemyCount = 0
	self.killEnemyCount = 0
	self.killEnemyTimerHandler = nil

	--注册英雄事件
	cc.EventProxy.new(self.hero, self)
		:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.beHurtEffect))
		:addEventListener(Hero.SKILL_ARMOURED_START_EVENT, handler(self, self.setShowArmoured))
		:addEventListener(Hero.SKILL_DEFENCE_START_EVENT, handler(self, self.setShowDefence))
		:addEventListener(Hero.SKILL_DEFENCE_RESUME_EVENT, handler(self, self.resumeDefence))
		:addEventListener(Hero.SKILL_GRENADE_START_EVENT, handler(self, self.throwGrenade))
		
		:addEventListener(Hero.ENEMY_KILL_ENEMY_EVENT, handler(self, self.killEnemyCallBack))
		:addEventListener(Hero.ENEMY_KILL_HEAD_EVENT, handler(self, self.effectPopupHead))
		
		:addEventListener(Hero.GUN_RELOAD_EVENT, handler(self, self.effectGunReload))
		
	--ui
	self:initUI()

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
    self.killEnemyTimerBg = cc.uiloader:seekNodeByName(self.uiRootNode, "killEnemyTimerBg")
    self.killEnemyTimerBg:removeFromParent()
    self:addChild(self.killEnemyTimerBg)
    self.killEnemyTimerBg:setVisible(false)

    self.killEnemyCountLabel = cc.uiloader:seekNodeByName(self.uiRootNode, "labelKillEnemyCount")
    self.killEnemyCountLabel:removeFromParent()
    self:addChild(self.killEnemyCountLabel)
    self.killEnemyCountLabel:setVisible(false)

    self.killEnemyTimer = display.newProgressTimer("#huan_lv.png", display.PROGRESS_TIMER_RADIAL)
    self:addChild(self.killEnemyTimer)
    self.killEnemyTimer:setPosition(76, 420)
    self.killEnemyTimer:setReverseDirection(true)
    self.killEnemyTimer:setPercentage(100)
    self.killEnemyTimer:setVisible(false)
end

--player血条血量改变
function HeroView:heroHpChange()
	local t = self.hero:getHp() / self.hero:getMaxHp() * 100
	local t1 = self.loadingBarHeroHp:getPercent()
	local tempHandler = nil

	local function checkHeroHp( dt )
		if t1 < t then
			scheduler.unscheduleGlobal(tempHandler)
			return
		end

		t1 = t1 - 0.4
		if t1 > 0 then
			self.loadingBarHeroHp:setPercent(t1)
			local posX = self.loadingBarHeroHp.viewRect_.width * t1 / 100
		else
			scheduler.unscheduleGlobal(tempHandler)
		end
	end
	tempHandler = scheduler.scheduleGlobal(checkHeroHp, 0.05)
end


--杀死敌人后跳出3金币
function HeroView:killEnmeyGold(enemyPos)
	for i = 1, 3 do
		local gold = getArmature("gold1", "res/Fight/heroAnim/gold/gold1.ExportJson")
		gold:setPosition(enemyPos.x, enemyPos.y)
		gold:getAnimation():play("gold", -1, 1)
		gold:runAction(cc.Sequence:create(
			--todoxx 待优化
			cc.JumpBy:create(0.7, cc.p(i * 12, 0), 80, 1),
			cc.DelayTime:create(0.5 - i * 0.1),
			cc.MoveTo:create(0.5, cc.p(884, 591)), --todo
			cc.CallFunc:create(function ()
				self.hero:dispatchEvent({name = "changeGold", goldCount = self.killEnemyCount * 50})
				gold:removeFromParent()
			end)
		))
		self:addChild(gold)
	end
end

--触发黄金武器
function HeroView:activeGoldWeapon()
	print("HeroView:activeGoldWeapon() pause")
	self.hero:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, isPause = true})
	local color = display.newColorLayer(cc.c4b(0, 0, 0, 180))
	cc.Director:getInstance():getRunningScene():addChild(color)  --todo 待优化!
	local function resume()
		print("HeroView:activeGoldWeapon() resume")
		self.hero:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, isPause = false})
		color:removeFromParent()
	end
	scheduler.performWithDelayGlobal(resume, 5)
end

--杀掉敌人后的回调
function HeroView:killEnemyCallBack( event )

	self.killEnemyCountLabel:setVisible(true)
	self.killEnemyTimerBg:setVisible(true)
	self:killEnmeyGold(event.enemyPos)
	self.keepKillEnemyCount = self.keepKillEnemyCount + 1
	self.killEnemyCount = self.killEnemyCount + 1
	local strKillEnemyCount = string.format("X %d", self.keepKillEnemyCount)
	self.killEnemyCountLabel:setString(strKillEnemyCount)

	--触发黄金武器
	if kGoldActivate <= self.keepKillEnemyCount then
		self.keepKillEnemyCount = 0
		self:activeGoldWeapon()
		return
	end

	-- body
	self.killEnemyTimer:setVisible(true)
	self.killEnemyTimer:setPercentage(100)

	--如果发生连杀,在第二次倒计时的时候将上次倒计时的进度条关闭
	if nil ~= self.killEnemyTimerHandler then 
		scheduler.unscheduleGlobal(self.killEnemyTimerHandler)
	end

    local function tick(dt)
        local t = self.killEnemyTimer:getPercentage()
        if 0 == t then
        	scheduler.unscheduleGlobal(self.killEnemyTimerHandler)
        	self.keepKillEnemyCount = 0
    		self.killEnemyCountLabel:setVisible(false)
			self.killEnemyTimerBg:setVisible(false)
        end
        self.killEnemyTimer:setPercentage(t - 1)
    end

    self.killEnemyTimerHandler = scheduler.scheduleGlobal(tick, 0.03)
end

--是否显示机甲
function HeroView:setShowArmoured()
	if false == self.layerArmoured:isVisible() then
		self.layerArmoured:setVisible(true)
	else
		self.layerArmoured:setVisible(false)
	end
end

--盾牌恢复完成的回调
function HeroView:resumeDefence( event )
	self.isResumeDefence = event.isResumeDefence
end


--显示/隐藏盾甲
function HeroView:setShowDefence()
	if false == self.isResumeDefence then

		--tood 待优化 可以放在一个node里就解决了
		local upFrame = cc.uiloader:seekNodeByName(self.defence, "upFrame")
		local downFrame = cc.uiloader:seekNodeByName(self.defence, "downFrame")
		local upFrameHeight = upFrame:getCascadeBoundingBox().size.height
		local downFrameHeight = downFrame:getCascadeBoundingBox().size.height
		local defenceHeight = downFrameHeight + upFrameHeight;

		if true == self.defence:isVisible() then
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
function HeroView:defenceBehurtEffect()

	if self.isResumeDefence then return end

	--defence behurted action effect
	local tMove = cc.MoveBy:create(0.05, cc.p(-18, -20))
	self.defence:runAction(cc.Sequence:create(tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse()))

	--defence behurted crack effect
	local tCrackEffect = display.newSprite("#hit_boli.png")
	local tCrackSize = tCrackEffect:getCascadeBoundingBox().size
	local tDefenceFrameSize = cc.uiloader:seekNodeByName(self.defence, "upFrame"):getCascadeBoundingBox().size
	tCrackEffect:setPosition(
		math.random(-tDefenceFrameSize.width / 2 + tCrackSize.width / 2,
		 tDefenceFrameSize.width / 2 - tCrackSize.width / 2), 
		math.random(-tDefenceFrameSize.height / 2 + tCrackSize.height / 2 + 30,
		 tDefenceFrameSize.height / 2 - tCrackSize.height / 2)
	)

	self.defence:addChild(tCrackEffect)

	self.crackTable[self.behurtCount] = tCrackEffect
	self.behurtCount = self.behurtCount + 1

	self.defenceHp = self.defenceHp - 10
	local tCurrentHp = 100 - self.defenceHp
	if 100 <= tCurrentHp then
		self:setShowDefence()
		for k, v in pairs(self.crackTable) do
			v:removeFromParent()
		end
		-- self.beHurtEffect = 1
		self.crackTable = {}
		self.isResumeDefence = true
		self.defenceHp = 100
	end
	self.hero:dispatchEvent({name = Hero.SKILL_DEFENCE_BEHURT_EVENT, damage = tCurrentHp})
end

function HeroView:bloodBehurtEffect()

	local tRandomBlood = nil
	if 1 >= math.random(0, 3) then 
		tRandomBlood = "blood1"
	else
		tRandomBlood = "blood2"
	end

    --hero behurt blood effect
    local tBloodArmature = getArmature(tRandomBlood, "res/Fight/heroAnim/" .. tRandomBlood .. "/" .. tRandomBlood .. ".ExportJson")
    local tBloodAniamtion = tBloodArmature:getAnimation()

    -- tBloodAniamtion:play("blood1_01" , -1, 1)
	tBloodAniamtion:playWithIndex(0)
    tBloodArmature:setPosition(math.random(0, display.width1), math.random(0, display.height1))
    tBloodAniamtion:setMovementEventCallFunc(
    	function ( armatureBack,movementType,movementI ) 
	    	if movementType == ccs.MovementEventType.complete then
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent() 
	    	end 
    	end
    )
    self:addChild(tBloodArmature)
end

function HeroView:beHurtEffect()

	self:screenHurtedEffect()
	if true == self.defence:isVisible() then
		if false == self.isLaunchDefenceResume then self:defenceBehurtEffect() end
	else
	 	self:bloodBehurtEffect()
		self:heroHpChange()
	end
end

--手雷
function HeroView:throwGrenade(event)

	local tGrenade = getArmature("shoulei", "res/Fight/heroAnim/shoulei/shoulei.ExportJson")
	self:addChild(tGrenade)
	tGrenade:setPosition(display.width / 2, 0)
	tGrenade:setScale(3)
	tGrenade:getAnimation():play("lei", -1, 1)
	tGrenade:runAction(
		cc.Sequence:create(
			cc.Spawn:create(cc.JumpTo:create(1, event.throwPos, 300, 1), cc.ScaleTo:create(1, 0.3)),
		 	cc.CallFunc:create(
		 		function ()
	 			    local kGrenadeW = 100.0
		 			local destPos = event.throwPos
					local destRect = cc.rect(destPos.x - kGrenadeW/2, 
										destPos.y - kGrenadeW/2, 
										kGrenadeW,kGrenadeW)
                    local targetData = {demage = 600, demageType = "lei"}
                    self.hero:dispatchEvent({name = Hero.SKILL_GRENADE_ARRIVE_EVENT, 
                    	targetData = targetData, destPos = destPos,destRect = destRect })
					tGrenade:removeFromParent()
				end
			)
		)
	)

	-- shadow effect
	local shadow = display.newSprite("#btn_dun03.png")
	shadow:setOpacity(100)
	shadow:setSkewY(70)
	shadow:setPosition(display.width / 2, 0)
	self:addChild(shadow)
	shadow:runAction( 
		cc.Sequence:create(
			cc.MoveTo:create(1, cc.p(event.throwPos)),
			cc.CallFunc:create(
				function () 
					shadow:removeFromParent()
			 	end
			)
		)
	)

end

--英雄受到伤害时,屏幕闪红效果
function HeroView:screenHurtedEffect()

	local tBeHurtScreenArmature = getArmature("avatarhit", "res/Fight/heroAnim/avatarhit/avatarhit.ExportJson")
    local tAniamtion = tBeHurtScreenArmature:getAnimation()

	tAniamtion:play("avatarhit" , -1, 1)
    tBeHurtScreenArmature:setAnchorPoint(0, 0)
    tAniamtion:setMovementEventCallFunc(
    	function ( armatureBack,movementType,movement) 
	    	if movementType == ccs.MovementEventType.loopComplete then
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent() 
	    	end 
    	end
    )
    self:addChild(tBeHurtScreenArmature)
end

function HeroView:effectPopupHead()
	local src = "res/Fight/uiAnim/baotou/baotou.ExportJson"
	local baotou = getArmature("baotou", src)
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
    self:addChild(baotou, 100)
end


function HeroView:effectGunReload(event)
	print("HeroView:effectGunReload()")
	local src = "res/Fight/uiAnim/huanzidan/huanzidan.ExportJson"
	local armature = getArmature("huanzidan", src)
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
    self:addChild(armature, 1000)	
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

return HeroView
