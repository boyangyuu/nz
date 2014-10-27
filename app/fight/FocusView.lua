
--[[--

“准星”的视图

]]
import("..includes.functionUtils")

local FocusView = class("FocusView", function()
    return display.newNode()
end)

function FocusView:ctor()
	self.playIndex = "stand"

	local gunId = 1   -- todo 外界传
	local focusId = gunId+11
    local src = "Fight/gunsAnim/anim_zunxin_sq/anim_zunxin_sq.ExportJson"
    local armature = getArmature("anim_zunxin_sq", src) 
	self.focus = armature
	self.focus:getAnimation():setMovementEventCallFunc(self.animationEvent)	
	self:addChild(armature)    
	self:playIdle()
end

function FocusView:playIdle()
	self.playIndex = "stand"
	self.focus:getAnimation():play("stand" , -1, 1) 
end

function FocusView:playFire()
	if self.playIndex == "stand" then 
		self.focus:getAnimation():play("fire01" , -1, 0) 
		self.playIndex = "fire01"
	elseif self.playIndex == "fire01" or self.playIndex == "fire02" then 
		print("fire02")
		self.focus:getAnimation():play("fire02" , -1, 0) 
		self.playIndex = "fire02"
	end
end

function FocusView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		if id == "fire01" then

    	elseif id == "fire02" then

    	end
	end
end

function FocusView:stopFire()
	self.playIndex = "stand"
end

return FocusView