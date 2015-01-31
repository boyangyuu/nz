

local PauseScene = class("PauseScene",function()
	return display.newScene("PauseScene")
end)

function PauseScene:ctor()
 	-- body
 	self.id = 1
 	self.layers = {}
 	cc.EventProxy.new(ui, self)
		:addEventListener(ui.PAUSESCENE_SHOW_EVENT, handler(self, self.showPopup))	
		:addEventListener(ui.PAUSESCENE_CLOSE_EVENT, handler(self, self.closePopup))
end 

function PauseScene:showPopup(event)
	print("PauseScene:showPopup(event)")

	print("event.isPauseSecond:",event.isPauseSecond)
	if not event.isPauseSecond then
	--jieping
		local screenCapture = self:screenCapture()
		local sprite = display.newSprite(screenCapture:getSprite():getTexture())
		-- sprite:setPosition(display.width1/2, display.height1/2)
		sprite:setAnchorPoint(0,0)
		sprite:setFlippedY(true)
		self:addChild(sprite, -1)


		self:addBgLayer()
		local director = cc.Director:getInstance()
		director:pushScene(self)
		print("PauseScene id:",self.id)
		self.id = self.id + 1
	end



	local cls = event.layerCls
	self.str = cls.__cname
	print("PauseScene layer Name:",self.str)
	local pro = event.properties
	local layer = cls.new(pro)
	if self.layers[str] ~= nil then 	
		self.layers[str]:removeSelf()
		self.layers[str] = nil
	end
	self.layers[self.str] = layer
	layer:setPositionY(display.offset)
	self:addChild(layer)
	layer:scale(0.0)
	if event.anim == false then
		layer:scale(1)
		print("dsdfad1")
	else
		layer:scaleTo(0.3, 1)
		print("dsdfad2")
	end

	

end

function PauseScene:closePopup(event)
	-- body
	-- transition.execute(self.layers[event.layerId], cc.ScaleTo:create(0.3, 0.0), {
 --    	delay = 0,
 --    	easing = "In",
 --    	onComplete = function() 
	--     	self.layers[event.layerId]:removeSelf()
	--     	self.layers[event.layerId] = nil
	--     	if table.nums(self.layers) == 0 then
	--     		self:setVisible(false)
	--     	end
 --       end, 
	-- })
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