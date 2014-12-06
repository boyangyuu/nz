local FightPlayer = import("..fight.FightPlayer")
local GuideLayer = import("..guide.GuideLayer")
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    -- local homeBarLayer = HomeBarLayer.new()
    -- self:addChild(homeBarLayer)
    local fightPlayer = FightPlayer.new()  --todo 战斗 homebar 等都放在commentNode上
    self:addChild(fightPlayer)

	local popupCommonLayer = app:getInstance(PopupCommonLayer)
    self:addChild(popupCommonLayer, 200)

    --guide
    local guideLayer = GuideLayer:new()
    self:addChild(guideLayer, 300)

 --    popupCommonLayer:loadAllImg()
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
