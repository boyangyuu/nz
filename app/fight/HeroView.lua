
--[[--

“英雄”的视图

]]

--import
import("..includes.functionUtils")
local CCSUILoader = import("framework.cc.uiloader.CCSUILoader")
local scheduler = require("framework.scheduler")
local Actor = import(".Actor")
local Hero = import(".Hero")

local HeroView = class("HeroView", function()
    return display.newNode()
end)

local tinkTest = nil

function HeroView:ctor(properties)
	--instance

	self.hero = app:getInstance(Hero)

	self.crackTable = {}
	self.behurtCount = 1
	self.isResumeDefence = false
	self.killEnemyCount = 0
	self.killEnemyTimerHandler = nil
	--注册英雄事件
	cc.EventProxy.new(self.hero, self):addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.beHurtEffect))
	cc.EventProxy.new(self.hero, self):addEventListener(Hero.SKILL_ARMOURED_EVENT, handler(self, self.setShowArmoured))
	cc.EventProxy.new(self.hero, self):addEventListener(Hero.SKILL_DEFENCE_EVENT, handler(self, self.setShowDefence))
	cc.EventProxy.new(self.hero, self):addEventListener(Hero.RESUME_DEFENCE_EVENT, handler(self, self.resumeDefence))
	cc.EventProxy.new(self.hero, self):addEventListener(Hero.ENEMY_KILL_EVENT, handler(self, self.killEnemyCallBack))
	cc.EventProxy.new(self.hero, self):addEventListener(Actor.FIRE_THROW_EVENT, handler(self, self.throwGrenade))
	self:initUiRootNode()
	self:initArmouredNode()
	self:initDefenceNode()
	self:initKillTimerNode()
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


function HeroView:killEnmeyGold(enemyPos)
	local pos = enemyPos
	local posX = enemyPos.x - 80

	for i = 1, 3 do
		local gold = getArmature("gold", "res/Fight/heroAnim/gold/gold.ExportJson")
		gold:setPosition(posX, enemyPos.y)
		gold:getAnimation():play("Animation1", -1, 1)
		gold:runAction(cc.Sequence:create(
			cc.JumpBy:create(0.7, cc.p(i * 12, 0), 80, 1),
			cc.DelayTime:create(0.5 - i * 0.1),
			cc.MoveTo:create(0.15, cc.p(884, 591)),
			cc.CallFunc:create(function ()
				gold:removeFromParent()
			end)
		))
		self:addChild(gold)
	end
end

--杀掉敌人后的回调
function HeroView:killEnemyCallBack( event )

	self.killEnemyCountLabel:setVisible(true)
	self.killEnemyTimerBg:setVisible(true)
	self:killEnmeyGold(event.enemyPos)
	self.killEnemyCount = self.killEnemyCount + 1
	local strKillEnemyCount = string.format("X %d", self.killEnemyCount)
	self.killEnemyCountLabel:setString(strKillEnemyCount)
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
        	self.killEnemyCount = 0
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


--获得UI.ExportJson数据
function HeroView:initUiRootNode()
	self.uiRootNode = cc.uiloader:load("Fight/fightLayer/ui/heroUI.ExportJson")
end

--获得装备机甲Ui节点
function HeroView:initArmouredNode()
	print("fit Armoured")
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
		self.beHurtEffect = 1
		self.crackTable = {}
		self.isResumeDefence = true
		self.defenceHp = 100
	end
	self.hero:dispatchEvent({name = Hero.BEHURT_DEFENCE_EVENT, damage = tCurrentHp})
end

--
function HeroView:bloodBehurtEffect()

	local tRandomBlood = nil
	if 1 >= math.random(0, 3) then 
		tRandomBlood = "blood1"
	else
		tRandomBlood = "blood2"
	end

    --hero behurt blood effect
    local tBloodArmature = getArmature(tRandomBlood, "Fight/heroAnim/" .. tRandomBlood .. "/" .. tRandomBlood .. ".ExportJson")
    local tBloodAniamtion = tBloodArmature:getAnimation()

    -- tBloodAniamtion:play("blood1_01" , -1, 1)
	tBloodAniamtion:playWithIndex(0)
    tBloodArmature:setPosition(math.random(0, display.width), math.random(0, display.height))
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
	end
end

--手雷
function HeroView:throwGrenade(event)

	local tGrenade = getArmature("shoulei", "res/Fight/heroAnim/shoulei/shoulei.ExportJson")
	self:addChild(tGrenade)
	tGrenade:setPosition(display.width / 2, 0)
	tGrenade:getAnimation():play("lei", -1, 1)
	tGrenade:runAction(
		cc.Sequence:create(
			cc.Spawn:create(cc.JumpTo:create(1, event.throwPos, 300, 1), cc.ScaleTo:create(1, 0.3)),
		 	cc.CallFunc:create(
		 		function ()
                    self.hero:dispatchEvent({name = Hero.GRENADE_ARRIVE_EVENT, damage = 100, destPos = event.throwPos})
					tGrenade:removeFromParent()
				end
			)
		)
	)

	-- shadow effect
	local shadow = display.newSprite("#huan_hui.png")
	shadow:setOpacity(100)
	shadow:setSkewY(60)
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

	local tBeHurtScreenArmature = getArmature("avatarhit", "Fight/heroAnim/avatarhit/avatarhit.ExportJson")
    local tAniamtion = tBeHurtScreenArmature:getAnimation()

	tAniamtion:play("avatarhit" , -1, 1)
    tBeHurtScreenArmature:setPosition(display.width / 2, display.height / 2)
    tAniamtion:setMovementEventCallFunc(
    	function ( armatureBack,movementType,movementI ) 
	    	if movementType == ccs.MovementEventType.loopComplete then
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent() 
	    	end 
    	end
    )
    self:addChild(tBeHurtScreenArmature)
end


return HeroView
