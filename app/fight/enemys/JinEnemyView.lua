
--[[--

“近战兵”的视图
1. property desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. ..
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseEnemyView = import(".BaseEnemyView")
local JinEnemyView = class("JinEnemyView", BaseEnemyView)  

local kAttackOffset = 2.0
local kTimeStartAhead = 2.0

function JinEnemyView:ctor(property)
	--instance
	JinEnemyView.super.ctor(self, property) 
    self.property = property
    dump(self.property, "self.property")
    self.isAheading = false
    self.attackHandler = nil
    self.aheadHandler = nil
    
    --前进
    local callFuncAhead = function ()
        self:play("ahead", handler(self, self.playAhead))
    end
    local aheadHandler = scheduler.performWithDelayGlobal(callFuncAhead, kTimeStartAhead)
    self:addScheduler(aheadHandler)
    
    --test
    self:test()
end

function JinEnemyView:playAttack()
    self.armature:getAnimation():play("attack" , -1, 1)
    self.enemy:hit(self.hero)
end

function JinEnemyView:playHitted(event)
    if not self.enemy:isDead() then
        print(self:playHittedEffect())
        self:playHittedEffect()
    end
end

function JinEnemyView:playAhead()
    --前进
    self.isAheading = true
    self.armature:getAnimation():play("walk" , -1, 1) --
    local speed = 60
    local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
    dump(pWorld, "pWorld")
    local desY = -180
    local distanceY = desY - pWorld.y
    local time = math.abs(distanceY) /speed
    local desPos = cc.p(0, distanceY)
    local actionAhead = cc.MoveBy:create(time, desPos)
    local scale = 1.8
    local actionScale = cc.ScaleTo:create(time, scale)

    --
    local aheadEndFunc = function ()
        print("aheadEnd")
         self.isAheading = false

        --改为呼吸
        self.armature:getAnimation():play("stand" , -1, 1) 
        
        --2秒一攻击
        function attack()
            self:play("fire", handler(self, self.playAttack))
        end
        local attackHandler = scheduler.scheduleGlobal(attack, kAttackOffset)
        self:addScheduler(attackHandler)
    end
    local afterAhead = cc.CallFunc:create(aheadEndFunc)
    local seq = cc.Sequence:create(actionAhead, afterAhead)
    self:runAction(seq)

    self:runAction(actionScale)
end

function JinEnemyView:tick(t)
    --change state
    if self.isAheading then return end
end

function JinEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID ~= "die" then
            local playCache = self:getPlayCache()
            if self.isAheading then 
                self.armature:getAnimation():play("walk" , -1, 1)
                return 
            end

            if playCache then 
                playCache()
            else                    
                self:playStand()
            end
        elseif movementID == "die" then
            print("self:setDeadDone()") 
            self:setDeadDone()          
        end 
    end
end

function JinEnemyView:test()
    --body
    -- local weakNode = self.armature:getBone("weak1"):getDisplayRenderNode()
    -- local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
    -- drawBoundingBox(self.armature, weakNode, "red") 
    -- drawBoundingBox(self.armature, bodyNode, "yellow") 
end

return JinEnemyView