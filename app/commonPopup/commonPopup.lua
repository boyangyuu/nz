local commonPopup = class("commonPopup",function()
	return display.newLayer()
end)
--[[
	style1:一个确定按钮，一个关闭按钮，content
		ui:showPopup("commonPopup",
			 {type = "style1",content = "必须装备狙击枪"},
			 {opacity = 0})
	style2:只有一个板，没有按钮，三秒消失
		ui:showPopup("commonPopup",
			 {type = "style2", content = "本关还没开启"},
			 {opacity = 0})
	style3:俩按钮，确定取消，content
		ui:showPopup("commonPopup",
			 {type = "style3", content = "必须装备狙击枪"},
			 {opacity = 0})
]]
function commonPopup:ctor(properties)
	self.commonPopModel = md:getInstance("commonPopModel")


	local typeName = properties.type
	self:loadCCS(typeName)
	self:initUI(properties)
end

function commonPopup:loadCCS(typeName)
    cc.FileUtils:getInstance():addSearchPath("res/CommonPopup/erjijiemian")
    local controlNode = cc.uiloader:load(typeName..".ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)

end

function commonPopup:initUI(properties)
	local typeName = properties.type
	if typeName == "style1" then
		local content = cc.uiloader:seekNodeByName(self, "content")
		content:setString(properties.content)
	    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    	btntrue:setTouchEnabled(true)
    	btnfalse:setTouchEnabled(true)
    	addBtnEventListener(btntrue, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self.commonPopModel:btnClickTrue()
	        end
	    end)
    	addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self.commonPopModel:btnClickFalse()
	        end
	    end)

	elseif typeName == "style2" then
	    local labelTip = cc.uiloader:seekNodeByName(self, "Label_tip")
	    labelTip:setString(properties.content)
	    self:setTouchEnabled(true)
	    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
	        if event.name=='began' then
	            ui:closePopup()
	            return true
	        end
	    end)

	    -- auto remove popup windows after 2 secs.
	    self:runAction(transition.sequence({cc.DelayTime:create(2), cc.CallFunc:create(function()
            ui:closePopup()
        end)}))

	elseif typeName == "style3" then
		local content = cc.uiloader:seekNodeByName(self, "content")
		content:setString(properties.content)
	    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    	btntrue:setTouchEnabled(true)
    	btnfalse:setTouchEnabled(true)
    	addBtnEventListener(btntrue, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self.commonPopModel:btnClickTrue()
	        end
	    end)
    	addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self.commonPopModel:btnClickFalse()
	        end
	    end)

	end
end

return commonPopup