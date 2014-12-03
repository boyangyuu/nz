
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

function DaoEnemyView:tick()
    --fire
    local fireRate = self.enemy:getFireRate()
    local randomSeed  
    math.newrandomseed()
    assert(fireRate > 1, "invalid fireRate")
    randomSeed = math.random(1, fireRate)
    if randomSeed > fireRate - 1 then 
        self:playAfterAlert("playFire", handler(self, self.playFire))
        return
    end
    self:getPosInMap()
end

function DaoEnemyView:test()
    --body
    local weak1 = self.armature:getBone("weak1"):getDisplayRenderNode()
    local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
    drawBoundingBox(self.armature, weak1, "yellow") 
    drawBoundingBox(self.armature, bodyNode, "yellow") 
end

function DaoEnemyView:playFire()
    --导弹
    print("发射")
    local  property = { destPos = cc.p(0, 0),
                        srcPos = cc.p(-1136/2, -640/2),
                        srcScale = self:getScale() * 0.3,
                        type = "missile",
                        id = 6, }
    self.hero:dispatchEvent({name = Hero.ENEMY_ADD_MISSILE_EVENT, property = property})
end

--Attackable interface
function DaoEnemyView:playHitted(event)
    --飘红
    self:playHittedEffect()
end

function DaoEnemyView:playKill(event)
    self:setDeadDone()

    --屏幕动画
end

function DaoEnemyView:onHitted(targetData)
    local demage     = targetData.demage
    local scale      = targetData.demageScale
    local demageType = targetData.demageType
    if self.enemy:canHitted() and self:canHitted() then
        self.enemy:decreaseHp(demage * scale)
    end

    --爆头
    if self.enemy:getHp() == 0 then 
        if demageType == "head" then 
            print("爆头")
            self.hero:dispatchEvent({
                name = self.hero.ENEMY_KILL_HEAD_EVENT})
        end
    end   
end

function DaoEnemyView:canHitted()
    return true
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

function DaoEnemyView:getModel(property)
    return Enemy.new(property)
end

return DaoEnemyView