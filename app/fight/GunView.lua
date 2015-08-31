
--[[--

“枪”的视图

]]
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
local Gun  		 = import(".Gun")

local GunView = class("GunView", function()
    return display.newNode()
end)

function GunView:ctor()
	--instance
	-- dump(properties, "GunView properties")
	self.hero  = md:getInstance("Hero")
	self.inlay = md:getInstance("FightInlay")
	self.isChanging = false
	self.gun   = nil
	self.jqk   = nil
	self.qkzd = nil
	self:refreshGun()

	--event
	cc.EventProxy.new(self.hero, self)
        :addEventListener(self.hero.GUN_CHANGE_EVENT, handler(self, self.playChange))
        :addEventListener(self.hero.FIRE_EVENT, handler(self, self.onHeroFire))

	cc.EventProxy.new(self.inlay, self)
        :addEventListener(self.inlay.INLAY_GOLD_BEGIN_EVENT, handler(self, self.onActiveGold))
        :addEventListener(self.inlay.INLAY_GOLD_END_EVENT,	 handler(self, self.onActiveGoldEnd))
end

function GunView:playIdle()
	self.armature:getAnimation():play("stand" , -1, 1)
end

function GunView:fire()
	--bullet
	local num = self.gun:getCurBulletNum() - 1
	self.gun:setCurBulletNum(num)
	if self.jqk then
		self.jqk   :setVisible(true)
		self.jqk:getAnimation():play("fire" , -1, 0)
	end

	if self.qkzd then
		self.qkzd :setVisible(true)
		self.qkzd:getAnimation():play("qkzd" , -1, 0)
	end

	self:addDanke()

	self.armature:getAnimation():play("fire" , -1, 1)
	local function animationEvent(armatureBack,movementType,movementId)
    	if movementType == ccs.MovementEventType.loopComplete
    	 and movementId == "fire"  then
			armatureBack:getAnimation():play("stand" , -1, 1)
    	end
	end
	self.armature:getAnimation():setMovementEventCallFunc(animationEvent)

	--sound
	local config = self.gun:getConfig()
	local soundName = config.imgName 			--动作特效

	--todo
	if soundName == "blt" then soundName = "lmd" end
	if soundName == "hql" then soundName = "ak" end
	if soundName == "bj" then soundName = "jfzc" end
	local soundSrc  = "res/Music/weapon/"..soundName.."fire.wav"
	self.audioId =  audio.playSound(soundSrc,false)
end

--hero层 发送换枪
function GunView:refreshGun()
	--clear
	if self.armature then
		self.armature:removeFromParent()
	end
	self.gun   = nil
	self.jqk   = nil
	self.qkzd = nil

	--gun
	self.gun  = self.hero:getGun()
	local config = self.gun:getConfig()
	-- dump(config, "config")

	--armature
	local animName = config.animName --动作特效
    local src = "res/Fight/gunsAnim/"..animName.."/"..animName..".ExportJson"
    local plist = "res/Fight/gunsAnim/"..animName.."/"..animName.."0.plist"
    local png   = "res/Fight/gunsAnim/"..animName.."/"..animName.."0.png"
    display.addSpriteFrames(plist, png)
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)

	local armature = ccs.Armature:create(animName)
    armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	self.armature = armature
	self:playIdle()
	self:addChild(armature)

	--isGold
	local isNativeGold = self.inlay:getIsNativeGold()
	local isGold = self.isGolding
	self:setGoldGun(isGold)

    local boneQk = armature:getBone("qk")
    local posBone = boneQk:convertToWorldSpace(cc.p(0, 0))
    local posArm = armature:convertToWorldSpace(cc.p(0, 0))
	local destpos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)

    --枪火
    local jqkName = config.jqkName --机枪口特效
    if jqkName ~= "null" then
	    self.jqk = ccs.Armature:create(jqkName)
	    self.jqk:setVisible(false)
	    self.jqk:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	    self.jqk:setPosition(destpos.x, destpos.y)
	    armature:addChild(self.jqk, -1)
	end

    --枪火遮挡
    local jqkzdName = config.jqkzdName
    if jqkzdName ~= "null" then
    	print("jqkzdName")
	    self.qkzd = ccs.Armature:create(jqkzdName)
	    self.qkzd:setVisible(false)
	   	self.qkzd:setPosition(destpos.x, destpos.y)
	    armature:addChild(self.qkzd , 100)
	    self.qkzd:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
    end

    --蛋壳
    self:addDanke()
