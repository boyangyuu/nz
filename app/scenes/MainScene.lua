local FightPlayer = import("..fight.FightPlayer")
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local homeBarLayer = HomeBarLayer.new()
    self:addChild(homeBarLayer)
    local FightPlayer = FightPlayer.new()
    self:addChild(FightPlayer)
    -- local DetailLayer=LevelDetailLayer.new()
    -- self:addChild(DetailLayer)

	-- local popupCommonLayer = app:getInstance(PopupCommonLayer)
 --    self:addChild(popupCommonLayer, 200)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
