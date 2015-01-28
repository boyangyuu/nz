

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
	sprite:setPosition(display.width1/2, display.height1/2)
	sprite:setAnchorPoint(0.5,0.5)
	sprite:setFlippedY(true)
	self:addChild(sprite, -1)

	self:addChild(PausePopup.new(configid),10)
	self:initBGLayer()

	director:pushScene(self)

end

function PauseScene:initBGLayer()
	local bgLayer = display.newColorLayer(cc.c4b(0, 0, 0, 150))
	self:addChild(bgLayer);
end

function PauseScene:screenCapture()
    local renderTexture = cc.RenderTexture:create(display.width1,display.height1)
    local runningScene = cc.Director:getInstance():getRunningScene()

    renderTexture:begin()
    runningScene:visit()
    renderTexture:endToLua()

    return renderTexture
end


return PauseScene