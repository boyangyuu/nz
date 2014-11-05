--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 15:31:35
--
import("..includes.functionUtils")

local InlayModel = class("InlayModel", cc.mvc.ModelBase)

function InlayModel:ctor(properties, events, callbacks)
	InlayModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function InlayModel:getConfigTable(fileName, index)
	assert(fileName and index, "invalid param")
	local config = getConfig("config/items_xq.json")
	local records = getRecord(config, fileName, index) or {}
	return records
end

function InlayModel:refreshBtnIcon(string, index)
	assert(string and index, "invalid param")
	self:dispatchEvent({name = "REFRESH_BTN_ICON_EVENT", string = string, index = index})
end

return InlayModel