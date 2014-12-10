local StartMenuLayer = import("..startMenu.StartMenuLayer")

local rootLayer = class("rootLayer", function()
    return display.newLayer()
end)

function rootLayer:ctor()
	local startMenuLayer = StartMenuLayer.new()
    self:addChild(startMenuLayer)
end

return rootLayer