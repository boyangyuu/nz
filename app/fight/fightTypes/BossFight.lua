local Fight   = import(".Fight") 

local BossFight = class("BossFight", Fight)
function BossFight:ctor(properties)
	dump(properties, "properties")
	BossFight.super.ctor(self, properties)
end

function BossFight:startFightResult()
	local resultData = self:getResultData()
	-- dump(resultData)
    ui:changeLayer("HomeBarLayer",{fightData = resultData})
end

function BossFight:getResultData()
	local levelMapModel = md:getInstance("LevelMapModel")
    local groupId, levelId = levelMapModel:getConfig()
	local resultData = {}
	resultData["fightType"] = self:getFightType()
	resultData["chapterIndex"] = 1 
	resultData["groupId"]   = groupId
	resultData["levelId"]   = self:getLevelId()
	resultData["result"]    = self:getResult() 
	return resultData   
end

function BossFight:isJujiFight()
    return false 
end

function BossFight:getFightType()
	return "bossFight"
end

return BossFight