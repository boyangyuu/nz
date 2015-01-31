

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseBossView = import(".BaseBossView")
local FightConfigs = import("..fightConfigs.FightConfigs")
local DuozuBossView = class("DuozuBossView", BaseBossView)

function DuozuBossView:ctor(property)
	DuozuBossView.super.ctor(self, property) 
end

function DuozuBossView:tick()
    --change state
    if self.isWudi then return end
    --fire    
    local fireRate, isAble = self.enemy:getFireRate()
    if isAble then
        assert(fireRate > 1, "invalid fireRate")
        local randomSeed = math.random(1, fireRate)
        if randomSeed > fireRate - 1 then 
            self:play("skill", handler(self, self.playFire))
            self.enemy:beginFireCd()
        end
    end

    --walk
    local walkRate, isAble = self.enemy:getWalkRate()
    if isAble then
        assert(walkRate > 1, "invalid walkRate")
        local randomSeed = math.random(1, walkRate)
        if randomSeed > walkRate - 1 then 
            self:play("walk", handler(self, self.playWalk))
            self.enemy:beginWalkCd()
        end
    end

 
    -- --speak
    -- local speakRate, isAble = self.enemy:getSpeakRate()
    -- assert(speakRate > 1, "invalid speakRate")

    -- if isAble then
    --     local randomSeed = math.random(1, speakRate)
    --     if randomSeed > speakRate - 1 then 
    --         self:play("playSpeak", handler(self, self.playSpeak))
    --         self.enemy:beginSpeakCd()
    --     end
    -- end     
end

function DuozuBossView:onHitted(targetData )
    if self.isShaning or self.isWudi then return end
    DuozuBossView.super.onHitted(self, targetData)
end

function DuozuBossView:playWalk()
    local randomSeed = math.random(1, 2)
    local isRun = false
    if randomSeed == 1 then 
        self:playWalkAction(1)
    else
        self:playWalkAction(-1)
    end
end

function DuozuBossView:playWalkAction(direct)

    local speed = isRun and define.kRenzheSpeed  or define.kRenzheWalkSpeed
    local time = isRoll and define.kRenzheRunTime or define.kRenzheWalkTime

    print("time"..time)
    local width = speed * time * self:getScale() * direct
    print("width", width)
    if not self:checkPlace(width) then 
        self:checkIdle()
        return 
    end
    
    local animName = direct == 1 and "walkleft" or "walkright"
    self.armature:getAnimation():play(animName , -1, 1) 
    local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(action) 
    self:restoreStand(time)  
end

function DuozuBossView:playSkill(skillName)
    -- print("DuozuBossView:playSkill: "..skillName)
    local name = string.sub(skillName, 1, 7)
    if name == "yanwu" then 
        self:play("skillPre",handler(self, self.playSkillWu))
        return 
    elseif name == "wang" then 
        self:play("skillPre",handler(self, self.playSkillWang))
        return 
    elseif name == "wudi" then 
        self:play("skillPre",handler(self, self.playSkillWudi))
        return         
    end    
    DuozuBossView.super.playSkill(self, skillName)
end

function DuozuBossView:playFire()
    --普通导弹
    self.armature:getAnimation():play("fire2" , -1, 1) 

    for i=1,3 do
        local index = i + 2
        local boneName = "dao"..index
        local bone = self.armature:getBone(boneName):getDisplayRenderNode()     
        local delay = 0.3 + 0.10 * i 
        local property = {
            type = "missile",
            srcScale = self:getScale() * 0.3, --导弹view用
            id = self.property["missileId"], 
            demageScale = self.enemy:getDemageScale(),
            offset = self.property["missileOffsets"][i],
        }
        local function callfuncAddDao()
            local srcPos = bone:convertToWorldSpace(cc.p(0.0,0.0))
            property.srcPos = srcPos
            property.destPos = srcPos
            self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, 
                property = property})
        end
        local sch = scheduler.performWithDelayGlobal(callfuncAddDao, delay)
        self:addScheduler(sch)
    end
end

function DuozuBossView:playSkillWu()
    --烟雾弹
    self.armature:getAnimation():play("fire1" , -1, 1) 

    -- print("发射烟雾弹")
    local boneDao = self.armature:getBone("dao1"):getDisplayRenderNode()
    local pWorldBone = boneDao:convertToWorldSpace(cc.p(0, 0))
    local delay = 0.6
    local property = {
        srcPos = pWorldBone,
        srcScale = self:getScale() * 0.4,
        destScale = 1.5,
        destPos = pWorldBone,
        type = "missile",
        id = self.property["missileId"],
        demageScale = self.enemy:getDemageScale(),
        -- missileType = "yanwu",
    }
    local function callfuncDaoDan()
         self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, property = property})
    end
    local sch = scheduler.performWithDelayGlobal(callfuncDaoDan, delay)
    self:addScheduler(sch)   
end

function DuozuBossView:playSkillWang()
    --蜘蛛网弹
    self.armature:getAnimation():play("fire3" , -1, 1) 

    print("发射蜘蛛网弹")
    local boneDao = self.armature:getBone("dao6"):getDisplayRenderNode()
    local pWorldBone = boneDao:convertToWorldSpace(cc.p(0, 0))
    local delay = 0.6
    local property = {
        srcPos = pWorldBone,
        srcScale = self:getScale() * 0.4,
        destScale = 1.5,
        destPos = pWorldBone,
        type = "dao_wang",
        id = self.property["wangId"],
        demageScale = self.enemy:getDemageScale(),
    }
    local function callfuncDaoDan()
         self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, property = property})
    end
    local sch = scheduler.performWithDelayGlobal(callfuncDaoDan, delay)
    self:addScheduler(sch)   
end

function DuozuBossView:playSkillWudi()
    self.isWudi = true
    self.wudiAnim = ccs.Armature:create("wdhd")
    self.wudiAnim:getAnimation():play("wdhd", -1, 1)
    self.wudiAnim:setPosition(cc.p(0, 141))
    self.wudiAnim:setScale(1.3)
    self.armature:addChild(self.wudiAnim, 10000)
    self:performWithDelay(handler(self, self.endWudi), 
            self.config["wudiTime"])
end

function DuozuBossView:endWudi()
    self.isWudi = false
    self.wudiAnim:removeSelf()    
end

function DuozuBossView:playZhanHuan()
    self.armature:getAnimation():play("zhaohuan", -1, 1)
    self:zhaohuan()
end


function DuozuBossView:onKillLastCall()
    self.isShaning = false
    self:setVisible(true)
    self.armature:getAnimation():play("shanru" , -1, 1) 
end

function DuozuBossView:animationEvent(armatureBack,movementType,movementID)
    if self.isWudi then return end
    if movementType == ccs.MovementEventType.loopComplete 
        or  movementType == ccs.MovementEventType.complete   then
        print("animationEvent id ", movementID)
        armatureBack:stopAllActions()
        if movementID == "runleft"  or movementID == "runright" then
            self.armature:getAnimation():play(movementID , -1, 1)
            return 
        end

        if movementID == "die" then
            self:setDeadDone()
            return
        end

        if movementID == "stand" then 
            local playCache = self:getPlayCache()
            if playCache then 
                playCache()
            else                    
                self:playStand()
            end
        else 
            self:playStand()
        end 
    end
end

return DuozuBossView