
--[[--

“英雄”的视图

]]

--import
import("..includes.functionUtils")

local Actor = import(".Actor")
local Hero = import(".Hero")

local HeroView = class("HeroView", function()
    return display.newNode()
end)

_heroBeHurtBloodArmature = nil
_beHurtNode = nil
_screenEffectIsStop = true

function HeroView:ctor(properties)
	--instance
	self.hero = app:getInstance(Hero)
	cc.EventProxy.new(self.hero, self):addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.heroBeHurtEffect))
	local test = cc.uiloader:load("Fight/fightLayer/ui/UI.ExportJson")
	_beHurtNode = cc.uiloader:seekNodeByName(test, "hit_red")
	_beHurtNode:removeFromParent()
    self:addChild(_beHurtNode)
    _beHurtNode:setVisible(false)
end

function HeroView:heroBeHurtEffect()

	self:screenEffect_()
    --hero behurt blood effect
    local tBloodArmature = getArmature("blood1", "blood1/blood1.ExportJson")
    local tBloodAniamtion = tBloodArmature:getAnimation()
    tBloodAniamtion:play("blood1_01" , -1, 1)
    tBloodArmature:setPosition(math.random(0, display.width), math.random(0, display.height))
    tBloodAniamtion:setMovementEventCallFunc( 
    	function ( armatureBack,movementType,movementI ) 
    	if movementType == ccs.MovementEventType.loopComplete then
    		armatureBack:stopAllActions()
    		armatureBack:removeFromParent() 
    	end 
    end)
    self:addChild(tBloodArmature)
end

function HeroView:screenEffect_()
	--hero behurt screen effect
	if true == _screenEffectIsStop then
		_beHurtNode:setVisible(true)
	    _beHurtNode:runAction(
	    	cc.Sequence:create(
	    		cc.FadeIn:create(0.2), 
	    		cc.FadeOut:create(0.3), 
		    	cc.CallFunc:create(
	    		function ()
		 			_screenEffectIsStop = true 
		 			_beHurtNode:setVisible(false)
		   		end
		   		)
		   	)
		)
	end
    _screenEffectIsStop = false
end


    -- if nil ~= _heroBeHurtBloodArmature then return end
    -- _heroBeHurtBloodArmature = getArmature("blood1", "blood1/blood1.ExportJson")
    -- local tBloodAniamtion = _heroBeHurtBloodArmature:getAnimation()
    -- tBloodAniamtion:playWithIndex(0)
    -- _heroBeHurtBloodArmature:setPosition(math.random(0, display.width), math.random(0, display.height))
    -- tBloodAniamtion:setMovementEventCallFunc(
    -- 	function ( armatureBack,movementType,movementI ) 
	   -- 		if movementType ~= ccs.MovementEventType.Complete then 
	   -- 			return 
	   -- 		end
	   --  	armatureBack:removeFromParent()
	   --  	_heroBeHurtBloodArmature = nil 
    -- 	end)
    -- self:addChild(_heroBeHurtBloodArmature)
return HeroView
