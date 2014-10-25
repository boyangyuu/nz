
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--model
import("..includes.functionUtils")
local scheduler = require("framework.scheduler")
local Enemy = import(".Enemy")

local EnemyView = class("EnemyView", function()
    return display.newNode()
end)

function EnemyView:ctor()
	local id = "1"   -- todo 外界传
	self.playIndex = nil

	--model
	self.enemy = Enemy.new({id = id})

	--armature
    local src = "Fight/enemys/anim_enemy_001/anim_enemy_001.ExportJson"
    local armature = getArmature("anim_enemy_001", src) 
	self.armature = armature
	self.armature:getAnimation():setMovementEventCallFunc(self.animationEvent)	
	
	--换肤
	self:addChild(armature)

    --帧事件
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()  
end

function EnemyView:playIdle()
	self.armature:getAnimation():play("stand" , -1, 1) 
end

function EnemyView:playFire()
	self.armature:getAnimation():play("fire" , -1, 0) 
end

function EnemyView:animationEvent(armatureBack,movementType,id)
	if movementType == ccs.MovementEventType.loopComplete then
		if id == "fire01" then

    	elseif id == "fire02" then

    	end 
	end
end

--play ami
function EnemyView:playIdle()

	self.armature:getAnimation():play("stand" , -1, 1) 
end

function EnemyView:playFire()
	self.armature:getAnimation():play("fire" , -1, 0) 
end

--random create state

--tick
function EnemyView:tick(t)
	local state = self.enemy:getState()
	print("state", state)
	if self.playIndex ~= state then 
		if state == "idle" then 
			self:playIdle()
		elseif state == "fire" then
			self:playFire()
		end
		self.playIndex = state
	end

	--change state
	if t % 100 == 0 then 
		self:playFire()
	end
end

return EnemyView