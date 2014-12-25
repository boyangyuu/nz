
--[[--

“近战兵”的视图
1. property desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. ..
]]

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseEnemyView = import(".BaseEnemyView")
local BaoEnemyView = class("BaoEnemyView", BaseEnemyView)  
local kTimeStartAhead = 2.0

function BaoEnemyView:ctor(property)
	--instance
	BaoEnemyView.super.ctor(self, property) 
    self.hero = md:getInstance("Hero")
    self.property = property
    dump(self.property, "self.property")
    self.isAheading = false
    self.isAheaded = false

    --前进
    local callFuncAhead = function ()
        self:play("run", handler(self, self.playAhead))
    end
    -- local aheadScheduler = scheduler.performWithDelayGlobal(callFuncAhead, kTimeStartAhead)
    -- self:addScheduler(aheadScheduler)
end


function BaoEnemyView:playAhead()
    --前进
    self.isAheading = true
    self.armature:getAnimation():play("run" , -1, 1) --
    local speed = 50
    local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
    -- dump(pWorld, "pWorld")
    local desY = -20 --屏幕位置
    local distanceY = desY - pWorld.y
    local time = math.abs(distanceY) /speed
    local desPos = cc.p(0, distanceY)
    local actionAhead = cc.MoveBy:create(time, desPos)
    local scale = 1
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
    self:runAction(seq)

    self:runAction(actionScale)
end

function BaoEnemyView:playKill(event)
    self:playBombEffects()
    BaoEnemyView.super.playKill(self,event)
end

function BaoEnemyView:playBombEffects()
    for i=1,6 do
        local sch  = scheduler.performWithDelayGlobal(
            handler(self, self.playBombEffect), i * 0.1)
        local sch1 = scheduler.performWithDelayGlobal(
            handler(self, self.demageOthers), i * 0.1)
        self:addScheduler(sch)
        self:addScheduler(sch1)
    end
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
        if movementID ~= "die" then
            local playCache = self:getPlayCache()
            if self.isAheading then 
                self.armature:getAnimation():play("run" , -1, 1) 
                return 
            end
            if playCache then 
                playCache()
            else                    
                self:playStand()
            end
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