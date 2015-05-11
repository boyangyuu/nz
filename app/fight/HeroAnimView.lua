
--[[--

“地图效果”的视图

]]

local HeroAnimView = class("HeroAnimView", function()
    return display.newNode()
end)

function HeroAnimView:ctor()
	self.hero   	 = md:getInstance("Hero")
    local fightFactory = md:getInstance("FightFactory")
    self.fight 		 = fightFactory:getFight()
	local fightInlay = md:getInstance("FightInlay")
	local fightMode  = md:getInstance("FightMode")
	self.isPlayCombo = false

	cc.EventProxy.new(self.hero, self)
		:addEventListener(self.hero.EFFECT_HURT_BOLI_EVENT	, handler(self, self.playHurtedBomb_boli))	
		:addEventListener(self.hero.EFFECT_HURT_YAN_EVENT	, handler(self, self.playHurtedBomb_yan))	
		:addEventListener(self.hero.EFFECT_HURT_BOMB_EVENT	, handler(self, self.playHurtedBomb_lei))	
		:addEventListener(self.hero.EFFECT_KEEPKILL_EVENT	, handler(self, self.playKeepKill))
		:addEventListener(self.hero.EFFECT_GUIDE_EVENT		, handler(self, self.playAnimGuide))
		:addEventListener(self.hero.EFFECT_ADDHP_EVENT		, handler(self, self.playAnimAddHp))
		
		:addEventListener(self.hero.ENEMY_KILL_HEAD_EVENT 	, handler(self, self.playKillHead))	
		:addEventListener(self.hero.ENEMY_KILL_HEAD_EVENT 	, handler(self, self.playWindEffect))	
		:addEventListener(self.hero.ENEMY_KILL_BOSS_EVENT 	, handler(self, self.playEffectBling))	
		
		:addEventListener(self.hero.HP_DECREASE_EVENT		, handler(self, self.playHitted))
		:addEventListener(self.hero.HP_STATE_EVENT			, handler(self, self.onUpdateHp))
		:addEventListener(self.hero.GUN_RELOAD_EVENT		, handler(self, self.playGunReload))

	cc.EventProxy.new(fightInlay, self)
		:addEventListener(fightInlay.INLAY_GOLD_BEGIN_EVENT , handler(self, self.playActiveGold))
	
	cc.EventProxy.new(fightMode, self)
		:addEventListener(fightMode.FightMODE_TIPS_EVENT	, handler(self, self.playFightTips))

	self:loadCCS()
end

function HeroAnimView:loadCCS()
	--爆头
	self.armatureHeadWind = ccs.Armature:create("btqpg")
    self:addChild(self.armatureHeadWind) 
    self.armatureHead = ccs.Armature:create("baotou")
    self:addChild(self.armatureHead)


    --血花 
    self.armatureBlood1 = ccs.Armature:create("blood1")
    self:addChild(self.armatureBlood1) 
    self.armatureBlood2 = ccs.Armature:create("blood2")
    self:addChild(self.armatureBlood2)  

    --换子弹
	self.armatureReload = ccs.Armature:create("huanzidan")    
    self:addChild(self.armatureReload) 	

    --连杀
	self.armatureKeepKill = ccs.Armature:create("ls")
	self.armatureKeepKill:setPosition(-390, 180)    
    self:addChild(self.armatureKeepKill)
    local strRes
    if device.platform == "android" then
	    strRes = "res/NO3.fnt"
	else
		strRes = "res/fnt/NO3.fnt"
	end
	self.labelKeepKill = display.newBMFontLabel({ text = "",font = strRes})
	self.labelKeepKill:setPosition(-470, 160)  
	self:addChild(self.labelKeepKill)
	self.armatureKeepKill:getAnimation():setMovementEventCallFunc(
        	function ( armatureBack,movementType,movementId ) 
    	    	if movementType == ccs.MovementEventType.complete then
					self.labelKeepKill:setVisible(false)
    	    	end
	    	end)	
end

function HeroAnimView:playHurtedBomb_lei(event)
	-- --sound
    local soundSrc  = "res/Music/fight/hd_bz.wav"
    audio.playSound(soundSrc,false)  	
end

function HeroAnimView:playHurtedBomb_boli(event)
    --玻璃碎
    local armatureBoli = ccs.Armature:create("bls")
    self:addChild(armatureBoli)	
	armatureBoli:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.complete then
				armatureBack:removeFromParent()
	    	end 
    	end)	
	armatureBoli:getAnimation():playWithIndex(0 , -1, 0)

	--sound
    local soundSrc  = "res/Music/fight/glass.wav"
    audio.playSound(soundSrc,false)  	
end

function HeroAnimView:playHurtedBomb_yan(event)
    --烟雾
    local armatureYan = ccs.Armature:create("yw")
    self:addChild(armatureYan)	
	armatureYan:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.loopComplete then
				if movementId == "yanwu" then 
					armatureYan:removeFromParent()
				end
	    	end 
    	end)	
	armatureYan:getAnimation():play("yanwu" , -1, 1)
end

