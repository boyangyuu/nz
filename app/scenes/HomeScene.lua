local HomeBarLayer = import("..homeBar.HomeBarLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

local HomeScene = class("HomeScene", function ()
	return display.newScene("HomeScene")
end)

function HomeScene:ctor(property)
	self:removeAllChildren()
	local homeBarLayer = HomeBarLayer.new()
    self:addChild(homeBarLayer)

	self.popupCommonLayer = PopupCommonLayer.new()
    self:addChild(self.popupCommonLayer, 200)
    self.popupCommonLayer:loadAllImg()    
end


return HomeScene