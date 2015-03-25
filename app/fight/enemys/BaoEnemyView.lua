
--[[--

“自爆兵”的视图
1. property desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. ..
]]

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseEnemyView = import(".BaseEnemyView")
local BaoEnemyView = class("BaoEnemyView", BaseEnemyView)  

function BaoEnemyView:ctor(property)
	--instance
	BaoEnemyView.super.ctor(self, property) 
    self.hero = md:getInstance("Hero")
    self.isAheading = false
    self.isAheaded = false

    --前进
    local callFuncAhead = function ()
        self:play("walk", handler(self, self.playAhead))
    end
    local aheadScheduler = scheduler.performWithDelayGlobal(callFuncAhead, define.kBaoEnemyTimeStart)
    self:addScheduler(aheadScheduler)
end

function BaoEnemyView:playAhead()
    --前进
    self.isAheading = true
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
        print("aheadEnd")
         self.isAheading = false
         self.isAheaded  = true
        --自爆攻击
        self:playKill()
    end
    local afterAhead = cc.CallFunc:create(aheadEndFunc)
    local seq = cc.Sequence:create(actionAhead, afterAhead)
    transition.execute(self, seq, {easing = "sineIn",})
    transition.execute(self, actionScale, {easing = "sineIn",})
end

function BaoEnemyView:playKill(event)
    BaoEnemyView.super.playKill(self,event)
    self.armature:getAnimation():play("die" ,-1 , 1)
    self:playBombEffects()
end

function BaoEnemyView:playBombEffects()
    for i=1,3 do
        local sch  = scheduler.performWithDelayGlobal(
            handler(self, self.playBombEffect), i * 0.1)
        self:addScheduler(sch)
    end
    local sch1 = scheduler.performWithDelayGlobal(
        handler(self, self.demageOthers), 0.3)
    
    self:addScheduler(sch1)    
end

function BaoEnemyView:playHitted(event)
    local currentName = self.armature:getAnimation():getCurrentMovementID()
    
    --飘红
    self:playHittedEffect()
end

function BaoEnemyView:tick(t)
    --change state
    if self.isAheading then return end
end

function BaoEnemyView:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        -- print("animationEvent id ", movementID)
        armatureBack:stopAllActions()
        if movementID ~= "die" and not self:getPauseOtherAnim() then

            if self.isAheading then 
                self.armature:getAnimation():play("walk" , -1, 1) 
                return 
            end
            self:doNextPlay()   
        elseif movementID == "die" then 
            self:setDeadDone()
        end 
    end
end

function BaoEnemyView:demageOthers()
    if self.isAheaded then
        --伤害hero
        self.enemy:hit(self.hero)
    else
        --伤害enemys
        print("成功摧毁")
        local destRect = self:getBaoRect()
        local targetData = {demage = define.kBaoDemageOtherEnemys, 
                            demageScale = 1, 
                            demageType = "bao",
                            }
        self.hero:dispatchEvent({name = self.hero.ENEMY_ATTACK_MUTI_EVENT, 
          targetData = targetData,destRect = destRect}) 
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