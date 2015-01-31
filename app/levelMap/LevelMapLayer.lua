
import("..includes.functionUtils")

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

    self.index = 1
    self:initData(properties)
    self:initBgLayer()
    self:initDailyLogin()
    self:initChooseLayer()
    self:refreshLevelLayer(self.index)
    cc.EventProxy.new(self.FightResultModel, self)
        :addEventListener("POPUP_LEVELDETAIL", handler(self, self.PopupLevelDetail))
    self:initGuide() 
end

function LevelMapLayer:initData(properties)
    if properties.groupId == 0 then
        local group,level = self.LevelMapModel:getConfig()
        self.index = group
    else
        self.index = properties.groupId
    end

    --userData
    self.preIndex = 0

    --config
    local recordsLevel = getRecordByKey("config/guanqia.json","levelId",1)
    self.groupNum = #recordsLevel

    self.levelAmount = {}
    for i = 1, self.groupNum do
        local recordsGroup = getRecordByKey("config/guanqia.json","groupId",i)
        self.levelAmount[i] = #recordsGroup
    end
end

function LevelMapLayer:initDailyLogin()
    local dailyLoginModel = md:getInstance("DailyLoginModel")
    local guide = md:getInstance("Guide")
    local isDone = guide:isDone("afterfight02")
    if dailyLoginModel:checkPop() and isDone then
        ui:showPopup("DailyLoginLayer", {})
        dailyLoginModel:donotPop()
    end
end

function LevelMapLayer:initBgLayer()
-- bg starting animation   

    self.armature = ccs.Armature:create("shijiemap")
    self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    self.armature:setAnchorPoint(0.5,0.5)
    self.armature:setPosition(display.width/2,display.height1/2)

    self:addChild(self.armature)
    -- addChildCenter(self.armature, self)
    self.armature:getAnimation():play("0_"..self.index , -1, 0)

    self.ldarmature = ccs.Armature:create("leida")
    self.ldarmature:setPosition(cc.p(568,300))
    self:addChild(self.ldarmature)
    self.ldarmature:getAnimation():play("leida" , -1, 1)


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
        buyModel:buy("novicesBag",{payDoneFunc = hideGiftIcon})
        end)
    
    local action = transition.sequence({
        cc.ScaleTo:create(0.5, 1.15),
        cc.ScaleTo:create(0.5, 1),})
    btnfirstgift:runAction(cc.RepeatForever:create(action))



    self.levelNum:setString(self.index)

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
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            
            if self.index >= self.groupNum then
                self.index = 1
                self.preIndex = self.groupNum
            else
                self.index = self.index + 1
                self.preIndex = self.index - 1
            end
            self:bgAction()
            self:panelAction()
            self.UserModel:panelAction()
        end
    end)
    addBtnEventListener(self.btnPre, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
            if self.index < 2 then
                self.index = self.groupNum
                self.preIndex = 1
            else
                self.index = self.index - 1
                self.preIndex = self.index + 1
            end
            self:bgAction()
            self:panelAction()
            self.UserModel:panelAction()
        end
    end)

    btnSale:setTouchEnabled(true)
    addBtnEventListener(btnSale, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
            local buy = md:getInstance("BuyModel")
            buy:buy("timeGiftBag", {})
        end
    end)

    -- btnTask:setTouchEnabled(true)
    -- addBtnEventListener(btnTask, function(event)
    --     if event.name=='began' then
    --         print("Btn is begining!")
    --         return true
    --     elseif event.name=='ended' then
    --         print("Btn is pressed!")

    --     end
    -- end)
    btnGold:setTouchEnabled(true)
    addBtnEventListener(btnGold, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            local buy = md:getInstance("BuyModel")
            buy:buy("goldGiftBag", {})
        end
    end)

    -- 添加客服按钮点击事件
    btnkefu:setTouchEnabled(true)
    btnkefu:onButtonPressed(function( event )
        --test 清理引导
        local guide = md:getInstance("Guide")
        guide:clearData()
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
    for i=1,self.levelAmount[groupId]-1 do
        dian[i] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "Panel_g"..i.."_0")
    end
    if  group > groupId then
        for i=1,table.nums(dian) do
            dian[i]:setVisible(true)
        end
    elseif group == groupId then
        for i=level,table.nums(dian) do
            dian[i]:setVisible(false)
        end
    else
        for i=1,table.nums(dian) do
            dian[i]:setVisible(false)
        end
    end
    for i = 1, self.levelAmount[groupId] do
        levelBtn[i]  = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "level_"..i)
        levelDian[i] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "dian_"..i)
        panelBtn[i] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "Panel_"..i)
        panelBtn[i]:setTouchEnabled(true)
        local record = self.LevelDetailModel:getConfig(group,level)
        if  group > groupId or group == groupId and level > i  then

        elseif group == groupId and level == i then
            print("....i")
            levelDian[i]:setVisible(false)
            -- while true do
            local action = transition.sequence({
            cc.MoveTo:create(0.625, cc.p(levelBtn[i]:getPositionX() , levelBtn[i]:getPositionY()+ 15)), 
            cc.MoveTo:create(0.625, cc.p(levelBtn[i]:getPositionX(), levelBtn[i]:getPositionY() - 15))})
            levelBtn[i]:runAction(cc.RepeatForever:create(action))

            -- end
            local type = record["type"]
            local armature = ccs.Armature:create("gktb")
            armature:setScale(0.8)
            armature:setPosition(panelBtn[i]:getContentSize().width/2,20)
            panelBtn[level]:addChild(armature)
            if type == "boss" or type == "juji" then
                armature:getAnimation():play("dizuohong" , -1, 1)
            elseif type == "jinbi" then
                armature:getAnimation():play("dizuohuang" , -1, 1)
            elseif type == "putong" then
                armature:getAnimation():play("dizuolan" , -1, 1)
            end
        else           
            if device.platform ~= "windows" then
                cc.ColorUtil:setGray(levelBtn[i])                 
                cc.ColorUtil:setGray(levelDian[i]) 
            end                
        end
        -- add listener
        addBtnEventListener(panelBtn[i], function(event)
            if event.name=='began' then
                if  group > groupId or group == groupId and level >= i  then
                    local levelId = i  
                    print(" addBtnEventListener(panelBtn[i], function(event)")
                    ui:showPopup("LevelDetailLayer", {groupId = groupId, levelId = levelId})
                else                            
                    ui:showPopup("commonPopup",
                     {type = "style2", content = "本关还没开启"},
                     { opacity = 0})
                end
            end
        end)
    end
