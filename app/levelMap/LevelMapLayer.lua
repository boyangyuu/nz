--
-- Author: Fangzhongzheng
-- Date: 2014-10-21 14:32:57
--
import("..includes.functionUtils")
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

--常量
local kZ_bar = 2

local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

function LevelMapLayer:ctor()
-- Member variables
    self.index = 1
    self.preIndex = 0
    self.totalLevelNumber = 4    -- "Big level" total number
    self.totalLevelNumber_1 = 6  -- "Interior small level" of 1 big level total number

    --ui
    self:onEnter()
end
    -- 
function LevelMapLayer:onEnter() 

    -- load bg ang play bg starting animation
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
    local bg = display.newSprite("levelMap_bg.png")
    bg:setAnchorPoint(0, 0)
    self:addChild(bg) 
    self.bg = bg
    self.bg:runAction(cc.ScaleTo:create(0.6, 1.8))  -- Starting action

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

    -- load control bar
    local controlNode = cc.uiloader:load("LevelMap_ui/levelMap_ui.ExportJson")
    self:addChild(controlNode, kZ_bar)

    -- seek all button
    self:initBtn()

    -- load level layer
    self:refreshLevels(groupId)
end

function LevelMapLayer:initBtn()
    local ccsBtn = 
        {"btn_next", "btn_pre","btn_setting","btn_buyCoin",
        "btn_arsenal","btn_inlay", "btn_shop","btn_sale",
        "btn_task","btn_gift", "level","Panel_up","Panel_right","panl_level", }

    -- set Member variables(or U can setting global variables)
    self.programBtn[11]:setTouchEnabled(false)
    self.programBtn[11]:addChild(display.newSprite("LevelMap_ui/1.png", 60, 25), 2)

    -- add listener (attention: this isnot button, so we add node event listener)
    addBtnEventListener(self.programBtn[1], function(event)
        if event.name=='began' then
            print("programBtn is begining!")
            return true
        elseif event.name=='ended' then
            print("programBtn is pressed!")
            if self.index >= self.totalLevelNumber then
                self.index = 1
                self.preIndex = self.totalLevelNumber
            else
                self.index = self.index + 1
                self.preIndex = self.index - 1
            end
            self:bgAnimation()
            self:btnAnimation()
        end
    end)
    addBtnEventListener(self.programBtn[2], function(event)
        if event.name=='began' then
            print("programBtn is begining!")
            return true
        elseif event.name=='ended' then
            print("programBtn is pressed!")
            if self.index < 2 then
                self.index = self.totalLevelNumber
                self.preIndex = 1
            else
                self.index = self.index - 1
                self.preIndex = self.index + 1
            end
            self:bgAnimation()
            self:btnAnimation()
        end
    end)

    for i = 3, 10 do
        addBtnEventListener(self.programBtn[i], function(event)
            if event.name=='began' then
                print("programBtn is begining!")
            return true
            elseif event.name=='ended' then
                print("programBtn is pressed!")
            end
        end)
    end    
end

function LevelMapLayer:refreshLevels(groupId)
    -- load level layer
    local bgNode = cc.uiloader:load("LevelMap_levelBtn/levelMap_"..self.index..".ExportJson")
    bgNode:setPosition(0, 0)
    self:addChild(bgNode, 1)
    self.bgNode = bgNode

    -- seek all button
    local levelBtn = {}
    for i = 1, self.totalLevelNumber_1 do
        levelBtn[i] = cc.uiloader:seekNodeByName(self, "level_"..i)
        levelBtn[i]:setTouchEnabled(true)

    -- add listener
    addBtnEventListener(levelBtn[i], function(event)
        if event.name=='began' then
            print("bigLevel = ", self.index, "smallLevelBtn = "..i.." is begining!")
            
            local levelDetailLayer = LevelDetailLayer.new(self.index, i)
            self.popupCommonLayer = app:getInstance(PopupCommonLayer)
            self.popupCommonLayer:showPopup(levelDetailLayer)

            -- self:addChild(getPopupTips("关卡尚未开启！"), 100)
            return true
        elseif event.name=='ended' then
            print("bigLevel = ", self.index, "smallLevelBtn = "..i.." is pressed!")
        end
    end)
    end
end
    
function LevelMapLayer:bgAnimation()
    --Amplify times of background
    self.amplifyTimes = 2
    self.smallTime = 0.7
    self.bigTime = 0.7

    -- switching animation
    if self.index == 1 then
        self.x, self.y = 0, 0
    elseif self.index == 2 then
        self.x, self.y = -display.width*(self.amplifyTimes - 1), 0
    elseif self.index == 3 then
        self.x, self.y = -display.width*(self.amplifyTimes - 1), -display.height*(self.amplifyTimes - 1)
    elseif self.index == 4 then
        self.x, self.y = 0, -display.height*(self.amplifyTimes - 1)
    end

    local bgScaleToSmall = cc.ScaleTo:create(self.smallTime, 1)
    local bgScaleToBig = cc.ScaleTo:create(self.bigTime, self.amplifyTimes)
    local bgMoveToOrigin = cc.MoveTo:create(self.smallTime, cc.p(0, 0))
    local delay = cc.DelayTime:create(self.smallTime)
    local bgMoveTo = cc.MoveTo:create(self.bigTime, cc.p(self.x, self.y))

    self.bg:runAction(cc.EaseIn:create(bgScaleToSmall, 1))   -- Native C++
    self.bg:runAction(transition.newEasing(bgMoveToOrigin, "In", 1))  -- quick package
    self.bg:runAction(cc.Sequence:create({delay, cc.EaseIn:create(bgScaleToBig, 2.5)}))  -- Native C++
    self.bg:runAction(cc.Sequence:create({delay, cc.EaseIn:create(bgMoveTo, 2.5)}))  -- Native C++

-- To make button disabled for a while
    self.programBtn[1]:setTouchEnabled(false)
    self.programBtn[2]:setTouchEnabled(false)
    self.bgNode:removeFromParent()

    self.programBtn[1]:runAction(transition.sequence({cc.DelayTime:create(self.smallTime + self.bigTime), 
        cc.CallFunc:create(function()
                self.programBtn[1]:setTouchEnabled(true)
                self.programBtn[2]:setTouchEnabled(true)
                self.programBtn[11]:removeAllChildren()
                self.programBtn[11]:addChild(display.newSprite("LevelMap_ui/"..self.index..".png", 60, 25), 2)
                self:refreshLevels()
            end)}))
end

function LevelMapLayer:btnAnimation()
    local changeTime = 0.2
    self.programBtn[12]:runAction(cc.MoveBy:create(changeTime, cc.p(0, 74)))
    self.programBtn[13]:runAction(cc.MoveBy:create(changeTime, cc.p(230, 0)))
    self.programBtn[14]:runAction(cc.MoveBy:create(changeTime, cc.p(0, -70)))
    self.programBtn[12]:runAction(transition.sequence({cc.DelayTime:create(self.smallTime + self.bigTime), 
        cc.CallFunc:create(function()
            -- reverse() is not work!
                self.programBtn[12]:runAction(cc.MoveBy:create(changeTime, cc.p(0, -74)))
                self.programBtn[13]:runAction(cc.MoveBy:create(changeTime, cc.p(-230, 0)))
                self.programBtn[14]:runAction(cc.MoveBy:create(changeTime, cc.p(0, 70)))
            end)}))
end

function LevelMapLayer:onExit()
end
    
return LevelMapLayer