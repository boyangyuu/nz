
local InlayModel = class("InlayModel", cc.mvc.ModelBase)

function InlayModel:ctor(properties, events, callbacks)
	InlayModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function InlayModel:getConfigTable(propertyName, index)
	assert(propertyName and index, "invalid param")
	local config = getConfig("config/items_xq.json")
	local records = getRecord(config, propertyName, index) or {}
	return records
end

return InlayModel