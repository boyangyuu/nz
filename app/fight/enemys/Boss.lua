-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local Boss = class("Boss", Actor)

function Boss:ctor(properties)
    --super
    local config = getConfigByID("config/boss.json", properties.id)
    self.config = config    
    assert(config, "config id is wrong id:"..properties.id)
    local property = {
        id = "boss"..properties.id,
        maxHp = 4000,
        demage = config.demage,
    }
    Boss.super.ctor(self, property)	

    --
end

function Boss:getFireRate()
	return self.config["fireRate"]
end

function Boss:getMoveRate()
	return self.config["walkRate"]
end

function Boss:getDemageScale(rangeStr)
    print(rangeStr, "rangeStr")
    return self.config[rangeStr]
end

return Boss