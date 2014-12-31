
--[[--

“英雄”的视图

]]

--import model
local scheduler = require("framework.scheduler")
local Actor 	= import(".Actor")
local Hero 		= import(".Hero")
local Fight 	= import(".Fight")

--import view
local DefenceView = import(".skills.DefenceView")
local RobotView = import(".skills.RobotView")
--kconfig
local kRemainSumTimes = 4
local kLeiDemage = 600.0
local kLeiW = 100.0

local HeroLayer = class("HeroLayer", function()
    return display.newLayer()
end)

function HeroLayer:ctor(properties)

	--instance
	self.hero 	= md:getInstance("Hero")
	self.guide 	= md:getInstance("Guide")
	self.inlay 	= md:getInstance("FightInlay")
	self.defence = md:getInstance("Defence")

	--events
	cc.EventProxy.new(self.hero, self)

		:addEventListener(Actor.HP_DECREASE_EVENT			, handler(self, self.onHurtEffect))
		:addEventListener(Hero.EFFECT_HURT_BOMB_EVENT		, handler(self, self.onHurtBombEffect))		
		-- :addEventListener(Hero.SKILL_ROBOT_START_EVENT		, handler(self, self.onShowRobot))

		:addEventListener(Hero.SKILL_GRENADE_START_EVENT	, handler(self, self.onThrowGrenade))		
		:addEventListener(Hero.ENEMY_KILL_ENEMY_EVENT		, handler(self, self.killEnemyCallBack))
		:addEventListener(Hero.ENEMY_KILL_HEAD_EVENT		, handler(self, self.effectPopupHead))		
		:addEventListener(Hero.GUN_RELOAD_EVENT				, handler(self, self.effectGunReload))
	
	cc.EventProxy.new(self.inlay, self)
		:addEventListener(self.inlay.INLAY_GOLD_BEGIN_EVENT	, handler(self, self.onActiveGold))
	self:loadCCS()
	self:initUI()
	self:initData()
	
	self:setTouchEnabled(false) 
	self:setNodeEventEnabled(true)
	--test

end

function HeroLayer:loadCCS()
	self.ui = cc.uiloader:load("res/Fight/fightLayer/ui/heroUI.ExportJson")
	self:addChild(self.ui)
end

function HeroLayer:initUI()

	self:initKillTimerNode()

	--defence
	local defenceNode = cc.uiloader:seekNodeByName(self.ui, "defenceNode")
	local defenceView = DefenceView.new()
	defenceNode:addChild(defenceView)

	--robot
	local robotNode = cc.uiloader:seekNodeByName(self.ui, "robotNode")
	local robotView = RobotView.new()
	robotNode:addChild(robotView)	
end

function HeroLayer:initData()
	--robot

	--killtimer
	self.killCntKeep = 0
	self.killCntTotal = 0

	--hp
	self:updateHp()
end

function HeroLayer:initKillTimerNode()
    self.killTimerBg = cc.uiloader:seekNodeByName(self.ui, "killTimerBg")
    self.killTimerBg:setVisible(false)

    self.killLabel = cc.uiloader:seekNodeByName(self.ui, "labelKillEnemyCount")
    self.killLabel:setVisible(false)

    self.killTimer = display.newProgressTimer("#huan_lv.png", display.PROGRESS_TIMER_RADIAL)
    self.killTimerBg:addChild(self.killTimer)
    self.killTimer:setReverseDirection(true)
    self.killTimer:setAnchorPoint(0.0,0.0)
    self.killTimer:setPercentage(100)
    self.killTimer:setVisible(false)
end

--杀死敌人后跳出3金币
function HeroLayer:killEnmeyGold(enemyPos)
	local awardValue = define.kKillEnemyAwardGold 
	local goldCount = self.killCntTotal * awardValue

	for i = 1, 3 do
		local armature = ccs.Armature:create("gold")
		armature:setPosition(enemyPos.x, enemyPos.y)
		armature:getAnimation():play("Animation1", -1, 1)
		armature:runAction(cc.Sequence:create(
			--todo 待优化
			cc.JumpBy:create(0.7, cc.p(i * 12, 0), 80, 1),
			cc.DelayTime:create(0.5 - i * 0.1),
			cc.MoveTo:create(0.5, cc.p(664, 604)),
			cc.CallFunc:create(function ()
				if i == 1 then
					self.hero:dispatchEvent({name = "changeGold", 
						goldCount = goldCount})
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
function HeroLayer:killEnemyCallBack(event)
	--is already gold
	local inlay = md:getInstance("FightInlay")
	local isGold = inlay:getIsActiveGold()
	if isGold then return end

	--连杀
	self.killLabel:setVisible(true)
	self.killTimerBg	:setVisible(true)
	self.killCntKeep  = self.killCntKeep + 1
	self.killCntTotal = self.killCntTotal + 1

	--award
	self:killEnmeyGold(event.enemyPos)
	local strKillEnemyCount = string.format("X %d", self.killCntKeep)
	self.killLabel:setString(strKillEnemyCount)

	--触发黄金武器
	if define.kGoldActivate <= self.killCntKeep then
		self.killCntKeep = 0
		self.inlay:activeGold()
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
 	self:bloodBehurtEffect()
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
	
	--destRect
	local destPos = event.throwPos
	local destRect = cc.rect(destPos.x, destPos.y ,
						kLeiW,kLeiW)
	destRect.x = destPos.x - kLeiW / 2
	destRect.y = destPos.y - kLeiW / 2
	--lei
	local function playBombEffect()
		local map = md:getInstance("Map")
		map:dispatchEvent({name = map.EFFECT_LEI_BOMB_EVENT,
			pWorld = destRect})
	end

	local seq =  cc.Sequence:create(
					cc.Spawn:create(cc.JumpTo:create(1, event.throwPos, 300, 1), cc.ScaleTo:create(1, 0.3)),
				 	cc.CallFunc:create(
				 		function ()
		                    local targetData = {demage = kLeiDemage, demageType = "lei"}
		                    self.hero:dispatchEvent({name = Hero.SKILL_GRENADE_ARRIVE_EVENT, 
		                    	targetData = targetData, destPos = destPos,destRect = destRect })
							armature:removeFromParent()
							playBombEffect()
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

function HeroLayer:onEnter()
	-- self.inlay:checkNativeGold()
end

return HeroLayer
