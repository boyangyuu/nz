
--[[--

“地图效果”的视图

]]
--events


local MapAnimView = class("MapAnimView", function()
    return display.newNode()
end)

function MapAnimView:ctor()
	self.map = md:getInstance("Map")
	cc.EventProxy.new(self.map, self)
		:addEventListener(self.map.EFFECT_LEI_BOMB_EVENT, handler(self, self.playEffectLeiBomb))	
		:addEventListener(self.map.AWARD_GOLD_EVENT, 	  handler(self, self.playAwardGold))	
		:addEventListener(self.map.EFFECT_DANDAO_EVENT,   handler(self, self.playEffectDandao))	
		:addEventListener(self.map.EFFECT_FOCUS_EVENT, 	  handler(self, self.playEffectFocus))	
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
	local destPos = self:convertToNodeSpace(cc.p(pWorld.x, pWorld.y))
	local armature = ccs.Armature:create("baozhasl_y")
	armature:setPosition(destPos)

	--scale 狙图特殊处理
	local scale = self:getScaleByPos(destPos)
	armature:setScale(scale)	
	self:addChild(armature)
	armature:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.complete then
				armature:removeFromParent()
	    	end 
    	end)	
	armature:getAnimation():playWithIndex(0)

	--sound
    local soundSrc  = "res/Music/fight/hd_bz.wav"
    audio.playSound(soundSrc,false) 	
end

function MapAnimView:playAwardGold(event)
	local pWorld = event.pWorld
	local pos 	 = self:convertToNodeSpace(pWorld)
	local armature = ccs.Armature:create("dlhjak")
	armature:setPosition(pos)

	local scale = self:getScaleByPos(pos)
	armature:setScale(scale)	
	self:addChild(armature)
	armature:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.loopComplete then
				armature:removeFromParent()			
	    	end 
    	end)	
	armature:getAnimation():playWithIndex(0 , -1, 1)	

	--gold
	local fightInlay = md:getInstance("FightInlay")
	fightInlay:activeGold()		
end

function MapAnimView:playEffectDandao(event)
	local pos           = event.enemyPos
	local effectName    = event.effectName
	local srcPos    	= self:convertToNodeSpace(cc.p(pos.x, pos.y))

	local rotate 	    = self.map:getDandaoRotate(srcPos)
	local armature = ccs.Armature:create("difang_dandao")
	armature:setPosition(srcPos)
	armature:setRotation(rotate)
	armature:getAnimation():play(effectName , -1, 1)
	self:addChild(armature)
	armature:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.loopComplete then
				armature:removeFromParent()			
	    	end 
    	end)	
end

function MapAnimView:playEffectFocus(event)
	local pos           = event.enemyPos
	local time 			= event.time
	local srcPos    	= self:convertToNodeSpace(cc.p(pos.x, pos.y))
	local rotate 		= self.map:getDaodaoRotate(srcPos)
	local armature = ccs.Armature:create("difang_dandao")
	armature:setPosition(srcPos)
	armature:setRotation(rotate)

	armature:getAnimation():play("miaozhun" , -1, 1)
	self:addChild(armature)
	local seq = transition.sequence({
			-- cc.RotateBy:create(time, -60),
			cc.DelayTime:create(time),
			cc.CallFunc:create(function ()
				armature:removeFromParent()
			end),
		})
	armature:runAction(seq)
end

return MapAnimView