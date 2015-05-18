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
		 contentString = contentBox:getText()
		end)

	addBtnEventListener(btntrue, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then		
        	if contentString ~= "" then
        		user:setUserName(contentString)
        		ui:closePopup("InputBoxPopup")
        	else
		        ui:showPopup("commonPopup",
				 {type = "style1",content = "名称不能为空"},
				 {opacity = 100})
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


function InputBoxPopup:onClickClose()
	ui:closePopup("InputBoxPopup")
end

return InputBoxPopup