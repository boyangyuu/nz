



local LayerColor_BLACK = cc.c4b(0, 0, 0, 0)
local kOpacity = 200.0

local PopupRootLayer = class("PopupRootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function PopupRootLayer:ctor(properties)
	self:setVisible(false)

	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.POPUP_SHOW_EVENT, handler(self, self.showPopup))	
		:addEventListener(ui.POPUP_CLOSE_EVENT, handler(self, self.closePopup))
end

function PopupRootLayer:showPopup(event)
	self:setVisible(true)

	if self.layer and self.layer:getParent() then 
		self.layer:removeSelf()
		self.layer = nil
	end
	local cls = event.layerCls
	local pro = event.properties
	self.layer = cls.new(pro)
	self:setOpacity(event.opacity or kOpacity)
	self:addChild(self.layer)
	self.layer:scale(0.0)
	if event.anim == false then
		self.layer:scale(1)
	else
		self.layer:scaleTo(0.3, 1)
	end
end

function PopupRootLayer:closePopup(event)
	transition.execute(self.layer, cc.ScaleTo:create(0.3, 0.0), {
    	delay = 0,
    	easing = "In",
    	onComplete = function() 
	    	self:setVisible(false)
	    	self.layer:removeSelf()
	    	self.layer = nil
       end, 
	})
end


return PopupRootLayer
