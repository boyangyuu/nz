
local JujiModeModel = class("JujiModeModel", cc.mvc.ModelBase)

function JujiModeModel:ctor(properties)
	
end

function JujiModeModel:initRankData()
	
end

function JujiModeModel:getRankData()
    local rank = md:getInstance("RankModel")
    local data = rank:getRankData("jujiMode")
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

return JujiModeModel