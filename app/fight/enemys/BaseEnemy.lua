local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local BaseEnemy = class("BaseEnemy", Actor)

function BaseEnemy:ctor(actor_property, enemy_property)
    --super  
    BaseEnemy.super.ctor(self, actor_property) 
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
    return baseDemage * scale
end

function BaseEnemy:setDemageScale(scale)
    self.demageScale = scale
end

function BaseEnemy:getDemageScale()
    return self.demageScale or 1.0
end

function BaseEnemy:getFireRate()
	return 30, not self.isFireCd
end

function BaseEnemy:beginFireCd()
    self.isFireCd = true
    assert(self.config["fireCd"] , "config fireCd is nil")
    local fireCd = self.config["fireCd"] or 3.0
    local function resumeCd()
        self.isFireCd = false
    end
    if self.resumeFireSch then 
        scheduler.unscheduleGlobal(self.resumeFireSch)
        self.resumeFireSch = nil
    end
    self.resumeFireSch = scheduler.performWithDelayGlobal(
        resumeCd, fireCd)
end

function BaseEnemy:getWalkRate()    
	return 30, not self.isWalkCd
end

function BaseEnemy:beginWalkCd()
    self.isWalkCd = true
    local walkCd = self.config["walkCd"] or 3.0

    local function resumeCd()
        self.isWalkCd = false
    end
    if self.resumeWalkSch then 
        scheduler.unscheduleGlobal(self.resumeWalkSch)
        self.resumeWalkSch = nil
    end    
    self.resumeWalkSch = scheduler.performWithDelayGlobal(
        resumeCd, walkCd)
end

function BaseEnemy:getRollRate()        
	return 30, not self.isRollCd
end

function BaseEnemy:beginRollCd()
    self.isRollCd = true
    local rollCd = self.config["rollCd"] or 3.0

    local function resumeCd()
        self.isRollCd = false
    end
    if self.resumeRollSch then 
        scheduler.unscheduleGlobal(self.resumeRollSch)
        self.resumeRollSch = nil
    end    
    self.resumeRollSch = scheduler.performWithDelayGlobal(
        resumeCd, rollCd)
end

function BaseEnemy:getSpeakRate()
	return 30, not self.isSpeakCd
end

function BaseEnemy:beginSpeakCd()
    self.isSpeakCd = true
    assert(self.config["speakCd"] , "config speakCd is nil")
    local speakCd = self.config["speakCd"]
    print("speakCd", speakCd)
    local function resumeCd()
        self.isSpeakCd = false
    end
    if self.resumeSpeakSch then 
        scheduler.unscheduleGlobal(self.resumeSpeakSch)
        self.resumeSpeakSch = nil
    end    
    self.resumeSpeakSch = scheduler.performWithDelayGlobal(resumeCd, speakCd)
end

function BaseEnemy:getShanRate()
    return 30, not self.isSpeakCd
end

function BaseEnemy:beginShanCd()
    self.isShanCd = true
    assert(self.config["shanCd"] , "config shanCd is nil")
    local shanCd = self.config["shanCd"]
    local function resumeCd()
        self.isShanCd = false
    end
    if self.resumeShanSch then 
        scheduler.unscheduleGlobal(self.resumeShanSch)
        self.resumeShanSch = nil
    end    
    self.resumeShanSch = scheduler.performWithDelayGlobal(resumeCd, shanCd)
end

function BaseEnemy:getWeakScale(rangeStr)
    return self.config[rangeStr]
end

function BaseEnemy:getConfig()
    return self.config
end

function BaseEnemy:getAward()
    if  self:isKillAward() then 
        return self.config["award"] or define.kKillEnemyAwardGold
    else
        return nil
    end
end

function BaseEnemy:onKill_(event)
    if self:isKillAward() then 
        local hero = md:getInstance("Hero")
        hero:killEnemy()
    end
    BaseEnemy.super.onKill_(self, event)
end

function BaseEnemy:isKillAward()
    local image = self.config["image"]
    local images = {"qyt_01", "shoulei", "daodan", "tieqiu", "zzw", "feibiao"}
    for i,v in ipairs(images) do
        if v == image then 
            return false
        end
    end  
    return true  
end

return BaseEnemy