-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local Enemy = class("Enemy", Actor)

function Enemy:ctor(properties)
    --super
    local config = getConfigByID("config/enemy.json", properties.id)
    self.config = config    
    assert(config, "config id is wrong id:"..properties.id)
    local property = {
        id = "enemy"..properties.id,
        maxHp = config.hp,
        demage = config.demage,
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

return Enemy