end

function LevelMapLayer:PopupLevelDetail(event)
    groupId = event.gid
    levelId = event.lid
    ui:showPopup("LevelDetailLayer", {groupId = groupId, levelId = levelId})
end

function LevelMapLayer:bgAction()    
    -- To make button disabled for a while
    self.ldarmature:removeFromParent()
    self.btnNext:setTouchEnabled(false)
    self.btnPre:setTouchEnabled(false)
    self.levelBtnRootNode:removeFromParent()
    self.animName = self.preIndex.."_"..self.index
    self.armature:getAnimation():play(self.animName , -1, 0)
end

function LevelMapLayer:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.complete then
        armatureBack:stopAllActions()
        if movementID == self.animName then
            self.btnNext:setTouchEnabled(true)
            self.btnPre:setTouchEnabled(true)
            self.ldarmature = ccs.Armature:create("leida")
            self.ldarmature:setPosition(cc.p(568,300))
            self:addChild(self.ldarmature)
            self.ldarmature:getAnimation():play("leida" , -1, 1)
            self.levelNum:setString(self.index)
            self:refreshLevelLayer(self.index)
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

function LevelMapLayer:onCleanup()

end

function LevelMapLayer:onEnter()   
    self:checkGuide()
    print("function LevelMapLayer:checkGuide()  ")
end

function LevelMapLayer:checkGuide()
    local curGroupId, curLevelId = self.LevelMapModel:getConfig()
    -- print("curGroupId", curGroupId)
    -- print("curLevelId", curLevelId)

    if curGroupId == 1 and curLevelId == 5 then 
        local guide = md:getInstance("Guide")
        guide:check("xiangqian")
    end
end

function LevelMapLayer:initGuide()
    --开启第二关之后 点击进入下一关
    local rect = cc.rect(200, 107, 120, 120)
    local guide = md:getInstance("Guide")
    guide:addClickListener({
        id = "prefight02_nextlevel",
        groupId = "prefight02",
        rect = rect,
        endfunc = function (touchEvent)
            ui:showPopup("LevelDetailLayer", {groupId = 1, levelId = 2})
        end
     })   

    --镶嵌之后 点击进入下一关
    local rect = cc.rect(572, 344, 120, 120)
    local guide = md:getInstance("Guide")
    guide:addClickListener({
        id = "xiangqian_nextLevel",
        groupId = "xiangqian",
        rect = rect,
        endfunc = function (touchEvent)
            ui:showPopup("LevelDetailLayer", {groupId = 1, levelId = 5})
        end
     })       
end

return LevelMapLayer