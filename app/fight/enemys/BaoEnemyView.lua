
--[[--

“近战兵”的视图
1. property desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. ..
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseEnemyView = import(".BaseEnemyView")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local Hero = import("..Hero")
local BaoEnemyView = class("BaoEnemyView", BaseEnemyView)  

local kTimeStartAhead = 2.0

function BaoEnemyView:ctor(property)
	--instance
	BaoEnemyView.super.ctor(self, property) 
    self.hero = app:getInstance(Hero)
    self.property = property
    dump(self.property, "self.property")
    self.isAheading = false
    self.isAheaded = false

    local weakNode = self.armature:getBone("weak1"):getDisplayRenderNode()
    local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
    drawBoundingBox(self.armature, weakNode, "red") 
    drawBoundingBox(self.armature, bodyNode, "yellow")     
    --前进F
    local callFuncAhead = function ()
        self:play("ahead", handler(self, self.playAhead))
    end
    self.aheadScheduler = scheduler.performWithDelayGlobal(callFuncAhead, kTimeStartAhead)
end


function BaoEnemyView:playAhead()
    --前进
    self.isAheading = true
    self.armature:getAnimation():play("walk" , -1, 1) --
    local speed = 50
    local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
    dump(pWorld, "pWorld")
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
    --clear
    self:clearPlayCache()
    self.armature:stopAllActions()

    self.armature:getAnimation():play("die" ,-1 , 1)
end

function BaoEnemyView:tick(t)
    --change state
    if self.isAheading then return end

    --walk
    local walkRate = self.enemy:getWalkRate()
    randomSeed =  math.random(1, walkRate)
    if randomSeed > walkRate - 1 then 
        self:play("playWalk", handler(self, self.playWalk))
        return 
    end

end

function BaoEnemyView:animationEvent(armatureBack,movementType,movementID)   
    if movementType == ccs.MovementEventType.loopComplete then
        -- print("animationEvent id ", movementID)
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
            if self.isAheaded then
                --伤害hero
                self.enemy:hit(self.hero)
            else
                --伤害enemys
                print("成功摧毁")
                local destRect = self:getBaoRect()
                self.hero:dispatchEvent({name = Hero.ENEMY_ATTACK_MUTI_EVENT, 
                  damage = 600,
                  destRect = destRect})
            end
            self:setDeadDone()
            if self.aheadScheduler then
                scheduler.unscheduleGlobal(self.aheadScheduler)
            end
        end 
    end
end

function BaoEnemyView:getBaoRect()
    local pWorld = self.armature:convertToWorldSpace(cc.p(0,0))
    local bound = self.armature:getBoundingBox() 
    pWorld.y = pWorld.y + bound.height / 2 * self:getScale()  --获得中心位置
    dump(pWorld, "pWorld")

    --create 群伤范围和位置
    local rangeW = 200
    local rangeH = 300
    local pos = cc.p(pWorld.x - rangeW / 2 ,
                 pWorld.y - rangeH / 2)
    local rect = cc.rect(pos.x, pos.y, rangeW, rangeH)
    return rect
end

function BaoEnemyView:getEnemyArmature()
    if self.armature then return self.armature end 
    --armature
    local src = "Fight/enemys/anim_enemy_002/anim_enemy_002.ExportJson"
    local armature = getArmature("anim_enemy_002", src) 
    armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
    return armature
end
return BaoEnemyView