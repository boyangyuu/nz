--
-- Author: Fangzhongzheng
-- Date: 2014-10-21 14:32:57
--
import("..includes.functionUtils")
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

--------  Constants  ---------
local Zorder_ui = 2

-- Interior levels and group numbers
local levelBtnNum_1, levelBtnNum_2, levelBtnNum_3, levelBtnNum_4 = 6, 6, 6, 6
local groupNum = 4

--Amplify times and time of background
local amplifyTimes, smallTime, bigTime = 2, 0.7, 0.7

----------  Class  -----------
local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)

-----------  Ctor  -----------
function LevelMapLayer:ctor()
    self.index = 1
    self.preIndex = 0

    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")

    --ui
    self:onEnter()
end

---------  onEnter  ---------
function LevelMapLayer:onEnter() 

    -- bg starting animation
    local bg = display.newSprite("levelMap_bg.png")
    self:addChild(bg) 
    bg:setAnchorPoint(cc.p(0, 0))
    self.bg = bg
    self.bg:runAction(cc.ScaleTo:create(0.6, 1.8))  -- Starting action

    -- load control layer
    local uiNode = cc.uiloader:load("LevelMap_ui/levelMap_ui.ExportJson")
    self:addChild(uiNode, Zorder_ui) 

    -- init ui buttons
    self:initUiBtn(uiNode)

    -- load level layer
    self:refreshLevelsBtn(self.index)

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

---------  init Ui Btn  ---------
function LevelMapLayer:initUiBtn(uiNode)
    local ccsBtn = 
        {"btn_next", "btn_pre", "btn_setting", "btn_buyCoin", "btn_arsenal",
        "btn_inlay", "btn_shop", "btn_sale", "btn_task", "btn_gift", 
        "level", "Panel_up", "Panel_right", "panl_level", }
    self.btn = {}

    for k, v in pairs(ccsBtn) do
        self.btn[k] = cc.uiloader:seekNodeByName(uiNode, v)
        self.btn[k]:setTouchEnabled(true)
    end

    self.btn[11]:addChild(display.newSprite("LevelMap_ui/1.png", 60, 25), Zorder_ui)

    -- add listener (attention: this isnot button, so we add node event listener)
    addBtnEventListener(self.btn[1], function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
            if self.index >= groupNum then
                self.index = 1
                self.preIndex = groupNum
            else
                self.index = self.index + 1
                self.preIndex = self.index - 1
            end
            self:bgAction()
            self:btnAction()
        end
    end)
    addBtnEventListener(self.btn[2], function(event)
        if event.name=='began' then
            print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            print("Btn is pressed!")
            if self.index < 2 then
                self.index = groupNum
                self.preIndex = 1
            else
                self.index = self.index - 1
                self.preIndex = self.index + 1
            end
            self:bgAction()
            self:btnAction()
        end
    end)

    for i = 3, 10 do
        addBtnEventListener(self.btn[i], function(event)
            if event.name=='began' then
                print("Btn is begining!")
            return true
            elseif event.name=='ended' then
                print("Btn is pressed!")
            end
        end)
    end    
end

--------refresh Levels Btn--------
function LevelMapLayer:refreshLevelsBtn(groupId)
    -- load level layer
    self.levelBtnNode = cc.uiloader:load("LevelMap_levelBtn/levelMap_"..groupId..".ExportJson")
    self.levelBtnNode:setPosition(0, 0)
    self:addChild(self.levelBtnNode)  

    -- seek level buttons
    local levelBtnNum = {levelBtnNum_1, levelBtnNum_2, levelBtnNum_3 ,levelBtnNum_4, }

    local levelBtn = {}
    for i = 1, levelBtnNum[groupId] do
        levelBtn[i] = cc.uiloader:seekNodeByName(self, "level_"..i)
        levelBtn[i]:setTouchEnabled(true)

        -- add listener
        addBtnEventListener(levelBtn[i], function(event)
            if event.name=='began' then
                print("bigLevel = ", groupId, "smallLevelBtn = "..i.." is begining!")
                
                app:getInstance(PopupCommonLayer):showPopup(LevelDetailLayer.new(groupId, i))

                -- self:addChild(getPopupTips("关卡尚未开启！"), 100)
            end
        end)
    end
end

-----------  bg Action  -----------
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
    self.btn[1]:setTouchEnabled(false)
    self.btn[2]:setTouchEnabled(false)
    self.levelBtnNode:removeFromParent()

    self.btn[1]:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
                self.btn[1]:setTouchEnabled(true)
                self.btn[2]:setTouchEnabled(true)
                self.btn[11]:removeAllChildren()
                self.btn[11]:addChild(display.newSprite("LevelMap_ui/"..self.index..".png", 60, 25), 2)
                self:refreshLevelsBtn(self.index)
            end)}))
end

-----------  btn Action  -----------
function LevelMapLayer:btnAction()
    local changeTime = 0.2
    self.btn[12]:runAction(cc.MoveBy:create(changeTime, cc.p(0, 74)))
    self.btn[13]:runAction(cc.MoveBy:create(changeTime, cc.p(230, 0)))
    self.btn[14]:runAction(cc.MoveBy:create(changeTime, cc.p(0, -70)))
    self.btn[12]:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
            -- reverse() is not work!
                self.btn[12]:runAction(cc.MoveBy:create(changeTime, cc.p(0, -74)))
                self.btn[13]:runAction(cc.MoveBy:create(changeTime, cc.p(-230, 0)))
                self.btn[14]:runAction(cc.MoveBy:create(changeTime, cc.p(0, 70)))
            end)}))
end

function LevelMapLayer:onExit()
end
    
return LevelMapLayer