

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseBossView = import(".BaseBossView")
local FightConfigs = import("..fightConfigs.FightConfigs")
local RenBossView = class("RenBossView", BaseBossView)

function RenBossView:ctor(property)
	RenBossView.super.ctor(self, property) 
end

function RenBossView:tick()
    --change state
    if self.isShaning then return end

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

    --闪
    local shanRate, isAble = self.enemy:getShanRate()
    if isAble then
        assert(shanRate > 1, "invalid shanRate")
        local randomSeed = math.random(1, shanRate)
        if randomSeed > shanRate - 1 then 
            self:play("skill", handler(self, self.playShan))
            self.enemy:beginShanCd()
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

    --roll
    local rollRate, isAble = self.enemy:getRollRate()
    if isAble then
        assert(rollRate > 1, "invalid rollRate")
        local randomSeed = math.random(1, rollRate)
        if randomSeed > rollRate - 1 then 
            self:play("roll", handler(self, self.playRun))
            self.enemy:beginRollCd()
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

function RenBossView:onHitted(targetData )
    if self.isShaning then return end
    RenBossView.super.onHitted(self, targetData)
end

function RenBossView:playWalk()
    local randomSeed = math.random(1, 2)
    local isRun = false
    if randomSeed == 1 then 
        self:playRunAction(1, isRun)
    else
        self:playRunAction(-1, isRun)
    end
end

function RenBossView:playRun()
    local randomSeed = math.random(1, 2)
    local isRun = true
    if randomSeed == 1 then 
        self:playRunAction(1, isRun)
    else
        self:playRunAction(-1, isRun)
    end
end

function RenBossView:playShan()
    local randomSeed = math.random(1, 2)
    local isLeft = randomSeed == 1 and -1 or 1 
    local offset =  math.random(define.kRenzheShanOffsetMin , 
                            define.kRenzheShanOffsetMax)   
                         * self:getScale() * isLeft
    if not self:checkPlace(offset) then 
        self:checkIdle()
        return 
    end 

    --
    self.armature:getAnimation():play("shanchu" , -1, 1) 
    self.isShaning = true

    --callfunc
    local function shanru()
        self:setVisible(true)
        self:setPositionX(self:getPositionX() +  offset)
        self.armature:getAnimation():play("shanru" , -1, 1) 
        self.isShaning = false
    end
    scheduler.performWithDelayGlobal(shanru, define.kRenzheShanTime)
end

function RenBossView:playRunAction(direct, isRun)
    -- print("function RenBossView:playRunAction():",isRun)
    local speed = isRun and define.kRenzheSpeed  or define.kRenzheWalkSpeed
    local time = isRoll and define.kRenzheRunTime or define.kRenzheWalkTime

    -- print("time"..time)
    local width = speed * time * self:getScale() * direct
    -- print("width", width)
    if not self:checkPlace(width) then 
        self:checkIdle()
        return 
    end
    
    local animName 
    if isRun then 
        animName = direct == 1 and "runright" or "runleft"
    else
        animName = "walk"
    end

    self.armature:getAnimation():play(animName , -1, 1) 
    local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(action) 

    self:restoreStand(time)  
end

function RenBossView:playSkill(skillName)
    print("RenBossView:playSkill: "..skillName)
    local name = string.sub(skillName, 1, 7)
    if name == "feibiao" then 
        local index = string.sub(skillName, 8, 8)
        self:playFeibiao(index)
        local function callfuncFeibiao()
            self:playFeibiao(skillName)
        end
        self:play("skillPre",callfuncFeibiao)
        return 
    end
    RenBossView.super.playSkill(self, skillName)
end

function RenBossView:playFeibiao(skillName)
    assert(index, "playFeibiao index is nil")
    local config = self.config[skillName] 
    self.armature:getAnimation():play("fire" , -1, 1) 
    for i=1,#config.srcPoses do
        local delay = 0.6 + 0.10 * i 
        local property = {
            srcPos = config.srcPoses[i],
            srcScale = self:getScale() * 0.4,
            destScale = 1.5,
            destPos = config.srcPoses[i],
            offset = config.offsetPoses[i],
            type = "missile",
            id = self.property["missileId"],
            demageScale = self.enemy:getDemageScale(),
            missileType = "feibiao",
        }
        local function callfuncDaoDan()
             self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, property = property})
        end
        local sch = scheduler.performWithDelayGlobal(callfuncDaoDan, delay)
        self:addScheduler(sch)         
    end    
end

function RenBossView:playFire()
    --导弹
    self.armature:getAnimation():play("fire" , -1, 1) 

    print("发射")
    local boneDao = self.armature:getBone("dao1"):getDisplayRenderNode()
    local pWorldBone = boneDao:convertToWorldSpace(cc.p(0, 0))
    local offsetPoses = self.property["missileOffsets"]
    for i=1,#offsetPoses do
        local delay = 0.6 + 0.10 * i 
        local property = {
            srcPos = pWorldBone,
            srcScale = self:getScale() * 0.4,
            destScale = 1.5,
            destPos = pWorldBone,
            offset = offsetPoses[i],
            type = "missile",
            id = self.property["missileId"],
            demageScale = self.enemy:getDemageScale(),
            missileType = "feibiao",
        }
        local function callfuncDaoDan()
             self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, property = property})
        end
        local sch = scheduler.performWithDelayGlobal(callfuncDaoDan, delay)
        self:addScheduler(sch)         
    end
end

function RenBossView:playZhanHuan()
    self.armature:getAnimation():play("zhaohuan", -1, 1)
    self:zhaohuan()
    self.isShaning = true
end

function RenBossView:onKillLastCall()
    self.isShaning = false
    self:setVisible(true)
    self.armature:getAnimation():play("shanru" , -1, 1) 
end

function RenBossView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete 
        or  movementType == ccs.MovementEventType.complete   then
        -- print("animationEvent id ", movementID)
        armatureBack:stopAllActions()
        if movementID == "shanchu" then 
            self:setVisible(false)
            return
        end

        if movementID == "zhaohuan" then 
            self:setVisible(false)
            return
        end

        if movementID == "runleft" 
	            or movementID == "runright" 
	            or movementID == "walk" 
	            or movementID == "chongfeng"  then
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

return RenBossView