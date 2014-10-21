--
-- Author: Fangzhongzheng
-- Date: 2014-10-20 17:53:15
--
local ViewUtils = import("..ViewUtils")

local LevelMapLayer = class("LevelMapLayer", function()
    return display.newLayer()
end)
    
function LevelMapLayer:ctor()
    self:onEnter()
end
    
function LevelMapLayer:onEnter() 

-- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/LevelMap/")
    local controlNode = cc.uiloader:load("levelMap_ui.ExportJson")
    
    -- Because anchor is (0, 0)
    controlNode:setPosition(0, 0)
    self:addChild(controlNode, 2)

    -- seek all button
    local nextButton = cc.uiloader:seekNodeByName(self, "btn_next")
    local preButton = cc.uiloader:seekNodeByName(self, "btn_pre")
    local settingButton = cc.uiloader:seekNodeByName(self, "btn_setting")
    local buyCoinButton = cc.uiloader:seekNodeByName(self, "btn_buyCoin")
    local arsenalButton = cc.uiloader:seekNodeByName(self, "btn_arsenal")
    local inlayButton = cc.uiloader:seekNodeByName(self, "btn_inlay")
    local shopButton = cc.uiloader:seekNodeByName(self, "btn_shop")
    local saleButton = cc.uiloader:seekNodeByName(self, "btn_sale")
    local taskButton = cc.uiloader:seekNodeByName(self, "btn_task")
    local giftButton = cc.uiloader:seekNodeByName(self, "btn_gift")

    -- setTouchEnabled
    nextButton:setTouchEnabled(true)
    preButton:setTouchEnabled(true)
    settingButton:setTouchEnabled(true)
    buyCoinButton:setTouchEnabled(true)
    arsenalButton:setTouchEnabled(true)
    inlayButton:setTouchEnabled(true)
    shopButton:setTouchEnabled(true)
    saleButton:setTouchEnabled(true)
    taskButton:setTouchEnabled(true)
    giftButton:setTouchEnabled(true)

    -- add listener (attention: this isnot button, so we add node event listener)
    ViewUtils:addBtnEventListener(nextButton, function(event)
        if event.name=='began' then
        	print("nextButton is begining!")
            return true
        elseif event.name=='ended' then
            print("nextButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(preButton, function(event)
        if event.name=='began' then
            print("preButton is begining!")
            return true
        elseif event.name=='ended' then
            print("preButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(settingButton, function(event)
        if event.name=='began' then
            print("settingButton is begining!")
            return true
        elseif event.name=='ended' then
            print("settingButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(buyCoinButton, function(event)
        if event.name=='began' then
            print("buyCoinButton is begining!")
            return true
        elseif event.name=='ended' then
            print("buyCoinButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(arsenalButton, function(event)
        if event.name=='began' then
            print("arsenalButton is begining!")
            return true
        elseif event.name=='ended' then
            print("arsenalButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(inlayButton, function(event)
        if event.name=='began' then
            print("inlayButton is begining!")
            return true
        elseif event.name=='ended' then
            print("inlayButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(shopButton, function(event)
        if event.name=='began' then
            print("shopButton is begining!")
            return true
        elseif event.name=='ended' then
            print("shopButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(saleButton, function(event)
        if event.name=='began' then
            print("saleButton is begining!")
            return true
        elseif event.name=='ended' then
            print("saleButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(taskButton, function(event)
        if event.name=='began' then
            print("taskButton is begining!")
            return true
        elseif event.name=='ended' then
            print("taskButton is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(giftButton, function(event)
        if event.name=='began' then
            print("giftButton is begining!")
            return true
        elseif event.name=='ended' then
            print("giftButton is pressed!")
        end
    end)

-- load background
    -- local bgNode = cc.uiloader:load("levelMap_bg.ExportJson")
    -- bgNode:setPosition(0, 0)
    -- self:addChild(bgNode, 0)

    local manager = ccs.ArmatureDataManager:getInstance()
    manager:removeArmatureFileInfo("levelMap_bg.ExportJson")
    manager:addArmatureFileInfo("levelMap_bg.ExportJson")

    local armature = ccs.Armature:create("map_shijie")
    armature:getAnimation():play("0_1")
    -- armature:setPosition(cc.p(display.cx, display.cy))
    self:addChild(armature)

-- load level layer
    local bgNode = cc.uiloader:load("levelMap_1.ExportJson")
    bgNode:setPosition(0, 0)
    self:addChild(bgNode, 1)

    -- seek all button
    local levelBtn1 = cc.uiloader:seekNodeByName(self, "level_1")
    local levelBtn2 = cc.uiloader:seekNodeByName(self, "level_2")
    local levelBtn3 = cc.uiloader:seekNodeByName(self, "level_3")
    local levelBtn4 = cc.uiloader:seekNodeByName(self, "level_4")
    local levelBtn5 = cc.uiloader:seekNodeByName(self, "level_5")
    local levelBtn6 = cc.uiloader:seekNodeByName(self, "level_6")

     -- setTouchEnabled
    levelBtn1:setTouchEnabled(true)
    levelBtn2:setTouchEnabled(true)
    levelBtn3:setTouchEnabled(true)
    levelBtn4:setTouchEnabled(true)
    levelBtn5:setTouchEnabled(true)
    levelBtn6:setTouchEnabled(true)

-- add listener
    ViewUtils:addBtnEventListener(levelBtn1, function(event)
        if event.name=='began' then
            print("levelBtn1 is begining!")
            return true
        elseif event.name=='ended' then
            print("levelBtn1 is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(levelBtn2, function(event)
        if event.name=='began' then
            print("levelBtn2 is begining!")
            return true
        elseif event.name=='ended' then
            print("levelBtn2 is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(levelBtn3, function(event)
        if event.name=='began' then
            print("levelBtn3 is begining!")
            return true
        elseif event.name=='ended' then
            print("levelBtn3 is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(levelBtn4, function(event)
        if event.name=='began' then
            print("levelBtn4 is begining!")
            return true
        elseif event.name=='ended' then
            print("levelBtn4 is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(levelBtn5, function(event)
        if event.name=='began' then
            print("levelBtn5 is begining!")
            return true
        elseif event.name=='ended' then
            print("levelBtn5 is pressed!")
        end
    end)
    ViewUtils:addBtnEventListener(levelBtn6, function(event)
        if event.name=='began' then
            print("levelBtn6 is begining!")
            return true
        elseif event.name=='ended' then
            print("levelBtn6 is pressed!")
        end
    end)

    -- set gray Btn_1


end
    
function LevelMapLayer:onExit()
end
    
return LevelMapLayer