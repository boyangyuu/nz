



local LayerColor_BLACK = cc.c4b(0, 0, 0, 0)
local kOpacity = 200.0

local PopupRootLayer = class("PopupRootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function PopupRootLayer:ctor(properties)
	self:setVisible(false)
	self.layers = {}
	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.POPUP_SHOW_EVENT, handler(self, self.showPopup))	
		:addEventListener(ui.POPUP_CLOSE_EVENT, handler(self, self.closePopup))
end

function PopupRootLayer:showPopup(event)
	self:setVisible(true)
	local cls = event.layerCls
	local str = cls.__cname
	local pro = event.properties
	local layer = cls.new(pro)
	if self.layers[str] ~= nil then 	
		self.layers[str]:removeSelf()
		self.layers[str] = nil
	end
	self.layers[str] = layer
	self:setOpacity(event.opacity or kOpacity)
	self:addChild(layer)
	layer:scale(0.0)
	if event.anim == false then
		layer:scale(1)
	else
		layer:scaleTo(0.3, 1)
	end
end

function PopupRootLayer:closePopup(event)
	print(" PopupRootLayer:closePopup(event)")
	local isCancelAnim = event.isCancelAnim
	if isCancelAnim then
		self.layers[event.layerId]:removeSelf()
    	self.layers[event.layerId] = nil
    	if table.nums(self.layers) == 0 then
    		self:setVisible(false)
    	end
	else
		transition.execute(self.layers[event.layerId], cc.ScaleTo:create(0.3, 0.0), {
	    	delay = 0,
	    	easing = "In",
	    	onComplete = function() 
		    	self.layers[event.layerId]:removeSelf()
		    	self.layers[event.layerId] = nil
		    	if table.nums(self.layers) == 0 then
		    		self:setVisible(false)
		    	end
	       end, 
		})
	end
end


return PopupRootLayer
