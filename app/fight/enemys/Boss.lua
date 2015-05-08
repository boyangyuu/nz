
-- --[[--
--[[--
“敵人”的实体

]]

local BaseEnemy = import(".BaseEnemy")
local Boss = class("Boss", BaseEnemy)

function Boss:ctor(enemy_property)
    --super
    local id          = enemy_property.id
    self.fightConfigs  = md:getInstance("FightConfigs")
    local waveConfig = self.fightConfigs:getWaveConfig() 
    self.config       = waveConfig:getBoss(id)
    local hpScale     = enemy_property["hpScale"] or 1.0
    -- dump(self.config, " Boss config")
    local actor_property = {
        id = "boss",
        maxHp = self.config["hp"] * hpScale,
        demage = self.config["demage"],
    }
    Boss.super.ctor(self, actor_property, enemy_property)

end


return Boss