--
-- Author: Fangzhongzheng
-- Date: 2014-10-27 16:14:14
--
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")

local PopupCommonLayer = class("PopupCommonLayer", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 150))
end)

function PopupCommonLayer:ctor(properties)

end

function removeColorLayer()
	self:removeSelf()
end


return PopupCommonLayer