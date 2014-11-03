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
	local config = getConfig("config/json_inlay.json")
	local records = getRecord(config, fileName, index)
	return records
end

function InlayModel:refreshBtnIcon(string, index)
	self:dispatchEvent({name = "REFRESH_BTN_ICON_EVENT", string = string, index = index})
end

return InlayModel