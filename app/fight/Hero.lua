local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“我”的实体

]]

--import
local Actor         = import(".Actor")
local Gun           = import(".Gun")
local InlayModel    = import("..Inlay.InlayModel")
local Hero          = class("Hero", Actor)

--events

--inlay
Hero.INLAY_UPDATE_EVENT           = "INLAY_UPDATE_EVENT"

--skill
Hero.SKILL_ARMOURED_START_EVENT   = "SKILL_ARMOURED_START_EVENT"    --机甲开启
Hero.SKILL_DEFENCE_START_EVENT    = "SKILL_DEFENCE_START_EVENT" --护盾开启
Hero.SKILL_DEFENCE_BEHURT_EVENT   = "SKILL_DEFENCE_BEHURT_EVENT" --护盾被攻击
Hero.SKILL_DEFENCE_RESUME_EVENT   = "SKILL_DEFENCE_RESUME_EVENT"  --护盾还原

Hero.SKILL_GRENADE_ARRIVE_EVENT   = "SKILL_GRENADE_ARRIVE_EVENT" --扔手雷结束
Hero.SKILL_GRENADE_START_EVENT    = "SKILL_GRENADE_START_EVENT"    --扔手雷开启

Hero.SKILL_GOLDWEAPON_ACTIVE_EVENT = "SKILL_GOLDWEAPON_ACTIVE_EVENT" --激活黄金武器（同时刷新血量上限）

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

function Hero:ctor(properties)
    --instance
    Hero.super.ctor(self, properties)
    self.inlayModel = app:getInstance(InlayModel) 

    --init
    self:refreshData({gunId1 = 1, gunId2 = 2}) 
end

--data
function Hero:refreshData(properties)
    --gun
    self.gunId1 = properties.gunId1
    self.gunId2 = properties.gunId2

    self.isGun1 = true 
    self:setGun(self.gunId1)  

    --hp
    self:refreshHp()

    --inlay
    --..   
end

--枪械相关
function Hero:changeGun()
    self.isGun1 = not self.isGun1
    local destGunId = nil
    if self.isGun1 then 
        destGunId = self.gunId1
    else
        destGunId = self.gunId2
    end
    print("destGunId", destGunId)
    self:setGun(destGunId)
    self:dispatchEvent({name = Hero.GUN_CHANGE_EVENT, gunId = destGunId})
end

function Hero:setGun(gunId)
    local gun = Gun.new({id = tostring(gunId)}) 
    self.gun = gun
    self:setCooldown(gun:getCooldown())
end

function Hero:getGun()
    return self.gun
end

function Hero:getDemage()
    local baseDemage = self.gun:getDemage()
    local value = 0
    local scale, isInlayed = self:getInlayedValue("bullet")
    if isInlayed then
        value = baseDemage + baseDemage * scale
    else
        value = baseDemage
    end
    return value
end

function Hero:refreshHp()
    local valueHp = 0.0 
    local value, isInlayed = self:getInlayedValue("blood")
    if isInlayed then 
        valueHp = kMaxHp + kMaxHp * value
    else
        valueHp = kMaxHp
    end
    self:setMaxHp(valueHp)
    self:setHp(valueHp)
end

function Hero:setMapZoom(scale)
    self.mapZoom = scale
end

function Hero:getMapZoom()
    return self.mapZoom or 1.0
end

--[[
    @param type：crit blood bullet clip helper speed 
    return: 镶嵌id
]]
function Hero:getInlayedValue(type)
    --id
    local inlays = self.inlayModel:getAllInlayed()
    -- dump(inlays, "inlays")
    -- print("type", type)
    local inlayedId  = inlays[type]
    if inlayedId == nil then return nil,false end
    local record = getRecordByKey("config/items_xq.json", "id", inlayedId)
    local value = record[1].valueProgram
    print("Hero:getInlayedValue value:", value)
    return value, true
end 

return Hero