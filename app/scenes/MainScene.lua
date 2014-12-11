
local GuideLayer = import("..guide.GuideLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local RootLayer = import("..root.RootLayer")
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local FightResultLayer = import("..fightResult.FightResultLayer")
local FightResultAnim = import("..fightResult.fightResultAnim")


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    -- local rootLayer = RootLayer.new()
    -- self:addChild(rootLayer)

 --    local HomeBarLayer = app:getInstance(HomeBarLayer)
 --    self:addChild(HomeBarLayer, 200)

	-- local popupCommonLayer = app:getInstance(PopupCommonLayer)
 --    self:addChild(popupCommonLayer, 200)
    
    -- display.addSpriteFrames("allImg0.plist", "allImg0.png")

    -- local FightResultLayer = app:getInstance(FightResultLayer)
    -- self:addChild(FightResultLayer, 200)
    local FightResultAnim = app:getInstance(FightResultAnim)
    self:addChild(FightResultAnim, 200)

    --guide
    -- local guideLayer = GuideLayer:new()
    -- guideLayer:setPositionY(display.offset)
    -- self:addChild(guideLayer, 300)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
