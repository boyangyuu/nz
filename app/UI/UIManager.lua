local UI = class("UIManager",cc.mvc.ModelBase)

-- 定义事件
UI.LAYER_CHANGE_EVENT = "LAYER_CHANGE_EVENT"
UI.POPUP_SHOW_EVENT   = "POPUP_SHOW_EVENT"
UI.POPUP_EXIT_EVENT   = "POPUP_EXIT_EVENT"

function UI:ctor(properties)
    UI.super.ctor(self, properties) 
	
	--instance
end

function UI:changeLayer(layerId)
	print("function UI:changeLayer(layerId)")
	self:dispatchEvent({name = UI.LAYER_CHANGE_EVENT, 
				layerId = layerId})
end

function UI:showPopupLayer(layerId)
	self:dispatchEvent({name = UI.POPUP_SHOW_EVENT, 
				layerId = layerId})
end

function UI:exitPopupLayer(node)
	self:dispatchEvent({name = UI.POPUP_EXIT_EVENT, 
				layerId = layerId})
end

return UI

