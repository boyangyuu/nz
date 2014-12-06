


import("..includes.functionUtils")

local LayerColor_BLACK = cc.c4b(0, 0, 0, 100)

local Guide = import(".GuideModel")
local Hero = import("..fight.Hero")
local GuideLayer = class("GuideLayer", function()
	local layer = display.newLayer()
	layer:setAnchorPoint(0.5, 0.5)
	layer:setPosition(0.0,0.0) 
    return layer
end)

function GuideLayer:ctor()
	--instance
	self.guide = app:getInstance(Guide)
	self.hero = app:getInstance(Hero)
	--
	self:setVisible(false)
	--ui

	--event
	cc.EventProxy.new(self.guide, self):
		addEventListener(Guide.GUIDE_SHOW_EVENT, handler(self, self.start))

	--touch
    self:setTouchEnabled(true) 
    self:setTouchCaptureEnabled(true)
    self:setTouchSwallowEnabled(true) 
    self:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)		
    self:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT,handler(self, self.onTouch))
end

function GuideLayer:onTouch(event)
    if event.name == "began" or event.name == "added" then
        return self:onMutiTouchBegin(event)
    elseif event.name == "ended" or event.name == "cancelled" or event.name == "removed" then
        return self:onMutiTouchEnd(event)
    elseif event.name == "moved" then 
        return self:onMutiTouchMoved(event)
    end
    return true
end

function GuideLayer:onMutiTouchBegin(event)
	-- dump(event, "onMutiTouchBegin event")
    for id, point in pairs(event.points) do
		local pos = cc.p(point.x, point.y)
		local isTouch = self:isTouchTarget(pos)
		if isTouch then 
			print("Begin 点击到指定区域")
			self:onTouchTarget(event)
			return true
		end
	end
	return true
end

function GuideLayer:onMutiTouchMoved(event)
	-- dump(event, "onMutiTouchMoved event")
    for id, point in pairs(event.points) do
		local pos = cc.p(point.x, point.y)
		local isTouch = self:isTouchTarget(pos)
		if isTouch then 
			print("Moved 点击到指定区域")
			self:onTouchTarget(event)
			return true
		end
	end
	return true
end

function GuideLayer:onMutiTouchEnd(event)
	-- dump(event, "onMutiTouchEnd event")
    for id, point in pairs(event.points) do
		local pos = cc.p(point.x, point.y)
		local isTouch = self:isTouchTarget(pos)
		self:onTouchTarget(event)
	end
	return true
end

function GuideLayer:onTouchTarget(event)
	--调用监听者的回调函数
	local listenData = self.guide:getCurData()
	if listenData.touchType then
		if listenData.touchType ~= event.name then 
			return 
		end
	end

	local endfunc = listenData.endfunc
	assert(endfunc, "endfunc is nil stepid is:"..listenData.id)
	print("endfunc excute eventname:"..event.name)
	endfunc(event)

	--config 是否点击立即next
	local config = self.guide:getCurConfig()
	if config.mode == "click" then
		self.guide:doGuideNext()
	end
end

function GuideLayer:getTargetRect()
	local listenData = self.guide:getCurData()
	local targetRect = listenData.rect
	-- dump(targetRect, "targetRect")
	local rect = targetRect
	return rect
end

function GuideLayer:isTouchTarget(pos)
	local rect = self:getTargetRect()
	local b = cc.rectContainsPoint(rect, pos)
	return b
end

function GuideLayer:refreshUI()
	--clear
	if self.bg then 
		self.bg:removeFromParent() 
		self.bg = nil
	end

	--highLight
	local rect = self:getTargetRect()
	local params = {fillColor = cc.c4f(0,0,0,0), 
			borderColor = cc.c4f(0,33,33,0), 
			borderWidth = 5}
	local circle = display.newRect(rect, params) --todo改为九宫格

	--render
	local render = cc.RenderTexture:create(display.width, display.height)
	local opacity = 0.6 --透明度
	render:clear(0, 0, 0, opacity)
	render:begin()
		circle:setBlendFunc(gl.DST_ALPHA, gl.ZERO)
		circle:visit()
	render:endToLua()

	--add
	self.bg = cc.Sprite:createWithTexture(render:getSprite():getTexture())
	self.bg:setAnchorPoint(0.0,0.0)
	self.bg:flipY(true)
	self:addChild(self.bg, 100)
end

function GuideLayer:start(event)
	print("function GuideLayer:start(event)")
	self:setVisible(true)

	self:refreshUI()
end

function GuideLayer:finish()
	print("function GuideLayer:finish(event)")
end

return GuideLayer