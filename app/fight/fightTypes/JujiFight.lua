
local Fight   = import(".Fight") 

local JujiFight = class("JujiFight", Fight)
JujiFight.JUJIFIGHT_SCORE_EVENT = "JUJIFIGHT_SCORE_EVENT"

function JujiFight:ctor(properties)
	JujiFight.super.ctor(self, properties)

	--instance
	self.passLevelNum = 0
end

function JujiFight:startFightResult()
	--save
	self:passLevel() 

	--closeFunc
	local function closeFunc()
		local resultData = self:getResultData()
	    ui:changeLayer("FightPlayer",{fightData = resultData})
	end
	
    --save goldValue
    local user = md:getInstance("UserModel") 
    print("self.goldValue", self.goldValue)
    user:addMoney(self.goldValue)

	--desc
    -- local fightDescModel = md:getInstance("FightDescModel")
    local data = {
	    -- name         = fightDescModel.JUJIGIFT_ANIM_EVENT,
    	levelIndex   = self:getLevelId() + 1,
    	waveIndex    = self.passLevelNum,
    	closeFunc    = closeFunc,
    	goldValue    = self.goldValue,
	}
    -- fightDescModel:dispatchEvent(data)	
    ui:showPopup("JujiResultLayer",data,{animName = "normal"})


end

function JujiFight:getResultData()
	local resultData = {}
	resultData["fightType"] = self:getFightType() 
	resultData["groupId"]   = self:getGroupId()
	resultData["levelId"]   = self:getLevelId() + 1 
	resultData["isContinue"]= true 
	resultData["result"]    = self:getResult()
	return resultData   
end

function JujiFight:getFightType()
	return "jujiFight"
end

function JujiFight:isJujiFight()
    return true
end

function JujiFight:waveUpdate(nextWaveIndex, waveType)
	--save
	if nextWaveIndex ~= 1 then
		self:passLevel()
	end

	--desc
    local fightDescModel = md:getInstance("FightDescModel")
    fightDescModel:waveStart(self.passLevelNum + 1)
end

function JujiFight:passLevel()
	self.passLevelNum = self.passLevelNum + 1

	--save data
	local jujiModeModel = md:getInstance("JujiModeModel")
	local curWaveIndex =  jujiModeModel:getCurWaveIndex()
	if curWaveIndex < self.passLevelNum then 
		jujiModeModel:setCurWaveIndex(self.passLevelNum)
	end	

	--test
	print("self.passLevelNum:", self.passLevelNum )
	local curWaveIndex =  jujiModeModel:getCurWaveIndex()
	print("curWaveIndex:", curWaveIndex)
end

function JujiFight:endFightFail()
    self:dispatchEvent({name = Fight.FIGHT_FAIL_EVENT})
    self:pauseFight(true)
	ui:showPopup("FightRelivePopup",
		{onReliveFunc = handler(self, self.onReliveConfirm),
		 onGiveUpFunc = handler(self, self.onReliveDeny)},
		{animName = "normal"})
    self:clearFightData()
end

function JujiFight:getReliveCost()
    local times = self:getRelivedTimes()
    local costs = define.kJujiReliveCosts
    local maxCost = costs[#costs]
    return costs[times + 1] or maxCost
end

function JujiFight:onReliveConfirm()
	self:doRelive()
end

function JujiFight:onReliveDeny()
	self:doGiveUp()
    local fightData = self:getResultData()
    ui:changeLayer("HomeBarLayer",{fightData = fightData})	
end

return JujiFight