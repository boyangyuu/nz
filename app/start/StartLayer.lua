local StartLayer = class("StartLayer", function()
	return display.newLayer()
end)

function StartLayer:ctor()
    self:playSound()
	self:loadCCS()
	self:initUI()
end

function StartLayer:playSound()
    local startMusic = "res/Start/start.ogg"
    audio.playMusic(startMusic,true)
end

function StartLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/zhucaidan")
    local controlNode = cc.uiloader:load("zhucaidan_1.ExportJson")
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
    local btnAbout = cc.uiloader:seekNodeByName(self, "beginbtn_2")
    btnAbout:setTouchEnabled(true)
    addBtnEventListener(btnAbout, function( event )
        if event.name == 'began' then
            return true
        elseif event.name == 'ended' then
            ui:showPopup("AboutPopup")
        end
    end)
end

function StartLayer:beginGame()
	ui:changeLayer("HomeBarLayer",{})
end

return StartLayer