function HeroAnimView:playKillHead(event)
	local currentName = self.armatureHead:getAnimation():getCurrentMovementID()
	if currentName == "" or currentName == nil then 
		self.armatureHead:getAnimation():play("baotou" , -1, 0)
	end
end

function HeroAnimView:playWindEffect(event)
	local currentName = self.armatureHeadWind:getAnimation():getCurrentMovementID()
	if currentName == "" or currentName == nil then 
		self.armatureHeadWind:getAnimation():play("btqpg" , -1, 0)
	end	
end

function HeroAnimView:playEffectBling(event)
	local armature = ccs.Armature:create("bossdies")
	armature:getAnimation():play("shan" , -1, 1)
    self:addChild(armature) 
    local function endFunc()
    	armature:removeSelf()
    	armature = nil
    end
    self:performWithDelay(endFunc, 2.6)
end

function HeroAnimView:playHitted(event)
	self:playHpDecreaseEffect()
end

function HeroAnimView:onUpdateHp(event)
	local isLessHp = event.isLessHp
	if isLessHp and self.armatureScreenRed == nil then
		self.armatureScreenRed = ccs.Armature:create("avatarhit")
	    self:addChild(self.armatureScreenRed)  
		self.armatureScreenRed:getAnimation():play("avatarhit" , -1, 1)
	elseif self.armatureScreenRed then
		self.armatureScreenRed:removeSelf()
		self.armatureScreenRed = nil
	end
end

function HeroAnimView:playHpDecreaseEffect()
	local armature
	if 1 == math.random(0, 1) then 
		armature = self.armatureBlood1
	else
		armature = self.armatureBlood2
	end
	armature:getAnimation():playWithIndex(0 , -1, 0)
    armature:setPosition(
    	math.random(-display.width/2, display.width/2), 
    	math.random(-display.height1/2, display.height1/2))
end

function HeroAnimView:playActiveGold(event)
    --黄武
    local armatureGold 	= ccs.Armature:create("hjwq")
    self:addChild(armatureGold) 
	armatureGold:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.complete then
				armatureBack:removeFromParent()
	    	end 
    	end)	
	armatureGold:getAnimation():playWithIndex(0 , -1, 0)

    --sound
    local soundSrc  = "res/Music/fight/hjwq.wav"
    audio.playSound(soundSrc,false) 
end

function HeroAnimView:playGunReload()
	self.armatureReload:getAnimation():playWithIndex(0 , -1, 0)
end

function HeroAnimView:playKeepKill(event)
	local count = event.count
	self.labelKeepKill:setString(count)
	self.labelKeepKill:setVisible(true)
	self.labelKeepKill:setScale(1.0)
	local actionScale1 = cc.ScaleTo:create(0.2, 3.0)
	local actionScale2 = cc.ScaleTo:create(0.1, 1.0)
	local seq = cc.Sequence:create(actionScale1, actionScale2) 
	transition.execute(self.labelKeepKill, seq, {easing = "Out",})
	self.armatureKeepKill:getAnimation():play("ls" , -1, 0)

	--sound
	local soundIndex = nil
	if count <= 7 then 
		soundIndex = count
	elseif count % 10 == 0 then
		soundIndex = 8 
	else

	end

	if soundIndex ~= nil then
	    local soundSrc   = "res/Music/fight/combo_" .. soundIndex .. ".wav"
	    audio.playSound(soundSrc,false) 	
	end
end

function HeroAnimView:playFightTips(event)
	local animName = event.animName
	assert(animName, "animName is nil")

	local armature 	= ccs.Armature:create("tishi")
	armature:getAnimation():play(animName , -1, 0)
	armature:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.complete then
				armatureBack:removeFromParent()
				armatureBack = nil
	    	end 
    	end)		
	self:addChild(armature)
end

function HeroAnimView:playAnimGuide(event)   
	--add res 
	local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo("res/Fight/heroAnim/yd_saos/yd_saos.ExportJson")
    display.addSpriteFrames("res/Fight/heroAnim/yd_saos/yd_saos0.plist", 
        "res/Fight/heroAnim/yd_saos/yd_saos0.png") 

    local armature = ccs.Armature:create("yd_saos")
    local animName = event.animName
    armature:getAnimation():play(animName, -1, 1)
    self:addChild(armature, 10)
    local removeFunc = function ()
        armature:removeSelf()
        armature = nil
    end
    self:performWithDelay(removeFunc, 10.0)	
end

function HeroAnimView:playAnimAddHp(event)
	--add res
	local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo("res/Fight/heroAnim/avatar_jiaxue/avatar_jiaxue.ExportJson")
    display.addSpriteFrames("res/Fight/heroAnim/avatar_jiaxue/avatar_jiaxue0.plist", 
        "res/Fight/heroAnim/avatar_jiaxue/avatar_jiaxue0.png") 

	local armature 	= ccs.Armature:create("avatar_jiaxue")
	armature:getAnimation():playWithIndex(0 , -1, 0)
	armature:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.complete then
				armatureBack:removeFromParent()
				armatureBack = nil
	    	end 
    	end)		
	self:addChild(armature)
end

function HeroAnimView:onExit()
	
end

return HeroAnimView