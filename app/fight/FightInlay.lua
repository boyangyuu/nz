--[[--

“FightInlay”的实体

]]

--import
local InlayModel   	= import("..inlay.InlayModel")


local FightInlay          = class("FightInlay", cc.mvc.ModelBase)

--events
FightInlay.INLAY_UPDATE_EVENT           = "INLAY_UPDATE_EVENT"
FightInlay.INLAY_GOLD_BEGIN_EVENT       = "INLAY_GOLD_BEGIN_EVENT" --激活黄金武器（同时刷新血量上限）
FightInlay.INLAY_GOLD_END_EVENT         = "INLAY_GOLD_END_EVENT"

function FightInlay:ctor(properties)
    --instance
    FightInlay.super.ctor(self, properties)
    self.inlayModel = app:getInstance(InlayModel) 
    
    self:checkNativeGold()
end

function FightInlay:checkNativeGold()
    local isNativeGold = self:getIsNativeGold()
    self:setIsGold(isNativeGold)
    if isNativeGold then 
        self:activeGold()
    end
end

function FightInlay:activeGold()
    self:setIsGold(true)   
    print("FightInlay:activeGold()") 
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_BEGIN_EVENT})
end

function FightInlay:activeGoldEnd()
    self:setIsGold(false)
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_END_EVENT})
end

function FightInlay:setIsGold(isGold_)
    self.isGold = isGold_
end

function FightInlay:getIsGold()
    return self.isGold
end

function FightInlay:getIsNativeGold()
    return true
end

--[[
    @param type: crit blood bullet clip helper speed 
    return: value, isInlayed
]]
function FightInlay:getInlayedValue(type)
    -- print("FightInlay:getInlayedValue type", type)
    local record = nil
    if self:getIsGold() then 
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