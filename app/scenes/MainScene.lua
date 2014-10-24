

local FightPlayer = import("..fight.FightPlayer")
local LevelMapLayer = import("..levelMap.LevelMapLayer")
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
<<<<<<< HEAD
    -- local levelMapLayer = LevelMapLayer.new()
    -- self:addChild(levelMapLayer)
    -- local FightPlayer = FightPlayer.new()
    -- self:addChild(FightPlayer)
    local DetailLayer=LevelDetailLayer.new()
    self:addChild(DetailLayer)
=======
    local levelMapLayer = LevelMapLayer.new()
    self:addChild(levelMapLayer)
    -- local FightPlayer = FightPlayer.new()
    -- self:addChild(FightPlayer)
>>>>>>> 2415b06021f3cfc208fbefdfaf8d1edbb9957c4c
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
