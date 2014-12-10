local FightPlayer = import("..fight.FightPlayer")
local GuideLayer = import("..guide.GuideLayer")
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local FightResultLayer = import("..fightResult.FightResultLayer")
local RootLayer = import("..rootLayer.rootLayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
<<<<<<< HEAD
    -- local rootLayer = RootLayer.new()
    -- self:addChild(rootLayer)
    local homeBarLayer = HomeBarLayer.new()
    self:addChild(homeBarLayer)
    -- local FightPlayer = FightPlayer.new()
    -- self:addChild(FightPlayer)
    -- popupCommonLayer:loadAllImg()
	local popupCommonLayer = app:getInstance(PopupCommonLayer)
    self:addChild(popupCommonLayer, 200)
    -- popupCommonbLayer:loadAllImg()
    -- display.addSpriteFrames("allImg0.plist", "allImg0.png")
    -- local fightResultLayer = FightResultLayer.new()
    -- self:addChild(fightResultLayer)
=======
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
>>>>>>> nz
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
