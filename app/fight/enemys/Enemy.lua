local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local Enemy = class("Enemy", Actor)
local FightConfigs = import("..fightConfigs.FightConfigs")

function Enemy:ctor(properties)
    --super
    local waveConfig = FightConfigs:getWaveConfig()
    self.config = waveConfig:getEnemys(properties.id)  

    local demageScale = self.properties["demageScale"] or 1.0
    self:setDemageScale(demageScale)

    local property = {
        id = "enemy"..properties.id,
        maxHp = self.config.hp,
    }
    Enemy.super.ctor(self, property) 

    --
    self.isFireCd = false
    self.isWalkCd = false
    self.isRollCd = false    
end

function Enemy:getDemage()
    local baseDemage = self.config.demage
    local scale = self:getDemageScale()
    return baseDemage * scale
end

function Enemy:setDemageScale(scale)
    self.demageScale = scale
end

function Enemy:getDemageScale()
    return self.demageScale or 1.0
end

function Enemy:getFireRate()
	return self.config["fireRate"], not self.isFireCd
end

function Enemy:beginFireCd()
    self.isFireCd = true
    -- assert(self.config["fireCd"] , "config fireCd is nil")
    local fireCd = self.config["fireCd"] or 3.0

    local function resumeCd()
        self.isFireCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, fireCd)
end

function Enemy:getWalkRate()
	return self.config["walkRate"], not self.isWalkCd
end

function Enemy:beginWalkCd()
    self.isWalkCd = true
    -- assert(self.config["walkCd"] , "config walkCd is nil")
    local walkCd = self.config["walkCd"] or 3.0

    local function resumeCd()
        self.isWalkCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, walkCd)
end

function Enemy:getRollRate()
	return self.config["rollRate"], not self.isRollCd
end

function Enemy:beginRollCd()
    self.isRollCd = true
    -- assert(self.config["rollCd"] , "config rollCd is nil")
    local rollCd = self.config["rollCd"] or 3.0

    local function resumeCd()
        self.isRollCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, rollCd)
end

function Enemy:getWeakScale(rangeStr)
    -- print(rangeStr, "rangeStr")
    return self.config[rangeStr]
end

function Enemy:getConfig()
    return self.config
end

function Enemy:getAward()
    return self.config["award"] or define.kKillEnemyAwardGold
end

return Enemy