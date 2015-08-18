local GiftBoxConfig = import(".GiftBoxConfig")

local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

--------  Constants  ---------
local Zorder_up = 10
local smallTime, bigTime = 0.5, 0.5  --Amplify times and time of background

function LevelMapLayer:ctor(properties)
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")

    --instance
    self.levelMapModel      = md:getInstance("LevelMapModel")
    self.giftBoxModel       = md:getInstance("GiftBoxModel")
    self.FightResultModel   = md:getInstance("FightResultModel")
    self.UserModel          = md:getInstance("UserModel")
    self.LevelDetailModel   = md:getInstance("LevelDetailModel")
    self.buyModel           = md:getInstance("BuyModel")
    self.properties = properties
    self.fightData = self.properties.fightData
    self.preGroupId = 0
    self.groupNum = self.levelMapModel:getGroupNum()    

    self:initGroupId()
    self:initUI()
    self:refreshLevelLayer(self.curGroupId)

    cc.EventProxy.new(ui, self)
        :addEventListener(ui.LOAD_HIDE_EVENT, handler(self, self.initBgLayer))
        :addEventListener(ui.LOAD_HIDE_EVENT, handler(self, self.mapPopUp))
    cc.EventProxy.new(self.levelMapModel, self)
        :addEventListener("HIDE_GIFTBAGICON_EVENT", handler(self, self.hideWeaponGiftBag))

    cc.EventProxy.new(self.buyModel, self)
        :addEventListener(self.buyModel.BUY_GIFTUPDATE_EVENT, 
            handler(self, self.refreshGift))

    self:initGuide() 
end

function LevelMapLayer:initUI()
    self:initChooseLayer()
    self:initKefuLayer()
    self:initFightActLayer()
    self:initGiftLayer()
end

function LevelMapLayer:initGroupId()
    assert(self.properties.fightData, "self.properties.fightData is nil")
    assert(self.fightData.groupId, "self.fightData.groupId is nil")
    assert(self.fightData.fightType, "self.fightData.fightType is nil")
    
    --set groupId
    local groupId, levelId = self.levelMapModel:getConfig()
    assert(groupId, "groupId getConfig")
    -- if self.fightData.fightType == "bossFight" then
    --     self.curGroupId = groupId
    -- elseif self.fightData.fightType == "jujiFight" then
    --     self.curGroupId = groupId
    -- else
    -- if self.fightData.fightType == "levelFight" then 
    if self.fightData.groupId == 0 and self.fightData.levelId == 0 then
        self.curGroupId = 1
    else
        self.curGroupId = groupId
    end
    -- end
    assert(self.curGroupId, "self.curGroupId is nil")
end

function LevelMapLayer:popUpWeaponGift()
    local isNotBought = self.buyModel:checkBought("weaponGiftBag") == false
    local isPopWeaponGift = false
    local userModel = md:getInstance("UserModel")
    local isDone = userModel:getUserLevel() >= 4

    --战斗失败返回世界地图
    if self.fightData["result"] == "fail" then isPopWeaponGift = true end
    --开始菜单进世界地图，玩家等级 >= 4
    if self.fightData["result"] == nil and isDone then isPopWeaponGift = true end
    if isPopWeaponGift and isNotBought then
        self.buyModel:showBuy("weaponGiftBag", 
            {isNotPopKefu = false},
            "主界面_进游戏自动弹出")
    elseif isPopWeaponGift then 
        self.buyModel:showBuy("goldGiftBag", 
            {isNotPopKefu = false},
            "主界面_进游戏自动弹出")   
    else 

    end
end

function LevelMapLayer:mapPopUp(event)
    -- if self.properties.fightData.fightType == "levelFight" then 
    function delayPopUpLF()
        self:popUpWeaponGift()   
    end
    self:performWithDelay(delayPopUpLF, 1)
    -- elseif self.properties.fightData.fightType == "bossFight" then
    --     local chapterIndex = self.properties.fightData.chapterIndex
    --     ui:showPopup("BossModeLayer", {chapterIndex = chapterIndex},{animName = "normal"})
    -- elseif self.properties.fightData.fightType == "jujiFight" then
    --     ui:showPopup("JujiModeLayer", {}, {animName = "normal"})
    -- end  
end

