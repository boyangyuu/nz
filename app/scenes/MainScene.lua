
local FightPlayer = import("..fight.FightPlayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
--    cc.ui.UILabel.new({
--            UILabelType = 2, text = "Hello, World12w1323", size = 64})
--        :align(display.CENTER, display.cx, display.cy)
--        :addTo(self)
    cc.ui.UILabel.new({
    
            text = "-- 122" .. " --", size = 24, color = display.COLOR_WHITE})
        :align(display.CENTER, display.cx, display.top - 20)
        :addTo(self, 1000)
    --todo
    local FightPlayer = FightPlayer.new()
    self:addChild(FightPlayer)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
