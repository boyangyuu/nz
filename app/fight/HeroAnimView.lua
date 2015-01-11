
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
		:addEventListener(Hero.EFFECT_HURT_BOMB_EVENT	, handler(self, self.playHurtedBomb))	
		:addEventListener(Hero.ENEMY_KILL_HEAD_EVENT 	, handler(self, self.playKillHead))	
		:addEventListener(Hero.ENEMY_KILL_HEAD_EVENT 	, handler(self, self.playWindEffect))	
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
    	    		print("HeroLayer:removeFromParent()")
    	    		armature:removeFromParent()
    	    		armature = nil
    	    	end
	    	end)
	armature:getAnimation():playWithIndex(0 , -1, 1)	
end

function HeroAnimView:playKillHead(event)
	print("function HeroAnimView:playKillHead(event)")
	local baotou = ccs.Armature:create("baotou")
	baotou:getAnimation():play("baotou" , -1, 1)
    baotou:getAnimation():setMovementEventCallFunc(
    	function ( armatureBack,movementType,movement) 
	    	if movementType == ccs.MovementEventType.loopComplete then
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent() 
	    	end 
    	end
    )
    self:addChild(baotou)
end

function HeroAnimView:playWindEffect(event)
	local armature = ccs.Armature:create("btqpg")
	armature:getAnimation():play("btqpg" , -1, 1)
    armature:getAnimation():setMovementEventCallFunc(
    	function ( armatureBack,movementType,movement) 
	    	if movementType == ccs.MovementEventType.loopComplete then
	    		armatureBack:stopAllActions()
	    		armatureBack:removeFromParent() 
	    	end 
    	end
    )
    self:addChild(armature) 
end

return HeroAnimView