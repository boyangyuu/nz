--
-- Author: Fangzhongzheng
-- Date: 2014-10-21 14:32:57
--
import("..includes.functionUtils")
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

--------  Constants  ---------
local Zorder_home, Zorder_choose = 200, 2
local amplifyTimes, smallTime, bigTime = 2, 0.7, 0.7  --Amplify times and time of background

function LevelMapLayer:ctor()
    self:initNumber()
    self:initBgLayer()
    self:initHomeLayer()
    self:initChooseLayer()
    self:refreshLevelLayer(self.index)

    -- Setting shadow and outline for TTFlabel
    -- local label = display.newTTFLabel({
    -- text = "人生就是干。",
    -- font = "黑体",
    -- size = 64,
    -- color = cc.c3b(255, 255, 255),
    -- align = cc.ui.TEXT_ALIGN_LEFT,
    -- })
    -- label:setPosition(display.cx, display.cy)
    -- -- label:enableOutline(cc.c4b(255, 0, 0, 255), 4) -- only ios and Android
    -- label:enableGlow(cc.c4b(255, 0, 0, 255))
    -- label:enableShadow(cc.c4b(255, 0, 0, 255))
    -- self:addChild(label, 2)
end

function LevelMapLayer:initNumber()
    self.index = 1
    self.preIndex = 0

-- Obtain group and litter levels amount from json
    local config = getConfig("config/3.json")
    local recordsLevel = getRecord(config,"xiaoguanqia",1)
    self.groupNum = #recordsLevel

    self.levelBtnNum = {}
    for i = 1, self.groupNum do
        local recordsGroup = getRecord(config,"daguanqia",i)
        self.levelBtnNum[i] = #recordsGroup

        print("self.groupNum =",  self.groupNum, 
            "self.levelBtnNum["..i.."] = ", self.levelBtnNum[i])
    end
end

function LevelMapLayer:initBgLayer()
-- bg starting animation
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
    local bg = display.newSprite("levelMap_bg.png")
    self:addChild(bg) 
    bg:setAnchorPoint(cc.p(0, 0))
    self.bg = bg
    self.bg:runAction(cc.ScaleTo:create(0.6, 1.8))  -- Starting action
end

function LevelMapLayer:initHomeLayer()
 -- load home layer
    local homeNode = cc.uiloader:load("LevelMap_home/levelMap_home.ExportJson")
    self:addChild(homeNode, Zorder_home)

    self.btnSetting = cc.uiloader:seekNodeByName(homeNode, "btn_setting")
    self.btnBuyCoin = cc.uiloader:seekNodeByName(homeNode, "btn_buyCoin")
    self.btnArsenal = cc.uiloader:seekNodeByName(homeNode, "btn_arsenal")
    self.btnInlay = cc.uiloader:seekNodeByName(homeNode, "btn_inlay")
    self.btnShop = cc.uiloader:seekNodeByName(homeNode, "btn_shop")
    self.panelUp = cc.uiloader:seekNodeByName(homeNode, "Panel_up")

    self.btnSetting:setTouchEnabled(true)
    self.btnBuyCoin:setTouchEnabled(true)
    self.btnArsenal:setTouchEnabled(true)
    self.btnInlay:setTouchEnabled(true)
    self.btnShop:setTouchEnabled(true)
    self.panelUp:setTouchEnabled(true)
    
    addBtnEventListener(self.btnSetting, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
    addBtnEventListener(self.btnBuyCoin, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
    addBtnEventListener(self.btnArsenal, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
    addBtnEventListener(self.btnInlay, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
    addBtnEventListener(self.btnShop, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
end

function LevelMapLayer:initChooseLayer()
-- load choose layer
    local chooseNode = cc.uiloader:load("LevelMap_choose/levelMap_choose.ExportJson")
    self:addChild(chooseNode, Zorder_choose)

    self.btnNext = cc.uiloader:seekNodeByName(chooseNode, "btn_next")
    self.btnPre = cc.uiloader:seekNodeByName(chooseNode, "btn_pre")
    self.btnSale = cc.uiloader:seekNodeByName(chooseNode, "btn_sale")
    self.btnTask = cc.uiloader:seekNodeByName(chooseNode, "btn_task")
    self.btnGift = cc.uiloader:seekNodeByName(chooseNode, "btn_gift")
    self.btnLevel = cc.uiloader:seekNodeByName(chooseNode, "level")
    self.panelRight = cc.uiloader:seekNodeByName(chooseNode, "Panel_right")
    self.panelDown = cc.uiloader:seekNodeByName(chooseNode, "panl_level")

    self.btnNext:setTouchEnabled(true)
    self.btnPre:setTouchEnabled(true)
    self.btnSale:setTouchEnabled(true)
    self.btnTask:setTouchEnabled(true)
    self.btnGift:setTouchEnabled(true)
    self.btnLevel:setTouchEnabled(true)
    self.panelRight:setTouchEnabled(true)
    self.panelDown:setTouchEnabled(true)

    self.btnLevel:addChild(display.newSprite("LevelMap_choose/1.png", 
        self.btnLevel:getContentSize().width/2, self.btnLevel:getContentSize().height/2), Zorder_choose)

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
            self:btnAction()
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
            self:btnAction()
        end
    end)
     addBtnEventListener(self.btnSale, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
    addBtnEventListener(self.btnTask, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)
    addBtnEventListener(self.btnGift, function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
        end
    end)

end

function LevelMapLayer:refreshLevelLayer(groupId)
    -- load level layer
    self.levelBtnNode = cc.uiloader:load("LevelMap_levelBtn/levelMap_"..groupId..".ExportJson")
    self.levelBtnNode:setPosition(0, 0)
    self:addChild(self.levelBtnNode)  

    -- seek level buttons
    local levelBtn = {}
    for i = 1, self.levelBtnNum[groupId] do
        levelBtn[i] = cc.uiloader:seekNodeByName(self.levelBtnNode, "level_"..i)
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

    self.bg:runAction(cc.EaseIn:create(scaleToSmall, 1))   -- Native C++
    self.bg:runAction(transition.newEasing(moveToOrigin, "In", 1))  -- quick package
    self.bg:runAction(cc.Sequence:create({delay, cc.EaseIn:create(scaleToBig, 2.5)}))  -- Native C++
    self.bg:runAction(cc.Sequence:create({delay, cc.EaseIn:create(moveTo, 2.5)}))  -- Native C++

-- To make button disabled for a while
    self.btnNext:setTouchEnabled(false)
    self.btnPre:setTouchEnabled(false)
    self.levelBtnNode:removeFromParent()

    self.btnNext:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
                self.btnNext:setTouchEnabled(true)
                self.btnPre:setTouchEnabled(true)
                self.btnLevel:removeAllChildren()
                self.btnLevel:addChild(display.newSprite("LevelMap_choose/"..self.index..".png", 60, 25), 2)
                self:refreshLevelLayer(self.index)
            end)}))
end

function LevelMapLayer:btnAction()
    local changeTime = 0.2
    self.panelUp:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelUp:getContentSize().height)))
    self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(self.panelRight:getContentSize().width, 0)))
    self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, -self.panelDown:getContentSize().height)))
    self.panelUp:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
            -- reverse() is not work!
                self.panelUp:runAction(cc.MoveBy:create(changeTime, cc.p(0, -self.panelUp:getContentSize().height)))
                self.panelRight:runAction(cc.MoveBy:create(changeTime, cc.p(-self.panelRight:getContentSize().width, 0)))
                self.panelDown:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelDown:getContentSize().height)))
            end)}))
end

function LevelMapLayer:onExit()
end
    
return LevelMapLayer