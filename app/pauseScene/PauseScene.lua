

local PausePopup = require("app.pauseScene.PausePopup")

local director = cc.Director:getInstance()

local PauseScene = class("PauseScene",function()
	return display.newScene("PauseScene")
end)

function PauseScene:ctor()
 	-- body
end 

function PauseScene:pause(configid)
	local screenCapture = self:screenCapture()
	local sprite = display.newSprite(screenCapture:getSprite():getTexture())
	sprite:setAnchorPoint(0.0,0.0)
	sprite:setFlippedY(true)
	self:addChild(sprite, -1)

	self:addChild(PausePopup.new(configid),10)
	self:initBGLayer()

	director:pushScene(self)

end

function PauseScene:initBGLayer()
	local bgLayer = display.newColorLayer(cc.c4b(0, 0, 0, 150))
	bgLayer:setPositionY(display.offset)
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