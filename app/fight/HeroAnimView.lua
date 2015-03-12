
--[[--

“地图效果”的视图

]]
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
--events


local HeroAnimView = class("HeroAnimView", function()
    return display.newNode()
end)

function HeroAnimView:ctor()
	self.hero   	 = md:getInstance("Hero")
	local fightInlay = md:getInstance("FightInlay")
	cc.EventProxy.new(self.hero, self)
		:addEventListener(self.hero.EFFECT_HURT_BOLI_EVENT	, handler(self, self.playHurtedBomb_boli))	
		:addEventListener(self.hero.EFFECT_HURT_BOMB_EVENT	, handler(self, self.playHurtedBomb_lei))	
		:addEventListener(self.hero.EFFECT_KEEPKILL_EVENT	, handler(self, self.playKeepKill))
		
		:addEventListener(self.hero.ENEMY_KILL_HEAD_EVENT 	, handler(self, self.playKillHead))	
		:addEventListener(self.hero.ENEMY_KILL_HEAD_EVENT 	, handler(self, self.playWindEffect))	
		:addEventListener(self.hero.ENEMY_KILL_BOSS_EVENT 	, handler(self, self.playEffectBling))	
		:addEventListener(self.hero.HP_DECREASE_EVENT		, handler(self, self.playHitted))
		:addEventListener(self.hero.HP_STATE_EVENT			, handler(self, self.playLessHp))
		:addEventListener(self.hero.GUN_RELOAD_EVENT		, handler(self, self.playGunReload))

	cc.EventProxy.new(fightInlay, self)
		:addEventListener(fightInlay.INLAY_GOLD_BEGIN_EVENT , handler(self, self.playActiveGold))

	self:loadCCS()
end

function HeroAnimView:loadCCS()
	--爆头
	self.armatureHeadWind = ccs.Armature:create("btqpg")
    self:addChild(self.armatureHeadWind) 
    self.armatureHead = ccs.Armature:create("baotou")
    self:addChild(self.armatureHead)

    --玻璃碎
    self.armatureBoli = ccs.Armature:create("bls")
    self:addChild(self.armatureBoli)

    --血量警告    
	self.armatureScreenRed = ccs.Armature:create("avatarhit")
    self:addChild(self.armatureScreenRed)   

    --血花 
    self.armatureBlood1 = ccs.Armature:create("blood1")
    self:addChild(self.armatureBlood1) 
    self.armatureBlood2 = ccs.Armature:create("blood2")
    self:addChild(self.armatureBlood2)  

    --黄武
    self.armatureGold 	= ccs.Armature:create("hjwq")
    self:addChild(self.armatureGold) 

    --换子弹
	self.armatureReload = ccs.Armature:create("huanzidan")    
    self:addChild(self.armatureReload) 	

    --连杀
	self.armatureKeepKill = ccs.Armature:create("ls")
	self.armatureKeepKill:setPosition(-390, 180)    
    self:addChild(self.armatureKeepKill)
	self.labelKeepKill = display.newBMFontLabel({ text = "",font = "res/fnt/NO3.fnt"})
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
	print("function HeroAnimView:playHurtedBomb_lei(event)")
	-- --sound
    local soundSrc  = "res/Music/fight/hd_bz.wav"
    audio.playSound(soundSrc,false)  	
end

function HeroAnimView:playHurtedBomb_boli(event)
	print("function HeroAnimView:playHurtedBomb_boli(event)")
	self.armatureBoli:getAnimation():playWithIndex(0 , -1, 0)	

	--sound
    local soundSrc  = "res/Music/fight/hd_bz.wav"
    audio.playSound(soundSrc,false)  	
end

function HeroAnimView:playKillHead(event)
	self.armatureHead:getAnimation():play("baotou" , -1, 0)
end

function HeroAnimView:playWindEffect(event)
	self.armatureHeadWind:getAnimation():play("btqpg" , -1, 0)
end

function HeroAnimView:playEffectBling(event)
	-- print("function HeroAnimView:playEffectBling(event)")
	local armature = ccs.Armature:create("bossdies")
	armature:getAnimation():play("shan" , -1, 1)
    self:addChild(armature) 
    local function endFunc()
	    -- print("HeroAnimView endFunc")
    	armature:removeSelf()
    	armature = nil
    end
    self:performWithDelay(endFunc, 2.6)
end

function HeroAnimView:playHitted(event)
	self:playHpDecreaseEffect()
	self:playHpAlertEffect()
end

function HeroAnimView:playLessHp(event)
	print("playLessHp event.isLessHp", event.isLessHp)
	local isLessHp = event.isLessHp
	if isLessHp then
		self.armatureScreenRed:getAnimation():play("avatarhit" , -1, 1)
	else
		self.armatureScreenRed:getAnimation():stop()
	end
end

function HeroAnimView:playHpAlertEffect()
	if self.hero:getIsLessHp() then return end
	self.armatureScreenRed:getAnimation():play("avatarhit" , -1, 0)
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
	print("function HeroAnimView:playActiveGold(event)")
	self.armatureGold:getAnimation():playWithIndex(0 , -1, 0)

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
end

return HeroAnimView