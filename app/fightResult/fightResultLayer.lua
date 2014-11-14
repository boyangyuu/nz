local fightResultLayer = class("fightResultLayer", function()
	return display.newLayer()
end)

function fightResultLayer:ctor()
	self:loadCCS()
	self:initUI()
end

function fightResultLayer:loadCCS()
    -- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/fightResult")
    local controlNode = cc.uiloader:load("renwuwc.json")
    -- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode)
end

function fightResultLayer:initUI()
    local success = cc.uiloader:seekNodeByName(self, "panl_renwuwc")
    local success = cc.uiloader:seekNodeByName(self, "panl_renwusb")
end



return fightResultLayer