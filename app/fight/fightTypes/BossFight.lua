local Fight   = import(".Fight") 
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local BossFight = class("BossFight", Fight)
function BossFight:ctor(properties)
	dump(properties, "properties")
	BossFight.super.ctor(self, properties)

	--instance
	self.chapterIndex = properties.chapterIndex
end

function BossFight:startFightResult()
	--closeFunc
	local function closeFunc()
		local resultData = self:getResultData()
	    ui:changeLayer("HomeBarLayer",{fightData = resultData})
	end

    --data
   	local map = md:getInstance("Map")
	local waveIndex = map:getWaveIndex()
	local curWaveIndex = waveIndex - 1 
	local bossModeModel = md:getInstance("BossModeModel")
	local isNewProgress = bossModeModel:passWave(self.chapterIndex, curWaveIndex) 
	
	--desc
    local data = {
	    -- name         = fightDescModel.BOSSGIFT_ANIM_EVENT,
    	chapterIndex = self.chapterIndex,
    	waveIndex    = curWaveIndex,
    	isAwardBujian= isNewProgress,
    	closeFunc    = closeFunc,
    	goldValue    = self.goldValue,
	}
    ui:showPopup("BossResultLayer",data,{animName = "normal"})

    --money
    local user = md:getInstance("UserModel") 
    user:addMoney(self.goldValue)
    self.goldValue = 0       
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
	if nextWaveIndex == 1 then return end

	--award
	local curWaveIndex = nextWaveIndex - 1
	local bossModeModel = md:getInstance("BossModeModel")
	local isNewProgress = bossModeModel:passWave(self.chapterIndex, curWaveIndex) 

	--award
	local map = md:getInstance("Map")
	local waveIndex = map:getWaveIndex()
    local eventData = {
    	chapterIndex = self.chapterIndex,
    	waveIndex    = curWaveIndex,
    	closeFunc    = handler(self, self.onClickedAwardBtn),
    	isAwardBujian= isNewProgress,
    	goldValue    = self.goldValue,
	}
    ui:showPopup("BossResultLayer",eventData,{animName = "normal"})
    self:pauseFight(true)

    --money
    local user = md:getInstance("UserModel") 
    user:addMoney(self.goldValue)
    self.goldValue = 0    
end

function BossFight:onClickedAwardBtn(event)
	--next wave
	local function delayCall()
		local map = md:getInstance("Map")
		local waveIndex = map:getWaveIndex()
	    local fightDescModel = md:getInstance("FightDescModel")
	    fightDescModel:waveStart(waveIndex)	
	   
	    --add hp
	    self.hero:costHpBag()

	    --pause
	    self:pauseFight(false)
	end

	scheduler.performWithDelayGlobal(delayCall, 2.0)      
end

function BossFight:endFightFail()
    self:dispatchEvent({name = Fight.FIGHT_FAIL_EVENT})
    self:pauseFight(true)
	ui:showPopup("FightRelivePopup",
		{onReliveFunc = handler(self, self.onReliveConfirm),
		 onGiveUpFunc = handler(self, self.onReliveDeny)},
		{animName = "normal"})
    self:clearFightData()
end

function BossFight:getReliveCost()
    local times = self:getRelivedTimes()
    local costs = define.kBossReliveCosts
    local maxCost = costs[#costs]
    return costs[times + 1] or maxCost
end

function BossFight:onReliveConfirm()
	self:doRelive()
end

function BossFight:onReliveDeny()
	self:doGiveUp()
    local fightData = self:getResultData()
    ui:changeLayer("HomeBarLayer",{fightData = fightData})	
end

return BossFight