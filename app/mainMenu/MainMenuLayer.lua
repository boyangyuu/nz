local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local HomeBarLayer = import("..homeBar.HomeBarLayer")

local MainMenuLayer = class("MainMenuLayer", function()
	return display.newLayer()
end)

function MainMenuLayer:ctor()
	self:loadCCS()
	self:initUI()
end

function MainMenuLayer:loadCCS()
    -- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/MainMenu")
    local controlNode = cc.uiloader:load("zhucaidan_1.json")
    -- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode)
end

function MainMenuLayer:initUI()
    local btnBegin = cc.uiloader:seekNodeByName(self, "btn_begin")
    btnBegin:setTouchEnabled(true)
    addBtnEventListener(btnBegin, function(event)
        if event.name == 'began' then
            print("btnBegin is begining!")
            return true
        elseif event.name == 'ended' then
        	self:beginGame()
        end
    end)
end

function MainMenuLayer:beginGame()
 --    self:removeAllChildren()
	-- local homeBarLayer = HomeBarLayer.new()
 --    self:addChild(homeBarLayer)
    app:runc()
end

return MainMenuLayer