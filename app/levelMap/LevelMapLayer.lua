--
-- Author: Fangzhongzheng
-- Date: 2014-10-21 14:32:57
--
local ViewUtils = import("..ViewUtils")

local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)
    
function LevelMapLayer:ctor()
    self:onEnter()
end
    
function LevelMapLayer:onEnter() 
-- Member variables
    self.index = 1
    self.preIndex = 0
    self.totalLevelNumber = 4    -- "Big level" total number
    self.totalLevelNumber_1 = 6  -- "Interior small level" of 1 big level total number

-- load bg ang play bg starting animation
    local bg = display.newSprite("res/LevelMap/levelMap_bg.png", 0, 0, {class=cc.FilteredSpriteWithOne})
    bg:setScaleX(1)
    bg:setScaleY(1)
    bg:setAnchorPoint(0, 0)
    self:addChild(bg, 0) 
    self.bg = bg
    self.bg:runAction(cc.ScaleTo:create(1.2, 2.0))  -- Starting action
    grayFilter = filter.newFilter("GRAY", {0.2, 0.3, 0.5, 0.1})
    self.bg:setFilter(grayFilter)

-- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
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
    ViewUtils:addBtnEventListener(self.programBtn[1], function(event)
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
    ViewUtils:addBtnEventListener(self.programBtn[2], function(event)
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
        ViewUtils:addBtnEventListener(self.programBtn[i], function(event)
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
        ViewUtils:addBtnEventListener(levelBtn[i], function(event)
            if event.name=='began' then
                print("bigLevel = ", self.index, "smallLevelBtn = "..i.." is begining!")
            return true
            elseif event.name=='ended' then
                print("bigLevel = ", self.index, "smallLevelBtn = "..i.." is pressed!")
            end
        end)
    end
end
    
function LevelMapLayer:bgAnimation()
    -- switching animation
    if self.index == 1 then
        self.x, self.y = 0, 0
    elseif self.index == 2 then
        self.x, self.y = -display.width, 0
    elseif self.index == 3 then
        self.x, self.y = -display.width, -display.height
    elseif self.index == 4 then
        self.x, self.y = 0, -display.height
    end

    local bgScaleToSmall = cc.ScaleTo:create(0.6, 1)
    local bgScaleToBig = cc.ScaleTo:create(1, 2)
    local bgMoveToOrigin = cc.MoveTo:create(0.6, cc.p(0, 0))
    local delay = cc.DelayTime:create(0.6)  
    local bgMoveTo = cc.MoveTo:create(1, cc.p(self.x, self.y))

    self.bg:runAction(bgScaleToSmall)
    self.bg:runAction(bgMoveToOrigin)
    self.bg:runAction(cc.Sequence:create({delay, bgScaleToBig}))
    self.bg:runAction(cc.Sequence:create({delay, bgMoveTo}))

-- To make button disabled for a while
    self.programBtn[1]:setTouchEnabled(false)
    self.programBtn[2]:setTouchEnabled(false)
    self.bgNode:removeFromParent()

    transition.execute(self.programBtn[1], cc.ScaleTo:create(0, 1), {
            delay = 1.6,
            easing = "backout",
            onComplete = function()
                self.programBtn[1]:setTouchEnabled(true)
                self.programBtn[2]:setTouchEnabled(true)
                self.programBtn[11]:removeAllChildren()
                self.programBtn[11]:addChild(display.newSprite(self.index..".png", 60, 25), 2)
                self:changeBigLevel()
            end,
        })
end

function LevelMapLayer:onExit()
end
    
return LevelMapLayer