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
Hero.SKILL_ARMOURED_EVENT   = "SKILL_ARMOURED_EVENT"
Hero.SKILL_DEFENCE_EVENT    = "SKILL_DEFENCE_EVENT"
Hero.BEHURT_DEFENCE_EVENT 	= "BEHURT_DEFENCE_EVENT"
Hero.RESUME_DEFENCE_EVENT   = "RESUME_DEFENCE_EVENT"

--enemy
Hero.ENEMY_KILL_EVENT   = "ENEMY_KILL_EVENT"
Hero.GRENADE_ARRIVE_EVENT = "GRENADE_ARRIVE_EVENT"

function Hero:ctor(properties, events, callbacks)
    --instance
    local property = {
    	id = "hero",
    	maxHp = 1000000,
    	demage = 10,
	}
    Hero.super.ctor(self, property)       
    self.gun = app:getInstance(Gun)

    --property
    local coolDown = self.gun:getCooldown() + 0.01
    print("--------------------------")
    print("coolDown", coolDown)
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
    return 5
end

function Hero:BeHurt(event)

	-- body
end


return Hero