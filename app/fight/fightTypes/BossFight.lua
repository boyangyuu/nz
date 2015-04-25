local Fight   = import(".Fight") 

local BossFight = class("BossFight", Fight)
function BossFight:ctor(properties)
	dump(properties, "properties")
	BossFight.super.ctor(self, properties)
end

function BossFight:startFightResult()
	local resultData = self:getResultData()
    ui:changeLayer("HomeBarLayer",{fightData = resultData})
end

function BossFight:getResultData()
	local resultData = {}
	resultData["fightType"] = self:getFightType()
	resultData["chapterId"] = 1 
	resultData["groupId"]   = self:getGroupId()
	resultData["levelId"]   = self:getLevelId()
	return resultData   
end

function BossFight:getFightType()
	return "bossFight"
end

return BossFight