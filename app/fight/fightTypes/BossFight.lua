local Fight   = import(".Fight") 

local BossFight = class("BossFight", Fight)
function BossFight:ctor(properties)
	dump(properties, "properties")
	BossFight.super.ctor(self, properties)

	--instance
	self.chapterIndex = properties.chapterIndex
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

function BossFight:waveUpdate(nextWaveIndex, waveType)
	--award
	local curWaveIndex = nextWaveIndex - 1
	local bossModeModel = md:getInstance("BossModeModel")
	bossModeModel:setBossModeWave(self.chapterIndex, curWaveIndex)

	--desc
    local fightDescModel = md:getInstance("FightDescModel")
    if nextWaveIndex == 1 then return end
    fightDescModel:bossGift(self.chapterIndex, curWaveIndex)
end


return BossFight