
--[[--
“自爆兵”的视图
]]

local BaseEnemyView = import(".BaseEnemyView")
local BaoEnemyView = class("BaoEnemyView", BaseEnemyView)  

function BaoEnemyView:ctor(property)
	--instance
	BaoEnemyView.super.ctor(self, property) 
    self.hero = md:getInstance("Hero")
end

function BaoEnemyView:playStartState(state)
    if state == "san" then 
        self:playSan()
    else 
        self:playAhead()
    end
end

function BaoEnemyView:playSan()
    self:setPositionY(display.height1)
    self:setIsFlying(true)

    --action
    local speed = define.kBaoEnemySanSpeed 
    local destPosY = self:getPlaceNode():getPositionY()
    local distance = display.height - destPosY
    local time = distance / speed 
    local action = cc.MoveBy:create(time, cc.p(0, -distance))

    local function fallEnd()
        self:setIsFlying(false)
        self:restoreStand()
        self:playAhead()   
    end
    local seq = cc.Sequence:create(action, 
        cc.CallFunc:create(fallEnd))    
    self:runAction(seq)

    --play
    self.armature:getAnimation():play("jiangluo" , -1, 1) 

    self:setPauseOtherAnim(true) 
end

function BaoEnemyView:playAhead()
    --前进
    self.armature:getAnimation():play("walk" , -1, 1)
    local configEnemy = self.enemy:getConfig()
    local speed = configEnemy["speed"] or define.kBaoEnemyWalkSpeed
    local pWorldMap = self:getPosInMap()
    local distanceY = -pWorldMap.y + define.kJinEnemyWalkPos

    local time = math.abs(distanceY) / speed
    local desPos = cc.p(0, distanceY)
    local actionAhead = cc.MoveBy:create(time, desPos)
    local scale = configEnemy["scale"] or define.kBaoEnemyScale 
    local actionScale = cc.ScaleTo:create(time, scale)

    --
    local aheadEndFunc = function ()
        self:playAheadEnd()
    end
    local afterAhead = cc.CallFunc:create(aheadEndFunc)
    local seq = cc.Sequence:create(actionAhead, afterAhead)
    transition.execute(self, seq, {easing = "sineIn",})
    transition.execute(self, actionScale, {easing = "sineIn",})
    self:setPauseOtherAnim(true)
end

function BaoEnemyView:playKill(event)
    BaoEnemyView.super.playKill(self,event)
    self.armature:getAnimation():play("die" ,-1 , 1)
    self:playBombEffects()
end

function BaoEnemyView:playAheadEnd()
    print("BaoEnemyView:playAheadEnd()")
    self:playKill()  
    self.enemy:hit(self.hero)
end

function BaoEnemyView:playBombEffects()
    for i=1,3 do
        self:performWithDelay( handler(self, self.playBombEffect), i * 0.1)
    end 
end

function BaoEnemyView:playHitted(event)
    local currentName = self.armature:getAnimation():getCurrentMovementID()
    
    --飘红
    self:playHittedEffect()
end

function BaoEnemyView:tick(t)
end

function BaoEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID ~= "die" and not self:getPauseOtherAnim() then
            self:doNextPlay()
        elseif movementID == "die" then 
            self:setDeadDone()
        end 
    end
end

function BaoEnemyView:getBaoRect()
    local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
    local bound = self.armature:getBoundingBox() 
    pWorld.y = pWorld.y + bound.height / 2 * self:getScale()  --获得中心位置
    -- dump(pWorld, "pWorld")

    --create 群伤范围和位置
    local rangeW = define.kBaoRangeW * self:getScale()
    local rangeH = define.kBaoRangeH * self:getScale()
    local pos = cc.p(pWorld.x - rangeW / 2 ,
                 pWorld.y - rangeH / 2)
    local rect = cc.rect(pos.x, pos.y, rangeW, rangeH)
    return rect
end

return BaoEnemyView