--[[--

“FightInlay”的实体

]]

--import

local InlayModel   	= import("..inlay.InlayModel")


local FightInlay          = class("FightInlay", cc.mvc.ModelBase)
--events

--inlay
FightInlay.INLAY_UPDATE_EVENT           = "INLAY_UPDATE_EVENT"

function FightInlay:ctor(properties)
    --instance
    FightInlay.super.ctor(self, properties)
    self.inlayModel = app:getInstance(InlayModel) 

end

--[[
    @param type：aim blood bullet clip helper speed 
    return: value, isInlayed
]]
function FightInlay:getInlayedValue(type)
    --id
    local inlays = self.inlayModel:getAllInlayed()
    -- dump(inlays, "inlays")
    -- print("type", type)
    local inlayedId  = inlays[type]
    if inlayedId == nil then return nil,false end
    local record = getRecordByKey("config/items_xq.json", "id", inlayedId)
    local value = record[1].valueProgram
    print("FightInlay:getInlayedValue value:", value)
    return value, true
end 

return FightInlay