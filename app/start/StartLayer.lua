local StartLayer = class("StartLayer", function()
	return display.newLayer()
end)

function StartLayer:ctor()
	self:loadCCS()
	self:initUI()
end

function StartLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/zhucaidan")
    local controlNode = cc.uiloader:load("zhucaidan_1.json")
    self:addChild(controlNode)
end

function StartLayer:initUI()
	local btnBegin = cc.uiloader:seekNodeByName(self, "beginbtn")
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
	ui:changeLayer("LoadingLayer",{})
end

return StartLayer