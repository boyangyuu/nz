
local GuideLayer = import("..guide.GuideLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local RootLayer = import("..root.RootLayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    local RootLayer = RootLayer.new()
    self:addChild(RootLayer)
    
    --popup
	local popupCommonLayer = app:getInstance(PopupCommonLayer)
    self:addChild(popupCommonLayer, 200)

    --guide
    local guideLayer = GuideLayer:new()
    guideLayer:setPositionY(display.offset)
    self:addChild(guideLayer, 300)
 --    popupCommonLayer:loadAllImg()
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
