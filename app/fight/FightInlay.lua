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

    --check
    self:initUm()
end

function FightInlay:initUm()
    local inlays = self.inlayModel:getAllInlayed()
    for type,configId in ipairs(inlays) do
        local record = self.inlayModel:getInlayRecord(configId)   
        local name   = record["describe2"]

        --um
        local fight = md:getInstance("Fight")
        local levelInfo = fight:getLevelInfo()  
        local umData = {}
        umData[levelInfo] = name

        print("关卡道具使用")
        um:event("关卡道具使用", umData)      
    end
end

function FightInlay:checkNativeGold()
    print("FightInlay:checkNativeGold()")
    local isNativeGold = self:getIsNativeGold()
    print("isNativeGold", isNativeGold)
    self:setIsActiveGold(isNativeGold)
    if isNativeGold then 
        self:activeGoldOnCost()
    end
end

function FightInlay:activeGoldOnCost()
    self:setIsActiveGold(true)
    print("FightInlay:activeGoldOnCost()") 
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_BEGIN_EVENT})

    --hero
    local hero = md:getInstance("Hero")

    --inlay
    self:setIsNativeGold(true)  

    --um
    local fight = md:getInstance("Fight")
    local levelInfo = fight:getLevelInfo()  
    local umData = {}
    umData[levelInfo] = "黄武"
    um:event("关卡道具使用", umData)    
end

function FightInlay:activeGold()
    if self:getIsNativeGold() then return end
    self:setIsActiveGold(true)   
    print("FightInlay:activeGold()") 
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
    print("function FightInlay:setIsActiveGold",IsActiveGold_)
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
    -- return 0,true
    local record = nil
    local isGoldForbid = type == "blood" or type == "helper" or type == "bullet"
    local isGoldForbid = type == "blood" or type == "bullet"

    local isGoldType = (not isGoldForbid and self:getIsActiveGold() ) 
                    or self:getIsNativeGold()
    if isGoldType then 
        record = self.inlayModel:getGoldByType(type)
        assert(record, "record is nil type:"..type)
    else
        local inlays = self.inlayModel:getAllInlayed()
        local inlayedId  = inlays[type]
        if inlayedId == nil then return nil,false end
        record = self.inlayModel:getInlayRecord(inlayedId)
    end
    local value = record.valueProgram
    return value, true
end 

return FightInlay