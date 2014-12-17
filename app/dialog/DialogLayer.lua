
local DialogConfigs = import(".DialogConfigs")
local DialogModel = import(".DialogModel")

local DialogLayer = class("DialogLayer", function()
    return display.newLayer()
end)

function DialogLayer:ctor(properties)
	self:loadCCS()
	self:initUI()
	self.index = 1
    self.DialogModel = app:getInstance(DialogModel)

	self:refreshUI(1, "level"..3, "forward", self.index)
end

function DialogLayer:loadCCS()
	--ui
    self.dialogNode = cc.uiloader:load("res/Dialog/duihua.ExportJson")
    self:addChild(self.dialogNode, 10)
end

function DialogLayer:initUI()
	self.msglabel = cc.uiloader:seekNodeByName(self, "msg")
	self.left = cc.uiloader:seekNodeByName(self, "roleleft")
	self.right = cc.uiloader:seekNodeByName(self, "roleright")
	local panldialog = cc.uiloader:seekNodeByName(self, "panldialog")
	panldialog:setTouchEnabled(true)
	panldialog:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then                
            return true
        elseif event.name=='ended' then
            local num = self.DialogModel:getDialogNum(1, "level"..3, "forward")
            if self.index > num then
	           	ui:closePopup()
            else
	            self:refreshUI(1, "level"..3, "forward", self.index)
	        end
        end
    end)
end

function DialogLayer:refreshUI(groupId,levelId,appear,index)
	local configs = DialogConfigs.getConfig(groupId,levelId,appear)
	dump(configs)
	local sentence = configs[index]
	local role = sentence["role"]
	local msg = sentence["msg"]
	local imgname = sentence["imgname"]
	local pos = sentence["pos"]
	local roleimg = display.newSprite("#"..imgname..".png")
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
	dump(self.index)

end

return DialogLayer