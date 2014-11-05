
--[[--
“boss”的实体

]]

local Actor = import("..Actor")
local Boss = class("Boss", Actor)

function Boss:ctor(properties)
    --instance

    --property	
    local config = getConfigByID("config/Boss.json", properties.id)
    self.config = config
    assert(config, "config id is wrong id:"..properties.id)
    self:setDemage(config.demage)
    self:setMaxHp(config.hp)
    Boss.super.ctor(self, properties)

    --..

end

return Boss