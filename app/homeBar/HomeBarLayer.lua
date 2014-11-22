--
-- Author: Fangzhongzheng
-- Date: 2014-10-21 14:32:57
--
import("..includes.functionUtils")
local LevelMapLayer = import("..levelMap.LevelMapLayer")
local InlayLayer = import("..inlay.InlayLayer")
local WeaponListLayer = import("..weaponList.WeaponListLayer")
local HomeModel = import(".HomeModel")
local HomeBarLayer = class("HomeBarLayer", function()
    return display.newLayer()
end)

function HomeBarLayer:ctor()
    self:loadAllImg()

    self:addEventProtocolListener()
    self:loadCCS()
    self:initHomeLayer()
    self:initCommonLayer()
end

function HomeBarLayer:addEventProtocolListener()
    app:getInstance(HomeModel):addEventListener("HOMEBAR_ACTION_UP_EVENT", handler(self, self.homeBarAction))
end

function HomeBarLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/HomeBarLayer/")
    local rootNode = cc.uiloader:load("homeBarLayer.json")
    self:addChild(rootNode)
    self.homeRootNode = cc.uiloader:seekNodeByName(rootNode, "homeLayer")
    self.commonRootNode = cc.uiloader:seekNodeByName(rootNode, "commonLayer")
end

function HomeBarLayer:initHomeLayer()
    local btnSetting = cc.uiloader:seekNodeByName(self.homeRootNode, "btn_setting")
    local btnBack = cc.uiloader:seekNodeByName(self.homeRootNode, "btn_back")
    local btnBuyCoin = cc.uiloader:seekNodeByName(self.homeRootNode, "btn_buyCoin")
    local btnArsenal = cc.uiloader:seekNodeByName(self.homeRootNode, "btn_arsenal")
    local btnInlay = cc.uiloader:seekNodeByName(self.homeRootNode, "btn_inlay")
    local btnShop = cc.uiloader:seekNodeByName(self.homeRootNode, "btn_shop")
    self.panelUp = cc.uiloader:seekNodeByName(self.homeRootNode, "homeLayer")

    btnBack:setVisible(false)
    
    addBtnEventListener(btnSetting, function(event)
        if event.name=='began' then
            -- print("settingBtn is begining!")
            return true
        elseif event.name=='ended' then
            -- print("settingBtn is pressed!")
        end
    end)
    btnBack:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            btnBack:runAction(cc.ScaleTo:create(0.05, 0.4524, 0.9))
            return true
        elseif event.name=='ended' then
            btnBack:runAction(cc.ScaleTo:create(0.05, 0.5027, 1))
            btnBack:setVisible(false)
            btnSetting:setVisible(true)

            self.commonRootNode:removeAllChildren()
            self:initCommonLayer()
        end
    end)
    addBtnEventListener(btnBuyCoin, function(event)
        if event.name=='began' then
            -- print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            -- print("Btn is pressed!")
        end
    end)
    addBtnEventListener(btnArsenal, function(event)
        if event.name=='began' then
            -- print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            btnSetting:setVisible(false)
            btnBack:setVisible(true)

            self.commonRootNode:removeAllChildren()
            local WeaponListLayer = WeaponListLayer.new()
            self.commonRootNode:addChild(WeaponListLayer)
            -- print("Btn is pressed!")
        end
    end)
    addBtnEventListener(btnInlay, function(event)
        if event.name=='began' then
            -- print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            btnSetting:setVisible(false)
            btnBack:setVisible(true)

            self.commonRootNode:removeAllChildren()
            local inlayLayer = InlayLayer.new()
            self.commonRootNode:addChild(inlayLayer)
        end
    end)
    addBtnEventListener(btnShop, function(event)
        if event.name=='began' then
            -- print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            -- print("Btn is pressed!")
        end
    end)
end

function HomeBarLayer:initCommonLayer()
    local levelMapRootNode = LevelMapLayer.new()
    self.commonRootNode:addChild(levelMapRootNode)
end

function HomeBarLayer:loadAllImg()
    self.imgRootNode = cc.uiloader:load("AllImg/allImg.json")
    -- print(".......HomeBarLayer:loadAllImg()")
end

function HomeBarLayer:getImgByName(fileName)
    -- dump(self.imgRootNode, ".........imgRootNode")
    -- self.imgRootNode = cc.uiloader:load("res/AllImg/allImg.ExportJson")
    local file = cc.uiloader:seekNodeByName(self.imgRootNode, fileName)
    return file
end

function HomeBarLayer:homeBarAction()
    local changeTime = 0.2
    local smallTime, bigTime = 0.7, 0.7
    self.panelUp:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelUp:getContentSize().height)))
    self.panelUp:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
            self.panelUp:runAction(cc.MoveBy:create(changeTime, cc.p(0, -self.panelUp:getContentSize().height)))
        end)}))
end

return HomeBarLayer