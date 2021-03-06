
--[[--

“绑匪”的视图
1. 
2. 
]]

--import
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local TFQiuEnemyView = class("TFQiuEnemyView", BaseEnemyView)

function TFQiuEnemyView:ctor(property)
    TFQiuEnemyView.super.ctor(self, property) 
    self.posIndex = 0
    self.posDatas = property.data
    self:setPauseOtherAnim(true) 
end

function TFQiuEnemyView:playStartState(state)
    if state == "san" then 
        self:playSan() 
    elseif state == "enterleft" then 
        self:playEnter("left")
    elseif state == "enterright" then
        self:playEnter("right")            
    else 
        self:playMoveToNext()
    end
end

function TFQiuEnemyView:playEnter(direct)
    --setPos
    local isLeft = direct == "left" 
    
    local srcPosX = 0 
    if isLeft then 
        srcPosX = - 300
    else
        srcPosX = display.width + 300
    end
    self:setPositionX(srcPosX)

    --藏身处
    self:playMoveToNext()
end

function TFQiuEnemyView:playMoveToNext()
    self.posIndex = self.posIndex + 1
    --check next
    local data    = self.posDatas[self.posIndex]
    local direct  = self.posDatas["direct"]
    if data == nil then 
        print("离开")
        self:exit()
        return
    end 
    
    --armature
    local animName = "run" .. direct
    self.armature:getAnimation():play(animName , -1, 1) 

    --pos
    local destPos = self:getOriginPosInMap()
    for i=1,self.posIndex do
        destPos.x = destPos.x + self.posDatas[i].pos
    end
    
    --action
    local distance = math.abs(self:getPositionX() - destPos.x)
    local speed = self:getSpeed()
    local time = distance / speed
    local action = cc.MoveTo:create(time, destPos)
    local callfunc = function ()
        self:playHide()
    end
    self:runAction(cc.Sequence:create(action, 
            cc.CallFunc:create(callfunc)))
end

function TFQiuEnemyView:playHide()
    self.armature:getAnimation():play("dunxiasj" , -1, 1) 
    self.enemy:hit(self.hero)

    --move next
    local function callfunc()
        self:playMoveToNext()
    end
    local data = self.posDatas[self.posIndex]
    local delay = data["time"]
    self:performWithDelay(callfunc, delay)
end

function TFQiuEnemyView:exit()
    if self.property["exit"] == "middle" then 
        self:onTao()
        return
    end

    if self.enemy:isDead() then return end
    local direct  = self.posDatas["direct"]
    self.armature:getAnimation():play("run" .. direct , -1, 1) 
    self.isExiting   = true
    local speed      = self:getSpeed()
    local posInMapx  = self:getPosInMap().x
    local width 
    if direct == "right" then 
        width = display.width - posInMapx + 300
    else
        width = - posInMapx - 300
    end
    local time       = math.abs(width / speed)
    local action     = cc.MoveBy:create(time, cc.p(width, 0))
    self:runAction(cc.Sequence:create(action, 
            cc.CallFunc:create(handler(self, self.onTao))))  
end

function TFQiuEnemyView:onTao()    
    local fightMode = md:getInstance("FightMode")
    fightMode:dispatchEvent({name = fightMode.FightMODE_TAOFAN_TAO_EVENT})
    
    --要滞后 否则可能会先赢
    self:setWillRemoved()
end

function TFQiuEnemyView:playKill(event)
    TFQiuEnemyView.super.playKill(self, event)
    if self:getIsFlying() then 
        self:setDeadDone()
        return 
    end

    self.armature:getAnimation():play("die" ,-1 , 1)
    
    --sound
    local soundSrc  = "res/Music/fight/die.wav"
    self.audioId =  audio.playSound(soundSrc,false) 

    --event
    local renzhiName   = self.property.renzhiName
    self.enemyM:dispatchEvent({name = self.enemyM.ENEMY_KILL_BANGFEI_EVENT,
            renzhiName = renzhiName})
end

function TFQiuEnemyView:playSan()
    self:setIsFlying(true)
    self:setPositionY(display.height)

    --action
    local speed = define.kQiufanSanSpeed
    local destPosY = self:getPlaceNode():getPositionY()
    local distance = display.height - destPosY
    local time = distance / speed 
    local action = cc.MoveBy:create(time, cc.p(0, -distance))
    
    local function callfunc()
        self:setIsFlying(false)
        self:playMoveToNext()
    end

    local seq = cc.Sequence:create(action, 
        cc.CallFunc:create(callfunc))    
    self:runAction(seq)

    --play
    self.armature:getAnimation():play("jiangluo" , -1, 1)    
end

function TFQiuEnemyView:playHitted()
    self:playHittedEffect()
end

function TFQiuEnemyView:getSpeed()
    local isJu     = self.fight:isJujiFight()
    local speed = isJu and define.kQiufanJuSpeed or define.kQiufanSpeed
    return speed
end

function TFQiuEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID == "die" then 
            self:setDeadDone()
        elseif movementID ~= "die" and not self:getPauseOtherAnim() then
            self:doNextPlay()
        end 
    end
end

return TFQiuEnemyView