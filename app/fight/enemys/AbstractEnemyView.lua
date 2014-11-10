import("...includes.functionUtils")
local scheduler = require("framework.scheduler")
local Enemy = import(".Enemy")
local Hero = import("..Hero")
local Actor = import("..Actor")

local AbstractEnemyView = class("AbstractEnemyView", function()
    return display.newNode()
end)

---- event ----
function AbstractEnemyView:ctor()

end


--受到攻击
function AbstractEnemyView:onHitted(demage)
	assert("required method, must implement me")
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


--[[
	@param rectName {"weak1", "body1"..}
	@return rect
]]
function AbstractEnemyView:getRange(rectName)
	assert("required method, must implement me")	
end

function AbstractEnemyView:setPlaceBound(bound)
	assert("required method, must implement me")	
end

function AbstractEnemyView:getPlaceBound()
	assert("required method, must implement me")	
end

function AbstractEnemyView:getDeadDone()
	assert("required method, must implement me")	
end

function AbstractEnemyView:setDeadDone()	
	assert("required method, must implement me")	
end

return AbstractEnemyView