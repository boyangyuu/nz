local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“敵人”的实体

]]

local Actor = import(".Actor")
local Enemy = class("Enemy", Actor)

function Enemy:ctor(properties, events, callbacks)
    Enemy.super.ctor(self, properties)
end
return Enemy