function LevelMapLayer:initBgLayer(event)
    -- bg starting animation
    self.armature = ccs.Armature:create("shijiemap")
    self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/shijiemap")
    local mapSrcName = "map_shijie.jpg"
    local skin = ccs.Skin:create(mapSrcName)
    self.armature:getBone("map_shijie"):addDisplay(skin, 1)
    self.armature:getBone("map_shijie"):changeDisplayWithIndex(1, true)

    self.armature:setAnchorPoint(0.5,0.5)
    self.armature:setPosition(display.width/2,display.height1/2)
    self:addChild(self.armature)
    
    -- print("self.curGroupId", self.curGroupId)
    if self.curGroupId == 0 then
        self.curGroupId = 1
    end
    self.armature:getAnimation():play("0_"..self.curGroupId , -1, 0)

    self.ldArmature = ccs.Armature:create("leida")
    self.ldArmature:setPosition(cc.p(568,300))
    self:addChild(self.ldArmature)
    self.ldArmature:getAnimation():play("leida" , -1, 1)

end

function LevelMapLayer:initGiftLayer()
    --一角礼包
    self:initUI_yijiaoGift()

    --土豪礼包
    self:initUI_goldGift()

    --武器礼包
    self:initUI_weaponGift()

    --vip礼包
    self:initUI_vipGift()

    --限时奖励礼包
    self:initUI_timeGift()

    --限时大促
    self:initUI_dacuGift()

    self:refreshGift()
end

function LevelMapLayer:initUI_yijiaoGift()
    local btnFirstGift = cc.uiloader:seekNodeByName(self.chooseRootNode, "btngift")
    if device.platform == "ios" then btnFirstGift:setVisible(false) return end
    btnFirstGift:onButtonClicked(function ()
        self.buyModel:showBuy("yijiaoBag", 
            {isGiftDirect = true},
            "主界面_点击新手礼包")
    end)    
end

function LevelMapLayer:initUI_goldGift()
    --土豪金
    local btnGold  = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_gold")
    local panelTuhaoAnim  = cc.uiloader:seekNodeByName(self.chooseRootNode, "animtuhao")
    local armature = ccs.Armature:create("thj_bx")
    armature:setPosition(5,-6)
    panelTuhaoAnim:addChild(armature) 
    armature:getAnimation():play("thj_bx" , -1, 1)

    btnGold:setTouchEnabled(true)
    addBtnEventListener(btnGold, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self.buyModel:showBuy("goldGiftBag", {
                isGiftDirect = true,
                }, 
                "主界面_点击土豪金礼包")
        end
    end)
end

function LevelMapLayer:initUI_weaponGift()
    --武器礼包
    local btnWeapon = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_weapon")
    if self.buyModel:checkBought("weaponGiftBag") then
        btnWeapon:setVisible(false)
    end        
    btnWeapon:setTouchEnabled(true)

    addBtnEventListener(btnWeapon, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self.buyModel:showBuy("weaponGiftBag", 
                {isGiftDirect = true,
                isNotPopKefu = true}, 
                "主界面_点击武器大礼包")
        end
    end)
end

function LevelMapLayer:initUI_vipGift()
    --vip
    local btnVip = cc.uiloader:seekNodeByName(self.chooseRootNode, "btnvip")
    btnVip:onButtonPressed(function( event )
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function( event )
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function()
            self:onClickGift_vip()
        end)   
end

function LevelMapLayer:onClickGift_vip()
    local isAvailable = network.isInternetConnectionAvailable()
    if isAvailable then
        local isBought = self.buyModel:checkBought("vip")
        if isBought then
            ui:showPopup("VipPopup",{style = "haveBought"},{opacity = 170})
        else
            ui:showPopup("VipPopup",{style = "notBought"},{opacity = 170})
        end
    else
        ui:showPopup("commonPopup",
             {type = "style1",content = "当前网络连接失败，请连接网络后领取奖励！"},
             {opacity = 0})
    end 
end

