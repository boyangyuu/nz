local InputBoxPopup = class("InputBoxPopup", function()
    return display.newLayer()
end)

function InputBoxPopup:ctor(properties)
	self.properties = properties
    self.inputString = ""
	self:loadCCS()
	self:initUI()
end

function InputBoxPopup:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/CommonPopup/erjijiemian")
    local controlNode = cc.uiloader:load("style_input.ExportJson")
    self:addChild(controlNode)
end

function InputBoxPopup:initUI()
	local contentBox = cc.uiloader:seekNodeByName(self, "content")
    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    contentBox:setPlaceHolder(self.properties.content)
	btntrue:setTouchEnabled(true)
	btnfalse:setTouchEnabled(true)
    contentBox:setMaxLengthEnabled(true)
    contentBox:setMaxLength(25)
	contentBox:addEventListener(function(contentBox, eventType)
            if device.platform == "ios" then
        		 self.inputString = contentBox:getString() --cocos 3.5
            else
                 self.inputString = contentBox:getText()
            end
		end)

	addBtnEventListener(btntrue, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickConfirm()
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

function InputBoxPopup:onClickConfirm()
    if self.inputString ~= "" then
        local data = {inputString = self.inputString}
        self.properties.onClickConfirm(data)
        ui:closePopup("InputBoxPopup")
    else
        ui:showPopup("commonPopup",
         {type = "style1",content = LanguageManager.getStringForKey("string_hint1")},
         {opacity = 100})
    end
end


function InputBoxPopup:onClickClose()
	ui:closePopup("InputBoxPopup")
end

return InputBoxPopup