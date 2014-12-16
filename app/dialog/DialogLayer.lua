
local DialogConfigs = import(".DialogConfigs")

local DialogLayer = class("DialogLayer", function()
    return display.newLayer()
end)

function DialogLayer:ctor(properties)
	
end

function DialogLayer:loadCCS()
	--ui
    self.dialogNode = cc.uiloader:load("res/Dialog/duihua.ExportJson")
    self:addChild(self.dialogNode, 10)
end

function DialogLayer:refreshUI(groupId,levelId,appear)
	DialogConfigs.getConfig(groupId,levelId,appear)
end

return DialogLayer