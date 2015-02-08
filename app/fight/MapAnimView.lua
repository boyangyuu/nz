
--[[--

“地图效果”的视图

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
	local offsetScale = (math.abs(pos.y - display.height/2)) / (display.height/2)
	local scale = 0.6 + 0.4 * offsetScale
	return scale
end

--event
function MapAnimView:playEffectShooted(event)
	local pWorld = event.pWorld
	local isHitted = event.isHitted
	local animName = nil
	local inlay = md:getInstance("FightInlay") 

	--robot gold or special gun
	local isGold = inlay:getIsActiveGold()
	-- print("isGold", isGold)
	local isRobot = md:getInstance("Robot"):getIsRoboting()
	local hero    = md:getInstance("Hero")
	local gunCfg  = hero:getGun():getConfig()
	local isRpg   = gunCfg["type"] == "rpg"
	local isPz    = gunCfg["type"] == "pz"

	--animName
	if isGold or isRobot or isRpg then 
		animName = "hjqmz"
	elseif isHitted then
		animName = "zdmz_pt" 
	else
		animName = "zdmz_di"
	end
	-- print("animName"..animName)
	--pos
	local pos = self:convertToNodeSpace(cc.p(pWorld.x, pWorld.y))
	assert(animName, "animName is nil type"..animName)

	if self.isShootAniming and animName == "zdmz_pt" then return end
	self.isShootAniming = true

	--one or many
	if isPz then 
		for i=1,6 do
			local rx = math.random(-70, 70)
			local ry = math.random(-40, 40)
			local destPos = cc.p(pos.x + rx, pos.y + ry)
			self:addShootedArmature(animName, destPos)
		end
	else
		self:addShootedArmature(animName, pos)
	end
end

function MapAnimView:addShootedArmature(animName, pos)
	-- print("function MapAnimView:addShootedArmature(animName, pos)")
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
    	    		armature:removeFromParent()
    	    		armature = nil
    	    		self.isShootAniming = false
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
	    	if movementType == ccs.MovementEventType.complete then
				armature:removeFromParent()
	    	end 
    	end)	
	armature:getAnimation():playWithIndex(0)
end

return MapAnimView