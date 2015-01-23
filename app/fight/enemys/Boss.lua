local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local BaseEnemy = import(".BaseEnemy")
local Boss = class("Boss", BaseEnemy)
local FightConfigs = import("..fightConfigs.FightConfigs")

function Boss:ctor(properties)
    --super
    -- dump(properties, "properties")
    local id = properties.id
    local waveConfig = FightConfigs:getWaveConfig()
    self.config = waveConfig:getBoss(id)
    dump(self.config, " Boss config")
    local property = {
        id = "boss",
        maxHp = self.config["hp"],
        demage = self.config["demage"],
    }
    Boss.super.ctor(self, property)

end


return Boss