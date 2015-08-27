
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
		:addEventListener(ui.POPUP_CLOSEALL_EVENT, handler(self, self.closeAllPopups))
end

function PopupRootLayer:showPopup(event)
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

	self:setVisible(true)

	--action
	local animName = event.animName or "scale"
	if event.animName == "normal" then
		layer:scale(1)
	elseif animName == "scale" then
		layer:scale(0.0)
		layer:scaleTo(0.15, 1)

	elseif animName == "shake" then
		layer:scale(0.8)
		local act1 = cc.ScaleTo:create(0.04, 1.2)
		local act2 = cc.ScaleTo:create(0.05, 0.9)
		local act3 = cc.ScaleTo:create(0.07, 1.05)
		local act4 = cc.ScaleTo:create(0.08, 0.95)
		local act5 = cc.ScaleTo:create(0.09, 1.0)
		-- local act6 = cc.ScaleTo:create(0.1, 1.0)


		layer:runAction(cc.Sequence:create(act1,act2,act3,act4,act5))
	elseif animName == "leftScale" then
		layer:setAnchorPoint(0.0, 0.0)
		layer:scale(0.5)
		local act1 = cc.ScaleTo:create(0.18, 1.1)
		local act2 = cc.ScaleTo:create(0.15, 1.0)
		layer:runAction(cc.Sequence:create(act1,act2))
	elseif animName == "fade" then
		local seq = transition.sequence({
			cc.DelayTime:create(0.6),
			cc.CallFunc:create(function ()
				self:removePopup(str)
			end),
			})
		layer:runAction(seq)
	end
end

function PopupRootLayer:closePopup(event)
	-- dump(event, "event")
	local eventData = event.eventData
	eventData = eventData or {}
	local animName = eventData.animName or "scale"
	local onCloseFunc  = eventData.onCloseFunc
	-- print("animName", animName)
	if animName == "normal" then
		self:removePopup(event.layerId, onCloseFunc)
	elseif animName == "scale" then
		transition.execute(self.layers[event.layerId], cc.ScaleTo:create(0.15, 0.0), {
	    	delay = 0,
	    	easing = "In",
	    	onComplete = function()
	    		self:removePopup(event.layerId, onCloseFunc)
	       end,
		})
	end
end

function PopupRootLayer:removePopup(layerId, onCloseFunc)
	self.layers[layerId]:setVisible(false)
	self.layers[layerId]:removeSelf()
	self.layers[layerId] = nil
	if table.nums(self.layers) == 0 then
		ui:closeAllPopups()
	end

	if onCloseFunc then onCloseFunc() end
end

function PopupRootLayer:closeAllPopups(event)
	self:removeAllChildren()
	self.layers = {}
	self:setVisible(false)
end

return PopupRootLayer
