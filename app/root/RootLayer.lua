local FightPlayer = import("..fight.FightPlayer")
local HomeBarLayer = import("..homeBar.HomeBarLayer")

local LayerColor_BLACK = cc.c4b(0, 122, 44, 0)

local RootLayer = class("RootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RootLayer:ctor()
    --root
    local fightPlayer = FightPlayer.new()  --todo 战斗 homebar 等都放在commentNode上
    fightPlayer:setPositionY(display.offset)
    self:addChild(fightPlayer)	
end

return RootLayer