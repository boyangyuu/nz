
--[[--

“枪”的视图

]]
import("..includes.functionUtils")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Hero = import(".Hero")
local Gun  = import(".Gun")
local GunView = class("GunView", function()
    return display.newNode()
end)

function GunView:ctor(properties)
	--instance
	-- dump(properties, "GunView properties")
	self.hero = app:getInstance(Hero)
	self.gun  = Gun.new({id = properties.id})
	self.isChanging = false

	--gun armature and base
	self:setGun(properties.id)

	--event
	cc.EventProxy.new(self.hero, self)
        :addEventListener(Hero.GUN_CHANGE_EVENT, handler(self, self.playChange))

end

function GunView:playIdle()
	self.armature:getAnimation():play("stand" , -1, 1) 
end

function GunView:fire()
	self.bulletNum = self.bulletNum - 1
	self:playFire()
end

function GunView:playFire()
	--枪火
	self.jqk:setVisible(true)
	self.jqk:getAnimation():play("fire" , -1, 0)
	self.armature:getAnimation():play("fire" , -1, 0)
end

function GunView:stopFire()
	self.jqk:setVisible(false)
end

function GunView:playChange(event)
	-- if self.isChanging then return end
	print("GunView:playChange(event)")
	local disy = 150
	local actionDown = cc.MoveBy:create(0.2, cc.p(0.0, -disy))
	local actionUp = cc.MoveBy:create(0.2, cc.p(0.0, disy))
	local function callFuncBeginChange()
		self.isChanging = true
	end

	local function callFuncChange()
		self:setGun(event.gunId)

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
	--子弹full
	local reloadTime = 2.0
	local speedScale = 1 / reloadTime
	local function reloadDone()
		self.isReloading = false
		self.bulletNum = 30
	end
	scheduler.performWithDelayGlobal(reloadDone, reloadTime)
	
	--hero层reload动画
	print("GunView:playReload()")
	self.hero:dispatchEvent({
				name = self.hero.GUN_RELOAD_EVENT , speedScale = speedScale})
end

function GunView:canShot() 
	--bullets
	if self.bulletNum <= 0 then 
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

function GunView:setBulletNum(num)
	self.bulletNum = num
end

--hero层 发送换枪
function GunView:setGun(id)
	--clear
	if self.armature then 
		self.armature:removeFromParent() 
		self.armature = nil
		self.jqk = nil
	end

	--gun
	self.gun = Gun.new({id = id})
	local config = self.gun:getConfig()
	-- dump(config, "config")
	
	--子弹数目
	self:setBulletNum(self.gun:getBulletNum())

	--armature
	local effectName = config.effectName --动作特效
	local path = "Fight/gunsAnim/"..effectName .."/"
    local src = path..effectName..".ExportJson"
    local armature = getArmature(effectName, src) 
	self.armature = armature
	self:playIdle()	

	--换肤
	local srcSkin = config.displayImage  -- 图片
	print("srcSkin", srcSkin)
    local skin = ccs.Skin:createWithSpriteFrameName(srcSkin)
    armature:getBone("gun"):addDisplay(skin, 1)
    armature:getBone("gun"):changeDisplayWithIndex(1, true)
	self:addChild(armature)

    --枪火
    local effectJqkName = config.jqkName --机枪口特效
    local srcJqk =  "Fight/jqkAnim/"..effectJqkName.."/"..effectJqkName..".ExportJson"
    self.jqk = getArmature(effectJqkName, srcJqk)
    self.jqk:setVisible(false)
   	self.jqk:setPosition(cc.p(-120,180))
    armature:addChild(self.jqk , -1)
end

return GunView