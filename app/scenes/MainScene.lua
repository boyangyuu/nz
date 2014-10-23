
local FightLayer = import("..fight.FightLayer")
local LevelMapLayer_1 = import("..levelMap.LevelMapLayer_1")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
--    cc.ui.UILabel.new({
--            UILabelType = 2, text = "Hello, World12w1323", size = 64})
--        :align(display.CENTER, display.cx, display.cy)
--        :addTo(self)
    -- cc.ui.UILabel.new({
    
    --         text = "-- 122" .. " --", size = 24, color = display.COLOR_WHITE})
    --     :align(display.CENTER, display.cx, display.top - 20)
    --     :addTo(self, 1000)
    
    --todo
    -- local fightLayer = FightLayer.new()
    -- self:addChild(fightLayer)

    --to levelMapLayer
    local levelMapLayer_1 = LevelMapLayer_1.new()
    self:addChild(levelMapLayer_1)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
