local LayerColor_BLACK = cc.c4b(0, 0, 0, 180)

local DialogConfigs = import(".DialogConfigs")
local LayerColor_BLACK = cc.c4b(0, 0, 0, 180)
local DialogLayer = class("DialogLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function DialogLayer:ctor()
    self.dialog = md:getInstance("DialogModel")
	self.index = 1

	--event
	cc.EventProxy.new(self.dialog, self)
		:addEventListener(self.dialog.DIALOG_FINISH_EVENT, handler(self, self.finish))
		:addEventListener(self.dialog.DIALOG_START_EVENT, handler(self, self.start))
	
	self:loadCCS()
	self:initUI()
end

function DialogLayer:loadCCS()
	--ui
    self.dialogNode = cc.uiloader:load("res/Dialog/duihua.ExportJson")
    self:addChild(self.dialogNode, 10)
end

function DialogLayer:initUI()
	self:setVisible(false)

	self.msglabel = cc.uiloader:seekNodeByName(self, "msg")
	self.left = cc.uiloader:seekNodeByName(self, "roleleft")
	self.right = cc.uiloader:seekNodeByName(self, "roleright")
	local panldialog = cc.uiloader:seekNodeByName(self, "tappanl")
	panldialog:setTouchEnabled(true)
	panldialog:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
	    	if self.msglabel:isSpeaking() then
	    		self.msglabel:stopSpeak()
	    	else
	            if self.index > self.num then
	            	self:finishDialog()
	            else
		            self:refreshUI()
		        end
        	end
        end
    end)
end

function DialogLayer:start(event)
	self:setVisible(true)
	print("function DialogLayer:start(event)")

	self.num = self.dialog:getDialogNum()

	self:refreshUI()
end

function DialogLayer:finishDialog()
	self.dialog:finishDialog()

	--clear
	self.index = 1
end


function DialogLayer:refreshUI()
	local fight  = md:getInstance("Fight") 	
	local groupId = fight:getGroupId()
	local levelId = fight:getLevelId()
	local appear  = self.dialog:getAppearType() 
	local configs = DialogConfigs.getConfig(groupId,levelId,appear)
	local sentence = configs[self.index]
	local role = sentence["role"]
	local msg = sentence["msg"]
	local imgname = sentence["imgname"]
	local pos = sentence["pos"]
	local roleimg = display.newSprite("#"..imgname..".png")
	roleimg:setScale(1.33)
	self.left:removeAllChildren()
	self.right:removeAllChildren()
	if pos == "left" then
		addChildCenter(roleimg, self.left)
	else
		addChildCenter(roleimg, self.right)
	end
	self.msglabel:setString(msg)
	self.msglabel:speak(0.1)
	self.index = self.index + 1
end

function DialogLayer:finish(event)
	--visible
	self:setVisible(false)
end

return DialogLayer