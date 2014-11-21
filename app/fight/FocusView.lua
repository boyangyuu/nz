
--[[--

“准星”的视图

]]

--import
import("..includes.functionUtils")
local FightConfigs = import(".fightConfigs.FightConfigs")
local Hero = import(".Hero")
local Gun = import(".Gun")

local FocusView = class("FocusView", function()
    return display.newNode()
end)

function FocusView:ctor(properties)
	
	--instance
	-- local fightConfigs = app:getInstance(FightConfigs)
	self.hero = app:getInstance(Hero)
	self.gun = app:getInstance(Gun)

	--focus
	local gunId = 1   -- todo 外界传 Gun
	local focusId = gunId + 11
    local src = "Fight/gunsAnim/anim_zunxin_sq/anim_zunxin_sq.ExportJson"
    local armature = getArmature("anim_zunxin_sq", src) 
    armature:setAnchorPoint(0.5,0.5)
	
    --都配在武器表里 
	self.focus = armature
	self.focus:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
	self:addChild(armature)    
	self:playIdle()
	local range = FightConfigs:getFocusRange() --todo 不要 fightConfigs 需要根据枪表来设置
	self:setFocusRange(cc.size(range, range))
	self.playIndex = "stand"

    --test
    self:test()
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
		-- print("fire02")
		self.focus:getAnimation():play("fire02" , -1, 0) 
		self.playIndex = "fire02"
	end
end

function FocusView:animationEvent(movementType,movementID,armatureBack)
	if movementType == ccs.MovementEventType.loopComplete then
		if id == "fire01" then

    	elseif id == "fire02" then

    	end
	end
end

function FocusView:stopFire()
	self.playIndex = "stand"
end

function FocusView:setFocusRange(size)
	if self.focusRange then 
		self.focusRange:removeFromParent()
	end
    self.focusRange = display.newScale9Sprite()
    self.focusRange:setContentSize(size)
    addChildCenter(self.focusRange, self)
end

function FocusView:getFocusRange()
	return self.focusRange
end

function FocusView:test()
    drawBoundingBox(self, self.focusRange, cc.c4f(1.0, 0.0, 0, 1.0))
end

return FocusView