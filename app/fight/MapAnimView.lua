
--[[--

“枪”的视图

]]
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
--events


local MapAnimView = class("MapAnimView", function()
    return display.newNode()
end)

function MapAnimView:ctor()
	local map = md:getInstance("Map")
	cc.EventProxy.new(map, self)
		:addEventListener(map.EFFECT_LEI_BOMB_EVENT, handler(self, self.playEffectLeiBomb))	
end

function MapAnimView:getScaleByPos(pos)
	local offsetScale = math.abs(pos.y - display.height/2) / display.height/2
	local scale = 0.3 + 0.7 * offsetScale
	return scale
end

--event
function MapAnimView:playEffectShooted(event)
	local pWorld = event.pWorld
	local ishitted = event.ishitted
	local animName = nil
	local inlay = md:getInstance("FightInlay") 
	local isGold = inlay:getIsActiveGold()
	local isRobot = md:getInstance("Robot"):getIsRoboting()

	--animName
	if isGold or isRobot then 
		animName = "hjqmz"
	elseif ishitted then
		animName = "zdmz_pt" 
	else
		animName = "zdmz_di"
	end

	--pos
	local pos = self:convertToNodeSpace(cc.p(pWorld.x, pWorld.y))
	assert(animName, "animName is nil type"..animName)
	local armature = ccs.Armature:create(animName)
	assert(armature, "armature os mil animName:"..animName)
	self:addChild(armature)
	armature:setPosition(pos)
	
	--scale 狙图特殊处理
	local scale = self:getScaleByPos(pos)
	armature:setScale(scale)
	armature:getAnimation():setMovementEventCallFunc(
        	function ( armatureBack,movementType,movementId ) 
    	    	if movementType == ccs.MovementEventType.loopComplete then
    	    		armatureBack:removeFromParent()
    	    	end
	    	end)
	armature:getAnimation():playWithIndex(0 , -1, 1)
end

function MapAnimView:playEffectLeiBomb(event)
	local pWorld = event.pWorld
	--pos
	local pos = self:convertToNodeSpace(cc.p(pWorld.x, pWorld.y))
	local armature = ccs.Armature:create("baozhasl_y")
	armature:setPosition(pos)
	
	--scale 狙图特殊处理
	local scale = self:getScaleByPos(pos)
	armature:setScale(scale)	
	self:addChild(armature)
	armature:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.loopComplete then
				armature:removeFromParent()
	    	end 
    	end)	
	armature:getAnimation():playWithIndex(0)
end

return MapAnimView