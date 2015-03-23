

local LayerColor_BLACK = cc.c4b(255, 0, 0, 0)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Guide = import(".GuideModel")
local GuideLayer = class("GuideLayer", function()
	local layer = display.newColorLayer(LayerColor_BLACK)
    return layer
end)

function GuideLayer:ctor()
	--instance
	self.guide = md:getInstance("Guide")

	--
	self:setVisible(false)
	self.bg 	  = nil
	self.armature = nil
	self.isSwallow = true
	self:setTouchSwallowEnabled(false)
	--ui
	self:loadCCS()

	--event
	cc.EventProxy.new(self.guide, self)
		:addEventListener(self.guide.GUIDE_START_EVENT, 		 handler(self, self.start))
		:addEventListener(self.guide.GUIDE_FINISH_EVENT,		 handler(self, self.finish))
		:addEventListener(self.guide.GUIDE_HIDE_EVENT, 			 handler(self, self.hideForTime))
		:addEventListener(self.guide.GUIDE_TOUCHSWALLOW_EVENT,   handler(self, self.setTouchSwallow))
end

function GuideLayer:onTouchOne(event)
	print("function GuideLayer:onTouchOne(event)")
    return false
end

function GuideLayer:onTouch(event)
	-- dump(event, "event")
	if not self.isGuiding then return false end
    if event.name == "began" or event.name == "added" then    	
        return self:onMutiTouchBegin(event)
    elseif event.name == "ended" or event.name == "cancelled" or event.name == "removed" then
        return self:onMutiTouchEnd(event)
    elseif event.name == "moved" then 
        return self:onMutiTouchMoved(event)
    end
    return false
end

function GuideLayer:onMutiTouchBegin(event)
	-- dump(event, "onMutiTouchBegin event")
	if event.points == nil then return false end
	if #event.points > 1 then return end 
    for id, point in pairs(event.points) do
		local pos = cc.p(point.x, point.y)
		local isTouch = self:isTouchTarget(pos)
		if isTouch then 
			print("Begin 点击到指定区域")
			self:onTouchTarget(event)
			return true
		end
	end
	return false
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
	return false
end

function GuideLayer:onMutiTouchEnd(event)
	-- dump(event, "onMutiTouchEnd event")
    for id, point in pairs(event.points) do
		local pos = cc.p(point.x, point.y)
		local isTouch = self:isTouchTarget(pos)
		self:onTouchTarget(event)
	end
	return false
end

function GuideLayer:onTouchTarget(event)
	--
	if not self.isGuiding then return end
	if event == nil then return end

	--调用监听者的回调函数
	local listenData = self.guide:getCurData()
	local cfg = self.guide:getCurConfig()
	-- dump(cfg, "cfg")
	-- dump(event, "event")

	--检查是否是特殊事件监听
	if event.name ~= "began" and event.name ~= "added" then
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
	end

	--hide
	self.guideNode:setVisible(false)
	self.bg:setVisible(false)

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
	cc.FileUtils:getInstance():addSearchPath("res/commonPNG")
    display.addSpriteFrames("res/commonPNG/role0.plist", "res/commonPNG/role0.png") 
    self.guideNode = cc.uiloader:load("res/xinshou/xinshou.ExportJson")
    self:addChild(self.guideNode, 10)

    --touchAll
    self.touchAll = cc.uiloader:seekNodeByName(self.guideNode, "touchAll")
end

function GuideLayer:checkFirstGuide()
	if self.isFirst then return end
	self.isFirst = true
	--res
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo("res/xinshou/xinsyd/xinsyd.ExportJson")
    display.addSpriteFrames("res/xinshou/xinsyd/xinsyd.plist", 
        "res/xinshou/yd_zyhua/yd_zyhua0.png")     
    manager:addArmatureFileInfo("res/xinshou/yd_dianji/yd_dianji.ExportJson")
    display.addSpriteFrames("res/xinshou/yd_dianji/yd_dianji0.plist", 
        "res/xinshou/yd_dianji/yd_dianji0.png")	

    --touch 
    self.touchAll:setTouchEnabled(true) 
    self.touchAll:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)	
    local isSwallow = self:getIsTouchSwallow()
    self.touchAll:setTouchSwallowEnabled(isSwallow) 	
    self.touchAll:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self, self.onTouch))     
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
	if cfg["hand"] == "move" or cfg["hand"] == "fire" then
		rect = cc.rect(0, 0, display.width1, display.height1)
	end
	-- dump(rect, "rect")
	local params = {fillColor = cc.c4f(255,0,0,255), 
			borderColor = cc.c4f(0,0,0,0), 
			borderWidth = 5}
	local circle = display.newRect(rect, params) --todo改为九宫格
	local opacityCfg = cfg.opacity 
	local render = cc.RenderTexture:create(display.width1, display.height1)
	local opacity = opacityCfg or 0.8 --透明度
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
	if cfg["hand"] == "move" then 
		self.armature = ccs.Armature:create("xinsyd")
		self.armature:getAnimation():play("huadong" , -1, 1)
		self.armature:setPosition(display.width1/2,
				display.height1/2)						
	elseif cfg["hand"] == "fire" then 
		self.armature = ccs.Armature:create("xinsyd")
		self.armature:getAnimation():play("dianji" , -1, 1)
		self.armature:setPosition(display.width1/2,
				display.height1/2)					
	else
		self.armature = ccs.Armature:create("yd_dianji")
		self.armature:getAnimation():play("yd_dianji" , -1, 1)		
		self.armature:setPosition(rect.x + rect.width/2,
				rect.y + rect.height/2)							
	end

	self.guideNode:addChild(self.armature)
end

function GuideLayer:refreshCommentUI()
	print("function GuideLayer:refreshCommentUI()")
	local cfg = self.guide:getCurConfig()    --anim

	--guide offset
	local contentNode = cc.uiloader:seekNodeByName(self.guideNode, "guide")
	local offset = cfg.contentOffset or {x = 0, y = 0}
	local pos = cc.p(display.width1/2 + offset.x, 
				display.height1/2 + offset.y)
	-- dump(pos, "")
	contentNode:setPosition(pos)	
	if cfg.rolepos == "hide" then 
		contentNode:setVisible(false)
		return 
	else
		contentNode:setVisible(true)
	end

	--msg
	local label_content =  cc.uiloader:seekNodeByName(self.guideNode, "label_content")
	local msg = cfg.msg
	assert(msg, "msg is nil")

	--guide role
	local image_role = cc.uiloader:seekNodeByName(self.guideNode, "image_role")
	local isRight = cfg.rolepos == "right" 
	image_role:setFlippedX(not isRight)
	if cfg.rolepos == "right" then  
		label_content:setPositionX(90)
		image_role:setPositionX(700)
	else
		label_content:setPositionX(250)
		image_role:setPositionX(-40)
	end	

	label_content:setString(msg)
	-- label_content:speak(0.1)	
end

function GuideLayer:start(event)
	print("function GuideLayer:start(event)")
	self.isGuiding = true

	--refresh
	self:setVisible(true)
	self:checkFirstGuide()
	self:refreshUI()
	self:refreshCommentUI()
end

function GuideLayer:finish(event)
	print("function GuideLayer:finish(event)")
	--touch
	self.isGuiding = false
	self.isFirst = false
	self.touchAll:removeAllNodeEventListeners()	
	self.isSwallow  = true

	--visible
	self:setVisible(false)
end

function GuideLayer:setTouchSwallow(event)
	self.isSwallow = event.isSwallow
end

function GuideLayer:getIsTouchSwallow()
	return self.isSwallow
end

return GuideLayer