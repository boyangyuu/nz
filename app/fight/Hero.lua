local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“我”的实体

]]

--import
local Actor = import(".Actor")
local Gun = import(".Gun")
local Hero = class("Hero", Actor)

--events

--skill
Hero.SKILL_ARMOURED_START_EVENT   = "SKILL_ARMOURED_START_EVENT"    --机甲开启

Hero.SKILL_DEFENCE_START_EVENT    = "SKILL_DEFENCE_START_EVENT" --护盾开启
Hero.SKILL_DEFENCE_BEHURT_EVENT   = "SKILL_DEFENCE_BEHURT_EVENT" --护盾被攻击
Hero.SKILL_DEFENCE_RESUME_EVENT   = "SKILL_DEFENCE_RESUME_EVENT"  --护盾还原?

Hero.SKILL_GRENADE_ARRIVE_EVENT = "SKILL_GRENADE_ARRIVE_EVENT" --扔手雷结束
Hero.SKILL_GRENADE_START_EVENT = "SKILL_GRENADE_START_EVENT"    --扔手雷开启

Hero.SKILL_GOLDWEAPON_ACTIVE_EVENT= "SKILL_GOLDWEAPON_ACTIVE_EVENT" --激活黄金武器


--enemy
Hero.ENEMY_ATTACK_MUTI_EVENT      = "ENEMY_ATTACK_MUTI_EVENT"   --群攻
Hero.ENEMY_KILL_ENEMY_EVENT   = "ENEMY_KILL_ENEMY_EVENT"  --杀死敌人      


function Hero:ctor(properties, events, callbacks)
    --instance
    local property = {
    	id = "hero",
    	maxHp = 100000,
    	demage = 30,
	}
    Hero.super.ctor(self, property)
    self.gun = app:getInstance(Gun)

    --property
    local coolDown = self.gun:getCooldown() + 0.01
    -- print("--------------------------")
    -- print("coolDown", coolDown)
    self:setCooldown(coolDown)

    self:setDemage(30)
    self:setMaxHp(100000)  
    Hero.super.ctor(self, properties)   

end

function Hero:setGroupId()
    
end

function Hero:getGroupId()
    return 1
end

function Hero:setLevelId()
    
end

function Hero:getLevelId()
    return 2
end

function Hero:BeHurt(event)

end

return Hero