
--[[--

“绑匪”的视图
1. 
2. 
]]

--import
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local RZBangfeiEnemyView = class("RZBangfeiEnemyView", BaseEnemyView)

function RZBangfeiEnemyView:ctor(property)
    RZBangfeiEnemyView.super.ctor(self, property) 
    self.walkPos = 0            --left -1, right 1
end

function RZBangfeiEnemyView:playStartState(state)
    if state == "left" then 
        self:playWalkLeft()
    elseif state == "right" then
        self:playWalkRight()    
    else 
        self:playStand()
    end
end

function RZBangfeiEnemyView:playKill(event)
    print("function RZBangfeiEnemyView:playKill(event)")
    RZBangfeiEnemyView.super.playKill(self, event)
    self.armature:getAnimation():play("die" ,-1 , 1)
    
    --sound
    local soundSrc  = "res/Music/fight/die.wav"
    self.audioId =  audio.playSound(soundSrc,false) 

    --event
    local renzhiName   = self.property.renzhiName
    self.enemyM:dispatchEvent({name = self.enemyM.ENEMY_KILL_BANGFEI_EVENT,
            renzhiName = renzhiName})
end

function RZBangfeiEnemyView:tick(t)
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
            self:playWalk()
        end
    end
end

function RZBangfeiEnemyView:playWalk()
    local random = math.random(0, 1)
    if random == 1 then 
        self:play("playWalkLeft", handler(self, self.playWalkLeft))
    else
        self:play("playWalkRight", handler(self, self.playWalkRight)) 
    end
end

function RZBangfeiEnemyView:playWalkLeft()
    if self.walkPos == -1 then return end
    local speed = define.kTufeiSpeed * self:getScale()
    local time = define.kTufeiWalkTime
    local width = speed * time * self:getScale() * -1
    self.armature:getAnimation():play("walk" , -1, 1) 
    self.walkPos = self.walkPos - 1
    local action = cc.MoveBy:create(time, cc.p(width, 0))
    self:setPauseOtherAnim(true)
    self:runAction(cc.Sequence:create(action, 
        cc.CallFunc:create(handler(self, self.restoreStand))
        ))      
end


function RZBangfeiEnemyView:playWalkRight()
    if self.walkPos == 1 then return end
    local speed = define.kTufeiSpeed * self:getScale()
    local time  = define.kTufeiWalkTime
    local width = speed * time * self:getScale() * 1
    self.armature:getAnimation():play("walk" , -1, 1) 
    self.walkPos = self.walkPos + 1
    local action = cc.MoveBy:create(time, cc.p(width, 0))
    self:setPauseOtherAnim(true)
    self:runAction(cc.Sequence:create(action, 
        cc.CallFunc:create(handler(self, self.restoreStand))
        ))       
end

function RZBangfeiEnemyView:playFire()
    if self.walkPos == 0 then return end
    RZBangfeiEnemyView.super.playFire(self) 
end

function RZBangfeiEnemyView:canHitted()
    if self:getPauseOtherAnim() or self.walkPos == 0 then 
        return false
    end
    return true
end

function RZBangfeiEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID ~= "die" and not self:getPauseOtherAnim() then
            self:doNextPlay()
        elseif movementID == "die" then 
            self:setDeadDone()
        end 
    end
end
return RZBangfeiEnemyView