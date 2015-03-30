
--[[--

“伞兵”的视图
1. desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. 伞兵落地 换为enemyview
]]

local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local JinbiEnemyView = class("JinbiEnemyView", Attackable)  


function JinbiEnemyView:ctor(property)
	--instance
	JinbiEnemyView.super.ctor(self, property) 
    self.isFlying = true
    

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    --
    self:playFly()
end

function JinbiEnemyView:tick()

end

function JinbiEnemyView:playFly()
	--start
	
    --action
    local scale = self.property["speed"]
	local speed = scale * 60
	local action = cc.MoveBy:create(1, cc.p(0, speed))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))

    --play
    self.armature:getAnimation():play("fly" , -1, 1) 
end

function JinbiEnemyView:stopFly()
    self:setWillRemoved()
end

function JinbiEnemyView:playKill(event)
    JinbiEnemyView.super.playKill(self, event)    
    self.armature:getAnimation():play("die" , -1, 1)
    self.isFlying  = false
end

function JinbiEnemyView:playHitted(event)
    
end

function JinbiEnemyView:onHitted(targetData)
    local demage     = targetData.demage 
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType or "body"
    if not self.enemy:canHitted() then return end
    self.enemy:decreaseHp(demage * scale)
end

function JinbiEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        if movementID ~= "die" then

        elseif movementID == "die" then
            print("elseif movementID == die then") 
            self:setDeadDone()
        end 
    end
end

function JinbiEnemyView:getModel(property)
    return Enemy.new(property)
end

return JinbiEnemyView