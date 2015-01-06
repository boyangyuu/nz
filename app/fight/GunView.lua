
--[[--

“枪”的视图

]]
import("..includes.functionUtils")
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
local Gun  		 = import(".Gun")

local GunView = class("GunView", function()
    return display.newNode()
end)

function GunView:ctor()
	--instance
	-- dump(properties, "GunView properties")
	self.hero = md:getInstance("Hero")
	self.inlay = md:getInstance("FightInlay")
	self.isChanging = false

	--gun armature and base
	self:refreshGun()
	-- scheduler.performWithDelayGlobal( handler(self, self.refreshGun), 1.0)  

	--event
	cc.EventProxy.new(self.hero, self)
        :addEventListener(self.hero.GUN_CHANGE_EVENT, handler(self, self.playChange))

	cc.EventProxy.new(self.hero, self)
        :addEventListener(self.hero.GUN_CHANGE_EVENT, handler(self, self.playChange))

	cc.EventProxy.new(self.inlay, self)
        :addEventListener(self.inlay.INLAY_GOLD_BEGIN_EVENT, handler(self, self.onActiveGold))
        :addEventListener(self.inlay.INLAY_GOLD_END_EVENT,	 handler(self, self.onActiveGoldEnd))
end

function GunView:playIdle()
	self.armature:getAnimation():play("stand" , -1, 1) 
end

function GunView:fire()
	local num = self.gun:getCurBulletNum() - 1
	self.gun:setCurBulletNum(num)
	self:playFire()
end

function GunView:playFire()
	--枪火
	self.jqk   :setVisible(true)
	-- self.jqkzd :setVisible(true)
	self.dk    :setVisible(true)
	self.jqk:getAnimation()	 :play("fire" , -1, 0)
	self.jqkzd:getAnimation():play("qkzd" , -1, 0)
	self.dk:getAnimation()	 :play("danke", -1, 0)
	self.armature:getAnimation():play("fire" , -1, 0)
end

function GunView:stopFire()
	self.jqk  :setVisible(false)
	self.jqkzd:setVisible(false)
	self.dk   :setVisible(false)
end

function GunView:playChange(event)
	if self.isChanging then return end
	
	--clear
	self:setPosition(cc.p(0.0,0.0))

	print("GunView:playChange(event)")
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
	if self.isReloading then return end

	self.isReloading = true

	--
	--回调 子弹full
	local reloadTime = self.gun:getReloadTime()
	local speedScale = 1 / reloadTime
	local function reloadDone()
		self.isReloading = false 
		self.gun:setFullBulletNum()
	end
	scheduler.performWithDelayGlobal(reloadDone, reloadTime)
	
	--hero层reload动画
	print("GunView:playReload()")
	self.hero:dispatchEvent({
				name = self.hero.GUN_RELOAD_EVENT , speedScale = speedScale})
end

function GunView:canShot() 
	--bullets
	if self.gun:getCurBulletNum() <= 0 then 
		self:stopFire()
		self:playReload()
		return false 
	end
	
	--is changing
	return not self.isChanging
end

function GunView:setCoolDown(time)
	self.hero:setCooldown(time)
end

--hero层 发送换枪
function GunView:refreshGun()
	
	
	-- print("refreshGun")
	self.gun  = self.hero:getGun()
	--clear
	if self.armature then 
		self.armature:removeFromParent() 
	end

	--gun
	local config = self.gun:getConfig()
	-- dump(config, "config")
	
	--armature
	local animName = config.animName --动作特效
	local armature = ccs.Armature:create(animName)
	self.armature = armature
	self:playIdle()	
	self:addChild(armature)

	--isGold
	local isNativeGold = self.inlay:getIsNativeGold()
	local isGold = self.isGolding
	self:setGoldGun(isGold)

    --枪火 todo放在fp里
    local jqkName = config.jqkName --机枪口特效
    self.jqk = ccs.Armature:create(jqkName)
    self.jqk:setVisible(false)
    local boneQk = armature:getBone("qk")
    local posBone = boneQk:convertToWorldSpace(cc.p(0, 0))
    local posArm = armature:convertToWorldSpace(cc.p(0, 0))
	local destpos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)
    self.jqk:setPosition(destpos.x, destpos.y)
    armature:addChild(self.jqk, -1)

    --枪火遮挡 
    self.jqkzd = ccs.Armature:create("qkzd")
    self.jqkzd:setVisible(false)
   	self.jqkzd:setPosition(destpos.x, destpos.y)
    armature:addChild(self.jqkzd , 1)

    --蛋壳
    self:addDanke()
end

function GunView:addDanke()
	self.dk = ccs.Armature:create("danke")

	--todo

	--special check
	local config = self.gun:getConfig()
	local animName = config["animName"]	
	local armature = self.armature
    local boneDk = armature:getBone("dk")
    local posBone = boneDk:convertToWorldSpace(cc.p(0, 0))
    local posArm = armature:convertToWorldSpace(cc.p(0, 0))
    local destpos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)
    self.dk:setVisible(false)
   	self.dk:setPosition(destpos.x, destpos.y)
    armature:addChild(self.dk , 3)	
end

function GunView:setGoldGun(isGold)
	local skinIndex = isGold and 1 or 0
	self.armature:getBone("gun"):changeDisplayWithIndex(skinIndex, true) 
	local boneIndex = 1
	while(true) do
		local boneStr = "gun"..boneIndex
		local bone = self.armature:getBone(boneStr)
		if bone == nil then break end
		bone:changeDisplayWithIndex(skinIndex, true)
		boneIndex = boneIndex + 1
	end
end


function GunView:onActiveGold(event)
	print("GunView:onActiveGold(event)")
	self.isGolding = true
	scheduler.performWithDelayGlobal(handler(self, self.playChange), 0.6)
end

function GunView:onActiveGoldEnd(event)
	self.isGolding = false
	scheduler.performWithDelayGlobal(handler(self, self.playChange), 0.6)
end

return GunView