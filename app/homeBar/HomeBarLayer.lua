import("..includes.functionUtils")
local LevelMapLayer = import("..levelMap.LevelMapLayer")
local InlayLayer = import("..inlay.InlayLayer")
local WeaponListLayer = import("..weaponList.WeaponListLayer")
local StoreLayer = import("..store.StoreLayer")
local FightDescLayer = import("..fight.fightDesc.FightDescLayer")


local HomeBarLayer = class("HomeBarLayer", function()
    return display.newLayer()
end)

function HomeBarLayer:ctor(properties)
    self.usermodel   = md:getInstance("UserModel")
    self.storeModel  = md:getInstance("StoreModel")
    self.guide       = md:getInstance("Guide")

    cc.EventProxy.new(self.usermodel , self)
        :addEventListener("REFRESH_MONEY_EVENT", handler(self, self.refreshMoney))
        :addEventListener("HOMEBAR_ACTION_UP_EVENT", handler(self, self.homeBarAction))
    
    self:initData(properties)
    self:loadCCS()
    self:initHomeLayer(self.groupid)
    self:popUpGify(properties)
    self:refreshMoney()

    self:initGuideWeapon()
    self:initGuideInlay()

    self:refreshCommonLayer("levelMapLayer")
    self:setNodeEventEnabled(true)
end

function HomeBarLayer:popUpGify(properties)
    local isDone = self.guide:isDone("xiangqian")
    if properties.popgift and isDone then
        local buy = md:getInstance("BuyModel")
        buy:buy("timeGiftBag", {})
    end
end

function HomeBarLayer:initData(properties)
    if properties.groupid ~= nil then
        self.groupid = properties.groupid
    else
        self.groupid = 0
    end
end

function HomeBarLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/HomeBarLayer")
    local rootNode = cc.uiloader:load("biaotou.ExportJson")
    self:addChild(rootNode)
    self.homeRootNode = cc.uiloader:seekNodeByName(rootNode, "biaotou")
    self.commonRootNode = cc.uiloader:seekNodeByName(rootNode, "commonlayer")
    self.btnMoney = cc.uiloader:seekNodeByName(self.homeRootNode, "money")
    self.btnDiamond = cc.uiloader:seekNodeByName(self.homeRootNode, "diamond")
end

function HomeBarLayer:refreshMoney()
    self.btnMoney:setString(self.usermodel:getMoney())
    self.btnDiamond:setString(self.usermodel:getDiamond())
end   

