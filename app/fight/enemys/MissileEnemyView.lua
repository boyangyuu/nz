
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

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
end

function MissileEnemyView:tick()
    
end

function MissileEnemyView:playFire()
    local missileType = self.property["missileType"] or "daodan"
    
    if missileType == "daodan" or missileType == "tie" then 
        self:playDaoDanFire()
    elseif missileType == "lei" then
        self:playLeiFire()
    elseif missileType == "feibiao" then
        self:playFeibiaoFire()        
    else 
        assert(false, "invalid missileType"..missileType)
    end 
end

function MissileEnemyView:playDaoDanFire()
    --scale
    self.armature:setScale(self.srcScale)
    local time = define.kMissileDaoTime    
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
    self.armature:runAction(seq)
    self.armature:runAction(cc.MoveTo:create(time, offset))
end

function MissileEnemyView:playLeiFire()
    self.armature:getAnimation():play("fire" , -1, 1)  
    local srcPos = self.property["srcPos"]
    local destPos = cc.p(srcPos.x - 90, 20)
    local jumpTime = define.kMissileLeiTime
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

function MissileEnemyView:playFeibiaoFire()
    --scale
    self.armature:setScale(self.srcScale)
    local time = define.kMissileFeibiaTime    
    local destScale = define.kMissileFeibiaScale 
    local scaleAction = cc.ScaleTo:create(time, destScale)

    --call end
    local function callMoveEnd()
        self.armature:getAnimation():play("die02", -1 , 1 )
        self.enemy:hit(self.hero) 
        self:playSound()          
    end

    --run
    local offset = self.property.offset or cc.p(0.0,0.0)
    self.armature:getAnimation():play("fire" , -1, 1) 
    local seq = cc.Sequence:create(scaleAction, cc.CallFunc:create(callMoveEnd))
    self.armature:runAction(seq)
    self.armature:runAction(cc.MoveTo:create(time, offset))
end

function MissileEnemyView:playBomb()
    local missileType = self.property["missileType"]

    --sound
    self:playSound()

    --kill
    self.armature:getAnimation():play("die" , -1, 1)  
    
    --bomb动画
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
    --bomb动画
    self.armature:getAnimation():play("die" , -1, 1)
    
    local missileType = self.property["missileType"]
    if missileType == "tie" or missileType == "lei" then
        self:playBombEffect()
    else

    end     
    self.armature:stopAllActions()  
end

function MissileEnemyView:playSound()
    --sound effect
    local soundSrc  = "res/Music/fight/hd_bz.wav"
    self.audioId1 =  audio.playSound(soundSrc,false)  
end

function MissileEnemyView:onHitted(targetData)
    local demage     = targetData.demage
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType or "body"
    if not self.enemy:canHitted() then return end
    self.enemy:decreaseHp(demage * scale)
end

function MissileEnemyView:animationEvent(armatureBack,movementType,movementID)
    -- print("animationEvent id ", movementID)
    if movementType == ccs.MovementEventType.loopComplete then

        if movementID ~= "die" and movementID ~= "die02" then
            local playCache = self:getPlayCache()
            if playCache then 
                playCache()
            end
        else
             self:setWillRemoved()
        end
    end
end

function MissileEnemyView:getModel(property)
    return Enemy.new(property)
end

return MissileEnemyView