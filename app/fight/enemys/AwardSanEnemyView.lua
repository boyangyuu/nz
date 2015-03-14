
--[[--

“伞兵”的视图
1. desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. 伞兵落地 换为enemyview
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local AwardSanEnemyView = class("AwardSanEnemyView", Attackable)  


function AwardSanEnemyView:ctor(property)
    --instance
    AwardSanEnemyView.super.ctor(self, property) 
    self.isFalling = false

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT,  handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT,         handler(self, self.playKill)) 

    --
    self:setVisible(false)
end

function AwardSanEnemyView:onEnter()
    self:playFall()    
end

function AwardSanEnemyView:tick()
    
end

function AwardSanEnemyView:playFall()
    --start
    self:setVisible(true)
    self:setPositionY(display.height)

    --action
    local speed = define.kSanEnemySpeed
    local destPosY = self:getPlaceNode():getPositionY()
    local distance = display.height - destPosY
    local time = distance / speed 
    local action = cc.MoveBy:create(time, cc.p(0, -distance))
    
    --callfunc
    local seq = cc.Sequence:create(action, cc.CallFunc:create(handler(self, self.stopFall)))    
    self:runAction(cc.RepeatForever:create(seq))

    --play
    self.armature:getAnimation():play("jiangluo" , -1, 1) 
end

function AwardSanEnemyView:stopFall()
    self:stopAllActions()
    self.armature:getAnimation():play("stand" , -1, 1) 
end

--Attackable interface
function AwardSanEnemyView:playHitted(event)

end

function AwardSanEnemyView:playKill(event)
    self:setDeadDone()

    --award
    self:sendAward()
end

function AwardSanEnemyView:sendAward()
    local pWorld = self:convertToWorldSpace(cc.p(0,0))

    --award
    local awardType = self.property.award 
    if awardType == "goldWeapon" then 
        local map = md:getInstance("Map")
        map:dispatchEvent({name = map.AWARD_GOLD_EVENT, pWorld = pWorld})   
    end

end
function AwardSanEnemyView:onHitted(targetData)
    local demage     = targetData.demage 
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType or "body"
    if not self.enemy:canHitted()  then return end
    self.enemy:decreaseHp(demage * scale)

    --爆头
    if self.enemy:getHp() == 0 then 
        if demageType == "head" then 
            local soundSrc  = "res/Music/fight/btts.wav"
            self.audioId =  audio.playSound(soundSrc,false)             
            self.hero:dispatchEvent({
                name = self.hero.ENEMY_KILL_HEAD_EVENT})
        end
    end          
end

function AwardSanEnemyView:animationEvent(armatureBack,movementType,movementID)

end

function AwardSanEnemyView:getModel(property)
    return Enemy.new(property)
end

return AwardSanEnemyView