
--[[--
“汽油桶兵”的视图
]]

local Attackable = import(".Attackable")
local Enemy = import(".Enemy")
local Hero = import("..Hero")
local Actor = import("..Actor") 

local BaoTongEnemyView = class("BaoTongEnemyView", Attackable)  

function BaoTongEnemyView:ctor(property)
    --instance
    BaoTongEnemyView.super.ctor(self, property) 
    self.hero = md:getInstance("Hero")
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT,        handler(self, self.playKill))     

    self:playStand()
end

function BaoTongEnemyView:playStand()
    self.armature:getAnimation():play("stand" ,-1 , 1)    
end

function BaoTongEnemyView:playKill(event)
    BaoTongEnemyView.super.playKill(self,event)
    self.armature:getAnimation():play("die" ,-1 , 1)
    self:demageOthers()
    self:playBombEffects()
end

function BaoTongEnemyView:playBombEffects()
    -- for i=1,3 do
    --     self:performWithDelay(handler(self, self.playBombEffect), i * 0.1)
    -- end
    local map = md:getInstance("Map")
    local pWorld = self:convertToWorldSpace(cc.p(0,0))
    map:dispatchEvent({name = map.EFFECT_LEI_BOMB_EVENT,
        pWorld = pWorld})

end

function BaoTongEnemyView:onHitted(targetData)
    local demage     = targetData.demage
    if not self.enemy:canHitted() then return end
    self.enemy:decreaseHp(demage)
end

function BaoTongEnemyView:playHitted(event)
    --飘红
    print("function BaoTongEnemyView:playHitted(event)")
    self:playHittedEffect()
end

function BaoTongEnemyView:tick(t)
end

function BaoTongEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID ~= "die" and not self:getPauseOtherAnim() then
            self:doNextPlay()
        elseif movementID == "die" then 
            self:setDeadDone()
        end 
    end
end

function BaoTongEnemyView:demageOthers()
    --伤害enemys
    local demage = self.enemy:getConfig().demage
    local destRect = self:getBaoRect()
    local targetData = {demage = demage, 
                        demageScale = 1, 
                        demageType = "bao",
                        }
    self.hero:dispatchEvent({name = self.hero.ENEMY_ATTACK_MUTI_EVENT, 
      targetData = targetData,destRect = destRect})  
end

function BaoTongEnemyView:getBaoRect()
    local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
    local bound = self.armature:getBoundingBox() 
    pWorld.y = pWorld.y + bound.height / 2 * self:getScale()  --获得中心位置

    --create 群伤范围和位置
    local rangeW = define.kBaoTongRangeW 
    local rangeH = define.kBaoTongRangeH 
    local pos = cc.p(pWorld.x - rangeW / 2 ,
                 pWorld.y - rangeH / 2)
    local rect = cc.rect(pos.x, pos.y, rangeW, rangeH)
    return rect
end

function BaoTongEnemyView:getModel(property)
    return Enemy.new(property)
end

function BaoTongEnemyView:isBeBuff()
    return false
end

return BaoTongEnemyView