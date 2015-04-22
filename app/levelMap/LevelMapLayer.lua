
local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

--------  Constants  ---------
local Zorder_up = 10
local smallTime, bigTime = 0.5, 0.5  --Amplify times and time of background

function LevelMapLayer:ctor(properties)
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
    self.LevelMapModel = md:getInstance("LevelMapModel")
    self.FightResultModel = md:getInstance("FightResultModel")
    self.UserModel = md:getInstance("UserModel")
    self.LevelDetailModel = md:getInstance("LevelDetailModel")
    
    self:initData(properties)
    self:initChooseLayer()
    self:refreshLevelLayer(self.curGroupId)

    cc.EventProxy.new(self.FightResultModel, self)
        :addEventListener("POPUP_LEVELDETAIL", handler(self, self.popupLevelDetail))
    cc.EventProxy.new(ui, self)
        :addEventListener(ui.LOAD_HIDE_EVENT, handler(self, self.initBgLayer))
    cc.EventProxy.new(self.LevelMapModel, self)
        :addEventListener("HIDE_GIFTBAGICON_EVENT", handler(self, self.hideWeaponGiftBag))

    self:initGuide() 
end

function LevelMapLayer:initData(properties)
    assert(properties.groupId, "properties.groupId is nil")
    self.curGroupId = properties.groupId
    --userData
    self.preGroupId = 0

    --config
    self.groupNum = self.LevelMapModel:getGroupNum()
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
    -- addChildCenter(self.armature, self)
    
    print("self.curGroupId", self.curGroupId)
    if self.curGroupId == 0 then
        self.curGroupId = 1
    end
    self.armature:getAnimation():play("0_"..self.curGroupId , -1, 0)

    self.ldArmature = ccs.Armature:create("leida")
    self.ldArmature:setPosition(cc.p(568,300))
    self:addChild(self.ldArmature)
    self.ldArmature:getAnimation():play("leida" , -1, 1)

end

