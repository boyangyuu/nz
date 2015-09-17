local Fight   = import(".Fight")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local NormalFight = class("NormalFight", Fight)
function NormalFight:ctor(properties)
    dump(properties, "properties")
    NormalFight.super.ctor(self, properties)

    --instance
    self.passLevelNum = 0
end

function NormalFight:startFightResult()
    --closeFunc
    local function closeFunc()
        local resultData = self:getResultData()
        ui:changeLayer("HomeBarLayer",{fightData = resultData})
    end

    --data

    --desc
    local data = {
        closeFunc    = closeFunc,
        goldValue    = self.goldGet,
    }
    ui:showPopup("MidAutumnResultLayer",data,{animName = "normal"})

    --money
    local user = md:getInstance("UserModel")
    user:addMoney(self.goldGet)
    self.goldGet = 0
end

function NormalFight:getResultData()
    local levelMapModel = md:getInstance("LevelMapModel")
    local groupId, levelId = levelMapModel:getConfig()
    local resultData = {}
    resultData["fightType"] = self:getFightType()
    resultData["groupId"]   = groupId
    resultData["levelId"]   = self:getLevelId()
    resultData["result"]    = self:getResult()
    return resultData
end

function NormalFight:isJujiFight()
    return false
end

function NormalFight:getFightType()
    return "normalFight"
end

function NormalFight:waveUpdate(nextWaveIndex, waveType)
    dump(waveType,"waveTypewaveTypewaveTypewaveType")
    dump(nextWaveIndex,"nextWaveIndexnextWaveIndexnextWaveIndex")
    -- if nextWaveIndex == 1 then return end

    if nextWaveIndex ~= 1 then
        self.passLevelNum = self.passLevelNum + 1
    end

    --award
    -- local map = md:getInstance("Map")
    -- local waveIndex = map:getWaveIndex()
    -- local eventData = {
    --     closeFunc    = handler(self, self.onClickedAwardBtn),
    --     goldValue    = self.goldGet,
    -- }
    -- ui:showPopup("MidAutumnResultLayer",eventData,{animName = "normal"})
    -- self:pauseFight(true)

    -- --money
    -- local user = md:getInstance("UserModel")
    -- user:addMoney(self.goldGet)
    -- self.goldGet = 0

    --desc
    local fightDescModel = md:getInstance("FightDescModel")
    if waveType == "boss" then
        fightDescModel:bossShow()
    elseif waveType == "award" then
        fightDescModel:goldShow()
    elseif waveType == "normalWave" then
        local waveIndex = self.passLevelNum + 1
        fightDescModel:waveStart(waveIndex)
    else
        assert(waveType, "waveType is nil")
    end
end

function NormalFight:onClickedAwardBtn(event)
    --next wave
    local function delayCall()
        --pause
        self:pauseFight(false)
    end

    scheduler.performWithDelayGlobal(delayCall, 2.0)
end

function NormalFight:endFightFail()
    self:dispatchEvent({name = Fight.FIGHT_FAIL_EVENT})
    self:pauseFight(true)
    ui:showPopup("FightRelivePopup",
        {onReliveFunc = handler(self, self.onReliveConfirm),
         onGiveUpFunc = handler(self, self.onReliveDeny),
         fightType = "normal"},
        {animName = "normal"})
    self:clearFightData()
end

function NormalFight:getReliveCost()
    local times = self:getRelivedTimes()
    local costs = define.kNormalReliveCosts
    local maxCost = costs[#costs]
    return costs[times + 1] or maxCost
end

function NormalFight:onReliveConfirm()
    self:doRelive()
end

function NormalFight:onReliveDeny()
    self:doGiveUp()
    local fightData = self:getResultData()
    ui:changeLayer("HomeBarLayer",{fightData = fightData})
end

return NormalFight