
local LayerColor_BLACK = cc.c4b(0, 0, 0, 0)
local kOpacity = 200.0

local PauseLayer = class("PauseLayer",function()
	return display.newColorLayer(LayerColor_BLACK)
end)

function PauseLayer:ctor()
	self:setVisible(false)
	self:setOpacity(kOpacity)
 	-- body
 	self.layer = nil
 	local pm = md:getInstance("PauseModel")
 	cc.EventProxy.new(pm, self)
		:addEventListener(pm.PAUSELAYER_SHOW_EVENT, handler(self, self.showPopup))	
		:addEventListener(pm.PAUSELAYER_CLOSE_EVENT, handler(self, self.closePopup))
end 

function PauseLayer:showPopup(event)
	print("function PauseLayer:showPopup(event)")
	self:setVisible(true)
	display.pause()
	print("event.isPauseSecond:",event.isPauseSecond)

	local cls = event.layerCls
	self.str = cls.__cname
	local pro = event.properties
	local layer = cls.new(pro)
	if self.layer ~= nil then 
		self.layer:removeSelf()
		self.layer = nil
		return 
	end
	self.layer = layer
	layer:setPositionY(display.offset)
	self:addChild(self.layer)
	
end

function PauseLayer:closePopup(event)
	display.resume()
	if self.layer ~= nil then
		self.layer:removeSelf()
		self.layer = nil
	end
	self:setVisible(false)
end

function PauseLayer:screenCapture()
	print("function PauseLayer:screenCapture()")
    local renderTexture = cc.RenderTexture:create(display.width,display.height)
    local runningScene = cc.Director:getInstance():getRunningScene()
    renderTexture:begin()
    runningScene:visit()
    renderTexture:endToLua()
    return renderTexture
end

return PauseLayer