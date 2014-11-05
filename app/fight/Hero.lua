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
    self:setMaxHp(1000)  
    Hero.super.ctor(self, properties)   
end



return Hero