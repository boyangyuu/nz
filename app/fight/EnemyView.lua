
--[[--

“enemy”的视图

]]

--model
local Enemy = import("..Enemy")


local EnemyView = class("EnemyView", function()
    return display.newNode()
end)

function EnemyView:ctor()
	local id = 1   -- todo 外界传

	--model
	self.enemy = Enemy.new()

	--armature
    local src = "Fight/enemys/anim_enemy_001/anim_enemy_001.ExportJson"
    local armature = getArmature("anim_enemy_001", src) 
	self.armature = armature

	--换肤
	self:addChild(armature)    
	self:playIdle()
end

function EnemyView:playIdle()
	self.gun:getAnimation():play("stand" , -1, 1) 
end

function EnemyView:playFire()
	self.gun:getAnimation():play("fire" , -1, 0) 
end



function EnemyView:playReload()
	
end

function EnemyView:setGun()
	
end

function EnemyView:getEnemy()
	return self.enemy
end

return EnemyView