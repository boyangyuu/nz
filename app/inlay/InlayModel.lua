--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 15:31:35
--
import("..includes.functionUtils")

local InlayModel = class("InlayModel", cc.mvc.ModelBase)

-- 定义事件
InlayModel.REFRESH_BTN_ICON_EVENT   = "REFRESH_BTN_ICON_EVENT"
InlayModel.INLAY_POPUP_TIPS_EVENT   = "INLAY_POPUP_TIPS_EVENT"
InlayModel.EQUIPMENT_ALREADY_LOADED = "EQUIPMENT_ALREADY_LOADED"

function InlayModel:ctor(properties, events, callbacks)
	InlayModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function InlayModel:getConfigTable(tableName, index)
	assert(tableName and index, "invalid param")
	local config = getConfig("config/items_xq.json")
	local records = getRecord(config, tableName, index) or {}
	return records
end

-- 数据储存，1储存是否已装备并设置touchEnabled；2储存耗材的数量；


function InlayModel:btnIconDispatch(string, index)
	assert(string and index, "invalid param")
	self:dispatchEvent({name = "REFRESH_BTN_ICON_EVENT", string = string, index = index})
end

function InlayModel:popupDispatch(type, index)
	assert(table and string and index, "invalid param")
	self:dispatchEvent({name = "INLAY_POPUP_TIPS_EVENT", Type = type, index = index})
end

function InlayModel:loadedDispatch(variable)
	self:dispatchEvent({name = "EQUIPMENT_ALREADY_LOADED", variable = variable})
end

return InlayModel