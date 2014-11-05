--
-- Author: Fangzhongzheng
-- Date: 2014-10-21 14:32:57
--
import("..includes.functionUtils")
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local HomeModel = import("..homeBar.HomeModel")
local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

--------  Constants  ---------
local Zorder_up, Zorder_bg = 10, 0
local amplifyTimes, smallTime, bigTime = 2, 0.7, 0.7  --Amplify times and time of background

function LevelMapLayer:ctor()
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
    
    self:initData()
    self:initBgLayer()
    self:initChooseLayer()
    self:refreshLevelLayer(self.index)
end

function LevelMapLayer:initData()
    --userData
    self.index = 1
    self.preIndex = 0

    --config
    local config = getConfig("config/levelDetail.json")
    local recordsLevel = getRecord(config,"xiaoguanqia",1)
    self.groupNum = #recordsLevel

    self.levelAmount = {}
    for i = 1, self.groupNum do
        local recordsGroup = getRecord(config,"daguanqia",i)
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
    self.panelRight = cc.uiloader:seekNodeByName(self.chooseRootNode, "Panel_right")
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
            app:getInstance(HomeModel):panelAction()
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
            app:getInstance(HomeModel):panelAction()
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

    -- seek level buttons
    local levelBtn = {}
    for i = 1, self.levelAmount[groupId] do
        levelBtn[i] = cc.uiloader:seekNodeByName(self.levelBtnRootNode, "level_"..i)
        levelBtn[i]:setTouchEnabled(true)

        -- add listener
        addBtnEventListener(levelBtn[i], function(event)
            if event.name=='began' then
                levelBtn[i]:runAction(transition.sequence({
                    cc.MoveTo:create(0.01, cc.p(levelBtn[i]:getPositionX() + 5, levelBtn[i]:getPositionY())), 
                    cc.MoveTo:create(0.01, cc.p(levelBtn[i]:getPositionX(), levelBtn[i]:getPositionY() + 5)), 
                    cc.MoveTo:create(0.01, cc.p(levelBtn[i]:getPositionX() - 5, levelBtn[i]:getPositionY())),
                    cc.MoveTo:create(0.01, cc.p(levelBtn[i]:getPositionX(), levelBtn[i]:getPositionY() - 5)),
                    cc.MoveTo:create(0.01, cc.p(levelBtn[i]:getPositionX() + 5, levelBtn[i]:getPositionY())),
                    cc.MoveTo:create(0.01, cc.p(levelBtn[i]:getPositionX(), levelBtn[i]:getPositionY())),
                    cc.CallFunc:create(function()
                        app:getInstance(PopupCommonLayer):showPopup(LevelDetailLayer.new(groupId, i))end)}))
                -- self:addChild(getPopupTips("关卡尚未开启！"), 100)
            end
        end)
    end
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
            -- reverse() is not work!
                self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelRight:getContentSize().width, 0)))
                self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelDown:getContentSize().height)))
            end)}))
end

function LevelMapLayer:onExit()
end
    
return LevelMapLayer