--[[--

“FightInlay”的实体

]]

--import

local InlayModel   	= import("..inlay.InlayModel")


local FightInlay          = class("FightInlay", cc.mvc.ModelBase)
--events

--inlay
FightInlay.INLAY_UPDATE_EVENT           = "INLAY_UPDATE_EVENT"
FightInlay.INLAY_GOLD_BEGIN_EVENT       = "INLAY_GOLD_BEGIN_EVENT" --激活黄金武器（同时刷新血量上限）
FightInlay.INLAY_GOLD_END_EVENT         = "INLAY_GOLD_END_EVENT"
function FightInlay:ctor(properties)
    --instance
    FightInlay.super.ctor(self, properties)
    self.inlayModel = app:getInstance(InlayModel) 
    self:setIsGold(properties.isGold)

end

function FightInlay:activeGold()
    self:setIsGold(true)
    --dispatch
    print("ightInlay:activeGold()")
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_BEGIN_EVENT})
end

function FightInlay:activeGoldEnd()
    self:setIsGold(false)
    --dispatch
    self:dispatchEvent({name = FightInlay.INLAY_GOLD_END_EVENT})
end

function FightInlay:setIsGold(status)
    self.isGold = status

end

function FightInlay:getIsGold()
    return self.isGold
end

--[[
    @param type: crit blood bullet clip helper speed 
    return: value, isInlayed
]]
function FightInlay:getInlayedValue(type)
    print("FightInlay:getInlayedValue type", type)
    if self:getIsGold() then 
        print("gold inlay~~~~~")
        --取黄金的数值

    end

    --normal
    local inlays = self.inlayModel:getAllInlayed()
    -- dump(inlays, "inlays")
    -- print("type", type)
    local inlayedId  = inlays[type]
    if inlayedId == nil then return nil,false end
    local record = getRecordByID("config/items_xq.json", inlayedId)
    local value = record.valueProgram
    -- print("FightInlay:getInlayedValue value:", value)
    return value, true
end 

return FightInlay