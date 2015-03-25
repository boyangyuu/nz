
--[[--

“导弹兵”的视图
1. desc: a.发射攻击物品 (导弹 斧头 煤气罐  )
]]

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local DaoEnemyView = class("DaoEnemyView", BaseEnemyView)  

function DaoEnemyView:ctor(property)
    --instance
    DaoEnemyView.super.ctor(self, property) 

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 
end

---- state ----
function DaoEnemyView:playStartState(state)
    if state == "rollleft" then 
        self:playRollLeft()
    elseif state == "rollright" then
        self:playRollRight()    
    else 
        self:playStand()
    end
end

function DaoEnemyView:tick()
    --fire
    local fireRate, isAble = self.enemy:getFireRate()
    if isAble then 
        assert(fireRate > 1, "invalid fireRate")
        randomSeed = math.random(1, fireRate)
        if randomSeed > fireRate - 1 then 
            self:playAfterAlert("skill", handler(self, self.playFire))
            self.enemy:beginFireCd()
        end
    end

    --walk
    local walkRate, isAble = self.enemy:getWalkRate()
    if isAble then
        assert(walkRate > 1, "invalid walkRate")
        randomSeed =  math.random(1, walkRate)
        if randomSeed > walkRate - 1 then 
            self:play("playWalk", handler(self, self.playWalk))
        end
    end

    --roll
    local rollRate, isAble = self.enemy:getRollRate()
    if isAble then 
        assert(rollRate > 1, "invalid rollRate")
        randomSeed =  math.random(1, rollRate)
        if randomSeed > rollRate - 1 then 
            self:playRoll()
        end
    end    
end

function DaoEnemyView:playFire()
    --导弹
    self.armature:getAnimation():play("fire" , -1, 1) 

    -- print("发射")
    local boneDao = self.armature:getBone("dao1"):getDisplayRenderNode()
    local pWorldBone = boneDao:convertToWorldSpace(cc.p(0, 0))
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

function DaoEnemyView:playKill(event)
    DaoEnemyView.super.playKill(self, event)

    --sound
    local soundSrc  = "res/Music/fight/die02.wav"
    self.audioId =  audio.playSound(soundSrc,false) 
end

function DaoEnemyView:playRoll()
    local randomSeed = math.random(1, 2)
    local canRoll = self.property["missileType"] == "lei"
    if not canRoll then return end
    
    if randomSeed == 1 then 
        self:play("playRollLeft", handler(self, self.playRollLeft))
    else
        self:play("playRollRight", handler(self, self.playRollRight))
    end
end

function DaoEnemyView:playRollLeft()
    if not self:checkPlace(-define.kEnemyRollWidth * self:getScale()) then 
        self:checkIdle()
        return
    end

    self.armature:getAnimation():play("rollleft" , -1, 1) 
    local speed = define.kEnemyRollSpeed  * self:getScale() 

    local action = cc.MoveBy:create(1/60, cc.p(-speed, 0))
    local seq = cc.Sequence:create(action)  
    self.armature:runAction(cc.RepeatForever:create(seq))   
    self.enemy:beginRollCd()    
end

function DaoEnemyView:playRollRight()
    if not self:checkPlace(define.kEnemyRollWidth * self:getScale()) then 
        self:checkIdle() 
        return
    end

    self.armature:getAnimation():play("rollright" , -1, 1) 
    local speed = define.kEnemyRollSpeed  * self:getScale() 

    local action = cc.MoveBy:create(1/60, cc.p(speed, 0))
    local seq = cc.Sequence:create(action)  
    self.armature:runAction(cc.RepeatForever:create(seq))  
    self.enemy:beginRollCd()             
end

--Attackable interface
function DaoEnemyView:playHitted(event)
    -- self.armature:getAnimation():play("hit" , -1, 1) 

    --飘红
    self:playHittedEffect()
end

function DaoEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete 
        or  movementType == ccs.MovementEventType.complete   then
        -- print("animationEvent id ", movementID)
        armatureBack:stopAllActions()
        if movementID ~= "die" then
            self:doNextPlay()
        elseif movementID == "die" then 
            self:setDeadDone()
        end 
    end
end

return DaoEnemyView