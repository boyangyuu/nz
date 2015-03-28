
local scheduler = require("framework.scheduler")

--[[
	Attackable
]]
local Attackable = class("Attackable", function()
    return display.newNode()
end)

---- event ----
function Attackable:ctor(property)
	--instance
    self.hero = md:getInstance("Hero")	
    self.fight = md:getInstance("Fight")
	self.enemy = self:getModel(property)
	self.property = property
	self.schedulers = {}
	self.playCache = {}
	self.isDead = false
	self.isRed = false
	self.isPauseOtherAnim = false
	self.isWillDie = false
	self.isWillRemove = false

	--init armature
	self.armature = self:getEnemyArmature()
	assert(self.armature)
	self:addChild(self.armature)
	self.armature:setScale(define.kEnemyAnimScale)
    self:setScale(property.scale or 1.0)
    
    --events
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    cc.EventProxy.new(self.fight, self)
    	:addEventListener(self.fight.PAUSE_SWITCH_EVENT, handler(self, self.setPause))
    	
    self:scheduleUpdate()  
    self:schedule(handler(self, self.checkAnim), 0.1)
    self:setNodeEventEnabled(true)	

    self:test()
end

function Attackable:setPause(event)
	if self:getDeadDone() then return end
	local isPause = event.isPause
	local actionManager = cc.Director:getInstance():getActionManager()
	local tAnimation = self.armature:getAnimation()
	if tAnimation == nil then return end
	if isPause then
		self:pause()
		tAnimation:pause()
		actionManager:pauseTarget(self)
		actionManager:pauseTarget(self.armature)
	else
		self:resume()
		tAnimation:resume()
		actionManager:resumeTarget(self)
		actionManager:resumeTarget(self.armature)
	end
end

--[[
	@param focusNode {cc.rect(20, 20)}
	@return isHited, targetData 
	{true, 		{
			demageType = "head", --"head", "body"
			demageScale = 2.0,
			enemy = xx,
		},}
]]

function Attackable:getTargetData(focusNode)

	local isHitedWeak, targetDataWeak = self:checkWeak(focusNode)
	local isHitedBody, targetDataBody = self:checkBody(focusNode)
	
	if true then
		if isHitedWeak then
			-- print("isHitedWeak")
			return true, targetDataWeak 
		elseif isHitedBody then 
			return true, targetDataBody
		end
	else
		if isHitedBody then
			-- print("isHitedBody")
			return true, targetDataBody
		elseif isHitedWeak then 
			return true, targetDataWeak
		end
	end		
	return false, nil
end

function Attackable:checkBody(focusNode)
	--body
	local targetData = {}
	targetData.demage = self.hero:getDemage()		
	local i = 0
	while true do
	
		i = i + 1
		local rangeStr = "body"..i
		-- print("rangeStr", rangeStr)
		local enemyRange = self:getRange(rangeStr)
		if enemyRange == nil then break end 	
		local isInRange = self:rectIntersectsRectInWorld(focusNode,
				 enemyRange)
		-- print(isInRange, "isInRange")
		if isInRange then 
			local isHited = isInRange 
			targetData.demageScale = 1.0
			targetData.demageType = "body"
			targetData.enemy = self
			return isHited,  targetData
		end
	end		
	return false, nil
end

function Attackable:checkWeak(focusNode)
	--weak
	local i = 0
	local targetData = {}
	targetData.demage = self.hero:getDemage()	
	while true do
		
		i = i + 1
		local rangeStr = "weak"..i
		local enemyRange, isValid = self:getRange(rangeStr)
		if enemyRange == nil then break end 
	
		local isInRange = self:rectIntersectsRectInWorld(focusNode,
				 enemyRange)
		if isInRange and isValid then 
			local isHited = isInRange 
			targetData.demageScale = self.enemy:getWeakScale(rangeStr)
			-- print("targetData.demageScale", targetData.demageScale)
			targetData.demageType = "head"
			targetData.enemy = self
			return isHited,  targetData
		end
	end	
	return false, nil
end

function Attackable:rectIntersectsRectInWorld(node, enemyRange)
	local bound = node:getBoundingBox()
	local enemyBound = enemyRange:getBoundingBox()
	
	-- dump(enemyBound, "enemyBound")
	local scale = self:getScale() * self.hero:getMapZoom() * (define.kEnemyAnimScale)
	enemyBound.width = enemyBound.width * scale
	enemyBound.height = enemyBound.height * scale
    -- dump(enemyBound, "enemyBound2")
    local pWorld1 = node:convertToWorldSpace(cc.p(0,0))
    bound.x = pWorld1.x
    bound.y = pWorld1.y
    local pWorld2 = enemyRange:convertToWorldSpace(cc.p(0,0))
    enemyBound.x = pWorld2.x
    enemyBound.y = pWorld2.y    
    
    return cc.rectIntersectsRect(bound, enemyBound)
