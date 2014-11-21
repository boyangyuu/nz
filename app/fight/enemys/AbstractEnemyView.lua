import("...includes.functionUtils")
local scheduler = require("framework.scheduler")
local Hero = import("..Hero")
local Actor = import("..Actor")


--[[
	attackable
]]
local AbstractEnemyView = class("AbstractEnemyView", function()
    return display.newNode()
end)

---- event ----
function AbstractEnemyView:ctor(property)
	--instance
    self.hero = app:getInstance(Hero)	
	self.enemy = self:getModel(property.id)
	self:setPlaceBound(property.boundPlace)
	self.deadDone = false
	self.isPause = false
	self.playCache = {}

	--init armature
	self.armature = self:getEnemyArmature()
	assert(self.armature)
	self:addChild(self.armature)

    --events
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    cc.EventProxy.new(self.hero, self):addEventListener("stop", handler(self, self.testStop))
    self:scheduleUpdate()  	
end

--[[
	@param rectFocus {cc.rect(20, 20)}
	@return isHited, targetData 
	{true, 		{
			demageType = "head", --"head", "body"
			demageScale = 2.0,
			enemy = xx,
		},}
]]

function AbstractEnemyView:testStop()
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

function AbstractEnemyView:getTargetData(rectFocus)
	local targetData = {}
	local i = 0

	--weak
	while true do
		i = i + 1
		local rangeStr = "weak"..i
		local rectEnemy, isValid = self:getRange(rangeStr)
		if rectEnemy == nil then break end 
		local isInRange = rectIntersectsRect(rectEnemy,
				 rectFocus)
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
		local rectEnemy = self:getRange(rangeStr)
		-- dump(rectEnemy)
		if rectEnemy == nil then break end 
		local isInRange = rectIntersectsRect(rectEnemy,
				 rectFocus)
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
--[[
	@param rectName {"weak1", "body1"..}
	@return rect
]]
function AbstractEnemyView:getRange(rectName)
	assert(rectName, "invalid param")
	local armature = self:getEnemyArmature()
	local bone = armature:getBone(rectName)
	if not bone then return end
	local node = bone:getDisplayRenderNode() 
	return node, true
end

function AbstractEnemyView:setPlaceBound(bound)
	assert(bound, "bound is nil")
	self.placeBound = bound 
end

function AbstractEnemyView:getPlaceBound()
	return self.placeBound 
end

function AbstractEnemyView:getDeadDone()
	return self.deadDone or false 
end

function AbstractEnemyView:setDeadDone()	
	self.deadDone = true
end

-- function AbstractEnemyView:setWillRemove()
-- 	self.willRemove = true
-- end

-- function AbstractEnemyView:get( ... )
-- 	-- body
-- end

function AbstractEnemyView:checkPlace(widthOffset)
	if self.placeBound == nil then 
		print("self.placeBound is nil")
		return false 
	end
	local x1, x2 = self.placeBound.x , self.placeBound.x + self.placeBound.width
	-- print("self.placeBound %d %d",x1, x2) 
	local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
	local bound = self.armature:getCascadeBoundingBox()
	bound.x, bound.y = pWorld.x, bound.y
	-- print("self.armature %d %d",bound.x, bound.y)
	local destx =  bound.x + widthOffset
	return x1 < destx and x2 > destx
end

function AbstractEnemyView:play(state, handlerFunc)
	local index = #self.playCache + 1
	local function play()
		handlerFunc()
		table.remove(self.playCache, index)
	end
	self.playCache[index] = play
end

function AbstractEnemyView:getPlayCache()
	return self.playCache[#self.playCache] or nil
end

function AbstractEnemyView:clearPlayCache()
	self.playCache = {}
end

--接口
function AbstractEnemyView:tick(t)
	assert("required method, must implement me")	
end

function AbstractEnemyView:onHitted(demage)
	assert("required method, must implement me")
end

function AbstractEnemyView:animationEvent()
	assert("required method, must implement me")	
end

function AbstractEnemyView:getEnemyArmature()
	assert("required method, must implement me")	
end

function AbstractEnemyView:getModel(id)
	assert("required method, must implement me")	
end

return AbstractEnemyView