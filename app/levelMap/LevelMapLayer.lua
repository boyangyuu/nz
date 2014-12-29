
import("..includes.functionUtils")

local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

--------  Constants  ---------
local Zorder_up, Zorder_bg = 10, 0
local amplifyTimes, smallTime, bigTime = 2, 0.7, 0.7  --Amplify times and time of background

function LevelMapLayer:ctor()
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
    self.LevelMapModel = md:getInstance("LevelMapModel")
    self.FightResultModel = md:getInstance("FightResultModel")
    self.UserModel = md:getInstance("UserModel")
    self.LevelDetailModel = md:getInstance("LevelDetailModel")
    self:initData()
    self:initBgLayer()
    self:initChooseLayer()
    self:refreshLevelLayer(self.index)

    cc.EventProxy.new(self.FightResultModel, self)
        :addEventListener("POPUP_LEVELDETAIL", handler(self, self.PopupLevelDetail))

end

function LevelMapLayer:initData()
    --userData
    self.index = 1
    self.preIndex = 0

    --config
    local recordsLevel = getRecordByKey("config/guanqia.json","levelId",1)
    self.groupNum = #recordsLevel

    self.levelAmount = {}
    for i = 1, self.groupNum do
        local recordsGroup = getRecordByKey("config/guanqia.json","groupId",i)
        self.levelAmount[i] = #recordsGroup
        -- print("self.groupNum =",  self.groupNum, 
        --     "self.levelAmount["..i.."] = ", self.levelAmount[i])
    end
end

function LevelMapLayer:initBgLayer()
-- bg starting animation
    local bg = display.newSprite("levelMap_bg.png")
    self:addChild(bg, Zorder_bg)
    bg:setAnchorPoint(cc.p(0, 0))
    self.bgRootNode = bg
    self.bgRootNode:runAction(cc.ScaleTo:create(0.6, 1.8))  -- Starting action
end

function LevelMapLayer:initChooseLayer()
    self.chooseRootNode = cc.uiloader:load("chooseLevel/chooseLevelLayer.ExportJson")
    self:addChild(self.chooseRootNode, Zorder_up)

    self.btnNext = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_next")
    self.btnPre = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_pre")
    local btnSale = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_sale")
    local btnTask = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_task")
    local btnGift = cc.uiloader:seekNodeByName(self.chooseRootNode, "btn_gift")
    self.levelNum = cc.uiloader:seekNodeByName(self.chooseRootNode, "level")
    self.panelRight = cc.uiloader:seekNodeByName(self.chooseRootNode, "panl_right")
    self.panelDown = cc.uiloader:seekNodeByName(self.chooseRootNode, "panl_level")

    self.levelNum:addChild(display.newSprite("chooseLevel/1.png", 
    self.levelNum:getContentSize().width/2, self.levelNum:getContentSize().height/2), Zorder_up)


    -- add listener (attention: this isnot button, so we add node event listener)
    addBtnEventListener(self.btnNext, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
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
     addBtnEventListener(btnSale, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
    addBtnEventListener(btnTask, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
    addBtnEventListener(btnGift, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
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
    local group,level = self.LevelMapModel:getConfig()
    for i = 1, self.levelAmount[groupId] do
        levelBtn[i] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "level_"..i)
        levelDian[i] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "dian_"..i)
        panelBtn[i] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "Panel_"..i)
        levelBtn[i]:setTouchEnabled(true)
        local record = self.LevelDetailModel:getConfig(group,level)
        if  group > groupId or group == groupId and level > i  then

        elseif group == groupId and level == i then
            levelDian[i]:setVisible(false)
            -- while true do
            local action = transition.sequence({
            cc.MoveTo:create(0.5, cc.p(levelBtn[i]:getPositionX() , levelBtn[i]:getPositionY()+ 15)), 
            cc.MoveTo:create(0.5, cc.p(levelBtn[i]:getPositionX(), levelBtn[i]:getPositionY() - 15))})
            levelBtn[i]:runAction(cc.RepeatForever:create(action))

            -- end
            local type = record["type"]
            local armature = ccs.Armature:create("gktb")
            armature:setScale(0.8)
            armature:setPosition(panelBtn[i]:getContentSize().width/2,20)
            panelBtn[i]:addChild(armature)
            if type == "boss" or type == "juji" then
                armature:getAnimation():play("dizuohong" , -1, 1)
            elseif type == "jinbi" then
                armature:getAnimation():play("dizuohuang" , -1, 1)
            elseif type == "putong" then
                armature:getAnimation():play("dizuolan" , -1, 1)
            end
        else                            
            levelBtn[i]:setColor(cc.c3b(80, 80, 80))
            levelDian[i]:setColor(cc.c3b(80, 80, 80))
            -- levelBtn[i]:setShaderProgram
        end
        -- add listener
        addBtnEventListener(levelBtn[i], function(event)
            if event.name=='began' then
                if  group > groupId or group == groupId and level >= i  then
                    local levelId = i  
                    ui:showPopup("LevelDetailLayer", {groupId = groupId, levelId = levelId})
                else                            
                    self:addChild(getPopupTips("关卡尚未开启！"))
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
    -- switching animation
    if self.index == 1 then
        self.x, self.y = 0, 0
    elseif self.index == 2 then
        self.x, self.y = -display.width*(amplifyTimes - 1), 0
    elseif self.index == 3 then
        self.x, self.y = -display.width*(amplifyTimes - 1), -display.height*(amplifyTimes - 1)
    elseif self.index == 4 then
        self.x, self.y = 0, -display.height*(amplifyTimes - 1)
    end

    local scaleToSmall = cc.ScaleTo:create(smallTime, 1)
    local scaleToBig = cc.ScaleTo:create(bigTime, amplifyTimes)
    local moveToOrigin = cc.MoveTo:create(smallTime, cc.p(0, 0))
    local delay = cc.DelayTime:create(smallTime)
    local moveTo = cc.MoveTo:create(bigTime, cc.p(self.x, self.y))

    self.bgRootNode:runAction(cc.EaseIn:create(scaleToSmall, 1))   -- Native C++
    self.bgRootNode:runAction(transition.newEasing(moveToOrigin, "In", 1))  -- quick package
    self.bgRootNode:runAction(cc.Sequence:create({delay, cc.EaseIn:create(scaleToBig, 2.5)}))  -- Native C++
    self.bgRootNode:runAction(cc.Sequence:create({delay, cc.EaseIn:create(moveTo, 2.5)}))  -- Native C++

    -- To make button disabled for a while
    self.btnNext:setTouchEnabled(false)
    self.btnPre:setTouchEnabled(false)
    self.levelBtnRootNode:removeFromParent()

    self.btnNext:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
                self.btnNext:setTouchEnabled(true)
                self.btnPre:setTouchEnabled(true)
                self.levelNum:removeAllChildren()
                self.levelNum:addChild(display.newSprite("chooseLevel/"..self.index..".png", 60, 25), 2)
                self:refreshLevelLayer(self.index)
            end)}))
end

function LevelMapLayer:panelAction()
    local changeTime = 0.2
    self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(self.panelRight:getContentSize().width, 0)))
    self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, -self.panelDown:getContentSize().height)))
    self.panelDown:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
                self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelRight:getContentSize().width, 0)))
                self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelDown:getContentSize().height)))
            end)}))
end

function LevelMapLayer:onExit()
end
    
return LevelMapLayer