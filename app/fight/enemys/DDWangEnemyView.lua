
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

local Attackable = import(".Attackable")
local Enemy = import(".Enemy")
local Hero = import("..Hero")
local Actor = import("..Actor")   

local DDWangEnemyView = class("DDWangEnemyView", Attackable)

---- event ----
function DDWangEnemyView:ctor(property)  
    --instance
    DDWangEnemyView.super.ctor(self, property)   
    self.srcPos = property.srcPos
    self.destPos = property.destPos
    self.srcScale = property.srcScale

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    self:playFire() 
end

function DDWangEnemyView:tick()
    
end

function DDWangEnemyView:playFire()
    --scale
    self.armature:setScale(self.srcScale)
    local time = define.kMissileWangTime    
    local destScale = 1.3
    local scaleAction = cc.ScaleTo:create(time, destScale)

    --call end
    local function callMoveEnd()
        self.armature:getAnimation():play("stand", -1 , 1)
        self:playSkillHit()        
    end

    --run
    self.armature:getAnimation():play("fly" , -1, 1) 
    local seq = cc.Sequence:create(scaleAction, cc.CallFunc:create(callMoveEnd))
    self.armature:runAction(seq)
end

function DDWangEnemyView:playSkillHit()
	local function callfuncHit()
		self.enemy:hit(self.hero) 
	end  
	self:schedule(callfuncHit, define.kMissileWangHitTime)
end

--Attackable接口
function DDWangEnemyView:playHitted(event)
	self:playHittedEffect()
end

function DDWangEnemyView:playKill(event)
    DDWangEnemyView.super.playKill(self, event)    
    self.armature:getAnimation():play("die" , -1, 1)
end

function DDWangEnemyView:onHitted(targetData)
    local demage     = targetData.demage
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType or "body"
    if not self.enemy:canHitted() then return end
    self.enemy:decreaseHp(demage * scale)
end

function DDWangEnemyView:animationEvent(armatureBack,movementType,movementID)
    -- print("animationEvent id ", movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        if movementID ~= "die" and movementID ~= "die02" then
        else
            self:setWillRemoved()
        end
    end
end

function DDWangEnemyView:getModel(property)
    return Enemy.new(property)
end

return DDWangEnemyView