

local FightPlayer = import("..fight.FightPlayer")
local LevelMapLayer = import("..levelMap.LevelMapLayer")
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local levelMapLayer = LevelMapLayer.new()
    self:addChild(levelMapLayer)	

	local popupCommonLayer = app:getInstance(PopupCommonLayer)
    self:addChild(popupCommonLayer, 200)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
