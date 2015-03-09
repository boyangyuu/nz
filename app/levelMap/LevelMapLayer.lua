
local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

--------  Constants  ---------
local Zorder_up, Zorder_bg = 10, 0
local amplifyTimes, smallTime, bigTime = 2, 0.7, 0.7  --Amplify times and time of background

function LevelMapLayer:ctor(properties)
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
    self.LevelMapModel = md:getInstance("LevelMapModel")
    self.FightResultModel = md:getInstance("FightResultModel")
    self.UserModel = md:getInstance("UserModel")
    self.LevelDetailModel = md:getInstance("LevelDetailModel")
    
    self:initData(properties)
    self:initBgLayer()
    self:initChooseLayer()
    self:refreshLevelLayer(self.curGroupId)
    cc.EventProxy.new(self.FightResultModel, self)
        :addEventListener("POPUP_LEVELDETAIL", handler(self, self.popupLevelDetail))
    self:initGuide() 
end

function LevelMapLayer:initData(properties)
    assert(properties.groupId, "properties.groupId is nil")
    self.curGroupId = properties.groupId
    --userData
    self.preGroupId = 0

    --config
    self.groupNum = self.LevelMapModel:getGroupNum()

    -- self.levelAmount = {}
    -- for i = 1, self.groupNum do
    --     self.levelAmount[i] = self.LevelMapModel:getLevelNum(i)
    -- end
end


function LevelMapLayer:initBgLayer()
    -- bg starting animation   

    self.armature = ccs.Armature:create("shijiemap")
    self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
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
    local btnSale = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_time")
    local btnGold = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_gold")
    local btnTask = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_task")
    self.levelNum = cc.uiloader:seekNodeByName(self.chooseRootNode, "levelnum")
    self.panelRight = cc.uiloader:seekNodeByName(self.chooseRootNode, "panl_right")
    self.panelDown = cc.uiloader:seekNodeByName(self.chooseRootNode, "panl_level")
    self.panelGift = cc.uiloader:seekNodeByName(self.chooseRootNode, "panel_left")
    local btnfirstgift = cc.uiloader:seekNodeByName(self.chooseRootNode, "btngift")


    local armature = ccs.Armature:create("thj_bx")
    armature:setPosition(56,43)
    btnGold:addChild(armature) 
    armature:getAnimation():play("thj_bx" , -1, 1)



    btnTask:setVisible(false)
    -- modified by lpf
    local btnkefu = cc.uiloader:seekNodeByName(self.chooseRootNode, "btnkefu")


    local armature = ccs.Armature:create("guang")
    -- armature:setPosition(-240,0)
    armature:setScale(2)
    addChildCenter(armature, self.panelGift)
    -- self.panelGift:addChild(armature)
    armature:getAnimation():play("guangtx" , -1, 1)
    local buyModel = md:getInstance("BuyModel")
    if buyModel:checkBought("novicesBag") then
        self.panelGift:setVisible(false)
    end

    function hideGiftIcon()
        self.panelGift:setVisible(false)
    end

    btnfirstgift:onButtonClicked(function()
        buyModel:showBuy("novicesBag",{payDoneFunc = hideGiftIcon}, "主界面_点击新手礼包")
        end)
    
    local action = transition.sequence({
        cc.ScaleTo:create(0.5, 1.15),
        cc.ScaleTo:create(0.5, 1),})
    btnfirstgift:runAction(cc.RepeatForever:create(action))



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

    btnSale:setTouchEnabled(true)
    addBtnEventListener(btnSale, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            local buyModel = md:getInstance("BuyModel")
            buyModel:showBuy("timeGiftBag", {}, "主界面_点击限时礼包")
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
    btnkefu:setTouchEnabled(true)
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

end

function LevelMapLayer:refreshLevelLayer(groupId)
    self.levelBtnRootNode = cc.uiloader:load("levelBtn/levelMap_"..groupId..".ExportJson")
    self.levelBtnRootNode:setPosition(0, 0)
    self:addChild(self.levelBtnRootNode, Zorder_up)

    --btn
    local levelBtn = {}
    local levelDian = {}
    local panelBtn = {}
    local dian = {}
    local group,level = self.LevelMapModel:getConfig()


    local groupInfo = self.LevelMapModel:getGroupInfo(self.curGroupId)


    for k,v in pairs(groupInfo) do
        if k ~= #groupInfo then
            dian[v] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "Panel_g"..v.."_0")
        end
    end

    if group > groupId then
        for k,v in pairs(dian) do
            dian[k]:setVisible(true)
        end
    elseif group == groupId then
        for k,v in pairs(groupInfo) do
            if v >= level and k ~= #groupInfo then
                dian[v]:setVisible(false)
            end
        end
    else
        for k,v in pairs(dian) do
            dian[k]:setVisible(false)
        end
    end

    -- for i = 1, self.levelAmount[groupId] do
    for k,v in pairs(groupInfo) do
        levelBtn[v]  = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "level_"..v)
        levelDian[v] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "dian_"..v)
        panelBtn[v] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "Panel_"..v)
        panelBtn[v]:setTouchEnabled(true)
    end


    for k,v in pairs(groupInfo) do
        local record = self.LevelDetailModel:getConfig(group,level)
        if  group > groupId or group == groupId and level > v then

        elseif group == groupId and level == v then
            levelDian[v]:setVisible(false)
            
            local action = transition.sequence({
            cc.MoveTo:create(0.625, cc.p(levelBtn[v]:getPositionX() , levelBtn[v]:getPositionY()+ 15)), 
            cc.MoveTo:create(0.625, cc.p(levelBtn[v]:getPositionX(), levelBtn[v]:getPositionY() - 15))})
            levelBtn[v]:runAction(cc.RepeatForever:create(action))

            -- end
            local type = record["type"]
            local armature = ccs.Armature:create("gktb")
            armature:setScale(0.8)
            armature:setPosition(panelBtn[v]:getContentSize().width/2,20)
            panelBtn[level]:addChild(armature)

            if type == "boss" or type == "juji" then
                armature:getAnimation():play("dizuohong" , -1, 1)
            elseif type == "jinbi" then
                armature:getAnimation():play("dizuohuang" , -1, 1)
            elseif type == "putong" or  type == "renzhi" then
                armature:getAnimation():play("dizuolan" , -1, 1)
            end
        else       
            if device.platform ~= "windows" then
                cc.ColorUtil:setGray(levelBtn[v])                 
                cc.ColorUtil:setGray(levelDian[v]) 
            end                
        end

        -- add listener
        panelBtn[v]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
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
            self:checkGuide()
        end
    end
