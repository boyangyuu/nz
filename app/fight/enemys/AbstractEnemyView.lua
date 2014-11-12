import("...includes.functionUtils")
local scheduler = require("framework.scheduler")
local Hero = import("..Hero")
local Actor = import("..Actor")

local AbstractEnemyView = class("AbstractEnemyView", function()
    return display.newNode()
end)

---- event ----
function AbstractEnemyView:ctor(property)
	--instance
    self.hero = app:getInstance(Hero)	
	self.enemy = self:getModel(property.id)
	self:setPlaceBound(property.boundPlace)
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
	assert("required method, must implement me")	
end

function AbstractEnemyView:getTargetData(rectFocus)
	local targetData = {}
	local i = 0

	--weak
	while true do
		i = i + 1
		local rangeStr = "weak"..i
		local rectEnemy = self:getRange(rangeStr)
		if rectEnemy == nil then break end 
		local isInRange = rectIntersectsRect(rectEnemy,
				 rectFocus)
		if isInRange then 
			local isHited = isInRange 
			targetData.demageScale = 4.0 --读表
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
	local bone = self.armature:getBone(rectName)
	if not bone then return end
	return bone:getDisplayRenderNode() --test visible
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

function AbstractEnemyView:canChangeState(stateId)
	local stateMatches = self:getStateMatches()
	local id = self.armature:getAnimation():getCurrentMovementID()
	if id == "" then return true end
	if stateId == id then return false end
	print("canChangeState? from", id, "to", stateId)
	local matchs = stateMatches[stateId] 
	assert(matchs, "stateMatches has no stateId: "..stateId)
	for i,v in ipairs(matchs) do
		-- print(i,v)
		if v == tostring(id) then 
			if matchs.checkFunc then
				return matchs.checkFunc(self) 
			else 
				return true
			end
		end
	end
	return false
end

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
	if self:canChangeState(state) then 
		print("self:canChangeState(state", state)
		handlerFunc()
	end
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

--[[
	local stateMatches = {
		stand = {"hit", "walk", "fire"},
		move = {"stand"},
		fire = {"stand","hit",},
		hit = {"walk", "stand", "fire",
			checkFunc = function(self) 
				return self.enemy:canHitted()  
			end,},
		die = {"stand", "hit", "walk", "fire"},
	}	
	desc: 
	stand: 目的状态
	{"hit", "walk", "fire"}: 对应的animIds(ccs动作列表)
	代表可以从hit walk fire动作 跳转为stand形态
]]
function AbstractEnemyView:getStateMatches()
	assert("required method, must implement me")
end

return AbstractEnemyView