local KefuPopup = class("KefuPopup", function()
    return display.newLayer()
end)

function KefuPopup:ctor(properties)
	self.properties = properties
	self:loadCCS()
	self:initUI()
end

function KefuPopup:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/CommonPopup/erjijiemian")
    local controlNode = cc.uiloader:load("style_kefu.ExportJson")
    self:addChild(controlNode)
end

function KefuPopup:initUI()
    --content
    local content = cc.uiloader:seekNodeByName(self, "content")
    if self.properties.content then 
        content:setString(self.properties.content)
    end
    
    --btns
    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    local btncall = cc.uiloader:seekNodeByName(self, "btncall")
    local label_kefu = cc.uiloader:seekNodeByName(self, "label_kefu")
    btntrue:setTouchEnabled(true)
    btnfalse:setTouchEnabled(true)
    btncall:setTouchEnabled(true)
    label_kefu:setString(__kefuNum)
    label_kefu:setColor(cc.c3b(255, 205, 0))

    addBtnEventListener(btntrue, function( event )
        if event.name == "began" then
            return true
        elseif event.name == "ended" then
            print("btntrue is pressed!") 
            ui:closePopup("KefuPopup")
        end
    end)

    addBtnEventListener(btnfalse, function( event )
        if event.name == "began" then
            return true
        elseif event.name == "ended" then
            print("btnfalse is pressed!")
            ui:closePopup("KefuPopup")
        end
    end)

    btncall:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
        if event.name == "began" then
            print("btncall is pressed!")
            return true
        elseif event.name == "ended" then
            
            if device.platform == "android" then

                local className = "com/hgtt/com/IAPControl"
                luaj.callStaticMethod(className, "callPhone")
                print("btncall is pressed!")
            end
        end
    end)
end

return KefuPopup