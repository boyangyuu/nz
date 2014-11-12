
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

function HeroView:ctor(properties)
	--instance
	self.hero = app:getInstance(Hero)
	cc.EventProxy.new(self.hero, self):addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.heroBeHurtEffect))
	local test = cc.uiloader:load("Fight/fightLayer/ui/UI.ExportJson")
	_beHurtNode = cc.uiloader:seekNodeByName(test, "hit_red")
	_beHurtNode:removeFromParent()
	-- _beHurtNode:serVisible(false)
	print("_beHurtNode", _beHurtNode:getScaleX())
    self:addChild(_beHurtNode)
    -- self:addChild(test)
end

function HeroView:heroBeHurtEffect()
    local tBloodArmature = getArmature("blood1", "blood1/blood1.ExportJson")
    local tBloodAniamtion = tBloodArmature:getAnimation()
    tBloodAniamtion:playWithIndex(0)
    tBloodArmature:setPosition(math.random(0, display.width), math.random(0, display.height))
    tBloodAniamtion:setMovementEventCallFunc(function ( armatureBack,movementType,movementI ) armatureBack:removeFromParent() end)
    self:addChild(tBloodArmature)
    -- if nil ~= _heroBeHurtBloodArmature then return end
    -- _heroBeHurtBloodArmature = getArmature("blood1", "blood1/blood1.ExportJson")
    -- local tBloodAniamtion = _heroBeHurtBloodArmature:getAnimation()
    -- tBloodAniamtion:playWithIndex(0)
    -- _heroBeHurtBloodArmature:setPosition(math.random(0, display.width), math.random(0, display.height))
    -- tBloodAniamtion:setMovementEventCallFunc(function ( armatureBack,movementType,movementI ) 
    -- 	armatureBack:removeFromParent()
    -- 	_beHurtNode:removeFromParent()
    -- 	_heroBeHurtBloodArmature = nil 
    -- 	end)
    -- self:addChild(_heroBeHurtBloodArmature)

    -- _beHurtNode:setVisible(true)
    -- _beHurtNode:runAction(cc.Blink(3, 2))
    -- _heroBeHurtScreenEffectArmature = getArmature("shan", "avatarhit_1.ExportJson")
    -- local tScreenAnimation = _heroBeHurtScreenEffectArmature:getAnimation()
    -- tScreenAnimation:playWithIndex(0)
    -- self:addChild(_heroBeHurtScreenEffectArmature)
    -- ccs.ActionManagerex:getInstance():playActionByName("shan", "")

end

return HeroView
