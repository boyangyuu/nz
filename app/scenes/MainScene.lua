
local GuideLayer = import("..guide.GuideLayer")
local PopupRootLayer = import("..UI.PopupRootLayer")
local RootLayer = import("..UI.RootLayer")
<<<<<<< HEAD
local DebugLayer = import("..debug.DebugLayer")
=======
local LoadingLayer = import("..UI.LoadingLayer")
>>>>>>> 9aa607b7d227f556163b7521329f97984ee8274e

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

<<<<<<< HEAD
    --debug
    local debugLayer = DebugLayer.new()
    debugLayer:setPositionY(display.offset)
    self:addChild(debugLayer, 400)

=======
    --loading
    local loadLayer = LoadingLayer.new()
    loadLayer:setPositionY(display.offset)
    self:addChild(loadLayer, 400)
    
    --black
    
>>>>>>> 9aa607b7d227f556163b7521329f97984ee8274e
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
