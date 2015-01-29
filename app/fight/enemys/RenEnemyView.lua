
--[[--

“忍者兵”的视图
1. desc: a.发射攻击物品 ()
]]

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local RenEnemyView = class("RenEnemyView", BaseEnemyView)  

function RenEnemyView:ctor(property)
    --instance
    RenEnemyView.super.ctor(self, property) 

    self.isAheading = false

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 
end

---- state ----
function RenEnemyView:playStartState(state)
    if state == "runleft" then 
        self:playRunAction(-1, true)
    elseif state == "runright" then
        self:playRunAction(1, true)    
    else 
        self:playEnter()
    end
end

function RenEnemyView:tick()
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

function RenEnemyView:playEnter()
    self.armature:getAnimation():play("fenshenru" , -1, 1)
end

function RenEnemyView:playFire()
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

function RenEnemyView:playWalk()
    local randomSeed = math.random(1, 2)
    local isRun = false
    if randomSeed == 1 then 
        self:playRunAction(1, isRun)
    else
        self:playRunAction(-1, isRun)
    end
end

function RenEnemyView:playRun()
    local randomSeed = math.random(1, 2)
    local isRun = true
    if randomSeed == 1 then 
        self:playRunAction(1, isRun)
    else
        self:playRunAction(-1, isRun)
    end
end

function RenEnemyView:playRunAction(direct, isRun)
    -- print("function RenEnemyView:playRunAction():",isRun)
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

--Attackable interface
function RenEnemyView:playHitted(event)
    -- self.armature:getAnimation():play("hit" , -1, 1) 

    --飘红
    self:playHittedEffect()
end

function RenEnemyView:onHitted(targetData)
    local demage     = targetData.demage
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType
    if not self.enemy:canHitted() then return end
    
    self.enemy:decreaseHp(demage * scale)
    --爆头
    if self.enemy:getHp() == 0 then 
        if demageType == "head" then 
            print("爆头")
            self.hero:dispatchEvent({
                name = self.hero.ENEMY_KILL_HEAD_EVENT})
        end
    end          
end

function RenEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete 
        or  movementType == ccs.MovementEventType.complete   then
        -- print("animationEvent id ", movementID)
        armatureBack:stopAllActions()
        if movementID == "runleft" 
            or movementID == "runright" 
            or movementID == "walk" then
                self.armature:getAnimation():play(movementID , -1, 1)
            return 
        end

        if movementID == "die" then
            self:setDeadDone()
            return
        end

        if movementID == "stand" then 
            local playCache = self:getPlayCache()
            if self.isAheading then 
                -- print("禁止")
                return
            end             
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

return RenEnemyView