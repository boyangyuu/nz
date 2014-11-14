local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“我”的实体

]]

--import
local Actor = import(".Actor")
local Gun = import(".Gun")
local Hero = class("Hero", Actor)

--events

function Hero:ctor(properties, events, callbacks)
    --instance
    self.gun = app:getInstance(Gun)
    
    --property
    local coolDown = self.gun:getCooldown()
    self:setCooldown(coolDown)
    self:setDemage(30)
    self:setMaxHp(10000)  
    Hero.super.ctor(self, properties)   
end

function Hero:win()
    print("Hero:win()")
    self:dispatchEvent({name = "win"})
end

function Hero:onKill_()
    print(" Hero:onKill_()")
    self:dispatchEvent({name = "failed"})
end

return Hero