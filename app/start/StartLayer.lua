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

    local btnMusic = cc.uiloader:seekNodeByName(self, "btnmusic")
    btnMusic:setTouchEnabled(true)
    local play = cc.uiloader:seekNodeByName(btnMusic, "play")
    local stop = cc.uiloader:seekNodeByName(btnMusic, "stop")
    play:setVisible(false)
    local isPlaying = true
    addBtnEventListener(btnMusic, function( event )
        if event.name == "began" then 
            return true
        elseif event.name == "ended" then
            if isPlaying then 
                stop:setVisible(false)
                play:setVisible(true)
                audio:pauseMusic()
                audio:pauseAllSounds()
                isPlaying = false
            else
                stop:setVisible(true)
                play:setVisible(false)
                audio:resumeMusic()
                audio:resumeAllSounds()
                isPlaying = true
            end
        end
    end)

    local btnAbout = cc.uiloader:seekNodeByName(self, "beginbtn_2")
    btnAbout:setTouchEnabled(true)
    addBtnEventListener(btnAbout, function( event )
        if event.name == 'began' then
            return true
        elseif event.name == 'ended' then
            ui:showPopup("AboutPopup",{popupName = "guangyu"})
        end
    end)

    local btnHelp = cc.uiloader:seekNodeByName(self, "beginbtn_1")
    btnHelp:setTouchEnabled(true)
    addBtnEventListener(btnHelp, function( event )
        if event.name == "began" then
            return true
        elseif event.name == "ended" then 
            ui:showPopup("AboutPopup",{popupName = "bangzhu"})
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

    self:initDailyLogin()

    if not self:isDone("isFirstRunning") then 
        ui:changeLayer("HomeBarLayer",{popgift = true})
    else
        ui:changeLayer("storyLayer",{})
    end
end

function StartLayer:isDone(id)
    local data = getUserData()
    if data then 
        return data.guide[id]
    else 
        return true
    end

 
end

function StartLayer:initDailyLogin()
    local dailyLoginModel = md:getInstance("DailyLoginModel")
    
    local isToday = dailyLoginModel:isToday()
    local isGet = dailyLoginModel:isGet()
    if isToday  == false  then
        dailyLoginModel:setGet(false)
    end
    dailyLoginModel:setTime()

end

return StartLayer