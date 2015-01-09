

local DebugLayer = class("DebugLayer", function()
	return display.newLayer()
end)

function DebugLayer:ctor()
	print("DebugLayer:ctor(debugInfo)")
	self:setVisible(false)
	self.debugModel = md:getInstance("DebugModel")
	cc.EventProxy.new(self.debugModel, self)
		:addEventListener(self.debugModel.DEBUG_SHOW_EVENT, handler(self, self.showError))
		:addEventListener(self.debugModel.DEBUG_CLOSE_EVENT, handler(self, self.closeError))
	self:loadCSS()	
end

function DebugLayer:loadCSS()
	local debugNode = cc.uiloader:load("res/Debug/debugLayerpro/DebugLayer.ExportJson")
	self.debugNode = debugNode
	self:addChild(self.debugNode)
end

function DebugLayer:showError(event)
	print("DebugLayer:showError(event)")
	if self.isShowing then return end
	self:setVisible(true)
	self.isShowing = true


	local luaErrorDetail = cc.uiloader:seekNodeByName(self.debugNode, "luaError_Detail")
	luaErrorDetail:setString(event.debugInfo.errormessage)

	local traceBackLabel = cc.uiloader:seekNodeByName(self.debugNode, "traceBackLabel")
	traceBackLabel:setString(event.debugInfo.tracebackinfo)

	local btnClose = cc.uiloader:seekNodeByName(self.debugNode, "btnClose")
	local btnScale = btnClose:getScale()
	btnClose:onButtonPressed(function( event )
		event.target:setScale(btnScale*1.2)
	end)
	:onButtonRelease(function( event )
		event.target:setScale(btnScale)
	end)
	:onButtonClicked(function(  )
		self:close()
	end)
end

function DebugLayer:close()

	self.isShowing = false
	self:setVisible(false)
end

return DebugLayer