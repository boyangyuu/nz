
local DialogConfigs = import(".DialogConfigs")

local DialogLayer = class("DialogLayer", function()
    return display.newLayer()
end)

function DialogLayer:ctor()
	self:loadCCS()
	self:initUI()
	self.index = 1
    self.dialog = md:getInstance("DialogModel")
    self.fight  = md:getInstance("Fight")   
    -- self.appear = ""
	-- get Group Level
    self.groupID = self.fight:getGroupId()
    self.levelID = self.fight:getLevelId()

	--event
	cc.EventProxy.new(self.dialog, self)
		:addEventListener(self.dialog.DIALOG_FINISH_EVENT, handler(self, self.finish))
		:addEventListener(self.dialog.DIALOG_START_EVENT, handler(self, self.start))

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
	local panldialog = cc.uiloader:seekNodeByName(self, "tappanl")
	panldialog:setTouchEnabled(true)
	panldialog:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then                
            return true
        elseif event.name=='ended' then
            if self.index > self.num then
	           	self.dialog:finishDialog()
            else
	            self:refreshUI(self.groupID, "level"..self.levelID, self.appear)
	        end
        end
    end)
end

-- local appear
function DialogLayer:start(event)

	self.appear = event.appear

	self.num = self.dialog:getDialogNum(self.groupID, "level"..self.levelID, self.appear)

	self:refreshUI(self.groupID, "level"..self.levelID, self.appear)
end

function DialogLayer:refreshUI(groupId,levelId,appear)
	local configs = DialogConfigs.getConfig(groupId,levelId,appear)
	dump(configs)
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
	-- self.msglabel:speak(0.1)
	self.index = self.index + 1
end

function DialogLayer:finish()
	--visible
	self:setVisible(false)
end

return DialogLayer