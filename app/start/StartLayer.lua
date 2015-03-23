local scheduler          = require(cc.PACKAGE_NAME .. ".scheduler")

local StartLayer = class("StartLayer", function()
	return display.newLayer()
end)

function StartLayer:ctor()
	self:loadCCS()
	self:initUI()
    self:initMusicUI()
    self:setNodeEventEnabled(true)
end

function StartLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/Start")
    local controlNode = cc.uiloader:load("zhucaidan_1.json")
    self:addChild(controlNode)
end

function StartLayer:initUI()
    local panlAnim = cc.uiloader:seekNodeByName(self, "panlAnim")
    local src = "res/Start/caidantx/caidantx.ExportJson"
    local logosrc = "res/Start/dl_logo/dl_logo.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    manager:addArmatureFileInfo(logosrc)

    local plist = "res/Start/caidantx/caidantx0.plist"
    local png = "res/Start/caidantx/caidantx0.png"
    display.addSpriteFrames(plist,png)
    local plist = "res/Start/dl_logo/dl_logo0.plist"
    local png = "res/Start/dl_logo/dl_logo0.png"
    display.addSpriteFrames(plist,png)

    local armature = ccs.Armature:create("caidantx")
    armature:setPosition(cc.p(568,320))
    self:addChild(armature,100)
    armature:getAnimation():play("caidantx" , -1, 1)

    local dlArmature = ccs.Armature:create("dl_logo")
    dlArmature:getAnimation():setMovementEventCallFunc(   
         function ( armatureBack,movementType,movement) 
            if movementType == ccs.MovementEventType.complete then
                dlArmature:getAnimation():play("chixu" , -1, 1)
            end 
        end)

    panlAnim:addChild(dlArmature)
    dlArmature:getAnimation():play("start" , -1, 0)

    scheduler.performWithDelayGlobal(handler(self, self.playEnterAnim), 1.9) 
    self.btnBegin = cc.uiloader:seekNodeByName(self, "btnBegin")
    self.btnAbout = cc.uiloader:seekNodeByName(self, "btnAbout")
    self.btnHelp = cc.uiloader:seekNodeByName(self, "btnHelp")
    self.btnMusic = cc.uiloader:seekNodeByName(self, "btnMusic")
    self.btnActivate = cc.uiloader:seekNodeByName(self, "btnActivate")
    self.imgBegin = cc.uiloader:seekNodeByName(self, "imgbegin")
    self.imgBegin:setScale(5)
    self.imgBegin:setVisible(false)
    

    self.btnBegin:setTouchEnabled(true)
    addBtnEventListener(self.btnBegin, function(event)
        if event.name == 'began' then
            print("btnBegin is begining!")
            return true
        elseif event.name == 'ended' then
            self:onClickBegan()
        end
    end)

    self.btnAbout:setTouchEnabled(true)
    addBtnEventListener(self.btnAbout, function( event )
        if event.name == 'began' then
            return true
        elseif event.name == 'ended' then
            ui:showPopup("AboutPopup",{popupName = "guangyu"})
        end
    end)

    self.btnHelp:setTouchEnabled(true)
    addBtnEventListener(self.btnHelp, function( event )
        if event.name == "began" then
            return true
        elseif event.name == "ended" then 
           ui:showPopup("AboutPopup",{popupName = "bangzhu"},{anim = false})
        end
    end)
end

function StartLayer:initMusicUI()
    local data = getUserData()
    local isOpenMusic = data.preference["isOpenMusic"]

    self.btnMusic:setTouchEnabled(true)
    local play = cc.uiloader:seekNodeByName(self.btnMusic, "play")
    local stop = cc.uiloader:seekNodeByName(self.btnMusic, "stop")
    play:setVisible(not isOpenMusic)
    stop:setVisible(isOpenMusic)
    
    addBtnEventListener(self.btnMusic, function(event)
        if event.name == "began" then 
            return true
        elseif event.name == "ended" then
            self:switchSound()
        end
    end)    
end

function StartLayer:playBgMusic()
    local startMusic = "res/Music/bg/bjyx.wav"
    audio.playMusic(startMusic,true)
end

function StartLayer:playEnterSound()
    local soundSrc  = "res/Music/ui/dl_logo.wav"
    audio.playSound(soundSrc,false)  
end

function StartLayer:playEnterAnim()
    local i = 1
    local btnKeys = {"btnActivate", "btnAbout","btnHelp","btnMusic","btnBegin"}
    for i,v in ipairs(btnKeys) do
        local delay = i * 0.1
        function delayMoveBy()
            local action = cc.MoveBy:create(0.2, cc.p(-450,0))
            self[v]:runAction(action)
        end
        i= i+1
        scheduler.performWithDelayGlobal(delayMoveBy, delay)
    end

    function delayScaleTo()
        self.imgBegin:setVisible(true)
        local sequence = transition.sequence({
            cc.ScaleTo:create(0.2, 1.5),
            cc.ScaleTo:create(0.1, 1.7),
            cc.ScaleTo:create(0.1, 1.5),
        })

        transition.execute(self.imgBegin, sequence)
    end
    scheduler.performWithDelayGlobal(delayScaleTo, 0.7)
end


function StartLayer:switchSound()
    local play      = cc.uiloader:seekNodeByName(self.btnMusic, "play")
    local stop      = cc.uiloader:seekNodeByName(self.btnMusic, "stop")    
    local isPlaying = audio.isSwitchOpen()
    isPlaying = not isPlaying
    
    --switch
    stop:setVisible(isPlaying)
    play:setVisible(not isPlaying)
    audio.switchAllMusicAndSounds(isPlaying)
    self:playBgMusic()

    --save
    local data = getUserData()
    data.preference["isOpenMusic"] = isPlaying
    setUserData(data)
end

function StartLayer:onEnter()
    --music 
    self:playBgMusic() 
    self:playEnterSound()
    
    --set sound
    local data = getUserData()
    local isPlaying = data.preference["isOpenMusic"]
    audio.switchAllMusicAndSounds(isPlaying)

    --init daily login
    self:initDailyLogin() 
end

function StartLayer:onClickBegan()
    print("function StartLayer:onClickBegan()")
          
    local guide = md:getInstance("Guide")

    if self:isGuideDone() then
        local levelMapModel = md:getInstance("LevelMapModel")
        local groupId, levelId = levelMapModel:getConfig()
        -- print("groupId", groupId)

        local userModel = md:getInstance("UserModel")
        local isDone = userModel:getUserLevel() >= 4
        ui:changeLayer("HomeBarLayer",{groupId = groupId,popWeaponGift = isDone, 
            loadingType = "home_first"})
    else
        --clear data
        guide:clearData()

        --story
        ui:changeLayer("storyLayer",{})
    end
end

function StartLayer:isGuideDone()
    local guide = md:getInstance("Guide")
    return guide:isDone("afterfight01")
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