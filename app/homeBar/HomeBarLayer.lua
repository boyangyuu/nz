import("..includes.functionUtils")
local LevelMapLayer = import("..levelMap.LevelMapLayer")
local InlayLayer = import("..inlay.InlayLayer")
local WeaponListLayer = import("..weaponList.WeaponListLayer")
local StoreLayer = import("..store.StoreLayer")
local FightDescLayer = import("..fight.fightDesc.FightDescLayer")
local pauseScene = import("..help.PauseScene")


local HomeBarLayer = class("HomeBarLayer", function()
    return display.newLayer()
end)

function HomeBarLayer:ctor(properties)
    self.usermodel = md:getInstance("UserModel")
    self.storeModel = md:getInstance("StoreModel")

    cc.EventProxy.new(self.usermodel , self)
        :addEventListener("REFRESH_MONEY_EVENT", handler(self, self.refreshMoney))
        :addEventListener("HOMEBAR_ACTION_UP_EVENT", handler(self, self.homeBarAction))
    
    -- self:playSound()
    self:initData(properties)
    self:loadCCS()
    self:initHomeLayer(self.groupid)
    self:refreshMoney()
    self:refreshCommonLayer("levelMapLayer")
    self:setNodeEventEnabled(true)

end

function HomeBarLayer:playSound()
    local homeBarMusic = "res/HomeBarLayer/homeBar.ogg"
    audio.playMusic(homeBarMusic,true)
end

function HomeBarLayer:initData(properties)
    if table.nums(properties) ~= 0 then
        self.groupid = properties.groupid
    else
        self.groupid = 0
    end
     -- dump(properties)
end

function HomeBarLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/HomeBarLayer")
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

function HomeBarLayer:initHomeLayer(groupid)
    local btnSetting = cc.uiloader:seekNodeByName(self.homeRootNode, "btnset")
    local btnBack = cc.uiloader:seekNodeByName(self.homeRootNode, "btnback")
    local btnBuyCoin = cc.uiloader:seekNodeByName(self.homeRootNode, "panelmoney")
    local btnArsenal = cc.uiloader:seekNodeByName(self.homeRootNode, "btnarsenal")
    local btnInlay = cc.uiloader:seekNodeByName(self.homeRootNode, "btninlay")
    local btnStore = cc.uiloader:seekNodeByName(self.homeRootNode, "btnstore")
    local zuanshi = cc.uiloader:seekNodeByName(self.homeRootNode, "Image_18")
    local jingbi = cc.uiloader:seekNodeByName(self.homeRootNode, "icon_jibi")
    self.panelUp = cc.uiloader:seekNodeByName(self.homeRootNode, "biaotou")
    btnBack:setTouchEnabled(true)  
    btnArsenal:onButtonPressed(function(event)
        event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function(event)
        event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    btnInlay:onButtonPressed(function(event)
        event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function(event)
        event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    btnStore:onButtonPressed(function(event)
        event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function(event)
        event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    btnSetting:setTouchEnabled(true)  
    btnBack:setVisible(false)
    btnBuyCoin:setTouchEnabled(true)

    zsarmature = ccs.Armature:create("zss")
    zsarmature:setPosition(cc.p(23,25))
    zuanshi:addChild(zsarmature)
    zsarmature:getAnimation():play("zss" , -1, 1)

    jbarmature = ccs.Armature:create("jbs")
    jbarmature:setPosition(cc.p(21,24))
    jingbi:addChild(jbarmature)
    jbarmature:getAnimation():play("jbs" , -1, 1)

    self.commonlayers = {}
    self.commonlayers["WeaponListLayer"] = WeaponListLayer.new()
    self.commonlayers["inlayLayer"] = InlayLayer.new()
    self.commonlayers["StoreLayer"] = StoreLayer.new()
    self.commonlayers["levelMapLayer"] = LevelMapLayer.new({groupId = groupid})
    for k,v in pairs(self.commonlayers) do
        v:setVisible(false)
        self.commonRootNode:addChild(v)
    end

    btnBuyCoin:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then                
            return true
        elseif event.name=='ended' then
            self.storeModel:refreshInfo("bank")
            btnSetting:setVisible(false)
            btnBack:setVisible(true)
            self:refreshCommonLayer("StoreLayer")
        end
    end)

    addBtnEventListener(btnSetting, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            print("settingBtn is pressed!")
            -- ui:showPopup("MapPopup")
            -- cc.Director:getInstance():pushScene(MapPopup)
            local pause = pauseScene.new()
            pause:pause("mapset")


            btnInlay:setButtonEnabled(true)
            btnStore:setButtonEnabled(true)
            btnArsenal:setButtonEnabled(true)
        end
    end)
    addBtnEventListener(btnBack, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            btnBack:runAction(cc.ScaleTo:create(0.05, 0.5027, 1))
            btnBack:setVisible(false)
            btnSetting:setVisible(true)
            self:refreshCommonLayer("levelMapLayer")
            btnInlay:setButtonEnabled(true)
            btnStore:setButtonEnabled(true)
            btnArsenal:setButtonEnabled(true)
        end
    end)

    btnArsenal:onButtonClicked(function()
        btnSetting:setVisible(false)
        btnBack:setVisible(true)
        self:refreshCommonLayer("WeaponListLayer")
        btnInlay:setButtonEnabled(true)
        btnStore:setButtonEnabled(true)
        btnArsenal:setButtonEnabled(false)
    end)
    btnInlay:onButtonClicked(function()
        btnSetting:setVisible(false)
        btnBack:setVisible(true)
        self:refreshCommonLayer("inlayLayer")
        btnInlay:setButtonEnabled(false)
        btnStore:setButtonEnabled(true)
        btnArsenal:setButtonEnabled(true)
    end)
    btnStore:onButtonClicked(function()
        btnSetting:setVisible(false)
        btnBack:setVisible(true)
        self:refreshCommonLayer("StoreLayer")

        local buy = md:getInstance("BuyModel")
        buy:buy("goldGiftBag", { isAll = true})
        btnInlay:setButtonEnabled(true)
        btnStore:setButtonEnabled(false)
        btnArsenal:setButtonEnabled(true)
    end)
end

function HomeBarLayer:refreshCommonLayer(layer)
    for k,v in pairs(self.commonlayers) do
        if k == layer then
            v:setVisible(true)
        else
            v:setVisible(false)
        end
    end
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

function HomeBarLayer:onEnter()
    self:playSound()
end

function HomeBarLayer:onCleanup()

end

return HomeBarLayer