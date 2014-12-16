
local GuideLayer = import("..guide.GuideLayer")
local PopupRootLayer = import("..UI.PopupRootLayer")
local RootLayer = import("..UI.RootLayer")


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    local rootLayer = RootLayer.new()
    rootLayer:setPositionY(display.offset)
    self:addChild(rootLayer)

    --popup
	local popupRootLayer = PopupRootLayer.new()
    popupRootLayer:setPositionY(display.offset)
    self:addChild(popupRootLayer, 200)

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
