
--[[--
“汽油桶兵”的视图
]]

local BaseEnemyView = import(".BaseEnemyView")
local BaoTongEnemyView = class("BaoTongEnemyView", BaseEnemyView)  

function BaoTongEnemyView:ctor(property)
    --instance
    BaoTongEnemyView.super.ctor(self, property) 
    self.hero = md:getInstance("Hero")
end

function BaoTongEnemyView:playStartState(state)
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
    for i=1,3 do
        self:performWithDelay(handler(self, self.playBombEffect), i * 0.1)
    end 
end

function BaoTongEnemyView:playHitted(event)
    --飘红
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
    print("成功摧毁")
    local destRect = self:getBaoRect()
    local targetData = {demage = define.kBaoDemageOtherEnemys, 
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
    -- dump(pWorld, "pWorld")

    --create 群伤范围和位置
    local rangeW = define.kBaoRangeW * self:getScale()
    local rangeH = define.kBaoRangeH * self:getScale()
    local pos = cc.p(pWorld.x - rangeW / 2 ,
                 pWorld.y - rangeH / 2)
    local rect = cc.rect(pos.x, pos.y, rangeW, rangeH)
    return rect
end

return BaoTongEnemyView