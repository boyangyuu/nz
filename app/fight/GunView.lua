
--[[--

“枪”的视图

]]
import("..includes.functionUtils")

local GunView = class("GunView", function()
    return display.newNode()
end)

function GunView:ctor()
	local gunId = 1   -- todo 外界传
    local src = "Fight/gunsAnim/anim_gun_jiqiang/anim_gun_jiqiang.ExportJson"
    local armature = getArmature("anim_gun_jiqiang", src) 
	self.gun = armature

	--换肤
	local srcSkin = "icon_shouqiang.png"
    local skin = ccs.Skin:createWithSpriteFrameName(srcSkin)
    -- dump(skin, "skin")
    armature:getBone("gun"):addDisplay(skin,1)
    armature:getBone("gun"):changeDisplayWithIndex(1, true)

	self:addChild(armature)    
	self:playIdle()
end

function GunView:playIdle()
	self.gun:getAnimation():play("stand" , -1, 1) 
end

function GunView:playFire()
	self.gun:getAnimation():play("fire" , -1, 0) 
end

function GunView:playReload()
	
end
function GunView:setGun()
	
end

return GunView