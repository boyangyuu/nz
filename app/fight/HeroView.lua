
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

local _beHurtNode = nil

function HeroView:ctor(properties)
	--instance
	self.hero = app:getInstance(Hero)
	cc.EventProxy.new(self.hero, self):addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.beHurtEffect))
	local test = cc.uiloader:load("Fight/fightLayer/ui/UI.ExportJson")
	_beHurtNode = cc.uiloader:seekNodeByName(test, "screenHurtedEffect")
	_beHurtNode:removeFromParent()
    self:addChild(_beHurtNode)
    _beHurtNode:setVisible(false)
end

function HeroView:beHurtEffect()
	self:screenHurtedEffect()

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

function HeroView:screenHurtedEffect()
	--hero behurt screen effect
	if true ~= _beHurtNode:isVisible() then
		_beHurtNode:setVisible(true)
	    _beHurtNode:runAction(
	    	cc.Sequence:create(
	    		cc.FadeIn:create(0.2), 
	    		cc.FadeOut:create(0.3), 
		    	cc.CallFunc:create(
	    		function ()
		 			_beHurtNode:setVisible(false)
		   		end
		   		)
		   	)
		)
	end
end
return HeroView
