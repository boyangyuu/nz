-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local Boss = class("Boss", Actor)
local FightConfigs = import("..fightConfigs.FightConfigs")

function Boss:ctor(properties)
    --super
    dump(properties, "properties")
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

    self.isFireCd = false
    self.isWalkCd = false
    --
end


--implement attackable
function Boss:getDemageScale(rangeStr)

    assert(self.config.demageScale[rangeStr], "wave config is invalid:"..rangeStr)
    return self.config.demageScale[rangeStr]
end

function Boss:getConfig()
    return self.config
end

function Boss:getFireRate()
    return self.config["fireRate"], not self.isFireCd
end

function Boss:beginFireCd()
    self.isFireCd = true
    assert(self.config["fireCd"] , "config fireCd is nil")
    local fireCd = self.config["fireCd"] or 3.0

    local function resumeCd()
        self.isFireCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, fireCd)
end

function Boss:getWalkRate()
    return self.config["walkRate"], not self.isWalkCd
end

function Boss:beginWalkCd()
    self.isWalkCd = true
    assert(self.config["walkCd"] , "config walkCd is nil")
    local walkCd = self.config["walkCd"] or 3.0

    local function resumeCd()
        self.isWalkCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, walkCd)
end

function Boss:getAward()
    return self.config["award"] or define.kKillEnemyAwardGold
end

return Boss