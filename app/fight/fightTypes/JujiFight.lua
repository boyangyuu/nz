
local Fight   = import(".Fight") 

local JujiFight = class("JujiFight", Fight)
function JujiFight:ctor(properties)
	-- dump(properties, "properties")
	JujiFight.super.ctor(self, properties)
end

function JujiFight:startFightResult()
	print("function JujiFight:startFightResult()")
	local resultData = self:getResultData()
	ui:changeLayer("FightPlayer", {fightData = resultData})	    
end

function JujiFight:getResultData()
	-- local levelMapModel = md:getInstance("LevelMapModel")
    -- local groupId, levelId = levelMapModel:getConfig()
	local resultData = {}
	resultData["fightType"] = self:getFightType()
	-- resultData["chapterIndex"] = 1 
	resultData["groupId"]   = self:getGroupId()
	resultData["levelId"]   = self:getLevelId() + 1 
	return resultData   
end

function JujiFight:getFightType()
	return "jujiFight"
end

function JujiFight:isJujiFight()
    return true
end

return JujiFight