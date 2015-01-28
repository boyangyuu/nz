local StartLayer = class("StartLayer", function()
	return display.newLayer()
end)

function StartLayer:ctor()
    self:playSound()
	self:loadCCS()
	self:initUI()
    self:setNodeEventEnabled(true)
end

function StartLayer:playSound()
    local startMusic = "res/Start/start.ogg"
    audio.playMusic(startMusic,true)
end

function StartLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/Start")
    local controlNode = cc.uiloader:load("zhucaidan_1.ExportJson")
    self:addChild(controlNode)
end

function StartLayer:initUI()
    local btnBegin = cc.uiloader:seekNodeByName(self, "beginbtn")
    local gifticon = cc.uiloader:seekNodeByName(self, "gifticon")
    gifticon:setColor(cc.c3b(255, 45, 49))
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
    local src = "res/Start/caidantx/caidantx.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local armature = ccs.Armature:create("caidantx")
    armature:setPosition(cc.p(568,320))
    self:addChild(armature,100)
    armature:getAnimation():play("caidantx" , -1, 1)

end

function StartLayer:onEnter()
    
end

function StartLayer:beginGame()
	ui:changeLayer("HomeBarLayer",{})
end

return StartLayer