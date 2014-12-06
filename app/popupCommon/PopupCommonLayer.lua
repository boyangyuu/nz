



local LayerColor_BLACK = cc.c4b(0, 0, 0, 0)

local PopupCommonLayer = class("PopupCommonLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function PopupCommonLayer:ctor(properties)
	self:setVisible(false)
end

function PopupCommonLayer:showPopup(layerNode,Layer_OPACITY)
	self:setVisible(true)
	self.layerNode = layerNode
	self:setOpacity(Layer_OPACITY)
	self:addChild(self.layerNode)
	self.layerNode:scale(0.25)
	self.layerNode:scaleTo(0.3, 1)
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

function PopupCommonLayer:loadAllImg()
	print("......PopupCommonLayer:loadAllImg()")
    self.imgRootNode = cc.uiloader:load("res/AllImg/allImg.json")
end

function PopupCommonLayer:getImgByName(fileName)
	dump(self.imgRootNode, "......self.imgRootNode")
    local file = cc.uiloader:seekNodeByName(self.imgRootNode, fileName)
    return file
end

return PopupCommonLayer