--
-- Author: Fangzhongzheng
-- Date: 2014-10-27 16:14:14
--

local PopupCommonLayer = class("PopupCommonLayer", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

function PopupCommonLayer:ctor(properties)
	self:setVisible(false)
end

function PopupCommonLayer:showPopup(layerNode)
	self:setVisible(true)
	self.layerNode = layerNode
	self:setOpacity(200)
	self:addChild(self.layerNode)
	self.layerNode:runAction(transition.sequence({cc.ScaleTo:create(0.01, 0.25),
		cc.ScaleTo:create(0.3, 1)}))
end

function PopupCommonLayer:onExit()
	transition.execute(self.layerNode, cc.ScaleTo:create(0.3, 0.25), {
    	delay = 0,
    	easing = "In",
    	onComplete = function() 
    		self.layerNode:removeSelf()  -- Must delete redundant layers
    		self:setVisible(false)
       end, 
	})
end

return PopupCommonLayer