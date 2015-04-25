local Fight   = import(".Fight") 

local BossFight = class("BossFight", Fight)
function BossFight:ctor(properties)
	dump(properties, "properties")
	BossFight.super.ctor(self, properties)
end

function BossFight:startFightResult()
	local resultData = self:getResultData()
    ui:changeLayer("HomeBarLayer",{fighResultData = resultData})
end

function Fight:getResultData()
	local resultData = BossFight.super.getResultData(self)
	resultData["fightType"] = "bossFight"
	resultData["bossFightId"] = 1 
	return resultData   
end

return BossFight