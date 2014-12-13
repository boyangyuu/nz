-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local Enemy = class("Enemy", Actor)
local FightConfigs = import("..fightConfigs.FightConfigs")

function Enemy:ctor(properties)
    --super
    -- local config = getConfigByID("config/enemy.json", properties.id)
    local waveConfig = FightConfigs:getWaveConfig()
    self.config = waveConfig:getEnemys(properties.id)    
    local property = {
        id = "enemy"..properties.id,
        maxHp = self.config.hp,
        demage = self.config.demage,
    }
    Enemy.super.ctor(self, property) 

    --

end

function Enemy:getFireRate()
	return self.config["fireRate"]
end

function Enemy:getWalkRate()
	return self.config["walkRate"]
end

function Enemy:getRollRate()
	return self.config["rollRate"]
end

function Enemy:getDemageScale(rangeStr)
    -- print(rangeStr, "rangeStr")
    return self.config[rangeStr]
end

function Enemy:getConfig()
    return self.config
end

return Enemy