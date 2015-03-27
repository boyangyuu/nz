

local PauseScene = class("PauseScene",function()
	return display.newScene("PauseScene")
end)

function PauseScene:ctor()
 	-- body
 	self.layer = nil
 	self:addBgLayer()
 	local pm = md:getInstance("PauseModel")
 	cc.EventProxy.new(pm, self)
		:addEventListener(pm.PAUSESCENE_SHOW_EVENT, handler(self, self.showPopup))	
		:addEventListener(pm.PAUSESCENE_CLOSE_EVENT, handler(self, self.closePopup))
end 

function PauseScene:showPopup(event)
	print("event.isPauseSecond:",event.isPauseSecond)
	--jieping
	if not event.isNotScrenCapture then 
		local screenCapture = self:screenCapture()
		local sprite = display.newSprite(screenCapture:getSprite():getTexture())
		sprite:setAnchorPoint(0,0)
		sprite:setFlippedY(true)
		self:addChild(sprite, -1)
	end

	local cls = event.layerCls
	self.str = cls.__cname
	local pro = event.properties
	local layer = cls.new(pro)
	if self.layer ~= nil then 
		return 
	end
	self.layer = layer
	layer:setPositionY(display.offset)
	self:addChild(self.layer)

end

function PauseScene:closePopup(event)
	local director = cc.Director:getInstance()
	director:popScene()
	print("PauseScene:closePopup(event)")
end

function PauseScene:addBgLayer()
	local bgLayer = display.newColorLayer(cc.c4b(0, 0, 0, 150))
	self:addChild(bgLayer)
end

function PauseScene:screenCapture()
    local renderTexture = cc.RenderTexture:create(display.width,display.height)
    local runningScene = cc.Director:getInstance():getRunningScene()

    renderTexture:begin()
    runningScene:visit()
    renderTexture:endToLua()

    return renderTexture
end

return PauseScene