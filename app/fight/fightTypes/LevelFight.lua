local Fight   = import(".Fight") 

local LevelFight = class("LevelFight", Fight)
function LevelFight:ctor(properties)
    dump(properties, "properties")
	LevelFight.super.ctor(self, properties)
end


function LevelFight:getFightType()
    return "levelFight"
end

function LevelFight:getResultData()
    local resultData = {}
    local hpPercent = self.hero:getHp() / self.hero:getMaxHp()
    -- is gold weapon
    local inlay = md:getInstance("FightInlay")
    local isGold = inlay:getIsNativeGold()
    local hpPercent = isGold and 1.00 or hpPercent

    resultData["goldNum"]   = self.goldValue
    resultData["hpPercent"] = hpPercent  
    resultData["levelId"]   = self:getLevelId()  
    resultData["groupId"]   = self:getGroupId()  
    resultData["fightType"] = self:getFightType() 
    resultData["result"]    = self:getResult()
    return resultData
end

function LevelFight:isJujiFight()
    local levelModel = md:getInstance("LevelDetailModel")
    local gid,lid    = self:getCurGroupAndLevel()
    local isju       = levelModel:isJujiFight(gid,lid) 
    return isju 
end

function LevelFight:waveUpdate(nextWaveIndex, waveType)
    local fightDescModel = md:getInstance("FightDescModel")
    if waveType == "boss" then 
        fightDescModel:bossShow()
    elseif waveType == "award" then  
        fightDescModel:goldShow()
    elseif waveType == "normalWave" then 
        fightDescModel:waveStart(nextWaveIndex)
    else
        assert(waveType, "waveType is nil")
    end    
end

return LevelFight