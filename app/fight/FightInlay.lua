--[[--

“FightInlay”的实体

]]

--import
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local FightInlay  = class("FightInlay", cc.mvc.ModelBase)

--events
FightInlay.INLAY_UPDATE_EVENT           = "INLAY_UPDATE_EVENT"
FightInlay.INLAY_GOLD_BEGIN_EVENT       = "INLAY_GOLD_BEGIN_EVENT" --激活黄金武器（同时刷新血量上限）
FightInlay.INLAY_GOLD_END_EVENT         = "INLAY_GOLD_END_EVENT"


function FightInlay:ctor(properties)
    --instance
    FightInlay.super.ctor(self, properties)
    self.inlayModel = md:getInstance("InlayModel") 
    self.isNativeGold = false
    self.IsActiveGold = false
    self.goldTimes    = 0
end

function FightInlay:refreshUm()
    local inlays = self.inlayModel:getAllInlayed()
    for type,configId in ipairs(inlays) do
        local record = self.inlayModel:getInlayRecord(configId)   
        local name   = record["describe2"]

        --um
        local fightFactory = md:getInstance("FightFactory")
        local fight = fightFactory:getFight()
        assert(levelInfo, "levelInfo is nil")
        local levelInfo = fight:getLevelInfo()  
        local umData = {}
        umData[levelInfo] = name

        print("关卡道具使用")
        um:event("关卡道具使用", umData)      
    end
end

function FightInlay:checkNativeGold()
    local isNativeGold = self:getIsNativeGold()
    self:setIsActiveGold(isNativeGold)
    if isNativeGold then 
        print("function FightInlay:checkNativeGold()")
        self:activeGoldOnCost()
    end
end

function FightInlay:activeGoldOnCost()
    self:setIsActiveGold(true)
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_BEGIN_EVENT})

    --hero
    local hero = md:getInstance("Hero")

    --inlay
    self:setIsNativeGold(true)  

    --um
    local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    local levelInfo = fight:getLevelInfo()
    assert(levelInfo, "levelInfo is nil") 
    local umData = {}
    umData[levelInfo] = "黄武"
    um:event("关卡道具使用", umData)   

    --goldTimes
    self.goldTimes = self.goldTimes + 1
    print("self.goldTimes", self.goldTimes)
end

function FightInlay:getGoldCostTimes()
    return self.goldTimes
end

function FightInlay:activeGold()
    if self:getIsNativeGold() then return end
    self:setIsActiveGold(true)   
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_BEGIN_EVENT})
    
    --delay
    local kGoldTime = define.kGoldTime
    self:delayCallGoldEnd(kGoldTime)
    --
end

function FightInlay:delayCallGoldEnd(delay)
    scheduler.performWithDelayGlobal(handler(self, self.activeGoldEnd), delay)
end

function FightInlay:activeGoldEnd()
    if self:getIsNativeGold() then return end
    self:setIsActiveGold(false)
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_END_EVENT})
end

function FightInlay:setIsActiveGold(IsActiveGold_)
    self.IsActiveGold = IsActiveGold_ 
end

function FightInlay:getIsActiveGold()
    return self.IsActiveGold
end

function FightInlay:getIsNativeGold()
    return self.inlayModel:isGetAllGold() or self.isNativeGold
end

function FightInlay:setIsNativeGold(isNativeGold_)
    self.isNativeGold = isNativeGold_
    local hero = md:getInstance("Hero")
    hero:setFullHp()
end

--[[
    @param type: crit blood bullet clip helper speed 
    return: value, isInlayed
]]
function FightInlay:getInlayedValue(type)
    local isGoldForbid = type == "blood" or type == "helper" or type == "bullet"
    local isGoldForbid = type == "blood" 

    --gold
    local isGoldType = (not isGoldForbid and self:getIsActiveGold() ) 
                    or self:getIsNativeGold()
    if isGoldType then 
        local record = self.inlayModel:getInlayConfigByTypeAndPri(type, 4)
        local value = record.valueProgram
        return value, true        
    end

    --not gold
    local record = nil
    local inlays = self.inlayModel:getAllInlayed()
    local inlayedId  = inlays[type]
    if inlayedId == nil then  
        record = self.inlayModel:getInlayConfigByTypeAndPri(type, 2)
    else
        record = self.inlayModel:getInlayRecord(inlayedId)
    end
    assert(record, "record is nil type:"..type)

    local value = record.valueProgram
    return value, true
end 

return FightInlay