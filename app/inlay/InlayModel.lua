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

function InlayModel:btnIconDispatch(string, index)
	assert(string and index, "invalid param")
	self:dispatchEvent({name = "REFRESH_BTN_ICON_EVENT", string = string, index = index})
end

function InlayModel:popupDispatch(table, string, index, btnVariable)
	assert(table and string and index, "invalid param")
	self:dispatchEvent({name = "INLAY_POPUP_TIPS_EVENT", table = table,
	 string = string, index = index, btnVariable = btnVariable})
end

function InlayModel:loadedDispatch(btnVariable)
	self:dispatchEvent({name = "EQUIPMENT_ALREADY_LOADED", btnVariable = btnVariable})
end

return InlayModel