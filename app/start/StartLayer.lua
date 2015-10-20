local StartLayer = class("StartLayer", function()
    return display.newLayer()
end)

function StartLayer:ctor()
    --test 3
    self:loadCCS()
    self:initUI()
    self:initMusicUI()
    self:setNodeEventEnabled(true)

    self.dailyLoginModel = md:getInstance("DailyLoginModel")
    self.activeCodeModel = md:getInstance("ActiveCodeModel")

end

function StartLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/Start")
    local controlNode = cc.uiloader:load("zhucaidan_1.json")
    self:addChild(controlNode)
end

function StartLayer:initUI()
    local panlAnim = cc.uiloader:seekNodeByName(self, "panlAnim")
    local p = cc.uiloader:seekNodeByName(self, "Image_17")
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
    p:addChild(armature,100)
    armature:getAnimation():play("caidantx" , -1, 1)

    local dlArmature = ccs.Armature:create("dl_logo")
    dlArmature:setPosition(cc.p(-80,-10))
    panlAnim:addChild(dlArmature)
    dlArmature:getAnimation():play("chixu" , -1, 1)

    self.btnBegin = cc.uiloader:seekNodeByName(self, "btnBegin")
    self.btnAbout = cc.uiloader:seekNodeByName(self, "btnAbout")
    self.btnHelp = cc.uiloader:seekNodeByName(self, "btnHelp")
    self.btnMusic = cc.uiloader:seekNodeByName(self, "btnMusic")
    self.btnActivate = cc.uiloader:seekNodeByName(self, "btnActivate")
    self.btnGonggao = cc.uiloader:seekNodeByName(self, "btnGonggao")

    local seq = transition.sequence({
        cc.ScaleTo:create(0.6, 1.04),
        cc.ScaleTo:create(0.6, 0.96),})
    self.btnBegin:runAction(cc.RepeatForever:create(seq))

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
           ui:showPopup("AboutPopup",{popupName = "bangzhu"},{animName = "normal"})
        end
    end)

    self.btnGonggao:setTouchEnabled(true)
    addBtnEventListener(self.btnGonggao, function( event )
        if event.name == "began" then
            return true
        elseif event.name == "ended" then
            self:onClickBtnGongGao()
        end
    end)

    self.btnActivate:setTouchEnabled(true)
    addBtnEventListener(self.btnActivate, function( event )
        if event.name == "began" then
            return true
        elseif event.name == "ended" then
            -- ui:showPopup("KefuPopup",{
            --         opacity = 0})
        end
    end)
end

function StartLayer:onClickBtnGongGao()
   ui:showPopup("AboutPopup",{popupName = "gonggao_1"},{animName = "normal"})
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

    audio.setMusicVolume(0.8)
end

function StartLayer:playEnterSound()
    local soundSrc  = "res/Music/ui/dl_logo.wav"
    self.enterSound = audio.playSound(soundSrc,false)
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
    audio.stopSound(self.enterSound)
    -- self:playBgMusic()

    --save
    local data = getUserData()
    data.preference["isOpenMusic"] = isPlaying
    setUserData(data)
end

function StartLayer:onEnter()

    --set sound
    local data = getUserData()
    local isPlaying = data.preference["isOpenMusic"]
    audio.switchAllMusicAndSounds(isPlaying)

    --music
    -- self:playEnterSound()
    -- self:playBgMusic()

    --um
    local guide = md:getInstance("Guide")
    guide:checkGuideUM("login")

    --gonggao
    ui:showPopup("AboutPopup",{popupName = "gonggao_1"}, {animName = "normal"})


    --login award 服务器请求不能与loadccd并行！！
    self:initDailyLogin()
end

function StartLayer:onClickBegan()
    print("function StartLayer:onClickBegan()")
    local guide = md:getInstance("Guide")

    if self:isGuideDone() then
        local levelMapModel = md:getInstance("LevelMapModel")
        local groupId, levelId = levelMapModel:getConfig()
        -- print("groupId", groupId)

        local fightData = {
            fightType = "levelFight",
            groupId = groupId,
            levelId = levelId,
        }
        ui:changeLayer("HomeBarLayer",{fightData = fightData,loadingType = "home_first"})

    else
        --clear data
        guide:clearData()

        --story
        ui:changeLayer("storyLayer",{})

    end

    -- --test
    -- local fightData = { groupId = 70,levelId = 3, fightType = "jujiFight"}  --无限狙击
    -- ui:changeLayer("FightPlayer", {fightData = fightData})
end

function StartLayer:isGuideDone()
    local guide = md:getInstance("Guide")
    local levelMapModel = md:getInstance("LevelMapModel")
    local groupId, levelId = levelMapModel:getConfig()
    local isFirst = groupId == 1 and levelId == 1
    if not isFirst then return true end
    return guide:isDone("afterfight01")
end

function StartLayer:initDailyLogin()
    local guide = md:getInstance("Guide")
    local function callfunc(status)
        print("网络请求", status)
        if status == "success" and not guide:getIsGuiding() then
            ui:showPopup("DailyLoginLayer", {})
        end
    end

    --test
    self.dailyLoginModel:requestDateSever(callfunc)
end

return StartLayer