function HomeBarLayer:initHomeLayer(groupid)
    self.btnSetting = cc.uiloader:seekNodeByName(self.homeRootNode, "btnset")
    self.btnBack = cc.uiloader:seekNodeByName(self.homeRootNode, "btnback")
    self.btnBuyCoin = cc.uiloader:seekNodeByName(self.homeRootNode, "panelmoney")
    self.btnArsenal = cc.uiloader:seekNodeByName(self.homeRootNode, "btnarsenal")
    self.btnInlay = cc.uiloader:seekNodeByName(self.homeRootNode, "btninlay")
    self.btnStore = cc.uiloader:seekNodeByName(self.homeRootNode, "btnstore")
    local zuanshi = cc.uiloader:seekNodeByName(self.homeRootNode, "Image_18")
    local jingbi = cc.uiloader:seekNodeByName(self.homeRootNode, "icon_jibi")
    self.panelUp = cc.uiloader:seekNodeByName(self.homeRootNode, "biaotou")


    local btnarmature = ccs.Armature:create("sczg")
    btnarmature:setPosition(0,0)
    -- btnarmature:setScale(1.2)
    self.btnStore:addChild(btnarmature)
    btnarmature:getAnimation():play("sczg" , -1, 1)


    self.btnBack:setTouchEnabled(true)  
    self.btnArsenal:onButtonPressed(function(event)
        -- event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function(event)
        -- event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    self.btnInlay:onButtonPressed(function(event)
        -- event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function(event)
        -- event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    self.btnStore:onButtonPressed(function(event)
        -- event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function(event)
        -- event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    self.btnSetting:setTouchEnabled(true)  
    self.btnBack:setVisible(false)
    self.btnBuyCoin:setTouchEnabled(true)

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

    self.btnBuyCoin:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then                
            return true
        elseif event.name=='ended' then
            self.storeModel:refreshInfo("bank")
            self.btnSetting:setVisible(false)
            self.btnBack:setVisible(true)
            self:refreshCommonLayer("StoreLayer")
            self.btnInlay:setButtonEnabled(true)
            self.btnStore:setButtonEnabled(false)
            self.btnArsenal:setButtonEnabled(true)
        end
    end)

    addBtnEventListener(self.btnSetting, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            print("settingBtn is pressed!")
            ui:showPopup("pausePopup",{popupName = "mapset"},{anim = true, isPauseScene = true})
            -- cc.Director:getInstance():pushScene(MapPopup)
            -- local pause = pauseScene.new()
            -- pause:pause({type = "mapset"})


            -- btnInlay:setButtonEnabled(true)
            -- btnStore:setButtonEnabled(true)
            -- btnArsenal:setButtonEnabled(true)
        end
    end)
    addBtnEventListener(self.btnBack, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onBtnBackClicked()
        end
    end)

    self.btnArsenal:onButtonClicked(function()
        self:onBtnArsenalClicked()
    end)
    self.btnInlay:onButtonClicked(function()
        self:onBtnInlayClicked()
    end)
    self.btnStore:onButtonClicked(function()
        self.btnSetting:setVisible(false)
        self.btnBack:setVisible(true)
        self:refreshCommonLayer("StoreLayer")

        local buy = md:getInstance("BuyModel")
        buy:buy("goldGiftBag", {})
        self.btnInlay:setButtonEnabled(true)
        self.btnStore:setButtonEnabled(false)
        self.btnArsenal:setButtonEnabled(true)

    end)
end

function HomeBarLayer:refreshCommonLayer(layer)
    for k,v in pairs(self.commonlayers) do
        if k == layer then
            v:setVisible(true)
            v:onEnter()
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
    self.guide:check("prefight02")
end

function HomeBarLayer:onBtnInlayClicked()
    self.btnSetting:setVisible(false)
    self.btnBack:setVisible(true)
    self:refreshCommonLayer("inlayLayer")
    self.btnInlay:setButtonEnabled(false)
    self.btnStore:setButtonEnabled(true)
    self.btnArsenal:setButtonEnabled(true)
end

function HomeBarLayer:onBtnArsenalClicked()
    self.btnSetting:setVisible(false)
    self.btnBack:setVisible(true)
    self:refreshCommonLayer("WeaponListLayer")
    self.btnInlay:setButtonEnabled(true)
    self.btnStore:setButtonEnabled(true)
    self.btnArsenal:setButtonEnabled(false)
end

function HomeBarLayer:onBtnBackClicked()
    self.btnBack:runAction(cc.ScaleTo:create(0.05, 0.5027, 1))
    self.btnBack:setVisible(false)
    self.btnSetting:setVisible(true)
    self:refreshCommonLayer("levelMapLayer")
    self.btnInlay:setButtonEnabled(true)
    self.btnStore:setButtonEnabled(true)
    self.btnArsenal:setButtonEnabled(true)
end

function HomeBarLayer:initGuideWeapon()
    local isDone = self.guide:isDone("prefight02")
    if isDone then return end

    print("function HomeBarLayer:initGuide()")

    self.guide:addClickListener({
        id = "prefight02_wuqiku",
        groupId = "prefight02",
        rect = self.btnArsenal:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
            self:onBtnArsenalClicked()
        end
     })    

    self.guide:addClickListener({
        id = "prefight02_back",
        groupId = "prefight02",
        rect = self.btnBack:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
            self:onBtnBackClicked()
        end
     })        

end

function HomeBarLayer:initGuideInlay() 
    local isDone = self.guide:isDone("xiangqian")
    if isDone then return end

    --点击镶嵌
    self.guide:addClickListener({
        id = "xiangqian_xiangqian",
        groupId = "xiangqian",
        rect = self.btnInlay:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
            self:onBtnInlayClicked()
        end
     })    

    --点击返回按钮
    self.guide:addClickListener({
        id = "xiangqian_back",
        groupId = "xiangqian",
        rect = self.btnBack:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
            -- self.guide:finishGuide()
            self:onBtnBackClicked()
        end
     })        

end

return HomeBarLayer