end

--[[
	@param rectName {"weak1", "body1"..}
	@return rect, isValid[是否当前有效]
]]
function Attackable:getRange(rectName)
	assert(rectName, "invalid param")
	local armature = self:getEnemyArmature()
	local bone = armature:getBone(rectName)
	if not bone then return nil, false end
	local node = bone:getDisplayRenderNode() 
	return node, true
end

function Attackable:getPlaceBound()
	local placeNode = self:getPlaceNode()
	local boundPlace 	= placeNode:getBoundingBox()
	local pWorld 		= placeNode:convertToWorldSpace(cc.p(0,0))
	boundPlace.x 		= pWorld.x
	return boundPlace
end

function Attackable:getPlaceNode()
	return self.property["placeNode"]
end

function Attackable:getProperty()
	return self.property
end

function Attackable:getDeadDone()
	return self.isDead
end

function Attackable:setDeadDone()
	if self.removeAllSchedulers then	
		self:removeAllSchedulers()	
	end
	self:setPauseOtherAnim(true)
	self.isDead = true
end

function Attackable:getWillRemoved()
	return self.isWillRemove
end

function Attackable:setWillRemoved(time)
	if self.removeAllSchedulers then	
		self:removeAllSchedulers()	
	end
	self:setPauseOtherAnim(true)
	local function callFunc()
		self.isWillRemove = true
	end 
	if time then 
		self:performWithDelay(callFunc, time)
	else
		callFunc()
	end
end

function Attackable:checkPlace(offset)
	local offset = offset or 0
	--place的范围
	local placeNode = self:getPlaceNode()
	local pWorld1	  = placeNode:convertToWorldSpace(cc.p(0,0))
	local bound1 	  = placeNode:getBoundingBox()
	
	local xLeftLimit  = pWorld1.x  
	local xRightLimit = pWorld1.x + bound1.width

	--我的范围
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
	local pWorld2 = self.armature:convertToWorldSpace(cc.p(0,0))
	-- dump(pWorld2, "pWorld2")
	local scale = self:getScale()
	-- print("scale", scale)
	local bound2  = bodyNode:getBoundingBox()
	-- print("offset", offset)
	local xLeft   = pWorld2.x - bound2.width/2 * scale + offset
	local xRight  = pWorld2.x + bound2.width/2 * scale + offset

	-- print("xLeft", xLeft)
	-- print("xRight", xRight)	
	return xLeftLimit < xLeft and xRight < xRightLimit 
end


function Attackable:play(state, handlerFunc)
	local per = self.enemy:getHp() / self.enemy:getMaxHp()
	-- print("进栈 state: "..state..", 当前血量:"..per)
	
	local function play()
		handlerFunc()
		-- dump(self.playCache, "self.playCache")
		local state = self.playCache[1].state
		table.remove(self.playCache, 1)
		-- print("出栈 state:"..state)
	end
	self:insertCache(play, state)
end

function Attackable:insertCache(play, state)
	if self.isWillDie then return end
	local index = #self.playCache + 1
	if state == "skillPre" then  --高于技能
		table.insert(self.playCache, 1, {func = play, state = state})
	elseif state == "skill" or index == 1 then --技能 or 第一个cache
		self.playCache[index] = {func = play, state = state}
	end
end

function Attackable:getPlayCache()
	if self.playCache[1] == nil then 
		return nil 
	end
	return self.playCache[1].func
end

function Attackable:doNextPlay()
	if self:getPauseOtherAnim() then return end
	local playCache = self:getPlayCache()		
	if playCache then 
		playCache()
	else 					
		self:playStand()
	end
end

function Attackable:clearPlayCache()
	self.playCache = {}
end

function Attackable:getScale()
	return self:getScaleX()
end

function Attackable:removeAllSchedulers()
	for i,v in ipairs(self.schedulers) do
		scheduler.unscheduleGlobal(v)
		v = nil
	end
end

