
local DebugModel = class("DebugModel", cc.mvc.ModelBase)

DebugModel.DEBUG_SHOW_EVENT   = "DEBUG_SHOW_EVENT"
DebugModel.DEBUG_CLOSE_EVENT  = "DEBUG_CLOSE_EVENT"

function DebugModel:ctor(properties)
	DebugModel.super.ctor(self, properties)
	self:showPopup()
end

function DebugModel:showPopup(debugInfo)
	print("function DebugModel:showPopup(debugInfo)")
	-- layer:showError()
	self:dispatchEvent({name = DebugModel.DEBUG_SHOW_EVENT,debugInfo = debugInfo})
end

function DebugModel:closePopup()
	self:dispatchEvent({name = DebugModel.DEBUG_CLOSE_EVENT})
end


return DebugModel