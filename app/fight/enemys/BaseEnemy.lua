local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local BaseEnemy = class("BaseEnemy", Actor)
local FightConfigs = import("..fightConfigs.FightConfigs")

function BaseEnemy:ctor(actor_property, enemy_property)
    --super
    BaseEnemy.super.ctor(self, actor_property) 

    -- dump(enemy_property, "enemy_property")
    local demageScale = enemy_property["demageScale"] or 1.0
    self:setDemageScale(demageScale)

    self.isFireCd = false
    self.isWalkCd = false
    self.isRollCd = false    
    self.isSpeakCd = false
    self.isShanCd = false
end

function BaseEnemy:getDemage()
    local baseDemage = self.config.demage or 1.0
    local scale = self:getDemageScale()
    -- print("baseDemage", baseDemage)
    -- print("scale", scale)
    return baseDemage * scale
end

function BaseEnemy:setDemageScale(scale)
    -- print("function BaseEnemy:setDemageScale(scale)  "..scale)
    self.demageScale = scale
end

function BaseEnemy:getDemageScale()
     -- print("function BaseEnemy:getDemageScale(scale): "..self.demageScale)
    return self.demageScale or 1.0
end

function BaseEnemy:getFireRate()
    if self.config["fireRate"] == nil then return 0, false end
	return self.config["fireRate"], not self.isFireCd
end

function BaseEnemy:beginFireCd()
    self.isFireCd = true
    assert(self.config["fireCd"] , "config fireCd is nil")
    local fireCd = self.config["fireCd"] or 3.0
    local function resumeCd()
        self.isFireCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, fireCd)
end

function BaseEnemy:getWalkRate()
    if self.config["walkRate"] == nil then return 0, false end    
	return self.config["walkRate"], not self.isWalkCd
end

function BaseEnemy:beginWalkCd()
    self.isWalkCd = true
    -- assert(self.config["walkCd"] , "config walkCd is nil")
    local walkCd = self.config["walkCd"] or 3.0

    local function resumeCd()
        self.isWalkCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, walkCd)
end

function BaseEnemy:getRollRate()
    if self.config["rollRate"] == nil then return 0, false end        
	return self.config["rollRate"], not self.isRollCd
end

function BaseEnemy:beginRollCd()
    self.isRollCd = true
    -- assert(self.config["rollCd"] , "config rollCd is nil")
    local rollCd = self.config["rollCd"] or 3.0

    local function resumeCd()
        self.isRollCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, rollCd)
end

function BaseEnemy:getSpeakRate()
    if self.config["speakRate"] == nil then return 0, false end       
	assert(self.config["speakRate"] , "config speakRate is nil")
	return self.config["speakRate"], not self.isSpeakCd
end

function BaseEnemy:beginSpeakCd()
    self.isSpeakCd = true
    assert(self.config["speakCd"] , "config speakCd is nil")
    local speakCd = self.config["speakCd"]
    print("speakCd", speakCd)
    local function resumeCd()
        self.isSpeakCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, speakCd)
end

function BaseEnemy:getShanRate()
    if self.config["shanRate"] == nil then return 0, false end       
    assert(self.config["shanRate"] , "config shanRate is nil")
    return self.config["shanRate"], not self.isSpeakCd
end

function BaseEnemy:beginShanCd()
    self.isShanCd = true
    assert(self.config["shanCd"] , "config shanCd is nil")
    local shanCd = self.config["shanCd"]
    -- print("shanCd", shanCd)
    local function resumeCd()
        self.isShanCd = false
    end
    scheduler.performWithDelayGlobal(resumeCd, shanCd)
end

function BaseEnemy:getWeakScale(rangeStr)
    -- print(rangeStr, "rangeStr")
    return self.config[rangeStr]
end

function BaseEnemy:getConfig()
    return self.config
end

function BaseEnemy:getAward()
    return self.config["award"] or define.kKillEnemyAwardGold
end

return BaseEnemy