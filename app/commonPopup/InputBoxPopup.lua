local InputBoxPopup = class("InputBoxPopup", function()
    return display.newLayer()
end)

function InputBoxPopup:ctor(properties)
	self.properties = properties
	self:loadCCS()
	self:initUI()
end

function InputBoxPopup:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/CommonPopup/erjijiemian")
    local controlNode = cc.uiloader:load("style8.ExportJson")
    self:addChild(controlNode)
end

function InputBoxPopup:initUI()
	local contentBox = cc.uiloader:seekNodeByName(self, "content")
    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
	if self.properties.content then
    	contentBox:setText(self.properties.content)
    end
	btntrue:setTouchEnabled(true)
	btnfalse:setTouchEnabled(true)

	local contentString = ""
	local user = md:getInstance("UserModel")
	contentBox:addEventListener(function(contentBox, eventType)
		if eventType == "began" then
	        -- 开始输入
	    elseif eventType == "changed" then
	        -- 输入框内容发生变化
	    elseif eventType == "ended" then
	        contentString = contentBox:getText()
	    elseif eventType == "return" then
	        -- 从输入框返回
	        contentString = contentBox:getText()
	    end
	end)

	addBtnEventListener(btntrue, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then		
        	if contentString ~= "" then
        		user:setUserName(contentString)
        	else
		        self:onClickCofirm()
        	end
        end
    end)

	addBtnEventListener(btnfalse, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then		
	        self:onClickClose()
        end
    end)
end

function InputBoxPopup:onClickCofirm()
	ui:closePopup("InputBoxPopup")
	local func =  self.properties.callfuncCofirm
	if func ~= nil then
		print("callfuncCofirm")
		func()		
	end
end

function InputBoxPopup:onClickClose()
	ui:closePopup("InputBoxPopup")
	local func =  self.properties.callfuncClose
	if func ~= nil then
		print("callfuncClose")
		func()
	end	
end

return InputBoxPopup