local StartLayer = class("StartLayer", function()
	return display.newLayer()
end)

function StartLayer:ctor()
	self:loadCCS()
	self:initUI()
    self:setNodeEventEnabled(true)
end

function StartLayer:playBgMusic()
    local startMusic = "res/Music/bg/bjyx.wav"
    audio.playMusic(startMusic,true)
end

function StartLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/Start")
    local controlNode = cc.uiloader:load("zhucaidan_1.json")
    self:addChild(controlNode)
end

function StartLayer:initUI()
    self:initMusicUI()

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

    local plist = "res/Start/caidantx/caidantx0.plist"
    local png = "res/Start/caidantx/caidantx0.png"
    display.addSpriteFrames(plist,png)

    local armature = ccs.Armature:create("caidantx")
    armature:setPosition(cc.p(568,320))
    self:addChild(armature,100)
    armature:getAnimation():play("caidantx" , -1, 1)
end

function StartLayer:initMusicUI()
    local data = getUserData()
    local isOpenMusic = data.preference["isOpenMusic"]

    local btnMusic = cc.uiloader:seekNodeByName(self, "btnmusic")
    btnMusic:setTouchEnabled(true)
    local play = cc.uiloader:seekNodeByName(btnMusic, "play")
    local stop = cc.uiloader:seekNodeByName(btnMusic, "stop")
    play:setVisible(isOpenMusic)
    stop:setVisible(not isOpenMusic)
    
    addBtnEventListener(btnMusic, function(event)
        if event.name == "began" then 
            return true
        elseif event.name == "ended" then
            self:switchSound()
        end
    end)    
end

function StartLayer:switchSound()
    local btnMusic  = cc.uiloader:seekNodeByName(self, "btnmusic")
    local play      = cc.uiloader:seekNodeByName(btnMusic, "play")
    local stop      = cc.uiloader:seekNodeByName(btnMusic, "stop")    
    local isPlaying = audio.isSwitchOpen()
    isPlaying = not isPlaying
    print("isPlaying", isPlaying)
    --switch

    stop:setVisible(not isPlaying)
    play:setVisible(isPlaying)
    audio.switchAllMusicAndSounds(isPlaying)

    --save
    local data = getUserData()
    data.preference["isOpenMusic"] = isPlaying
    setUserData(data)
end


function StartLayer:onEnter()
    self:playBgMusic() 

    local data = getUserData()
    local isPlaying = data.preference["isOpenMusic"]
    audio.switchAllMusicAndSounds(isPlaying)
end

function StartLayer:beginGame()
    self:initDailyLogin()       

    if self:isDone("gamePre") then 
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
    -- local data = getUserData()
    -- data.dailylogin.logintime = "%9"
    -- setUserData(data)

end

return StartLayer