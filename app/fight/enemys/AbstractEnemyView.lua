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
	self.playCache = {}

	--init armature
	self.armature = self:getEnemyArmature()
	assert(self.armature)
	self:addChild(self.armature)

    --events
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
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

function AbstractEnemyView:checkPlace(offset)
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

function AbstractEnemyView:play(state, handlerFunc)
	local per = self.enemy:getHp() / self.enemy:getMaxHp()
	print("进栈 state: "..state..", 当前血量:"..per)
	
	local index = #self.playCache + 1
	local function play()
		handlerFunc()
		dump(self.playCache, "self.playCache")
		local state = self.playCache[1].state
		table.remove(self.playCache, 1)
		print("出栈 state:"..state)
	end
	self.playCache[index] = {func = play, state = state}
	
end

function AbstractEnemyView:getPlayCache()
	if self.playCache[1] == nil then 
		return nil 
	end
	return self.playCache[1].func
end

function AbstractEnemyView:clearPlayCache()
	self.playCache = {}
end

function AbstractEnemyView:getScale()
	return self:getScaleX()
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