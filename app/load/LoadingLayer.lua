local LoadingLayer = class("LoadingLayer", function()
	return display.newLayer()
end)

function LoadingLayer:ctor()
	self:loadCCS()
end

function LoadingLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/loading")
    local controlNode = cc.uiloader:load("loading_1.json")
    self:addChild(controlNode)
end

function LoadingLayer:changeHomeLayer()
	ui:changeLayer("HomeBarLayer", {})
end

return LoadingLayer