-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local Boss = class("Boss", Actor)

function Boss:ctor(properties)
    --super
    dump(properties, "properties")
    -- self.config = .. --根据bossconfig_1 
    local property = {
        id = "boss",
        maxHp = 4000,
        demage = 20,
    }
    Boss.super.ctor(self, property)

    --
end

function Boss:getFireRate()
    return 100
	-- return self.config["fireRate"] 
end

function Boss:getMoveRate()
    return 100
	-- return self.config["walkRate"]
end

function Boss:getDemageScale(rangeStr)
    return 2.0
    -- print(rangeStr, "rangeStr")
    -- return self.config[rangeStr]
end

return Boss