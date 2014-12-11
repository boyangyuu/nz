



local LayerColor_BLACK = cc.c4b(0, 0, 0, 0)
local kOpacity = 200.0

local PopupCommonLayer = class("PopupCommonLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function PopupCommonLayer:ctor(properties)
	self:setVisible(false)

	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.POPUP_SHOW_EVENT, handler(self, self.showPopup))	
end

function PopupCommonLayer:showPopup(event)
	self:setVisible(true)
	self.layer = event.layer
	self:setOpacity(event.opacity or kOpacity)
	self:addChild(self.layer)
	self.layer:scale(0.25)
	self.layer:scaleTo(0.3, 1)
end

function PopupCommonLayer:onExit()
	transition.execute(self.layer, cc.ScaleTo:create(0.3, 0.25), {
    	delay = 0,
    	easing = "In",
    	onComplete = function() 
    		self.layer:removeSelf()  -- Must delete redundant layers
    		self.layer = nil
    		self:setVisible(false)
       end, 
	})
end

return PopupCommonLayer