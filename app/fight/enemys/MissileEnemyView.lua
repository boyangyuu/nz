
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

import("...includes.functionUtils")
local Attackable = import(".Attackable")
local Enemy = import(".Enemy")
local Hero = import("..Hero")
local Actor = import("..Actor")   

local MissileEnemyView = class("MissileEnemyView", Attackable)

---- event ----
function MissileEnemyView:ctor(property)  
    --instance
    MissileEnemyView.super.ctor(self, property)   
    self.srcPos = property.srcPos
    self.destPos = property.destPos
    self.srcScale = property.srcScale

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    self:playFire() 

    --test
    self.enemy:setHp(1.0)
end

function MissileEnemyView:tick()
    
end

function MissileEnemyView:playFire()
    -- print("issileEnemyView:playStand")

    --pos
    self:setPosition(self.srcPos)

    --scale
    self:setScale(self.srcScale)
    local time = 2.0
    local destScale = 0.9
    local scaleAction = cc.ScaleTo:create(time, destScale)

    --call end
    local function callMoveEnd()
        self:playBomb()
    end

    --run
    self.armature:getAnimation():play("fire" , -1, 1) 
    local seq = cc.Sequence:create(scaleAction, cc.CallFunc:create(callMoveEnd))
    self:runAction(seq)
    self:runAction(cc.MoveTo:create(time, self.destPos))
end

function MissileEnemyView:playBomb()
    -- print("MissileEnemyView:playBomb")

    --bomb动画
    self.armature:getAnimation():play("die" , -1, 1)  

    --demage
    self.enemy:hit(self.hero)   

    --屏幕爆炸效果
    self.hero:dispatchEvent({name = Hero.EFFECT_HURT_BOMB_EVENT})

end


--Attackable接口
function MissileEnemyView:playHitted(event)
end

function MissileEnemyView:playKill(event)
    print("MissileEnemyView:playKill(event)")

    --bomb动画
    self.armature:getAnimation():play("die" , -1, 1)      
end

function MissileEnemyView:onHitted(targetData)
    local demage     = targetData.demage
    local scale      = targetData.demageScale
    local demageType = targetData.demageType
    if self.enemy:canHitted() then
        print("self.enemy:decreaseHp(demage * scale)")
        self.enemy:decreaseHp(demage * scale)
    end
end

function MissileEnemyView:animationEvent(armatureBack,movementType,movementID)
    -- print("animationEvent id ", movementID)
    if movementType == ccs.MovementEventType.loopComplete then

        if movementID ~= "die" then
            local playCache = self:getPlayCache()
            if playCache then 
                playCache()
            end
        elseif movementID == "die" then
             self:setDeadDone()
        end
    end
end

function MissileEnemyView:getModel(property)
    return Enemy.new(property)
end

return MissileEnemyView