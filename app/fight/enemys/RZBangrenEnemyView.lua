
--[[--

“绑匪”的视图
1. 
2. 
]]

--import
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local RZBangrenEnemyView = class("RZBangrenEnemyView", BaseEnemyView)

function RZBangrenEnemyView:ctor(property)
    RZBangrenEnemyView.super.ctor(self, property) 

    --events
    cc.EventProxy.new(self.enemyM, self)
        :addEventListener(self.enemyM.ENEMY_KILL_BANGFEI_EVENT, handler(self, self.onKillFei))
end

function RZBangrenEnemyView:onEnter()
     RZBangrenEnemyView.super.onEnter(self) 
    self:playStand()
end

function RZBangrenEnemyView:playKill(event)
    self.isWillDead = true
    RZBangrenEnemyView.super.playKill(self, event)
    self.armature:getAnimation():play("die" ,-1 , 1)
end

function RZBangrenEnemyView:tick(t)

end

function RZBangrenEnemyView:onKillFei(event)
    if self.isWillDead then 
        return 
    end
    local renzhiName = event.renzhiName
    if self.property.renzhiName == renzhiName then 
        self:onJiejiu()
        --event
        local mode = md:getInstance("FightMode")
        mode:dispatchEvent({name = mode.FightMODE_RENZHI_SAVE_EVENT})
    end 
end

function RZBangrenEnemyView:playStand()
    self.armature:getAnimation():play("stand" , -1, 1) 
end

function RZBangrenEnemyView:onJiejiu()
    if self.property["exit"] == "middle" then 
        self:playStand()
        self:setWillRemoved(1.0)
    else
        self:playRun()
    end
end

function RZBangrenEnemyView:playRun()
    local posInMapx = self:getPosInMap().x
    local direct = posInMapx <= display.width/2 and -1 or 1
    local speed = define.kBangrenSpeed
    local width ,time
    if direct == -1 then 
        width = -posInMapx - 300
        time = -width / speed
    else
        width = display.width  - posInMapx + 300
        time = width / speed
    end

    local animName = direct == 1 and "runright" or "runleft"
    self.armature:getAnimation():play(animName , -1, 1) 
    local action = cc.MoveBy:create(time, cc.p(width, 0))
    self:setPauseOtherAnim(true)
    local callfunc = function ()
        self:setWillRemoved()
    end
    self:runAction(cc.Sequence:create(
        cc.DelayTime:create(0.5),
        action, 
        cc.CallFunc:create(callfunc)))
end

function RZBangrenEnemyView:rectIntersectsRect(focusBound, enemyBound)
    focusBound.width = 1
    focusBound.height = 1
    return RZBangrenEnemyView.super.rectIntersectsRect(
        self, focusBound, enemyBound) 
end

function RZBangrenEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID ~= "die" and not self:getPauseOtherAnim() then
            self:doNextPlay()
        elseif movementID == "die" then 
            self:setDeadDone()
            local fightMode = md:getInstance("FightMode")
            fightMode:willFail({type = "renZhi"})        
        end 
    end
end

return RZBangrenEnemyView