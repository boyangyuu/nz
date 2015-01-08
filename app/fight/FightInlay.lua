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

--constanst
local kGoldTime = 5.0

function FightInlay:ctor(properties)
    --instance
    FightInlay.super.ctor(self, properties)
    self.inlayModel = md:getInstance("InlayModel") 

    -- self:checkNativeGold()
end

function FightInlay:checkNativeGold()
    print("FightInlay:checkNativeGold()")
    local isNativeGold = self:getIsNativeGold()
    print("isNativeGold", isNativeGold)
    self:setIsActiveGold(isNativeGold)
    if isNativeGold then 
        self:activeGoldForever()
    end
end

function FightInlay:activeGoldForever()
    self:setIsActiveGold(true)
    print("FightInlay:activeGoldForever()") 
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_BEGIN_EVENT})

    --hero
    local hero = md:getInstance("Hero")
    hero:refreshHp()  

    --inlay
    self:setIsNativeGold(true)  
end

function FightInlay:activeGold()
    if self:getIsNativeGold() then return end
    self:setIsActiveGold(true)   
    print("FightInlay:activeGold()") 
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_BEGIN_EVENT})

    --delay
    self:delayCallGoldEnd(kGoldTime)
end

function FightInlay:delayCallGoldEnd(delay)
    scheduler.performWithDelayGlobal(handler(self, self.activeGoldEnd), delay)
end

function FightInlay:activeGoldEnd()
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
end

--[[
    @param type: crit blood bullet clip helper speed 
    return: value, isInlayed
]]
function FightInlay:getInlayedValue(type)
    local record = nil
    if self:getIsActiveGold() then 
        record = self.inlayModel:getGoldByType(type)
        assert(record, "record is nil type:"..type)
    else
        local inlays = self.inlayModel:getAllInlayed()
        local inlayedId  = inlays[type]
        if inlayedId == nil then return nil,false end
        record = getRecordByID("config/items_xq.json", inlayedId)
    end
    local value = record.valueProgram
    return value, true
end 

return FightInlay