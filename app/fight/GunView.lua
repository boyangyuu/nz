
--[[--

“枪”的视图

]]

local GunView = class("GunView", function()
    return display.newNode()
end)

function GunView:ctor()
	local gunId = 1   -- todo 外界传
    local src = "Fight/guns/jiqiang/anim_gun_jiqiang.ExportJson"
    local armature = app:getArmature("anim_gun_jiqiang", src) 
	self.gun = armature
	self:addChild(armature)
	self:playIdle()
end

function GunView:playIdle()
	-- self.gun:getAnimation():playWithIndex(0 , -1, 1) --play
end

function GunView:playFire()
	self.gun:getAnimation():playWithIndex(1 , -1, 0) --play
end

function GunView:playReload()
	
end



return GunView