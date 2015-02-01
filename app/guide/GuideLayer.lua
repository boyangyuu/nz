


import("..includes.functionUtils")

local LayerColor_BLACK = cc.c4b(255, 0, 0, 0)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Guide = import(".GuideModel")
local GuideLayer = class("GuideLayer", function()
	local layer = display.newColorLayer(LayerColor_BLACK)
	layer:setAnchorPoint(0.5, 0.5)
	layer:setPosition(0.0,0.0) 
    return layer
end)

function GuideLayer:ctor()
	--instance
	self.guide = md:getInstance("Guide")

	--
	self:setVisible(false)
	self.isWaiting = false
	self.bg 	  = nil
	self.armature = nil
		
	--ui
	self:loadCCS()

	--event
	cc.EventProxy.new(self.guide, self)
		:addEventListener(self.guide.GUIDE_START_EVENT, handler(self, self.start))
		:addEventListener(self.guide.GUIDE_FINISH_EVENT, handler(self, self.finish))
		:addEventListener(self.guide.GUIDE_HIDE_EVENT, handler(self, self.hideForTime))
	--touch
    self:setTouchEnabled(true) 
    self:setTouchSwallowEnabled(true) 
    self:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)		
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT,handler(self, self.onTouch))
end

function GuideLayer:onTouch(event)
	if not self.isGuiding then return false end
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
	--
	if self.isWaiting or not self.isGuiding then return end
	if event == nil then return end

	--调用监听者的回调函数
	local listenData = self.guide:getCurData()
	local cfg = self.guide:getCurConfig()
	-- dump(cfg, "cfg")
	-- dump(event, "event")

	--检查是否是特殊事件监听
	if event.name ~= "began" then
		if cfg.touchType ~= "all" then return end
	end

	--endfunc
	local endfunc = listenData.endfunc
	assert(endfunc, "endfunc is nil stepid is:"..listenData.id)
	-- print("endfunc excute eventname:"..event.name)
	
	--do next
	if cfg.skipMode ~= "condition" then
		--回调
		endfunc(event)
		--自动跳下一步
		self.guide:doGuideNext()
		--hide
		if cfg.skipDelay then
			self.guide:hideGuideForTime(cfg.skipDelay)
		end
	else
		--回调
		endfunc(event)
	end
end

function GuideLayer:hideForTime(event)
	local delay = event.delay
	local function restoreFunc()
		self.bg:setVisible(true)
		self.guideNode:setVisible(true)
		self.isWaiting = false
	end

	--hide
	self.guideNode:setVisible(false)
	self.bg:setVisible(false)
	self.isWaiting = true

	--restore after time
	scheduler.performWithDelayGlobal(restoreFunc, delay)	
end

function GuideLayer:getTargetRect()
	local listenData = self.guide:getCurData()
	local targetRect = listenData.rect
	-- dump(targetRect, "targetRect")
	local rect = targetRect
	return rect
end

function GuideLayer:isTouchTarget(pos)
	-- dump(pos, "pos")
	pos.y = pos.y - display.offset 
	local rect = self:getTargetRect()
	-- dump(rect, "rect")
	local b = cc.rectContainsPoint(rect, pos)
	return b
end

function GuideLayer:loadCCS()
	--ui
	self:removeAllChildren()
	self.bg 	  = nil
	self.armature = nil

    self.guideNode = cc.uiloader:load("res/xinshou/xinshou.ExportJson")
    self:addChild(self.guideNode, 10)

    --anim
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo("res/xinshou/yd_zyhua/yd_zyhua.csb")
    display.addSpriteFrames("res/xinshou/yd_zyhua/yd_zyhua0.plist", 
        "res/xinshou/yd_zyhua/yd_zyhua0.png")     
    manager:addArmatureFileInfo("res/xinshou/yd_dianji/yd_dianji.csb")
    display.addSpriteFrames("res/xinshou/yd_dianji/yd_dianji0.plist", 
        "res/xinshou/yd_dianji/yd_dianji0.png")     
end


function GuideLayer:refreshUI()
	local cfg = self.guide:getCurConfig()

	--clear
	if self.bg then 
		self.bg:removeFromParent() 
		self.bg = nil
	end

	--highLight
	local rect = self:getTargetRect()
	local size = cc.size(rect.width, rect.height)
	dump(rect, "rect")
	local params = {fillColor = cc.c4f(255,0,0,255), 
			borderColor = cc.c4f(0,0,0,0), 
			borderWidth = 5}
	local circle = display.newRect(rect, params) --todo改为九宫格
	local opacityCfg = cfg.opacity 
	local render = cc.RenderTexture:create(display.width1, display.height1)
	local opacity = opacityCfg or 0.5 --透明度
	render:clear(0.1, 0.1, 0.1, opacity)
	render:begin()
		circle:setBlendFunc(gl.DST_ALPHA, gl.ZERO)
		circle:visit()
	render:endToLua()

	--add bg
	self.bg = cc.Sprite:createWithTexture(render:getSprite():getTexture())
	self.bg:setAnchorPoint(0.0,0.0)
	self.bg:flipY(true)
	self:addChild(self.bg)

	--add hand
	if self.armature then 
		self.armature:removeFromParent()
		self.armature = nil
	end

	--hand cfg
	if cfg.hand == "move" then 
		self.armature = ccs.Armature:create("yd_zyhua")
		self.armature:getAnimation():play("yd_zyhua" , -1, 1)
	elseif cfg.hand == "longtouch" then
		self.armature = ccs.Armature:create("yd_dianji")
		self.armature:getAnimation():play("yd_changan" , -1, 1)
	else 
		self.armature = ccs.Armature:create("yd_dianji")
		self.armature:getAnimation():play("yd_dianji" , -1, 1)				
	end
	self.armature:setPosition(rect.x + rect.width/2,
			rect.y + rect.height/2)	
	self.guideNode:addChild(self.armature)
end

function GuideLayer:refreshCommentUI()
	local cfg = self.guide:getCurConfig()

	--guide offset
	local contentNode = cc.uiloader:seekNodeByName(self.guideNode, "guide")
	local offset = cfg.contentOffset or {x = 0, y = 0}
	local pos = cc.p(display.width1/2 + offset.x, 
				display.height1/2 + offset.y)
	-- dump(pos, "")
	contentNode:setPosition(pos)

	--msg
	local label_content =  cc.uiloader:seekNodeByName(self.guideNode, "label_content")
	local msg = cfg.msg
	assert(msg, "msg is nil")
	label_content:setString(msg)
	label_content:speak(0.1)
end

function GuideLayer:start(event)
	print("function GuideLayer:start(event)")
	self:loadCCS()	
	self:setVisible(true)
	self:setTouchEnabled(true)
	self.isGuiding = true
	-- if self.bg then self.bg:setVisible(true) end 
	-- if self.guideNode then self.guideNode:setVisible(true) end 

	self:refreshUI()
	self:refreshCommentUI()
end

function GuideLayer:finish(event)
	print("function GuideLayer:finish(event)")
	--clear
	self:loadCCS()
	self:setTouchEnabled(false)
	self.isGuiding = false
	--visible
	self:setVisible(false)
end

return GuideLayer