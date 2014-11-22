
--[[--

“枪”的视图

]]
import("..includes.functionUtils")

local GunView = class("GunView", function()
    return display.newNode()
end)

function GunView:ctor(properties)
	--instance
	self:setGun(properties.id)

	self:playIdle()
	self.isChanging = false

end

function GunView:playIdle()
	self.gun:getAnimation():play("stand" , -1, 1) 
end

function GunView:fire()
	self:playFire()
end

function GunView:playFire()

	self.gun:getAnimation():play("fire" , -1, 0)
	--枪火
	self.jqk:setVisible(true)
	self.jqk:getAnimation():play("fire" , -1, 0)
	
end

function GunView:stopFire()
	self.jqk:setVisible(false)
end

function GunView:playChange(gunId)
	if self.isChanging then return end
	local disy = 150
	local actionDown = cc.MoveBy:create(0.2, cc.p(0.0, -disy))
	local actionUp = cc.MoveBy:create(0.2, cc.p(0.0, disy))
	local function callFuncBeginChange()
		self.isChanging = true
	end

	local function callFuncChange()
		self:setGun(gunId)

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
	
end

function GunView:canShot() 
	--bullets

	--is changing
	return not self.isChanging
end

function GunView:setGun(id)
	--clear
	if self.gun then 
		self.gun:removeFromParent() 
		self.gun = nil
		self.jqk = nil
	end

	self.gunId = id
	local config = getConfigByID("config/weapon_weapon.json", id)
	assert(config, "invalid id")
	dump(config, "config")
	
	--动作
	local effectName = config.effectName --动作特效
	local path = "Fight/gunsAnim/"..effectName .."/"
    local src = path..effectName..".ExportJson"
    local armature = getArmature(effectName, src) 
	self.gun = armature

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