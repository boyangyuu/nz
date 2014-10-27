--
-- Author: Fangzhongzheng
-- Date: 2014-10-21 14:32:57
--
import("..includes.functionUtils")

local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

function LevelMapLayer:ctor()
    self:onEnter()
end
    -- 
function LevelMapLayer:onEnter() 
-- Member variables
    self.index = 1
    self.preIndex = 0
    self.totalLevelNumber = 4    -- "Big level" total number
    self.totalLevelNumber_1 = 6  -- "Interior small level" of 1 big level total number

-- load bg ang play bg starting animation
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
    local bg = display.newSprite("levelMap_bg.png", 0, 0)
    bg:setScaleX(1)
    bg:setScaleY(1)
    bg:setAnchorPoint(0, 0)
    self:addChild(bg, 0) 
    self.bg = bg
    self.bg:runAction(cc.ScaleTo:create(0.6, 1.8))  -- Starting action

    -- local label = ui.newTTFLabelWithOutline({
    --     text = "超值礼包",
    --     font = "隶书",
    --     size = 32,
    --     color = cc.c3b(0, 0, 0),
    --     align = cc.ui.TEXT_ALIGN_LEFT,
    --     outlineColor = cc.c4b(255, 255, 0, 255),
    --     })
    -- self:addChild(label, 2)

-- load control bar
    local controlNode = cc.uiloader:load("levelMap_ui.ExportJson")
    controlNode:setPosition(0, 0) -- Because anchor is (0, 0)
    self:addChild(controlNode, 2)

    -- seek all button
    local ccsBtn = 
    {
    "btn_next", 
    "btn_pre",
    "btn_setting",
    "btn_buyCoin",
    "btn_arsenal",
    "btn_inlay",
    "btn_shop",
    "btn_sale",
    "btn_task",
    "btn_gift",
    "level"
    }
    local programBtn = {}

    for i, v in ipairs(ccsBtn) do
        programBtn[i] = cc.uiloader:seekNodeByName(self, v)
        programBtn[i]:setTouchEnabled(true)
    end

    -- set Member variables(or U can setting global variables)
    self.programBtn = programBtn
    self.programBtn[11]:setTouchEnabled(false)
    self.programBtn[11]:addChild(display.newSprite("1.png", 60, 25), 2)

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

-- load level layer
    self:changeBigLevel()
end

function LevelMapLayer:changeBigLevel()
    -- load level layer
    local bgNode = cc.uiloader:load("levelMap_"..self.index..".ExportJson")
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
                self:addChild(getPopupLayer("levelMap_popup.ExportJson"), 100)
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
                self.programBtn[11]:addChild(display.newSprite(self.index..".png", 60, 25), 2)
                self:changeBigLevel()
            end)}))
end

function LevelMapLayer:onExit()
end
    
return LevelMapLayer