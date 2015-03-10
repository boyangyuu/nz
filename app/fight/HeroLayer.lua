
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
		:addEventListener(Hero.ENEMY_KILL_ENEMY_EVENT		, handler(self, self.killEnmeyGold))		
		:addEventListener(Hero.GUN_RELOAD_EVENT				, handler(self, self.effectGunReload))
	
	cc.EventProxy.new(self.inlay, self)
		:addEventListener(self.inlay.INLAY_GOLD_BEGIN_EVENT	, handler(self, self.onActiveGold))
	self:loadCCS()
	self:initUI()
	self:initData()
	
	self:setTouchEnabled(false) 
	self:setNodeEventEnabled(true)
end

function HeroLayer:loadCCS()
	self.ui = cc.uiloader:load("res/Fight/fightLayer/ui/heroUI.ExportJson")
	self:addChild(self.ui)
end

function HeroLayer:initUI()
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
	--hp
	self:updateHp()
end


--杀死敌人后跳出3金币
function HeroLayer:killEnmeyGold(event)
	local enemyPos = event.enemyPos
	local value = event.award 
	local baseValue = define.kGoldCoinValue
	local flySpeed = 900.0
	-- print("value", value)
	local num = math.floor(value / baseValue)
	if num > 12 then num = 12 end 
	local isMany = num > 3
	local w = isMany and 5 or 5
	local d = 0.1
	local destPos = cc.p(664, 604)
	for i = 1, num do
		local direct = i % 2 == 1 and -1 or 1
		local xIndex = (num + i * direct) 
		xIndex = isMany and math.floor(xIndex / 4) or xIndex
		local delay = xIndex * d
		local armature = ccs.Armature:create("gold")
		armature:setPosition(enemyPos.x, enemyPos.y)
		local flyTime = cc.pGetDistance(enemyPos, destPos) / flySpeed
		armature:setScale(0.5)
		armature:getAnimation():play("gold", -1, 1)
		armature:runAction(cc.Sequence:create(		
			cc.JumpBy:create(0.4, cc.p(i * w * direct, 0), 80, 1),
			cc.DelayTime:create(delay),
			cc.Spawn:create(
				cc.MoveTo:create(flyTime, destPos),
				cc.ScaleTo:create(flyTime, 0.3)),
			cc.CallFunc:create(function ()
				armature:removeFromParent()
			end)
		))
		self:addChild(armature)
	end
end

--触发黄金武器
function HeroLayer:onActiveGold(event)
	print("function HeroLayer:onActiveGold(event)")
	local armature = ccs.Armature:create("hjwq")
	addChildCenter(armature, self)
    local anim = armature:getAnimation()
	anim:play("hjwq" , -1, 1)
    anim:setMovementEventCallFunc(
    	function ( armatureBack,movementType,movementId ) 
    		print("movementType", movementType)
	    	if movementType == ccs.MovementEventType.loopComplete then
				armature:removeFromParent()
	    	end 
    	end
    )

    --sound
    local soundSrc  = "res/Music/fight/hjwq.wav"
    self.audioId =  audio.playSound(soundSrc,false)      
end

function HeroLayer:updateHp(event)
	if self.hpUpdateHandler then 
		scheduler.unscheduleGlobal(self.hpUpdateHandler)
		self.hpUpdateHandler = nil
	end

	local function updateHpFunc()
		--ispause
		local isPause = self.hero:getIsPause()
		if isPause then return end

		local value = 0.0
		local scale, isInlayed = self.inlay:getInlayedValue("helper") 
		local maxHp = self.hero:getMaxHp()
		local baseHp = define.kHeroBaseHp 
		if isInlayed then 
			value =  baseHp * scale
		else 
			value = define.kHeroHelper
		end
		if self.hero:isDead() then 
			
			return
		end

		--check hp
		self.hero:onHpChange()

		if value == 0 then return end
		self.hero:increaseHp(value)

	end
	self.hpUpdateHandler = scheduler.scheduleGlobal(updateHpFunc, 1.0)
end

function HeroLayer:checkHpLess()
	
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
	if self.hpUpdateHandler then
		scheduler.unscheduleGlobal(self.hpUpdateHandler)
		self.hpUpdateHandler = nil
	end
end

function HeroLayer:onEnter()
	
end


return HeroLayer