function LevelMapLayer:initChooseLayer()
    self.chooseRootNode = cc.uiloader:load("chooseLevel/chooseLevelLayer.ExportJson")
    self:addChild(self.chooseRootNode, Zorder_up)

    self.btnNext = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_next")
    self.btnPre = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_pre")
    self.btnWeapon = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_weapon")
    local btnGold = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_gold")
    local btnTask = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_task")
    self.levelNum = cc.uiloader:seekNodeByName(self.chooseRootNode, "levelnum")
    self.panelRight = cc.uiloader:seekNodeByName(self.chooseRootNode, "panl_right")
    self.panelDown = cc.uiloader:seekNodeByName(self.chooseRootNode, "panl_level")
    self.panelLeft = cc.uiloader:seekNodeByName(self.chooseRootNode, "panel_left")
    self.panelgift = cc.uiloader:seekNodeByName(self.chooseRootNode, "panelgift")
    local btnfirstgift = cc.uiloader:seekNodeByName(self.chooseRootNode, "btngift")

    local armature = ccs.Armature:create("thj_bx")
    armature:setPosition(56,43)
    btnGold:addChild(armature) 
    armature:getAnimation():play("thj_bx" , -1, 1)

    btnTask:setVisible(false)
    local btnkefu = cc.uiloader:seekNodeByName(self.chooseRootNode, "btnkefu")
    local btnboss = cc.uiloader:seekNodeByName(self.chooseRootNode, "btnboss")
    local armature = ccs.Armature:create("guang")
    armature:setScale(2)
    addChildCenter(armature, self.panelgift)
    armature:getAnimation():play("guangtx" , -1, 1)
    local buyModel = md:getInstance("BuyModel")
    if buyModel:checkBought("novicesBag") then
        self.panelgift:setVisible(false)
    end
    if buyModel:checkBought("weaponGiftBag") then
        self.btnWeapon:setVisible(false)
    end    

    function hideGiftIcon()
        self.panelgift:setVisible(false)
    end

    btnfirstgift:onButtonClicked(function()
        buyModel:showBuy("novicesBag",{payDoneFunc = hideGiftIcon}, "主界面_点击新手礼包")
        end)
    
    local libaoArmature = ccs.Armature:create("libao")
    btnfirstgift:addChild(libaoArmature)
    libaoArmature:getAnimation():play("libao" , -1, 1)

    self.levelNum:setString(self.curGroupId)

    local actionPre = transition.sequence({
    cc.MoveTo:create(0.5, cc.p(self.btnPre:getPositionX()-10 , self.btnPre:getPositionY())), 
    cc.MoveTo:create(0.5, cc.p(self.btnPre:getPositionX()+10, self.btnPre:getPositionY()))})
    self.btnPre:runAction(cc.RepeatForever:create(actionPre))

    local actionNext = transition.sequence({
    cc.MoveTo:create(0.5, cc.p(self.btnNext:getPositionX()+10 , self.btnNext:getPositionY())), 
    cc.MoveTo:create(0.5, cc.p(self.btnNext:getPositionX()-10, self.btnNext:getPositionY()))})
    self.btnNext:runAction(cc.RepeatForever:create(actionNext))

    -- add listener (attention: this isnot button, so we add node event listener)
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
        end
    end)

    self.btnWeapon:setTouchEnabled(true)
    addBtnEventListener(self.btnWeapon, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            local buyModel = md:getInstance("BuyModel")
            buyModel:showBuy("weaponGiftBag", {payDoneFunc = handler(self, self.refreshData),
                isNotPopKefu = true}, "主界面_点击武器大礼包")
        end
    end)

    btnGold:setTouchEnabled(true)
    addBtnEventListener(btnGold, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            local buyModel = md:getInstance("BuyModel")
            buyModel:showBuy("goldGiftBag", {}, "主界面_点击土豪金礼包")
        end
    end)

    -- 添加客服按钮点击事件
    btnkefu:onButtonPressed(function( event )
        event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function( event )
        event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    :onButtonClicked(function( event )
        ui:showPopup("commonPopup",{type = "style4",
                opacity = 0})
    end)

    btnboss:onButtonPressed(function( event )
        event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function( event )
        event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    :onButtonClicked(function( event )
        ui:showPopup("BossModeLayer")
    end)
end

function LevelMapLayer:refreshData()
    self.LevelMapModel:hideGiftBagIcon()
end

function LevelMapLayer:hideWeaponGiftBag(event)
    self.btnWeapon:setVisible(false)
end

function LevelMapLayer:refreshLevelLayer(groupId)
    self.levelBtnRootNode = cc.uiloader:load("levelBtn/levelMap_"..groupId..".ExportJson")
    self:addChild(self.levelBtnRootNode, Zorder_up)

    --btn
    local levelName = {}
    local levelIcon = {}
    local levelAnim = {}
    local panelBtn = {}
    local panelGray = {}
    -- local dian = {}
    local imgIcon = {}
    local group,level = self.LevelMapModel:getConfig()
    local groupInfo = self.LevelMapModel:getGroupInfo(self.curGroupId)

    for k,v in pairs(groupInfo) do
        panelBtn[v] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "Panel_"..v)
        panelGray[v] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "gray_"..v)
    end

    for k,v in pairs(panelBtn) do
        levelName[k]  = cc.uiloader:seekNodeByName(v, "name")
        levelIcon[k] = cc.uiloader:seekNodeByName(v, "icon")
        levelAnim[k] = cc.uiloader:seekNodeByName(v, "anim")
        levelIcon[k]:setTouchEnabled(true)
        imgIcon[k] = cc.uiloader:seekNodeByName(v, "iconimg")
    end

    for k,v in pairs(groupInfo) do
        local record = self.LevelDetailModel:getConfig(group,level)
        if  group > groupId or group == groupId and level > v then

        elseif group == groupId and level == v then
            panelGray[v]:setVisible(false)            
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
                     {type = "style2", content = "本关还没开启",delay = 2},
                     { opacity = 0})
                end
            end
        end)
    end
end

function LevelMapLayer:popupLevelDetail(event)
    groupId = event.gid
    levelId = event.lid
    ui:showPopup("LevelDetailLayer", {groupId = groupId, levelId = levelId})
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
        end
    end
end

function LevelMapLayer:panelAction()
    local changeTime = 0.2
    self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(self.panelRight:getContentSize().width+8, 0)))
    self.panelLeft:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelLeft:getContentSize().width-25, 0)))
    self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, -self.panelDown:getContentSize().height-5)))
    self.panelDown:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
                self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelRight:getContentSize().width-8, 0)))
                self.panelLeft:runAction(cc.MoveBy:create(changeTime, cc.p(self.panelLeft:getContentSize().width+25, 0)))
                self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelDown:getContentSize().height+5)))
            end)}))
end

function LevelMapLayer:onShow()  
end

function LevelMapLayer:initGuide()
    --开启第1关之后 点击进入下一关
    local rect = cc.rect(190, 60, 130, 130)
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
    local rect = cc.rect(320, 240, 130, 130)
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