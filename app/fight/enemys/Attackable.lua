import("...includes.functionUtils")
local scheduler = require("framework.scheduler")
local Hero = import("..Hero")
local Actor = import("..Actor")


--[[
	Attackable
]]
local Attackable = class("Attackable", function()
    return display.newNode()
end)

---- event ----
function Attackable:ctor(property)
	-- dump(property, "Attackable property")
	--instance
    self.hero = app:getInstance(Hero)	
	self.enemy = self:getModel(property)
	self:setPlaceBound(property.boundPlace)
	self.deadDone = false
	self.schedulers = {}
	self.isPause = false
	self.playCache = {}

	--init armature
	self.armature = self:getEnemyArmature()
	assert(self.armature)
	self:addChild(self.armature)

    --events
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    cc.EventProxy.new(self.hero, self)
    	:addEventListener("stop", handler(self, self.testStop))
    	
    self:scheduleUpdate()  	
end

function Attackable:testStop()
	self.isPause = not self.isPause
	local actionManager = cc.Director:getInstance():getActionManager()
	local tAnimation = self.armature:getAnimation()
	if self.isPause then
		self:pause()
		tAnimation:pause()
		actionManager:pauseTarget(self)
	else
		self:resume()
		tAnimation:resume()
		actionManager:resumeTarget(self)
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
	local targetData = {}
	targetData.demage = self.hero:getDemage()
	local i = 0

	--weak
	while true do
		i = i + 1
		local rangeStr = "weak"..i
		local enemyRange, isValid = self:getRange(rangeStr)
		if enemyRange == nil then break end 
	
		local isInRange = self:rectIntersectsRectInWorld(focusNode,
				 enemyRange)
		if isInRange and isValid then 
			local isHited = isInRange 
			targetData.demageScale = self.enemy:getDemageScale(rangeStr)
			-- print("targetData.demageScale", targetData.demageScale)
			targetData.demageType = "head"
			targetData.enemy = self
			return isHited,  targetData
		end
	end

	--body
	i = 0
	while true do
		i = i + 1
		local rangeStr = "body"..i
		-- print("rangeStr", rangeStr)
		local enemyRange = self:getRange(rangeStr)
		-- dump(enemyRange)
		if enemyRange == nil then break end 	
		local isInRange = self:rectIntersectsRectInWorld(focusNode,
				 enemyRange)
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

function Attackable:rectIntersectsRectInWorld(node, enemyRange)
	local bound = node:getBoundingBox()
	local enemyBound = enemyRange:getBoundingBox()	
	enemyBound.width = enemyBound.width * self:getScale()	
	enemyBound.height = enemyBound.height * self:getScale()		
    
    local pWorld1 = node:convertToWorldSpace(cc.p(0,0))
    bound.x = pWorld1.x
    bound.y = pWorld1.y
    local pWorld2 = enemyRange:convertToWorldSpace(cc.p(0,0))
    enemyBound.x = pWorld2.x
    enemyBound.y = pWorld2.y    
    
    -- dump(bound, "bound ------")
    -- dump(enemyBound, "enemyBound -------")    
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

function Attackable:getBodyBox()
	local armature = self:getEnemyArmature()
	local box = armature:getBone("body1"):getDisplayRenderNode():getBoundingBox()
	if not box then return end
	return box
end

function Attackable:setPlaceBound(bound)
	assert(bound, "bound is nil")
	self.placeBound = bound 
end

function Attackable:getPlaceBound()
	return self.placeBound 
end

function Attackable:getDeadDone()
	return self.deadDone or false 
end

function Attackable:setDeadDone()	
	self.deadDone = true
end

-- function Attackable:setWillRemove()
-- 	self.willRemove = true
-- end

-- function Attackable:get( ... )
-- 	-- body
-- end

function Attackable:checkPlace(offset)
	local offset = offset or 0
	--place的范围
	local placeNode = self:getParent()
	local pWorld1	  = placeNode:convertToWorldSpace(cc.p(0,0))
	local bound1 	  = placeNode:getBoundingBox()
	
	local xLeftLimit  = pWorld1.x  
	local xRightLimit = pWorld1.x + bound1.width
	-- dump(pWorld1, "pWorld1")
	-- print("xLeftLimit", xLeftLimit)
	-- print("xRightLimit", xRightLimit)

	--我的范围
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
	local pWorld2 = self.armature:convertToWorldSpace(cc.p(0,0))
	-- dump(pWorld2, "pWorld2")
	local scale = self:getScale()
	local bound2  = bodyNode:getBoundingBox()
	local xLeft   = pWorld2.x - bound2.width/2 * scale + offset
	local xRight  = pWorld2.x + bound2.width/2 * scale + offset
	-- print("xLeft", xLeft)
	-- print("xRight", xRight)	
	return xLeftLimit < xLeft and xRight < xRightLimit 
end

function Attackable:play(state, handlerFunc)
	local per = self.enemy:getHp() / self.enemy:getMaxHp()
	-- print("进栈 state: "..state..", 当前血量:"..per)
	
	local index = #self.playCache + 1
	local function play()
		handlerFunc()
		-- dump(self.playCache, "self.playCache")
		local state = self.playCache[1].state
		table.remove(self.playCache, 1)
		-- print("出栈 state:"..state)
	end
	self.playCache[index] = {func = play, state = state}
	
end

function Attackable:getPlayCache()
	if self.playCache[1] == nil then 
		return nil 
	end
	return self.playCache[1].func
end

function Attackable:clearPlayCache()
	self.playCache = {}
end

function Attackable:getScale()
	return self:getScaleX()
end

--接口
function Attackable:tick(t)
	assert("required method, must implement me")	
end

function Attackable:onHitted(demage)
	assert("required method, must implement me")
end

function Attackable:animationEvent()
	assert("required method, must implement me")	
end

function Attackable:getEnemyArmature()
	assert("required method, must implement me")	
end

function Attackable:getModel(id)
	assert("required method, must implement me")	
end

return Attackable