

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseBossView = import(".BaseBossView")
local FightConfigs = import("..fightConfigs.FightConfigs")
local RenBossView = class("RenBossView", BaseBossView)

function RenBossView:ctor(property)
	RenBossView.super.ctor(self, property) 
end

function RenBossView:tick()
    --change state

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

function RenBossView:playFire()
    --导弹
    self.armature:getAnimation():play("fire" , -1, 1) 

    print("发射")
    local boneDao = self.armature:getBone("dao1"):getDisplayRenderNode()
    local pWorldBone = boneDao:convertToWorldSpace(cc.p(0, 0))
    -- pWorldBone = self.armature:convertToWorldSpace(cc.p(0,0))
    -- dump(self.property, "self.property")
    local property = {
        srcPos = pWorldBone,
        srcScale = self:getScale() * 0.3,
        destPos = pWorldBone,
        type = "missile",
        id = self.property["missileId"],
        demageScale = self.enemy:getDemageScale(),
        missileType = self.property["missileType"],
    }
    local function callfuncDaoDan()
         self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, property = property})
    end
    local sch = scheduler.performWithDelayGlobal(callfuncDaoDan, 0.3)
    self:addScheduler(sch) 
end

function RenBossView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete 
        or  movementType == ccs.MovementEventType.complete   then
        -- print("animationEvent id ", movementID)
        armatureBack:stopAllActions()
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