end

function LevelMapLayer:panelAction()
    local changeTime = 0.2
    self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(self.panelRight:getContentSize().width+8, 0)))
    self.panelGift:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelGift:getContentSize().width-25, 0)))
    self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, -self.panelDown:getContentSize().height-5)))
    self.panelDown:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
                self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelRight:getContentSize().width-8, 0)))
                self.panelGift:runAction(cc.MoveBy:create(changeTime, cc.p(self.panelGift:getContentSize().width+25, 0)))
                self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelDown:getContentSize().height+5)))
            end)}))
end

function LevelMapLayer:onEnter()   
    self:checkGuide()
    print("function LevelMapLayer:checkGuide()  ")
end

function LevelMapLayer:checkGuide()
    local curGroupId, curLevelId = self.LevelMapModel:getConfig()

    if curGroupId == 1 and curLevelId == 3 then 
        local guide = md:getInstance("Guide")
        guide:check("xiangqian")
    end
end

function LevelMapLayer:initGuide()
    --开启第1关之后 点击进入下一关
    local rect = cc.rect(95, 280, 120, 120)
    local guide = md:getInstance("Guide")
    guide:addClickListener({
        id = "prefight02_nextlevel",
        groupId = "prefight02",
        rect = rect,
        endfunc = function (touchEvent)
            ui:showPopup("LevelDetailLayer", {groupId = 1, levelId = 1})
            playSoundBtn()
        end
     })   

    --镶嵌之后 点击进入下一关
    local rect = cc.rect(650, 384, 130, 130)
    local guide = md:getInstance("Guide")
    guide:addClickListener({
        id = "xiangqian_nextLevel",
        groupId = "xiangqian",
        rect = rect,
        endfunc = function (touchEvent)
            ui:showPopup("LevelDetailLayer", {groupId = 1, levelId = 5})
            playSoundBtn()
        end
     })       
end

return LevelMapLayer