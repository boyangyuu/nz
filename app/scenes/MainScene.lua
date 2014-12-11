
local GuideLayer = import("..guide.GuideLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local RootLayer = import("..UI.RootLayer")


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    local rootLayer = RootLayer.new()
    rootLayer:setPositionY(display.offset)
    self:addChild(rootLayer)

    --popup
	local popupCommonLayer = app:getInstance(PopupCommonLayer)
    popupCommonLayer:setPositionY(display.offset)
    self:addChild(popupCommonLayer, 200)

    --guide
    local guideLayer = GuideLayer:new()
    guideLayer:setPositionY(display.offset)
    self:addChild(guideLayer, 300)

    --black

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
