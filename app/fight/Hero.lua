local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“我”的实体

]]

local Actor = import(".Actor")
local Hero = class("Hero", Actor)

function Hero:ctor(properties, events, callbacks)
    Hero.super.ctor(self, properties)
end

return Hero