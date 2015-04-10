
--[[--

“近战兵”的视图
1. property desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. ..
]]

local BaseEnemyView = import(".BaseEnemyView")
local JinEnemyView = class("JinEnemyView", BaseEnemyView)  

function JinEnemyView:ctor(property)
	--instance
	JinEnemyView.super.ctor(self, property) 
end

function JinEnemyView:playStartState(state)
    if state == "san" then 
        self:playSan()
    else 
        self:playAhead()
    end
end

function JinEnemyView:playSan()
    self:setPositionY(display.height1)

    --action
    local speed = define.kJinEnemySanSpeed 
    local destPosY = self:getPlaceNode():getPositionY()
    local distance = display.height - destPosY
    local time = distance / speed 
    local action = cc.MoveBy:create(time, cc.p(0, -distance))

    local function fallEnd()
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

function JinEnemyView:playAhead()
    --前进
    self.armature:getAnimation():play("walk" , -1, 1) --
    local configEnemy = self.enemy:getConfig()
    local speed = configEnemy["speed"] or define.kJinEnemyWalkSpeed 
    local pWorldMap = self:getPosInMap()
    local distanceY = -pWorldMap.y + define.kJinEnemyWalkPos
    local time = math.abs(distanceY) / speed
    local desPos = cc.p(0, distanceY)
    local actionAhead = cc.MoveBy:create(time, desPos)
    local scale = configEnemy["scale"] or  define.kJinEnemyScale
    local actionScale = cc.ScaleTo:create(time, scale)

    --
    local aheadEndFunc = function ()
        --改为呼吸
        self:restoreStand()
    end
    local afterAhead = cc.CallFunc:create(aheadEndFunc)
    local seq = cc.Sequence:create(actionAhead, afterAhead)
    transition.execute(self, seq, {easing = "sineIn",})
    transition.execute(self, actionScale, {easing = "sineIn",})
    self:setPauseOtherAnim(true)
end

function JinEnemyView:tick(t)
    --fire
    local fireRate, isAble = self.enemy:getFireRate()
    assert(fireRate > 1, "invalid fireRate")
    if isAble then 
        randomSeed = math.random(1, fireRate)
        if randomSeed > fireRate - 1 then 
            self:playAfterAlert("skill", handler(self, self.playAttack))
            self.enemy:beginFireCd()
        end
    end    
end

function JinEnemyView:onEnter()
    JinEnemyView.super.onEnter(self)
end

function JinEnemyView:playKill(event)
    JinEnemyView.super.playKill(self, event)
    self.armature:getAnimation():play("die" ,-1 , 1)

    --sound
    local soundSrc  = "res/Music/fight/die02.wav"
    self.audioId =  audio.playSound(soundSrc,false) 
end

function JinEnemyView:playAttack()
    self.armature:getAnimation():play("attack" , -1, 1)
    self.enemy:hit(self.hero)
end

function JinEnemyView:playHitted(event)  
    self:playHittedEffect()
end

function JinEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID ~= "die" and not self:getPauseOtherAnim() then
            self:doNextPlay()
        elseif movementID == "die" then 
            self:setDeadDone()
        end 
    end
end

return JinEnemyView