
--[[--

“导弹兵”的视图
1. desc: a.发射攻击物品 (导弹 斧头 煤气罐  )
]]

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
    self:playStand()
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
  
end

function DaoEnemyView:playFire()
    --导弹
    self.armature:getAnimation():play("fire" , -1, 1) 

    -- print("发射")
    local boneDao = self.armature:getBone("dao1"):getDisplayRenderNode()
    local pWorldBone = boneDao:convertToWorldSpace(cc.p(0, 0))
    local property = {
        type = "missile",
        srcPos = pWorldBone,
        srcScale = self:getScale() * 0.3,
        destPos = pWorldBone,
        id = self.property["missileId"], 
        demageScale = self.enemy:getDemageScale(),
        missileType = self.property["missileType"],
    }
    self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, property = property})
end

function DaoEnemyView:playKill(event)
    DaoEnemyView.super.playKill(self, event)
    self.armature:getAnimation():play("die" ,-1 , 1)
    --sound
    local soundSrc  = "res/Music/fight/die02.wav"
    self.audioId =  audio.playSound(soundSrc,false) 
end



--Attackable interface
function DaoEnemyView:playHitted(event)
    local curID = self:getCurrentMovementID()
    if curID ~= "hit" and not self:getPauseOtherAnim() then
        self.armature:getAnimation():play("hit" ,-1 , 1)
    end
    
    --飘红
    self:playHittedEffect()
end

function DaoEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete 
        or  movementType == ccs.MovementEventType.complete   then
        -- print("animationEvent id ", movementID)
        armatureBack:stopAllActions()
        if movementID ~= "die" and not self:getPauseOtherAnim() then
            self:doNextPlay()
        elseif movementID == "die" then 
            self:setDeadDone()
        end 
    end
end

return DaoEnemyView