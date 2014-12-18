local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“我”的实体

]]

--import
local Actor         = import(".Actor")
local Gun           = import(".Gun")
local FightInlay    = import(".FightInlay")
local Hero          = class("Hero", Actor)

--events

--skill
Hero.SKILL_ARMOURED_START_EVENT   = "SKILL_ARMOURED_START_EVENT"    --机甲开启
Hero.SKILL_DEFENCE_START_EVENT    = "SKILL_DEFENCE_START_EVENT" --护盾开启
Hero.SKILL_DEFENCE_BEHURT_EVENT   = "SKILL_DEFENCE_BEHURT_EVENT" --护盾被攻击
Hero.SKILL_DEFENCE_RESUME_EVENT   = "SKILL_DEFENCE_RESUME_EVENT"  --护盾还原

Hero.SKILL_GRENADE_ARRIVE_EVENT   = "SKILL_GRENADE_ARRIVE_EVENT" --扔手雷结束
Hero.SKILL_GRENADE_START_EVENT    = "SKILL_GRENADE_START_EVENT"    --扔手雷开启

--enemy
Hero.ENEMY_ATTACK_MUTI_EVENT    = "ENEMY_ATTACK_MUTI_EVENT"   --群攻
Hero.ENEMY_KILL_ENEMY_EVENT     = "ENEMY_KILL_ENEMY_EVENT"  --杀死敌人      
Hero.ENEMY_KILL_HEAD_EVENT      = "ENEMY_KILL_HEAD_EVENT"   --爆头
Hero.ENEMY_ADD_EVENT            = "ENEMY_ADD_EVENT"
Hero.ENEMY_ADD_MISSILE_EVENT    = "ENEMY_ADD_MISSILE_EVENT"

--gun
Hero.GUN_RELOAD_EVENT           = "GUN_RELOAD_EVENT"             
Hero.GUN_CHANGE_EVENT           = "GUN_CHANGE_EVENT"
Hero.GUN_FIRE_EVENT             = "GUN_FIRE_EVENT"
Hero.GUN_SWITCH_JU_EVENT        = "GUN_SWITCH_JU_EVENT"

--map
Hero.MAP_ZOOM_OPEN_EVENT        = "MAP_ZOOM_OPEN_EVENT"
Hero.MAP_ZOOM_RESUME_EVENT      = "MAP_ZOOM_RESUME_EVENT"

--define
local kMaxHp          = 100
local kCritScale      = 3.0

function Hero:ctor(properties)
    --instance
    Hero.super.ctor(self, properties)
    self.fightInlay = app:getInstance(FightInlay)
    
    --init
    self.isGun1 = true
    self:setGun("bag1")

    --hp
    self:refreshHp()
end

--枪械相关
function Hero:changeGun()
    self.isGun1 = not self.isGun1
    local bagIndex = nil
    if self.isGun1 then 
        bagIndex = "bag1"
    else
        bagIndex = "bag2"
    end
    print("change gun bagIndex", bagIndex)
    self:setGun(bagIndex)
    self:dispatchEvent({name = Hero.GUN_CHANGE_EVENT, bagIndex = bagIndex})
end

function Hero:setGun(bagIndex)
    local gun = Gun.new({bagIndex = bagIndex}) 
    self.gun = gun
    self:setCooldown(gun:getCooldown())
end

function Hero:getGun()
    return self.gun
end

function Hero:getDemage()
    local baseDemage = self.gun:getDemage()
    local value = 0

    --inlay
    local scale, isInlayed = self.fightInlay:getInlayedValue("bullet")
    if isInlayed then
        value = baseDemage + baseDemage * scale
    else
        value = baseDemage
    end

    --crit
    local critNum = self.gun:getCritPercent() * 100
    -- print("critNum:", critNum)
    if critNum > math.random(0, 100) then 
        value = value * kCritScale
    end

    return value
end

function Hero:refreshHp()
    local valueHp = 0.0 
    local value, isInlayed = self.fightInlay:getInlayedValue("blood")
    if isInlayed then 
        valueHp = kMaxHp + kMaxHp * value
    else
        valueHp = kMaxHp
    end
    self:setMaxHp(valueHp)
    self:setHp(valueHp)
end

function Hero:activeGold()
    --check
    if self.fightInlay:getIsNativeGold() then return end

    --active
    self.fightInlay:activeGold()

    --hp
    self:refreshHp()

end

function Hero:activeGoldEnd()
    --check
    if self.fightInlay:getIsNativeGold() then return end    
    
    --active
    self.fightInlay:activeGoldEnd()

    --hp
    self:refreshHp()

end

function Hero:setMapZoom(scale)
    self.mapZoom = scale
end

function Hero:getMapZoom()
    return self.mapZoom or 1.0
end


return Hero