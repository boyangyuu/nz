
local Fight   = import(".Fight") 

local JujiFight = class("JujiFight", Fight)
function JujiFight:ctor(properties)
	-- dump(properties, "properties")
	JujiFight.super.ctor(self, properties)

	--instance
	self.passLevelNum = 0
end

function JujiFight:startFightResult()
	print("function JujiFight:startFightResult()")
	local resultData = self:getResultData()
	ui:changeLayer("FightPlayer", {fightData = resultData})	   

	--save
	self:passLevel() 

	--closeFunc
	local function closeFunc()
		local resultData = self:getResultData()
	    ui:changeLayer("HomeBarLayer",{fightData = resultData})
	end
	
	--desc
    local fightDescModel = md:getInstance("FightDescModel")
    local data = {
	    name         = fightDescModel.BOSSGIFT_ANIM_EVENT,
    	chapterIndex = self.chapterIndex,
    	waveIndex    = curWaveIndex,
    	closeFunc    = closeFunc,
	}
    fightDescModel:dispatchEvent(data)	
end

function JujiFight:getResultData()
	local resultData = {}
	resultData["fightType"] = self:getFightType() 
	resultData["groupId"]   = self:getGroupId()
	resultData["levelId"]   = self:getLevelId() + 1 
	resultData["isContinue"]= true 
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

return JujiFight