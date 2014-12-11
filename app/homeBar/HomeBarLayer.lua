


import("..includes.functionUtils")
local LevelMapLayer = import("..levelMap.LevelMapLayer")
local InlayLayer = import("..inlay.InlayLayer")
local WeaponListLayer = import("..weaponList.WeaponListLayer")
local StoreLayer = import("..store.StoreLayer")
local UserModel = import(".UserModel")
local HomeBarLayer = class("HomeBarLayer", function()
    return display.newLayer()
end)

function HomeBarLayer:ctor()
    self.usermodel = app:getInstance(UserModel)
    cc.EventProxy.new(self.usermodel , self)
        :addEventListener("REFRESH_MONEY_EVENT", handler(self, self.refreshMoney))
        :addEventListener("HOMEBAR_ACTION_UP_EVENT", handler(self, self.homeBarAction))
    self:addPlistRes("allImg0")

    self:loadCCS()
    self:initHomeLayer()
    self:refreshMoney()
    self:initCommonLayer()
end


function HomeBarLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/HomeBarLayer/biaotou")
    local rootNode = cc.uiloader:load("biaotou.ExportJson")
    self:addChild(rootNode)
    self.homeRootNode = cc.uiloader:seekNodeByName(rootNode, "biaotou")
    self.commonRootNode = cc.uiloader:seekNodeByName(rootNode, "commonlayer")
end

function HomeBarLayer:refreshMoney()
    local btnMoney = cc.uiloader:seekNodeByName(self.homeRootNode, "money")
    btnMoney:setString( self.usermodel:getMoney())
    local btnDiamond = cc.uiloader:seekNodeByName(self.homeRootNode, "diamond")
    btnDiamond:setString( self.usermodel:getDiamond())
end   

function HomeBarLayer:initHomeLayer()
    local btnSetting = cc.uiloader:seekNodeByName(self.homeRootNode, "btnset")
    local btnBack = cc.uiloader:seekNodeByName(self.homeRootNode, "btnback")
    -- local btnBuyCoin = cc.uiloader:seekNodeByName(self.homeRootNode, "btn_buyCoin")
    local btnArsenal = cc.uiloader:seekNodeByName(self.homeRootNode, "btnarsenal")
    local btnInlay = cc.uiloader:seekNodeByName(self.homeRootNode, "btninlay")
    local btnStore = cc.uiloader:seekNodeByName(self.homeRootNode, "btnstore")
    self.panelUp = cc.uiloader:seekNodeByName(self.homeRootNode, "biaotou")
    btnBack:setTouchEnabled(true)  
    btnArsenal:setTouchEnabled(true) 
    btnInlay:setTouchEnabled(true)  
    btnStore:setTouchEnabled(true)  
    btnSetting:setTouchEnabled(true)  
    
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
    -- addBtnEventListener(btnBuyCoin, function(event)
    --     if event.name=='began' then
    --         -- print("Btn is begining!")
    --         return true
    --     elseif event.name=='ended' then
    --         -- print("Btn is pressed!")
    --     end
    -- end)
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
    addBtnEventListener(btnStore, function(event)
        if event.name=='began' then
            -- print("Btn is begining!")
            return true
        elseif event.name=='ended' then
            btnSetting:setVisible(false)
            btnBack:setVisible(true)

            self.commonRootNode:removeAllChildren()
            local StoreLayer = StoreLayer.new()
            self.commonRootNode:addChild(StoreLayer)       
        end
    end)
end

function HomeBarLayer:initCommonLayer()
    local levelMapRootNode = LevelMapLayer.new()
    self.commonRootNode:addChild(levelMapRootNode)
end

function HomeBarLayer:addPlistRes(srcname)

    local plist = string.format("%s.plist", srcname)
    local name = string.format("%s.png", srcname)
     
    display.addSpriteFrames(plist, name)     
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