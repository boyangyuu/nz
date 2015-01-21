
--[[--

“导弹兵”的视图
1. desc: a.发射攻击物品 (导弹 斧头 煤气罐  )
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local Hero = import("..Hero")
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
    assert(fireRate > 1, "invalid fireRate")
    if isAble then 
        randomSeed = math.random(1, fireRate)
        if randomSeed > fireRate - 1 then 
            self:playAfterAlert("playFire", handler(self, self.playFire))
            self.enemy:beginFireCd()
        end
    end

    --walk
    local walkRate, isAble = self.enemy:getWalkRate()
    assert(walkRate > 1, "invalid walkRate")

    if isAble then
        randomSeed =  math.random(1, walkRate)
        if randomSeed > walkRate - 1 then 
            self:play("playWalk", handler(self, self.playWalk))
            self.enemy:beginWalkCd()
        end
    end

    --roll
    local rollRate, isAble = self.enemy:getRollRate()
    assert(rollRate > 1, "invalid rollRate")

    if isAble then 
        randomSeed =  math.random(1, rollRate)
        if randomSeed > rollRate - 1 then 
            self:playRoll()
        end
    end    
end

function DaoEnemyView:playFire()
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
        missileType = self.property["missileType"],
    }
    local function callfuncDaoDan()
         self.hero:dispatchEvent({name = Hero.ENEMY_ADD_MISSILE_EVENT, property = property})
    end
    local sch = scheduler.performWithDelayGlobal(callfuncDaoDan, 0.3)
    self:addScheduler(sch)    
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
    if not self:checkPlace(-define.kEnemyRollWidth * self:getScale()) then return end
    self.armature:getAnimation():play("rollleft" , -1, 1) 
    local speed = define.kEnemyRollSpeed  * self:getScale() 

    local action = cc.MoveBy:create(1/60, cc.p(-speed, 0))
    local seq = cc.Sequence:create(action)  
    self.armature:runAction(cc.RepeatForever:create(seq))   
    self.enemy:beginRollCd()    
end

function DaoEnemyView:playRollRight()
    if not self:checkPlace(define.kEnemyRollWidth * self:getScale()) then return end
    self.armature:getAnimation():play("rollright" , -1, 1) 
    local speed = define.kEnemyRollSpeed  * self:getScale() 

    local action = cc.MoveBy:create(1/60, cc.p(speed, 0))
    local seq = cc.Sequence:create(action)  
    self.armature:runAction(cc.RepeatForever:create(seq))  
    self.enemy:beginRollCd()             
end

--Attackable interface
function DaoEnemyView:playHitted(event)
    self.armature:getAnimation():play("hit" , -1, 1) 

    --飘红
    self:playHittedEffect()
end

function DaoEnemyView:onHitted(targetData)
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

function DaoEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        -- print("animationEvent id ", movementID)
        armatureBack:stopAllActions()
        if movementID ~= "die" then
            local playCache = self:getPlayCache()
            if playCache then 
                playCache()
            else                    
                self:playStand()
            end
        elseif movementID == "die" then 
            self:setDeadDone()
        end 
    end
end

return DaoEnemyView