
--[[--

“伞兵”的视图
1. desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. 伞兵落地 换为enemyview
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local AbstractEnemyView = import(".AbstractEnemyView")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local SanEnemyView = class("SanEnemyView", AbstractEnemyView)  


function SanEnemyView:ctor(property)
	--instance
	SanEnemyView.super.ctor(self, property) 
    self.isFalling = true
    self.property = property
	dump(property, "property")
    
    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    --
    self:playFall() 

    --test
    self:test()

    self.enemy:setHp(1.0)
end


function SanEnemyView:tick()
    if self.isFalling then 
        local enemy = self.armature:getBone("enemy"):getDisplayRenderNode()
        local pWorld = enemy:convertToWorldSpace(cc.p(0,0))

        local placeNode = self:getParent()
        local pWorld2 = placeNode:convertToWorldSpace(cc.p(0,0))
        if pWorld.y <= pWorld2.y then 
            self.isFalling = false
            self:stopFall()
        end
    end
end

function SanEnemyView:playFall()
	--start
	self.armature:setPositionY(display.height)
	
    --action
	local speed = -2
	local action = cc.MoveBy:create(1/60, cc.p(0, speed))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))

    --play
    self.armature:getAnimation():play("fall" , -1, 1) 
end

function SanEnemyView:stopFall()
	--stop action
	self.armature:stopAllActions()
    self.armature:removeFromParent()
    self:setDeadDone()  

    -- 召唤
    local data = {
        placeName = self.property.placeName,
        pos = cc.p(self:getPositionX(), self:getPlaceBound().y),
        delay = 0,
        property = {
                id = self.property.enemyId,
                },
        }

    self.hero:dispatchEvent({name = "ENEMY_ADD", enemys = {data}})    
end


function SanEnemyView:test()
	--body
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
    local enemyNode = self.armature:getBone("enemy"):getDisplayRenderNode()
	drawBoundingBox(self.armature, bodyNode, "yellow") 
    drawBoundingBox(self.armature, enemyNode, "red")
end

--AbstractEnemyView interface
function SanEnemyView:playHitted(event)
    print("SanEnemyView:playHitted")
end

function SanEnemyView:playKill(event)
    print("SanEnemyView:playKill") 
    self:setDeadDone()

    --屏幕动画
end

function SanEnemyView:onHitted(demage)
    if self.enemy:canHitted() then
        self.enemy:decreaseHp(demage)
    end    
end

function SanEnemyView:animationEvent(armatureBack,movementType,movementID)

end

function SanEnemyView:getEnemyArmature()
    if self.armature then return self.armature end 
    --armature
    local src = "Fight/enemys/sanbing01/sanbing01.ExportJson"
    local armature = getArmature("sanbing01", src) 
    armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
    return armature
end

function SanEnemyView:getModel(id)
    return Enemy.new({id = id})
end

return SanEnemyView