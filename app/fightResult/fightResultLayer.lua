
local FightResultLayer = class("FightResultLayer", function()
	return display.newLayer()
end)

function FightResultLayer:ctor(result)
	self:loadCCS()
	self:initUI()
    if result == true then
        --todo
        self.failed:setVisible(false)
        self.success:setVisible(true)
    else
        self.success:setVisible(false)
        self.failed:setVisible(true)
        --todo
    end
end

function FightResultLayer:loadCCS()
    -- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/fightResult")
    local controlNode = cc.uiloader:load("renwuwc.json")
    -- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode)
end

function FightResultLayer:initUI()
    self.success = cc.uiloader:seekNodeByName(self, "panl_renwuwc")
    self.failed  = cc.uiloader:seekNodeByName(self, "panl_renwusb")
    self.success:setTouchEnabled(true)
    self.failed:setTouchEnabled(true)
    addBtnEventListener(self.success, function(event)
        if event.name == 'began' then
            print("btnBegin is begining!")
            return true
        elseif event.name == 'ended' then
            app:runc()
        end
    end)
    addBtnEventListener(self.failed, function(event)
        if event.name == 'began' then
            print("btnBegin is begining!")
            return true
        elseif event.name == 'ended' then
            app:runc()
        end
    end)
end

return FightResultLayer