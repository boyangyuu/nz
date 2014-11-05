-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local Enemy = class("Enemy", Actor)

function Enemy:ctor(properties)
    --instance

    --property	
    local config = getConfigByID("config/enemy.json", properties.id)
    self.config = config
    assert(config, "config id is wrong id:"..properties.id)
    self:setDemage(config.demage)
    self:setMaxHp(config.hp)
    Enemy.super.ctor(self, properties)
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