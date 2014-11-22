
--[[--

“伞兵”的视图
1. desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. 伞兵落地 换为enemyview
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local AbstractEnemyView = import(".AbstractEnemyView")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local JinEnemyView = class("JinEnemyView", AbstractEnemyView)  


function JinEnemyView:ctor(property)
	--instance
	JinEnemyView.super.ctor(self, property) 
    self.property = property
    
    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    --
    self:playStand()
    --test
    self:test()
end

function JinEnemyView:playStand()
    self.armature:getAnimation():play("stand" , -1, 1)  
end

function JinEnemyView:tick()
    -- if self.isFalling then 
    --     local enemy = self.armature:getBone("enemy"):getDisplayRenderNode()
    --     local pWorld = enemy:convertToWorldSpace(cc.p(0,0))

    --     local placeNode = self:getParent()
    --     local pWorld2 = placeNode:convertToWorldSpace(cc.p(0,0))
    --     if pWorld.y <= pWorld2.y then 
    --         self.isFalling = false
    --         self:stopFall()
    --     end
    -- end
end

function JinEnemyView:test()
	--body
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
    local enemyNode = self.armature:getBone("enemy"):getDisplayRenderNode()
	drawBoundingBox(self.armature, bodyNode, "yellow") 
    drawBoundingBox(self.armature, enemyNode, "red")
end

--AbstractEnemyView interface
function JinEnemyView:playHitted(event)
    -- print("JinEnemyView:playHitted")
end

function JinEnemyView:playKill(event)
    -- print("JinEnemyView:playKill") 
    self:setDeadDone()

    --屏幕动画
end

function JinEnemyView:onHitted(demage)
    if self.enemy:canHitted() then
        self.enemy:decreaseHp(demage)
    end    
end

function JinEnemyView:animationEvent(armatureBack,movementType,movementID)

end

function JinEnemyView:getEnemyArmature()
    if self.armature then return self.armature end 
    --armature
    local src = "Fight/enemys/anim_enemy_002/anim_enemy_002.ExportJson"
    local armature = getArmature("anim_enemy_002", src) 
    armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
    return armature
end

function JinEnemyView:getModel(property)
    return Enemy.new(property)
end

return JinEnemyView