
--[[--

“忍者兵”的视图
1. desc: a.发射攻击物品 ()
]]

local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local RenEnemyView = class("RenEnemyView", BaseEnemyView)  

function RenEnemyView:ctor(property)
    --instance
    RenEnemyView.super.ctor(self, property) 

    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    --
    self.isChongCd = false
end

---- state ----
function RenEnemyView:playStartState(state)
    if state == "runleft" then 
        self:playRunAction(-1, true)
    elseif state == "runright" then
        self:playRunAction(1, true)    
    else 
        self:playEnter()
    end
end

function RenEnemyView:onHitted(targetData)
    if self.isShaning then return end
    RenEnemyView.super.onHitted(self, targetData)
end

function RenEnemyView:tick()
    --change state
    if self.isShaning then return end
    --fire    
    local fireRate, isAble = self.enemy:getFireRate()
    if isAble then
        assert(fireRate > 1, "invalid fireRate")
        local randomSeed = math.random(1, fireRate)
        if randomSeed > fireRate - 1 then 
            self:play("skill", handler(self, self.playFire))
            self.enemy:beginFireCd()
        end
    end

    --闪
    local shanRate, isAble = self.enemy:getShanRate()
    if isAble then
        assert(shanRate > 1, "invalid shanRate")
        local randomSeed = math.random(1, shanRate)
        if randomSeed > shanRate - 1 then 
            self:play("skill", handler(self, self.playShan))
            self.enemy:beginShanCd()
        end
    end  

    --冲锋
    local config = self.enemy:getConfig()
    local chongRate, isAble = config["chongRate"], not self.isChongCd
    if isAble then
        assert(chongRate > 1, "invalid chongRate")
        local randomSeed = math.random(1, chongRate)
        if randomSeed > chongRate - 1 then 
            self:play("skill", handler(self, self.playChongfeng))
            self:beginChongCd()
        end
    end

    --walk
    local walkRate, isAble = self.enemy:getWalkRate()
    if isAble then
        assert(walkRate > 1, "invalid walkRate")
        local randomSeed = math.random(1, walkRate)
        if randomSeed > walkRate - 1 then 
            self:play("walk", handler(self, self.playWalk))
            self.enemy:beginWalkCd()
        end
    end

    --roll
    local rollRate, isAble = self.enemy:getRollRate()
    if isAble then
        assert(rollRate > 1, "invalid rollRate")
        local randomSeed = math.random(1, rollRate)
        if randomSeed > rollRate - 1 then 
            self:play("roll", handler(self, self.playRun))
            self.enemy:beginRollCd()
        end
    end 
end

function RenEnemyView:playKill(event)
    RenEnemyView.super.playKill(self, event)
    self.armature:getAnimation():play("die" ,-1 , 1)
end

function RenEnemyView:beginChongCd()
    self.isChongCd = true
    local config = self.enemy:getConfig()
    assert(config["chongCd"] , "config ChongCd is nil")
    local chongCd = config["ChongCd"] or 3.0
    local function resumeCd()
        self.isChongCd = false
    end
    self:performWithDelay(resumeCd, chongCd)
end

function RenEnemyView:playEnter()
    self.armature:getAnimation():play("fenshenru" , -1, 1)
end

function RenEnemyView:playFire()
    --导弹
    self.armature:getAnimation():play("fire" , -1, 1) 

    -- print("发射")
    local boneDao = self.armature:getBone("dao1"):getDisplayRenderNode()
    local pWorldBone = boneDao:convertToWorldSpace(cc.p(0, 0))
    local property = {
        srcPos = pWorldBone,
        srcScale = self:getScale() * 0.3,
        destPos = pWorldBone,
        destScale = 1.2,
        type = "missile",
        id = self.property["missileId"], 
        level = self.property["missileLevel"],
        demageScale = self.enemy:getDemageScale(),
        missileType = "feibiao",
    }
    local function callfuncDaoDan()
         self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, property = property})
    end
    self:performWithDelay(callfuncDaoDan, 0.8)   
