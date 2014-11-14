local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")
local WeaponBag = import("..weaponList.WeaponBag")
local MainMenuLayer = import("..mainMenu.MainMenuLayer")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local mainMenuLayer = MainMenuLayer.new()
    self:addChild(mainMenuLayer)
end

function MainScene:onEnter()

end

function MainScene:onExit()
    
end

return MainScene
