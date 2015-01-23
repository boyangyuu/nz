local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local BaseEnemy = import(".BaseEnemy")
local Enemy = class("Enemy", BaseEnemy)
local FightConfigs = import("..fightConfigs.FightConfigs")

function Enemy:ctor(properties)
    --super
    local waveConfig = FightConfigs:getWaveConfig()
    self.config = waveConfig:getEnemys(properties.id)  

    local property = {
        id = "enemy"..properties.id,
        maxHp = self.config.hp,
    }
    Enemy.super.ctor(self, property) 

end

return Enemy