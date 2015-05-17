local JujiModeConfigs = import(".JujiModeConfigs")
local JujiModeModel = class("JujiModeModel", cc.mvc.ModelBase)

function JujiModeModel:ctor(properties)
	JujiModeModel.super.ctor(self, properties)
end

function JujiModeModel:initRankData()
	
end

function JujiModeModel:getRankData()
    local rank = md:getInstance("RankModel")
    local data = rank:getRankData("jujiLevel")
    -- dump(data, "data")
    return data	
end

function JujiModeModel:setCurWaveIndex(waveIndex)
	local data = getUserData()
	local curIndex = data.jujiMode.waveIndex 
	if curIndex >= waveIndex then assert(false) end

	--save
	data.jujiMode.waveIndex = waveIndex	
	setUserData(data)
end

function JujiModeModel:getCurWaveIndex()
	local data = getUserData()
	local curIndex = data.jujiMode.waveIndex 
	return curIndex
end

function JujiModeModel:getCurScore()
	local score = self:getCurWaveIndex() * 100
	return score
end

function JujiModeModel:isScoreAwardAvailable(awardIndex)
	local curScore = self:getCurScore()
	local scoreAwardCfg = JujiModeConfigs.getScoreAward(awardIndex)
	assert(scoreAwardCfg, "awardIndex"..awardIndex)
	local scoreLimit = scoreAwardCfg["score"]
	return curScore >= scoreLimit
end

function JujiModeModel:isScoreAwardGetted(awardIndex)
	local data = getUserData()
	local isGetted = data.jujiMode.scoreAwarded[awardIndex] 	
	return isGetted
end

function JujiModeModel:getAward(awardIndex)
	local isAvaliable = self:isScoreAwardAvailable(awardIndex)
	local isGetted    = self:isScoreAwardGetted(awardIndex) == true
	assert(isGetted == false and isAvaliable, "invalid awardIndex："..awardIndex)

    --award
    print("发奖励")
    local cfg = JujiModeConfigs.getScoreAward(awardIndex)
    local moneyNum   = cfg["money"] or 0
    local diamondNum = cfg["diamond"] or 0
    local user       = md:getInstance("UserModel")
    user:addDiamond(diamondNum)
    user:addMoney(moneyNum)

	--save
	local data = getUserData()
	data.jujiMode.scoreAwarded[awardIndex]= true
    setUserData(data)
end

return JujiModeModel