end

function RenEnemyView:playChongfeng()
    self.armature:getAnimation():play("chongfeng", -1, 1)
    
    --前进
    local speed = 400
    local desY = -0
    local scaleSrc = self:getScaleX()

    local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
    -- dump(pWorld, "pWorld")
    local posOri = cc.p(self:getPositionX(), self:getPositionY())
    
    local distanceY = desY - pWorld.y
    local time = math.abs(distanceY) /speed
    local desPos = cc.p(0, distanceY)
    local actionAhead = cc.MoveBy:create(time, desPos)
    local actionScale = cc.ScaleTo:create(time, scaleSrc * 2)

    --
    local aheadEndFunc = function ()
        --demage
        local config = self.enemy:getConfig()
        local destDemage = config["demage"] 
            * self.enemy:getDemageScale()
        self.enemy:hit(self.hero, destDemage)
        self:setPosition(posOri)
        self:scaleTo(0.01, scaleSrc)
        local map = md:getInstance("Map")
        map:playEffect("shake")
        self:restoreStand()
    end
    local afterAhead = cc.CallFunc:create(aheadEndFunc)
    self:setPauseOtherAnim(true)
    self:runAction(cc.Sequence:create(actionAhead, afterAhead))
    self:runAction(actionScale) 
end

function RenEnemyView:playWalk()
    local randomSeed = math.random(1, 2)
    local isRun = false
    if randomSeed == 1 then 
        self:playRunAction(1, isRun)
    else
        self:playRunAction(-1, isRun)
    end
end

function RenEnemyView:playRun()
    local randomSeed = math.random(1, 2)
    local isRun = true
    if randomSeed == 1 then 
        self:playRunAction(1, isRun)
    else
        self:playRunAction(-1, isRun)
    end
end

function RenEnemyView:playShan()
    local randomSeed = math.random(1, 2)
    local isLeft = randomSeed == 1 and -1 or 1 
    local offset =  math.random(define.kRenzheShanOffsetMin , 
                            define.kRenzheShanOffsetMax)   
                         * self:getScale() * isLeft
    if not self:checkPlace(offset) then 
        return 
    end 
    --
    self.armature:getAnimation():play("shanchu" , -1, 1) 
    self.isShaning = true

    --callfunc
    local function shanru()
        self:setVisible(true)
        self:setPositionX(self:getPositionX() +  offset)
        self.armature:getAnimation():play("shanru" , -1, 1) 
        self.isShaning = false
    end
    self:performWithDelay(shanru, define.kRenzheShanTime)
end

function RenEnemyView:playRunAction(direct, isRun)
    local speed = isRun and define.kRenzheSpeed  or define.kRenzheWalkSpeed
    local time = isRoll and define.kRenzheRunTime or define.kRenzheWalkTime

    local width = speed * time * self:getScale() * direct
    if not self:checkPlace(width) then 
        return 
    end
    
    local animName 
    if isRun then 
        animName = direct == 1 and "runright" or "runleft"
    else
        animName = "walk"
    end

    self.armature:getAnimation():play(animName , -1, 1) 
    local action = cc.MoveBy:create(time, cc.p(width, 0))
    self:setPauseOtherAnim(true)
    self:runAction(cc.Sequence:create(action, 
        cc.CallFunc:create(handler(self, self.restoreStand))
        ))  
end

--Attackable interface
function RenEnemyView:playHitted(event)
    --飘红
    self:playHittedEffect()
end

function RenEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete 
        or  movementType == ccs.MovementEventType.complete   then
        -- print("animationEvent id ", movementID)
        if self:getPauseOtherAnim() and movementID ~= "die" then
            return 
        end        
        armatureBack:stopAllActions()
        armatureBack:getAnimation():stop()
        if movementID == "shanchu" then 
            self:setVisible(false)
            return
        elseif movementID == "die" then
            self:setDeadDone()
            return
        else
            self:doNextPlay()
        end 
    end
end

return RenEnemyView