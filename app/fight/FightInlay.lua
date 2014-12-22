--[[--

“FightInlay”的实体

]]

--import
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local FightInlay          = class("FightInlay", cc.mvc.ModelBase)

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

    self:checkNativeGold()
end

function FightInlay:checkNativeGold()
    print("FightInlay:checkNativeGold()")
    local isNativeGold = self:getIsNativeGold()
    self:setIsActiveGold(isNativeGold)
    if isNativeGold then 
        self:activeGoldForever()
    end
end

function FightInlay:activeGoldForever()
    self:setIsActiveGold(true)   
    print("FightInlay:activeGold()") 
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_BEGIN_EVENT})
end

function FightInlay:activeGold()
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
    return self.inlayModel:isGetAllGold()
end

--[[
    @param type: crit blood bullet clip helper speed 
    return: value, isInlayed
]]
function FightInlay:getInlayedValue(type)
    -- print("FightInlay:getInlayedValue type", type)
    local record = nil
    if self:getIsActiveGold() then 
        -- print("gold inlay~~~~~")
        record = self.inlayModel:getGoldByType(type)
        assert(record, "record is nil type:"..type)
    else
        local inlays = self.inlayModel:getAllInlayed()
        local inlayedId  = inlays[type]
        if inlayedId == nil then return nil,false end
        record = getRecordByID("config/items_xq.json", inlayedId)
    end
    local value = record.valueProgram
    -- print("FightInlay:getInlayedValue value:", value)
    return value, true
end 

return FightInlay