end

function GunView:onHeroFire(event)
	self:fire()
end

function GunView:stopFire()
	if self.jqk then
		self.jqk :setVisible(false)
	end
	if self.qkzd then
		self.qkzd:setVisible(false)
	end

	-- self:playIdle()
end

function GunView:playChange(event)
	if self.isChanging then return end

	--clear
	self:setPosition(cc.p(0.0,0.0))

	-- print("GunView:playChange(event)")
	local disy = 150
	local actionDown = cc.MoveBy:create(0.2, cc.p(0.0, -disy))
	local actionUp 	 = cc.MoveBy:create(0.2, cc.p(0.0, disy))
	local function callFuncBeginChange()
		self.isChanging = true
	end
	local function callFuncChange()
		self:refreshGun()
	end
	local function callFuncFinishChange()
		self.isChanging = false
	end

	local seq = cc.Sequence:create(
		cc.CallFunc:create(callFuncBeginChange),
		actionDown,
		cc.CallFunc:create(callFuncChange),
		actionUp,
		cc.CallFunc:create(callFuncFinishChange))

	self:runAction(seq)
end

function GunView:playReload()
	if self.hero:getIsReloading() then return end

	self.hero:setIsReloading(true)

	--effect
	local soundSrc  = "res/Music/fight/hzd.wav"
	self.audioId =  audio.playSound(soundSrc,false)

	--回调 子弹full
	local reloadTime = self.gun:getReloadTime()
	print("reloadTime", reloadTime)
	local speedScale = 1 / reloadTime
	local function reloadDone()
		self.hero:setIsReloading(false)
		self.gun:setFullBulletNum()
	end
	self:performWithDelay(reloadDone, reloadTime)

	self.hero:dispatchEvent({
				name = self.hero.GUN_RELOAD_EVENT , speedScale = speedScale})
end

function GunView:canShot()
	--bullets
	if self.gun:getCurBulletNum() == 1 then
		self:stopFire()
		self:playReload()
		local fightFactory = md:getInstance("FightFactory")
   	 	local fight = fightFactory:getFight()
		fight:dispatchEvent({name = fight.GUN_RELOAD_EVENT})
		return true
	end

	--is changing
	return not self.isChanging
end

function GunView:setCoolDown(time)
	self.hero:setCooldown(time)
end

function GunView:addDanke()
	local dk = ccs.Armature:create("danke")
	dk:getAnimation():play("danke", -1, 1)
	local function animationEvent(armatureBack,movementType,movementId)
    	if movementType == ccs.MovementEventType.loopComplete then
			dk:removeSelf()
    	end
	end
	dk:getAnimation():setMovementEventCallFunc(animationEvent)

	--special check
	local config = self.gun:getConfig()
	local animName = config["animName"]
	local armature = self.armature

	--danke
    if self.destpos == nil then
	    local boneDk = armature:getBone("dk")
	    local posBone = boneDk:convertToWorldSpace(cc.p(0, 0))
	    local posArm = armature:convertToWorldSpace(cc.p(0, 0))
	    self.destpos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)
	end
   	dk:setPosition(self.destpos.x, self.destpos.y)
    armature:addChild(dk)
end

function GunView:setGoldGun(isGold)
	local skinIndex = isGold and 1 or 0
	self.armature:getBone("gun"):changeDisplayWithIndex(skinIndex, true)
	local boneIndex = 1

	--other bone
	while(true) do
		local boneStr = "gun"..boneIndex
		local bone = self.armature:getBone(boneStr)
		if bone == nil then break end
		bone:changeDisplayWithIndex(skinIndex, true)
		boneIndex = boneIndex + 1
	end
end

function GunView:onActiveGold(event)
	-- print("GunView:onActiveGold(event)")
	self.isGolding = true
	self.gun:setFullBulletNum()
	self:performWithDelay(handler(self, self.playChange), 0.6)
end

function GunView:onActiveGoldEnd(event)
	self.isGolding = false
	self.gun:setFullBulletNum()
	self:performWithDelay(handler(self, self.playChange), 0.6)
end

function GunView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		-- print("animationEvent id ", movementID)
		armatureBack:stopAllActions()
	end
end

return GunView