
-- --[[--
--[[--
“敵人”的实体

]]

local BaseEnemy = import(".BaseEnemy")
local Enemy = class("Enemy", BaseEnemy)
local FightConfigs = import("..fightConfigs.FightConfigs")

function Enemy:ctor(enemy_property)
    --super
    local waveConfig = FightConfigs:getWaveConfig()
    self.config = waveConfig:getEnemys(enemy_property.id)  
    local hpScale     = enemy_property["hpScale"] or 1.0
    local actor_property = {
        id = "enemy"..enemy_property.id,
        maxHp = self.config.hp * hpScale,
    }
    Enemy.super.ctor(self, actor_property, enemy_property) 

end

return Enemy