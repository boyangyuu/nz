local StartMenuLayer = class("StartMenuLayer", function()
    return display.newLayer()
end)

function StartMenuLayer:ctor()
	self:loadCCS()
end

function StartMenuLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/Start")
    local controlNode = cc.uiloader:load("zhucaidan_1.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)
    local stattbtn = cc.uiloader:seekNodeByName(self, "Panel_9")
    stattbtn:setTouchEnabled(true)
    addBtnEventListener(stattbtn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	-- dispach
        end
    end)
end

return StartMenuLayer