function Attackable:addScheduler(scheduler)
	self.schedulers[#self.schedulers + 1] = scheduler
end

--飘红 飘血
function Attackable:playHittedEffect()
	--red
	if self.isRed then return end
	local function callfunc()
		if self.isRed then 
			-- print("回复")
			self:restoreRedEffect()
		end
	end

	local function callfuncRestore()
		-- print("callfuncRestore")
		self.isRed = false
	end

	-- print("变红")
	self.isRed = true
	self.armature:setColor(cc.c3b(255,50,5))
	self:performWithDelay(callfunc, 20/60)
	self:performWithDelay(callfuncRestore, 60/60)
end

function Attackable:restoreRedEffect()
	self.armature:setColor(cc.c3b(255,255,255))
end

function Attackable:playBombEffect()
	local bone = self.armature:getBone("bomb")
	if bone == nil then return end
	local node = bone:getDisplayRenderNode()
	if node == nil then return end
	local box = node:getBoundingBox()
	box.width  = box.width / define.kEnemyAnimScale
	box.height = box.height / define.kEnemyAnimScale
	local bomb = ccs.Armature:create("baozha4")
	bomb:setAnchorPoint(0.5,0.5)
	-- dump(box, "box")
	local bombBox = bomb:getBoundingBox()
	-- dump(bombBox, "bombBox")
	bomb:setPosition(
		math.random(-box.width/2, box.width/2 ), 
		math.random(0, box.height))

	self.armature:addChild(bomb, 100)
	bomb:getAnimation():play("baozha4", -1, 0) 

	--play
    local src = "res/Music/fight/bossbz.wav"
    audio.playSound(src, false)
end

function Attackable:restoreStand()
	print("function Attackable:restoreStand()")
	self.playAnimId = nil 
	self.armature:stopAllActions()	
	self.armature:getAnimation():stop()
	self:setPauseOtherAnim(false)

end

function Attackable:setPauseOtherAnim(isPause)
	self.isPauseOtherAnim = isPause
end

function Attackable:getPauseOtherAnim()
	return self.isPauseOtherAnim
end

function Attackable:checkAnim()
	if self.enemy:isDead() then return end
	if self:getPauseOtherAnim() then return end
	local currentName = self.armature:getAnimation():getCurrentMovementID()
	if currentName == "" or currentName == nil then 
		self:playStand()
	end
end

function Attackable:test()
    local weakNode2 = self.armature:getBone("weak2")
    if weakNode2 then drawBoundingBox(self.armature, weakNode2:getDisplayRenderNode(), "red")  end
    local weakNode1 = self.armature:getBone("weak1")
    if weakNode1 then drawBoundingBox(self.armature, weakNode1:getDisplayRenderNode(), "red")  end
    local bodyNode = self.armature:getBone("body1")
    assert(bodyNode, "bodyNode is nil , 美术没加帧")
    if bodyNode then drawBoundingBox(self.armature, bodyNode:getDisplayRenderNode(), "yellow")  end
end

function Attackable:getEnemyArmature()
    if self.armature then return self.armature end 
    --armature
    local config = self.enemy:getConfig()
    assert(config, "config is nil")
    local imgName = config["image"]

    --isBoss
    local armature
    local manager = ccs.ArmatureDataManager:getInstance()
    local src = "res/Fight/enemys/"..imgName.."/"..imgName..".ExportJson"
    local plist = "res/Fight/enemys/"..imgName.."/"..imgName.."0.plist"
    local png   = "res/Fight/enemys/"..imgName.."/"..imgName.."0.png" 
    manager:addArmatureFileInfo(src)
    display.addSpriteFrames(plist, png)    

    armature = ccs.Armature:create(imgName)
    armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
    return armature		
end

function Attackable:getPosInMap()
	local world = self:convertToWorldSpace(cc.p(0,0))
	local map   = self:getParent()
	local box 	= map:getBoundingBox()
	local worldMap = map:convertToNodeSpace(cc.p(world.x, world.y))	
	return worldMap
end

function Attackable:getPosInMapBg()
	local world = self:convertToWorldSpace(cc.p(0,0))
	local map   = md:getInstance("Map")
	local mapbg = map:getMapBgNode()
	local worldMap = mapbg:convertToNodeSpace(cc.p(world.x, world.y))	
	return worldMap
end

function Attackable:getNickname()
	return self.property["type"] .. "_" ..
		(self.property["order"] or 0)
end

function Attackable:getEnemyType()
	return self.property.type
end

function Attackable:getEnemyModel()
	return self.enemy
end

--接口
function Attackable:tick(t)
	assert("required method, must implement me")	
end

function Attackable:onHitted(targetData)
	assert("required method, must implement me")
end

function Attackable:animationEvent()
	assert("required method, must implement me")	
end

function Attackable:getModel(id)
	assert("required method, must implement me")	
end

function Attackable:playStand()
	assert("required method, must implement me")
end

function Attackable:playKill(event)
	self.isWillDie = true
	self:clearPlayCache()
	self:removeAllSchedulers()
	self.armature:stopAllActions()
	self:stopAllActions()
	self:setPauseOtherAnim(true)
	self:setWillRemoved(4.0)
	self:restoreRedEffect()
end

function Attackable:onEnter()
	local fight = md:getInstance("Fight")
	local isPause = fight:isPauseFight()
	if isPause then 
		self:setPause({isPause = true}) 
	end
end

function Attackable:onCleanup()
	if self.property["deadEventData"] then 
		self.hero:dispatchEvent(self.property["deadEventData"])
	end
	self:removeAllSchedulers()  
end

return Attackable