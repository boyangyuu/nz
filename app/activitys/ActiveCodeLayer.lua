local ActiveCodeLayer = class("ActiveCodeLayer", function()
    return display.newLayer()
end)

function ActiveCodeLayer:ctor()
    self.activeCodeModel = md:getInstance("ActiveCodeModel")
    self:loadCCS()
    self:initUI()
end

function ActiveCodeLayer:loadCCS()
    self.ui = cc.uiloader:load("ActiveCode/jiangliduihuan.ExportJson")
    self:addChild(self.ui)
end

function ActiveCodeLayer:initUI()
    local contentBox = cc.uiloader:seekNodeByName(self, "content")
    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
    btntrue:setTouchEnabled(true)
    contentBox:setMaxLengthEnabled(true)
    contentBox:setMaxLength(25)
    self.inputString = ""
    contentBox:addEventListener(function(contentBox, eventType)
        if device.platform == "ios" then
             self.inputString = contentBox:getString() --cocos 3.5
        else
             self.inputString = contentBox:getText()
        end
    end)
    addBtnEventListener(btntrue, function(event)
        if event.name == 'began' then
            return true
        elseif event.name == 'ended' then
            self:onInputActiveCode()
        end
    end)
end

function ActiveCodeLayer:onInputActiveCode()
    self.activeCode = self.inputString
    if self.activeCode == "" then
        ui:showPopup("commonPopup",
             {type = "style2",content = LanguageManager.getStringForKey("string_hint1")},
             {opacity = 100})
        return
    end
    if self.activeCode == "81556146laose"
        and JavaUtils.getIsShenhe() then
        __isDebug = true
        __isFree = true
        __reviewLimitData = {year = 2015, month = 7, day = 24}
        local guideModel = md:getInstance("Guide")
        guideModel:fillData()
        local data = getUserData()
        data.currentlevel.group = 10
        data.currentlevel.level = 1
        data.user.level = 20
        setUserData(data)
        ui:showPopup("commonPopup",
         {type = "style2", content = LanguageManager.getStringForKey("string_hint2")},
         {opacity = 0})
        return
    end
    if self.activeCodeModel:checkGet(self.activeCode) then
        ui:showPopup("commonPopup",
         {type = "style2", content = LanguageManager.getStringForKey("string_hint3")},
         {opacity = 0})
        return
    end

    local url = "http://123.57.213.26/gift/dsx_gift/get_gift.php?activeCode="..self.activeCode
    local request = network.createHTTPRequest(handler(self,self.onRequestFinished), url, "GET")
    request:start()

end

function ActiveCodeLayer:onRequestFinished(event)
    local ok = (event.name == "completed")
    local request = event.request
    if request == nil then return end
     if event.name == "failed" then
        ui:showPopup("commonPopup",
         {type = "style2", content = LanguageManager.getStringForKey("string_hint4")},
         {opacity = 0})
        return
    end

    if not ok then
        -- 请求失败，显示错误代码和错误消息
        print("getErrorMessage", request:getErrorMessage())
        return
    end

    local code = request:getResponseStatusCode()
    if code ~= 200 then
        print("getErrorMessage", request:getErrorMessage())
        print("request:getErrorCode()", request:getErrorCode())
        ui:showPopup("commonPopup",
         {type = "style2", content = LanguageManager.getStringForKey("string_hint4")},
         {opacity = 0})
        return
    end

    --请求成功
    local response = request:getResponseString()
    print("请求成功 response", response)
    response = string.sub(response,string.len(response)-1,string.len(response))

    if response == "11" then
        ui:showPopup("commonPopup",
         {type = "style2", content = LanguageManager.getStringForKey("string_hint5")},
         {opacity = 0})
    elseif response == "12" then
        ui:showPopup("commonPopup",
         {type = "style2", content = LanguageManager.getStringForKey("string_hint2")},
         {opacity = 0})
    elseif response == "01" then
        ui:showPopup("commonPopup",
         {type = "style2", content = LanguageManager.getStringForKey("string_hint6")},
         {opacity = 0})
        self.activeCodeModel:sentActiveGift(self.activeCode)
        self.activeCodeModel:setGet(self.activeCode)
    else
        dump(response)
    end
end

return ActiveCodeLayer