
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

local Attackable = import(".Attackable")
local Enemy = import(".Enemy")
local Hero = import("..Hero")
local Actor = import("..Actor")   

local DDWuEnemyView = class("DDWuEnemyView", Attackable)

---- event ----
function DDWuEnemyView:ctor(property)  
    --instance
    DDWuEnemyView.super.ctor(self, property)   
    dump(property, "property")
    self.srcPos = property.srcPos
    self.destPos = property.destPos
    self.srcScale = property.srcScale

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    self:playFire() 
end

function DDWuEnemyView:tick()
    
end

function DDWuEnemyView:playFire()
    --scale
    self.armature:setScale(self.srcScale)
    local time = self.property["flyTime"] or define.kMissileDaoTime    
    local destScale = self.property["destScale"] or 1.0
    local scaleAction = cc.ScaleTo:create(time, destScale)

    --run
    local offset = self.property.offset or cc.p(0.0,0.0)
    self.armature:getAnimation():play("fire" , -1, 1) 
    local seq = cc.Sequence:create(scaleAction, 
        cc.CallFunc:create(handler(self, self.playAheadEnd)))
    self.armature:runAction(seq)
    self.armature:runAction(cc.MoveTo:create(time, offset)) 
end

function DDWuEnemyView:playAheadEnd()
   --kill
    self.armature:getAnimation():play("die" , -1, 1)  
    
    --demage
    self.enemy:hit(self.hero) 

    --dispatch 
    local time = define.kYanEffectTime
    local hero = md:getInstance("Hero")
    self.hero:dispatchEvent({name = hero.EFFECT_HURT_YAN_EVENT, time = time})
end

--Attackable接口
function DDWuEnemyView:playHitted(event)
    
end

function DDWuEnemyView:playKill(event)
    --bomb动画
    self.armature:getAnimation():play("die" , -1, 1)
    self:playBombEffect()
    self.armature:stopAllActions()  
end

function DDWuEnemyView:onHitted(targetData)
    local demage     = targetData.demage
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType or "body"
    if not self.enemy:canHitted() then return end
    self.enemy:decreaseHp(demage * scale)
end

function DDWuEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        if movementID ~= "die" then

        else
             self:setWillRemoved()
        end
    end
end

function DDWuEnemyView:getModel(property)
    return Enemy.new(property)
end


function DDWuEnemyView:isBeBuff()
    return false
end

return DDWuEnemyView