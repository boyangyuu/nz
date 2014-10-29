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
    Hero.super.ctor(self, properties)

    self.gun = app:getInstance(Gun)
    local coolDown = self.gun:getCooldown()
    self:setCooldown(coolDown)
end

return Hero