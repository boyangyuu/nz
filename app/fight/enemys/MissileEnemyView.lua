
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
function MissileEnemyView:ctor(properties)  
    --instance
    MissileEnemyView.super.ctor(self, properties)   

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
    self.armature:getAnimation():play("fire" , -1, 1) 
    local time = 3.0
    local scale = 1
    self.armature:setScale(0.20) 
    local scaleAction = cc.ScaleTo:create(time, scale)
    local function callMoveEnd()
        self:playBomb()
    end
    local seq = cc.Sequence:create(scaleAction, cc.CallFunc:create(callMoveEnd))
    self.armature:runAction(seq)
end

function MissileEnemyView:playBomb()
    -- print("MissileEnemyView:playBomb")

    --bomb动画
    -- self.armature:getAnimation():play("bomb" , -1, 1)  

    --demage
    self.enemy:hit(self.hero)   

    --屏幕爆炸效果
    --dispatch effect_hurted_bomb
end


--Attackable接口
function MissileEnemyView:playHitted(event)
end

function MissileEnemyView:playKill(event)
    self:setDeadDone() 

    --bomb动画
    -- self.armature:getAnimation():play("kill" , -1, 1)      
end

function MissileEnemyView:onHitted(demage)
    if self.enemy:canHitted() then
        self.enemy:decreaseHp(demage)
    end    
end

function MissileEnemyView:animationEvent(armatureBack,movementType,movementID)
    -- print("animationEvent id ", movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        local playCache = self:getPlayCache()
        if playCache then 
            playCache()
        end
    end
end

function MissileEnemyView:getEnemyArmature()
    if self.armature then return self.armature end 
    --armature
    local src = "Fight/enemys/daodan/daodan.ExportJson"
    local armature = getArmature("daodan", src) 
    armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
    return armature
end


function MissileEnemyView:getModel(property)
    return Enemy.new(property)
end


return MissileEnemyView