function LevelMapLayer:initUI_timeGift()
    local notiTime      = cc.uiloader:seekNodeByName(self.chooseRootNode, "noti")

    --限时礼包
    local btnTime      = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_time")
    local labelTime    = cc.uiloader:seekNodeByName(self.chooseRootNode, "label_time")    
    btnTime:onButtonPressed(function( event )
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function( event )
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function( event )
            self:onClickedBtnAwardTime()
        end)

    --timer
    local function funcTime()
        local awardModel = md:getInstance("AwardTimeModel") 
        local str = awardModel:getContent()   
        -- print("str", str)
        labelTime:setString(str)
        --check
        local awardModel = md:getInstance("AwardTimeModel")   
        local isCanAward = awardModel:isCanAward()
        if isCanAward then 
            notiTime:setVisible(true)
        else
            notiTime:setVisible(false)
        end
    end
    self:schedule(funcTime, 1.0)
end

function LevelMapLayer:initUI_dacuGift()
    local btnXianshi = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_xianshidacu")
    btnXianshi:onButtonClicked(function( event )
        ui:showPopup("GiftBagStonePopup", 
            {ccsName = "GiftBag_Xianshidacu",
            strPos   = "地图界面_点击限时大促",
            stoneCost = 450},
            {animName = "shake"})        
    end)
end

function LevelMapLayer:onClickedBtnAwardTime()
    local awardModel = md:getInstance("AwardTimeModel")   
    local isCanAward = awardModel:isCanAward()
    if isCanAward then 
        awardModel:achieveAward()
       ui:showPopup("commonPopup",
         {type = "style2", content = "领取成功！"},
         { opacity = 0})          
    else
       ui:showPopup("commonPopup",
         {type = "style2", content = "领取时间未到哦！"},
         { opacity = 0})        
    end
end

function LevelMapLayer:initFightActLayer()
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/chooseLevel")
    local btn_acts  = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_acts")
    local noti_acts = cc.uiloader:seekNodeByName(self.chooseRootNode, "noti_acts")

    --acts
    btn_acts:onButtonClicked(function ()
        local actModel = md:getInstance("ActivityMainModel")
        actModel:dispatchEvent({name = actModel.SHOW_ACTIVITYMAIN})
        noti_acts:setVisible(false)
    end)
end

