
--[[--

“地图效果”的视图

]]
--events


local MapAnimView = class("MapAnimView", function()
    return display.newNode()
end)

function MapAnimView:ctor()
	self.map 	   = md:getInstance("Map")
	local fightGun = md:getInstance("FightGun") 

	--events
	cc.EventProxy.new(self.map, self)
		:addEventListener(self.map.EFFECT_LEI_BOMB_EVENT, handler(self, self.playEffectLeiBomb))	
		:addEventListener(self.map.AWARD_PROP_EVENT, 	  handler(self, self.playAwardProp))	
		:addEventListener(self.map.EFFECT_DANDAO_EVENT,   handler(self, self.playEffectDandao))	
		:addEventListener(self.map.EFFECT_FOCUS_EVENT, 	  handler(self, self.playEffectFocus))	

	cc.EventProxy.new(fightGun, self)
		:addEventListener(fightGun.GUN_SKILL_EVENT, handler(self, self.playEffectGunSkill))	

end

function MapAnimView:getScaleByPos(pos)
	local offsetScale = (math.abs(pos.y - display.height/2)) / (display.height/2)
	local scale = 0.8 + 1.2 * offsetScale
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
	isGold = false
	-- print("isGold", isGold)
	local isRobot = md:getInstance("Robot"):getIsRoboting()
	local hero    = md:getInstance("Hero")
	local gunCfg  = hero:getGun():getConfig()
	local isRpg   = gunCfg["type"] == "rpg"
	local isPz    = gunCfg["type"] == "pz"

	--animName
	if isGold or isRobot or isRpg then 
		animName = "zd_hjqmz"
	elseif isHitted then
		animName = gunCfg["mzName"]
	else
		animName = "zd_dimian"
	end

	
	-- animName = "zd_dimian" -- todo

	--pos
	local pos = self:convertToNodeSpace(cc.p(pWorld.x, pWorld.y))
	assert(animName, "animName is nil type"..animName)

	if self.isShootAniming and animName == "diren" then return end
	self.isShootAniming = true

	--one or many
	if isPz then 
		for i=1,3 do
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
	local armature = ccs.Armature:create(animName)
	self:addChild(armature)
	armature:setPosition(pos)
	
	--scale 狙图特殊处理
	local scale = self:getScaleByPos(pos)
	armature:setScale(scale)
	armature:getAnimation():setMovementEventCallFunc(
        	function ( armatureBack,movementType,movementId ) 
    	    	if movementType == ccs.MovementEventType.complete then
    	    		armatureBack:removeFromParent()
    	    		armatureBack = nil
    	    		self.isShootAniming = false
    	    	end
	    	end)
	armature:getAnimation():playWithIndex(0 , -1, 0)
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

function MapAnimView:playAwardProp(event)
	local pWorld    = event.pWorld
	local animName 	= event.awardType

	--armature
	local pos 	 = self:convertToNodeSpace(pWorld)
	local armature = ccs.Armature:create("diaoluojiangli")
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
	armature:getAnimation():play(animName , -1, 1)
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
	local rotate 		= self.map:getDandaoRotate(srcPos)
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

function MapAnimView:playEffectGunSkill(event)
	--add res
	local animName = event.animName
	local manager = ccs.ArmatureDataManager:getInstance()
    local src = "res/Fight/skillAnim/"..animName.."/"..animName..".ExportJson"
    local plist = "res/Fight/skillAnim/"..animName.."/"..animName.."0.plist"
    local png   = "res/Fight/skillAnim/"..animName.."/"..animName.."0.png"	
    manager:addArmatureFileInfo(src)
    display.addSpriteFrames(plist, png) 

    --armature
	local armature = ccs.Armature:create(animName)
	assert(armature, "armature is nil " .. animName)
	armature:getAnimation():play("skill1" , -1, 1)
	armature:setPosition(display.pCenter)
	self:addChild(armature)
	armature:getAnimation():setMovementEventCallFunc(
    	function (armatureBack,movementType,movementId) 
	    	if movementType == ccs.MovementEventType.loopComplete then
				armatureBack:removeFromParent()		
	    	end 
    	end)	
end

return MapAnimView