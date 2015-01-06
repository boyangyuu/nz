
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
    self.property = property
    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    self:playFire() 
end

function MissileEnemyView:tick()
    
end

function MissileEnemyView:playFire()
    local missileType = self.property["missileType"] or "daodan"
    
    if missileType == "daodan" or missileType == "tie" then 
        self:playDaoDanFire()
    elseif missileType == "lei" then
        self:playLeiFire()
    else 
        assert(false, "invalid missileType"..missileType)
    end 

end

function MissileEnemyView:playDaoDanFire()
    --scale
    self:setScale(self.srcScale)
    local time = 2.0
    local destScale = self.property["destScale"] or 1.0
    local scaleAction = cc.ScaleTo:create(time, destScale)

    --call end
    local function callMoveEnd()
        self:playBomb()
    end

    --run
    local offset = self.property.offset or cc.p(0.0,0.0)
    self.armature:getAnimation():play("fire" , -1, 1) 
    local seq = cc.Sequence:create(scaleAction, cc.CallFunc:create(callMoveEnd))
    self:runAction(seq)
    self:runAction(cc.MoveTo:create(time, offset))
end

function MissileEnemyView:playLeiFire()
    print("lei")
    
    self.armature:getAnimation():play("fire" , -1, 1)  
    local srcPos = self.property["srcPos"]
    local destPos = cc.p(srcPos.x - 90, 20)
    local jumpTime = 1.8
    local jumpH = 300.0
    local moveAction = cc.JumpTo:create(jumpTime, destPos, jumpH, 1)
    local action = transition.newEasing(moveAction,"in", jumpTime)   
    
    local callFunc = function ()
        self:playBomb()
    end
    local seq =  cc.Sequence:create(
                    action,
                    cc.CallFunc:create(callFunc) )    
    self:runAction(seq)
    self.armature:setScale(0.05)
    self.armature:runAction(cc.ScaleTo:create(jumpTime, 2.0))
end

function MissileEnemyView:playBomb()
    local missileType = self.property["missileType"]
    
    --bomb动画
    self.armature:getAnimation():play("die" , -1, 1)  
    if missileType == "tie" or missileType == "lei" then
        self:playBombEffect()
    end
    
    --demage
    self.enemy:hit(self.hero)   

    --屏幕爆炸效果
    local animName = self.property.animName
    if animName then 
            self.hero:dispatchEvent({name = Hero.EFFECT_HURT_BOMB_EVENT, 
                animName = animName})
    end

end

--Attackable接口
function MissileEnemyView:playHitted(event)

end

function MissileEnemyView:playKill(event)
    print("MissileEnemyView:playKill(event)")

    --bomb动画
    self.armature:getAnimation():play("die" , -1, 1)
    self:playBombEffect()      
end

function MissileEnemyView:onHitted(targetData)
    print("function MissileEnemyView:onHitted(targetData)")
    local demage     = targetData.demage
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType or "body"
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
             self:setWillRemoved()
        end
    end
end

function MissileEnemyView:getModel(property)
    return Enemy.new(property)
end

return MissileEnemyView