function LevelMapLayer:initKefuLayer()
    --客服
    self.telNum = cc.uiloader:seekNodeByName(self, "telNum")
    self.telNum:setColor(cc.c3b(255, 0, 0))
    self.telNum:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.telNum:setString("官方唯一投诉电话："..__kefuNum)

    local btnkefu = cc.uiloader:seekNodeByName(self.chooseRootNode, "btnkefu")

    -- 添加客服按钮点击事件
    btnkefu:onButtonPressed(function( event )
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

function LevelMapLayer:initChooseLayer()
    self.chooseRootNode = cc.uiloader:load("chooseLevel/chooseLevelLayer.ExportJson")
    self:addChild(self.chooseRootNode, Zorder_up)

    self.btnNext = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_next")
    self.btnPre = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_pre")
    
    self.levelNum = cc.uiloader:seekNodeByName(self.chooseRootNode, "levelnum")
    self.panelRight = cc.uiloader:seekNodeByName(self.chooseRootNode, "panl_right")
    self.panelDown = cc.uiloader:seekNodeByName(self.chooseRootNode, "panl_level")
    self.panelLeft = cc.uiloader:seekNodeByName(self.chooseRootNode, "panel_left")
    
    self.levelNum:setString(self.curGroupId)

    local actionPre = transition.sequence({
    cc.MoveTo:create(0.5, cc.p(self.btnPre:getPositionX()-10 , self.btnPre:getPositionY())), 
    cc.MoveTo:create(0.5, cc.p(self.btnPre:getPositionX()+10, self.btnPre:getPositionY()))})
    self.btnPre:runAction(cc.RepeatForever:create(actionPre))

    local actionNext = transition.sequence({
    cc.MoveTo:create(0.5, cc.p(self.btnNext:getPositionX()+10 , self.btnNext:getPositionY())), 
    cc.MoveTo:create(0.5, cc.p(self.btnNext:getPositionX()-10, self.btnNext:getPositionY()))})
    self.btnNext:runAction(cc.RepeatForever:create(actionNext))

    addBtnEventListener(self.btnNext, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            if self.curGroupId >= self.groupNum then
                self.curGroupId = 1
                self.preGroupId = self.groupNum
            else
                self.curGroupId = self.curGroupId + 1
                self.preGroupId = self.curGroupId - 1
            end
            self:bgAction()
            self:panelAction()
            self.UserModel:panelAction()
            self.telNum:setVisible(false)
        end
    end)

    addBtnEventListener(self.btnPre, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            if self.curGroupId < 2 then
                self.curGroupId = self.groupNum
                self.preGroupId = 1
            else
                self.curGroupId = self.curGroupId - 1
                self.preGroupId = self.curGroupId + 1
            end
            self:bgAction()
            self:panelAction()
            self.UserModel:panelAction()
            self.telNum:setVisible(false)
        end
    end)
end

function LevelMapLayer:refreshLevelLayer(groupId)
    -- assert(adf,"groupId"..groupId)
    self.levelBtnRootNode = cc.uiloader:load("levelBtn/levelMap_"..groupId..".ExportJson")
    self:addChild(self.levelBtnRootNode, Zorder_up)

    --btn
    local levelName = {}
    local levelIcon = {}
    local levelAnim = {}
    local panelBtn = {}
    self.shadow = {}
    local panelGray = {}
    -- local dian = {}
    local imgIcon = {}
    local group,level = self.levelMapModel:getConfig()
    local groupInfo = self.levelMapModel:getGroupInfo(self.curGroupId)

    for k,v in pairs(groupInfo) do
        panelBtn[v] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "Panel_"..v)
        panelGray[v] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "gray_"..v)
        self.shadow[v] = cc.uiloader:seekNodeByName(self, "shadow_"..v)
    end

    for k,v in pairs(panelBtn) do
        levelName[k]  = cc.uiloader:seekNodeByName(v, "name")
        levelIcon[k] = cc.uiloader:seekNodeByName(v, "icon")
        levelAnim[k] = cc.uiloader:seekNodeByName(v, "anim")
        levelIcon[k]:setTouchEnabled(true)
        imgIcon[k] = cc.uiloader:seekNodeByName(v, "iconimg")
    end

    for k,v in pairs(groupInfo) do
        if  group > groupId or group == groupId and level > v then

        elseif group == groupId and level == v then
            panelGray[v]:setOpacity(0)           
            local action = transition.sequence({
            cc.MoveTo:create(0.625, cc.p(levelName[v]:getPositionX() , levelName[v]:getPositionY()+ 15)), 
            cc.MoveTo:create(0.625, cc.p(levelName[v]:getPositionX(), levelName[v]:getPositionY() - 15))})
            levelName[v]:runAction(cc.RepeatForever:create(action))

            local armature = ccs.Armature:create("sjdt_tbtx")
            levelAnim[level]:addChild(armature)
            armature:getAnimation():play("kaishi" , -1, 0)
            armature:getAnimation():setMovementEventCallFunc(
            function ( armatureBack,movementType,movementId ) 
                if movementType == ccs.MovementEventType.complete then
                    armature:getAnimation():play("chixu" , -1, 1)
                end
            end)
        else       
            levelName[v]:setOpacity(0)
            imgIcon[v]:setOpacity(0)
        end

        -- add listener
        levelIcon[v]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then
                if  group > groupId or group == groupId and level >= v  then
                    local levelId = v
                    ui:showPopup("LevelDetailLayer", {groupId = groupId, levelId = levelId})
                else                            
                    ui:showPopup("commonPopup",
                     {type = "style2", content = "本关还没开启"},
                     { opacity = 0})
                end
            end
        end)


        --宝箱
        -- local giftBoxInfo = GiftBoxConfig.getConfig(groupId,v)
        -- if giftBoxInfo then
        --     self:initGiftBox(groupId,k)
        -- end
    end
end

function LevelMapLayer:initGiftBox(groupId,levelId)
    local receiveState = self.giftBoxModel:getReceiveState(groupId,levelId)
    if receiveState == "canReceive" then
        local giftBoxImg = display.newSprite("#icon_yijiao.png")
        giftBoxImg:setPosition(cc.p(200,60))
        self.shadow[levelId]:addChild(giftBoxImg)
        addBtnEventListener(giftBoxImg, function(event)
            if event.name == 'began' then
                return true
            elseif event.name == 'ended' then
                self:onClickCanReceive()
            end
        end)    

    elseif receiveState == "alreadyReceive" then
        local giftBoxImg = display.newSprite("#icon_yijiao.png")
        giftBoxImg:setPosition(cc.p(200,60))
        self.shadow[levelId]:addChild(giftBoxImg) 

    elseif receiveState == "futureReceive" then
        local giftBoxImg = display.newSprite("#icon_yijiao.png")
        giftBoxImg:setPosition(cc.p(200,60))
        self.shadow[levelId]:addChild(giftBoxImg)    
        addBtnEventListener(giftBoxImg, function(event)
            if event.name == 'began' then
                return true
            elseif event.name == 'ended' then
                self:onClickFutureReceive()
            end
        end)    
    end
