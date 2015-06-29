local StartLayer = class("StartLayer", function()
	return display.newLayer()
end)

function StartLayer:ctor()
	self:loadCCS()
	self:initUI()
    self:initMusicUI()
    self:setNodeEventEnabled(true)

    self.dailyLoginModel = md:getInstance("DailyLoginModel")

--[[
    local function onRequestFinished(event)
        local ok = (event.name == "completed")
        local request = event.request
     
        if not ok then
            -- 请求失败，显示错误代码和错误消息
            print(request:getErrorCode(), request:getErrorMessage())
            return
        end
     
        local code = request:getResponseStatusCode()
        if code ~= 200 then
            -- 请求结束，但没有返回 200 响应代码
            print(code)
            return
        end

        --请求成功
        local response = request:getResponseString()
        print("请求成功 response", response)        
    end
 
    local url = "http://121.42.208.220:21080/gift/dsx_gift/get_gift.php"

    
    local request = network.createHTTPRequest(onRequestFinished, url, "POST")
    request:addPOSTValue("activeCode","A408c58646f0e46f6")
    request:start()
    ]]    
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
    dlArmature:getAnimation():setMovementEventCallFunc(   
         function (armatureBack,movementType,movement) 
            if movementType == ccs.MovementEventType.complete then
                dlArmature:getAnimation():play("chixu" , -1, 1)
            end 
        end)

    panlAnim:addChild(dlArmature)
    dlArmature:getAnimation():play("start" , -1, 0)

    self.btnBegin = cc.uiloader:seekNodeByName(self, "btnBegin")
    self.btnAbout = cc.uiloader:seekNodeByName(self, "btnAbout")
    self.btnHelp = cc.uiloader:seekNodeByName(self, "btnHelp")
    self.btnMusic = cc.uiloader:seekNodeByName(self, "btnMusic")
    self.btnActivate = cc.uiloader:seekNodeByName(self, "btnActivate")

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

    self.btnActivate:setTouchEnabled(true)
    addBtnEventListener(self.btnActivate, function( event )
        if event.name == "began" then
            return true
        elseif event.name == "ended" then 
            self:onClickActiveCode()
        end
    end)

    local btnTousu = cc.uiloader:seekNodeByName(self, "btnTousu")

    local manager = ccs.ArmatureDataManager:getInstance()
    local toususrc = "res/LevelMap/tousu_tx/tousu_tx.ExportJson"
    manager:addArmatureFileInfo(toususrc)
    local plist = "res/LevelMap/tousu_tx/tousu_tx0.plist"
    local png   = "res/LevelMap/tousu_tx/tousu_tx0.png"
    display.addSpriteFrames(plist, png)  

    local tousuArm = ccs.Armature:create("tousu_tx")
    addChildCenter(tousuArm, btnTousu)
    tousuArm:getAnimation():play("Animation1" , -1, 1)

    -- 添加客服按钮点击事件
    btnTousu:onButtonPressed(function( event )
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function( event )
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function( event )
            ui:showPopup("KefuPopup",{
                    opacity = 0})
        end)
end

function StartLayer:onClickActiveCode()
    ui:showPopup("InputBoxPopup", 
        {content = "请输入激活码",
         onClickConfirm = handler(self, self.onInputActiveCode)}, 
         {opacity = 0})
end

function StartLayer:onInputActiveCode(event)
    dump(event, "event")
    local str = event.inputString
    if str ~= "11" then
        ui:showPopup("commonPopup",
         {type = "style2", content = "激活码错误！"},
         {opacity = 0}) 
    end
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
    self:playEnterSound()
    -- self:playBgMusic() 

    --um
    local guide = md:getInstance("Guide")
    guide:checkGuideUM("login")

    --login award
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
end

function StartLayer:isGuideDone()
    local guide = md:getInstance("Guide")
    return guide:isDone("afterfight01")
end

function StartLayer:initDailyLogin()
    local function callfunc(status)
        print("网络请求", status)
        if status == "success" then            
            ui:showPopup("DailyLoginLayer", {})
        end
    end

    self.dailyLoginModel:requestDateSever(callfunc)
end

return StartLayer