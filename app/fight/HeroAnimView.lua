
--[[--

“地图效果”的视图

]]
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
--events


local HeroAnimView = class("HeroAnimView", function()
    return display.newNode()
end)

function HeroAnimView:ctor()
	local Hero = md:getInstance("Hero")
	cc.EventProxy.new(Hero, self)
		:addEventListener(Hero.EFFECT_HURT_BOMB_EVENT, handler(self, self.playHurtedBomb))	
end

function HeroAnimView:playHurtedBomb(event)
	print("HeroLayer:playHurtedBomb()")
	local animName = event.animName
	local armature = ccs.Armature:create(animName)
	-- assert(armature, "armature os mil animName:"..bls)
	self:addChild(armature)
	armature:getAnimation():setMovementEventCallFunc(
        	function ( armatureBack,movementType,movementId ) 
    	    	if movementType == ccs.MovementEventType.loopComplete then
    	    		armature:removeFromParent()
    	    		armature = nil
    	    	end
	    	end)
	armature:getAnimation():playWithIndex(0 , -1, 1)	
end

return HeroAnimView