end

function LevelMapLayer:onClickCanReceive()
    print("onClickCanReceive")
end

function LevelMapLayer:onClickFutureReceive()
    print("onClickFutureReceive")
end

function LevelMapLayer:bgAction()    
    -- To make button disabled for a while
    self.ldArmature:removeFromParent()
    self.btnNext:setTouchEnabled(false)
    self.btnPre:setTouchEnabled(false)
    self.levelBtnRootNode:removeFromParent()
    self.animName = self.preGroupId.."_"..self.curGroupId
    self.armature:getAnimation():play(self.animName , -1, 0)
end

function LevelMapLayer:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.complete then
        armatureBack:stopAllActions()
        if movementID == self.animName then
            self.btnNext:setTouchEnabled(true)
            self.btnPre:setTouchEnabled(true)
            self.ldArmature = ccs.Armature:create("leida")
            self.ldArmature:setPosition(cc.p(568,300))
            self:addChild(self.ldArmature)
            self.ldArmature:getAnimation():play("leida" , -1, 1)
            self.levelNum:setString(self.curGroupId)
            self:refreshLevelLayer(self.curGroupId)
            self.telNum:setVisible(true)
        end
    end
end

function LevelMapLayer:panelAction()
    local changeTime = 0.2
    self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(self.panelRight:getContentSize().width+8, 0)))
    self.panelLeft:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelLeft:getContentSize().width-100, 0)))
    self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, -self.panelDown:getContentSize().height-5)))
    self.panelDown:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
                self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelRight:getContentSize().width-8, 0)))
                self.panelLeft:runAction(cc.MoveBy:create(changeTime, cc.p(self.panelLeft:getContentSize().width+100, 0)))
                self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelDown:getContentSize().height+5)))
            end)}))
end

function LevelMapLayer:onShow()  

end

function LevelMapLayer:refreshGift(event)
    print("function LevelMapLayer:refreshGift(event)")
    local isBuyed   = self.buyModel:checkBought("weaponGiftBag")
    local btnWeapon = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_weapon")    
    btnWeapon:setVisible(not isBuyed)
 
    local isBuyed   = self.buyModel:checkBought("GiftBag_Xianshidacu")    
    local btnXianshi = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_xianshidacu")
    btnXianshi:setVisible(not isBuyed)


    local isBuyed   = self.buyModel:checkBought("yijiaoBag") 
    local btnFirstGift = cc.uiloader:seekNodeByName(self.chooseRootNode, "btngift")
    btnFirstGift:setVisible(not isBuyed)
    local isIOS = device.platform == "ios"
    if not JavaUtils.isSIMJD() or isIOS then 
        btnFirstGift:setVisible(false)
    end    
end

function LevelMapLayer:initGuide()
    --开启第1关之后 点击进入下一关
    local rect = cc.rect(225, 340, 140, 140)
    local guide = md:getInstance("Guide")
    guide:addClickListener({
        id = "xiangqian_nextLevel",
        groupId = "xiangqian",
        rect = rect,
        endfunc = function (touchEvent)
            ui:showPopup("LevelDetailLayer", {groupId = 1, levelId = 2})
            playSoundBtn()
        end
     })

    --镶嵌之后 点击进入下一关
    local rect = cc.rect(280, 180, 140, 140)
    local guide = md:getInstance("Guide")
    guide:addClickListener({
        id = "weapon_nextlevel",
        groupId = "weapon",
        rect = rect,
        endfunc = function (touchEvent)
            ui:showPopup("LevelDetailLayer", {groupId = 1, levelId = 3})
            playSoundBtn()
        end
     })       
end

return LevelMapLayer