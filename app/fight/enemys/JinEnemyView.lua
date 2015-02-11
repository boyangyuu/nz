
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
    -- dump(self.property, "self.property")
    self.isAheading = false
    self.attackHandler = nil
    self.aheadHandler = nil
    
    --前进
    local callFuncAhead = function ()
        self:play("ahead", handler(self, self.playAhead))
    end
    local aheadHandler = scheduler.performWithDelayGlobal(callFuncAhead, kTimeStartAhead)
    self:addScheduler(aheadHandler)

end

function JinEnemyView:tick(t)
    --change state
    if self.isAheading then return end

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

function JinEnemyView:playKill(event)
    JinEnemyView.super.playKill(self,event)

    --sound
    local soundSrc  = "res/Music/fight/die02.wav"
    self.audioId =  audio.playSound(soundSrc,false) 
end

function JinEnemyView:playAttack()
    self.armature:getAnimation():play("attack" , -1, 1)
    self.enemy:hit(self.hero)
end

function JinEnemyView:playHitted(event)
    -- if self.isAheading then
    self:playHittedEffect()
    -- else
    --     JinEnemyView.super.playHitted(self, event)
    -- end
end

function JinEnemyView:playAhead()
    --前进
    self.isAheading = true
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
         self.isAheading = false

        --改为呼吸
        self.armature:getAnimation():play("stand" , -1, 1) 
    end
    local afterAhead = cc.CallFunc:create(aheadEndFunc)
    local seq = cc.Sequence:create(actionAhead, afterAhead)
    transition.execute(self, seq, {easing = "sineIn",})
    transition.execute(self, actionScale, {easing = "sineIn",})
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
            -- print("self:setDeadDone()") 
            self:setDeadDone()          
        end 
    end
end

return JinEnemyView