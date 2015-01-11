
--[[--

“伞兵”的视图
1. desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. 伞兵落地 换为enemyview
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local JinbiEnemyView = class("JinbiEnemyView", Attackable)  


function JinbiEnemyView:ctor(property)
	--instance
	JinbiEnemyView.super.ctor(self, property) 
    self.isFlying = true
    self.property = property
    

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    --
    self:playFly()
    -- self:test()
end

function JinbiEnemyView:tick()
    if self.isFlying then 
        local enemy = self.armature:getBone("body1"):getDisplayRenderNode()
        local pWorld = enemy:convertToWorldSpace(cc.p(0,0))

        local placeNode = self:getParent()
        local pWorld2 = placeNode:convertToWorldSpace(cc.p(0,0))
        if pWorld.y >= display.height then 
            self.isFlying = false
            self:stopFly()
        end
    end
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

function JinbiEnemyView:test()
	--body
    -- local weak1 = self.armature:getBone("weak1"):getDisplayRenderNode()
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
    -- drawBoundingBox(self.armature, weak1, "red") 
	drawBoundingBox(self.armature, bodyNode, "yellow") 
end

function JinbiEnemyView:playKill(event)
    self.armature:getAnimation():play("die" , -1, 1)
    self.hero:dispatchEvent({
                name = self.hero.ENEMY_KILL_HEAD_EVENT})
    --屏幕动画
end

function JinbiEnemyView:playHitted(event)
    
end

function JinbiEnemyView:onHitted(targetData)
    local demage     = targetData.demage 
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType or "body"
    if self.enemy:canHitted() then
        self.enemy:decreaseHp(demage * scale)
    end
end

function JinbiEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementID ~= "die" then

    elseif movementID == "die" then 
        self:setDeadDone()
    end 
end

function JinbiEnemyView:getModel(property)
    return Enemy.new(property)
end

return JinbiEnemyView