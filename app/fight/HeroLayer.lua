
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
local HeroAnimView = import(".HeroAnimView")
--kconfig
local kRemainSumTimes = 4
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
	self.keepKillPercent = 100
	--events
	cc.EventProxy.new(self.hero, self)

		:addEventListener(Actor.HP_DECREASE_EVENT			, handler(self, self.onHurtEffect))
		:addEventListener(Hero.SKILL_GRENADE_START_EVENT	, handler(self, self.onThrowGrenade))		
		:addEventListener(Hero.ENEMY_KILL_ENEMY_EVENT		, handler(self, self.killEnemyCallBack))	
		:addEventListener(Hero.ENEMY_KILL_ENEMY_EVENT		, handler(self, self.killEnmeyGold))		
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

	--anim
	local heroAnimNode = cc.uiloader:seekNodeByName(self.ui, "heroAnim")
	local heroAnimView = HeroAnimView.new()
	heroAnimNode:addChild(heroAnimView)	
end

function HeroLayer:initData()
	--robot

	--killtimer
	self.killCntKeep = 0

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
function HeroLayer:killEnmeyGold(event)
	local enemyPos = event.enemyPos
	local value = event.award 
	local baseValue = define.kGoldCoinValue
	-- print("value", value)
	local num = math.floor(value / baseValue)
	
	local isMany = num > 3
	local w = isMany and 10 or 24
	local d = 0.1
	for i = 1, num do
		local direct = i % 2 == 1 and -1 or 1
		local xIndex = (num + i * direct) 
		xIndex = isMany and math.floor(xIndex / 4) or xIndex
		local delay = xIndex * d
		local armature = ccs.Armature:create("gold")
		armature:setPosition(enemyPos.x, enemyPos.y)
		armature:getAnimation():play("gold", -1, 1)
		armature:runAction(cc.Sequence:create(
		
			cc.JumpBy:create(0.4, cc.p(i * w * direct, 0), 80, 1),
			cc.DelayTime:create(delay),
			cc.Spawn:create(
				cc.MoveTo:create(0.4, cc.p(664, 604)),
				cc.ScaleTo:create(0.4, 0.5)),
			cc.CallFunc:create(function ()
				if i == 1 then
					self.hero:dispatchEvent({name = self.hero.AWARD_GOLD_INCREASE_EVENT, 
						value = value})
				end
				armature:removeFromParent()
			end)
		))
		self:addChild(armature)
	end
end

--触发黄金武器
function HeroLayer:onActiveGold(event)
	local armature = ccs.Armature:create("hjwq")
	addChildCenter(armature, self)
    local anim = armature:getAnimation()
	anim:playWithIndex(0)
    anim:setMovementEventCallFunc(
    	function ( armatureBack,movementType,movementId ) 
	    	if movementType == ccs.MovementEventType.complete then
				armature:removeFromParent()
	    	end 
    	end
    )
end

--杀掉敌人后的回调
function HeroLayer:killEnemyCallBack(event)
	--is already gold
	local inlay = md:getInstance("FightInlay")
	local isGold = inlay:getIsActiveGold()
	
	--modified by yby 取消黄武需求
	--[[
	if not isGold then 
		self:killEnemyKeep()
	end
	]]
	self:killEnemyKeep()
end

function HeroLayer:killEnemyKeep()
	--连杀
	self.killLabel:setVisible(true)
	self.killTimerBg	:setVisible(true)
	self.killCntKeep  = self.killCntKeep + 1	
	local strKillEnemyCount = string.format("X %d", self.killCntKeep)
	self.killLabel:setString(strKillEnemyCount)

	--触发黄金武器
	if define.kGoldActivate <= self.killCntKeep then
		self.killCntKeep = 0
		self.inlay:activeGold()
		return
	end

	-- body
	local percent = self.keepKillPercent
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



--手雷
function HeroLayer:onThrowGrenade(event)

	--	effect
	local soundSrc  = "res/Music/fight/rengsl.wav"
	self.audioId =  audio.playSound(soundSrc,false)		

	local armature = ccs.Armature:create("shoulei")
	self:addChild(armature)
	armature:setPosition(display.width / 2, 0)
	armature:setScale(2.0)
	armature:getAnimation():play("fire", -1, 1)
	
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
		                    local targetData = {demage = define.kLeiDemage, demageType = "lei", demageScale = 1.0}
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
		local baseHp = define.kHeroBaseHp 
		if isInlayed then 
			value =  baseHp * scale
		else 
			value = 0.0
		end
		if self.hero:isDead() then 
			
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

function HeroLayer:onCleanup()
	print("function HeroLayer:onCleanup()")

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
	
end


return HeroLayer
