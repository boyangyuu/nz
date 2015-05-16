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
    self.guide       = md:getInstance("Guide")
    self.levelMapModel = md:getInstance("LevelMapModel")

    cc.EventProxy.new(self.usermodel , self)
        :addEventListener("REFRESH_MONEY_EVENT", handler(self, self.refreshMoney))
        :addEventListener("HOMEBAR_ACTION_UP_EVENT", handler(self, self.homeBarAction))
    
    self.properties = properties
    self.fightData  = properties["fightData"]

    self:loadCCS()
    self:initHomeLayer()
    self:refreshMoney()
    self:initGuideWeapon()
    self:initGuideInlay()

    self:refreshCommonLayer("levelMapLayer")
    self:setNodeEventEnabled(true)
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

function HomeBarLayer:initHomeLayer()
    self.btnSetting = cc.uiloader:seekNodeByName(self.homeRootNode, "btnset")
    self.btnBack = cc.uiloader:seekNodeByName(self.homeRootNode, "btnback")
    self.btnBuyCoin = cc.uiloader:seekNodeByName(self.homeRootNode, "panelmoney")
    self.btnArsenal = cc.uiloader:seekNodeByName(self.homeRootNode, "btnarsenal")
    self.btnInlay = cc.uiloader:seekNodeByName(self.homeRootNode, "btninlay")
    self.btnStore = cc.uiloader:seekNodeByName(self.homeRootNode, "btnstore")
    local zuanshi = cc.uiloader:seekNodeByName(self.homeRootNode, "Image_18")
    local jingbi = cc.uiloader:seekNodeByName(self.homeRootNode, "icon_jibi")
    self.panelUp = cc.uiloader:seekNodeByName(self.homeRootNode, "biaotou")
    self.notiArsenal = cc.uiloader:seekNodeByName(self.homeRootNode, "notiarsenal")
    self.notiStore = cc.uiloader:seekNodeByName(self.homeRootNode, "notistore")

    local btnarmature = ccs.Armature:create("sczg")
    btnarmature:setPosition(0,0)
    self.btnStore:addChild(btnarmature)
    btnarmature:getAnimation():play("sczg" , -1, 1)

    local guide = md:getInstance("Guide")
    local isNotDone = guide:isDone("xiangqian") == false
    if isNotDone then
        self.notiArsenal:setVisible(false)
        self.notiStore:setVisible(false)
    end
    
    self.btnBack:setTouchEnabled(true)  
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
    self.commonlayers["levelMapLayer"] = LevelMapLayer.new({fightData = self.fightData})
    for k,v in pairs(self.commonlayers) do
        v:setVisible(false)
        self.commonRootNode:addChild(v)
    end

    self.btnBuyCoin:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then                
            return true
        elseif event.name=='ended' then
            self.btnSetting:setVisible(false)
            self.btnBack:setVisible(true)
            self:refreshCommonLayer("StoreLayer")
            self.btnInlay:setButtonEnabled(true)
            self.btnStore:setButtonEnabled(false)
            self.btnArsenal:setButtonEnabled(true)
            local storeModel  = md:getInstance("StoreModel")
            storeModel:refreshInfo("bank")
        end
    end)

    addBtnEventListener(self.btnSetting, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            print("settingBtn is pressed!")
            local pauseModel = md:getInstance("PauseModel")
            pauseModel:showPopup("MapPausePopup",{popupName = "mapset"},{anim = true, isPauseScene = true})
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
        self:onBtnStoreClicked()
    end)
end

function HomeBarLayer:refreshCommonLayer(layer)
    for k,v in pairs(self.commonlayers) do
        if k == layer then
            v:setVisible(true)
            v:onShow()
        else
            v:setVisible(false)
        end
    end
end

function HomeBarLayer:homeBarAction()
    local changeTime = 0.2
    local smallTime, bigTime = 0.5, 0.5
    self.panelUp:runAction(cc.MoveBy:create(changeTime, cc.p(0, self.panelUp:getContentSize().height)))
    self.panelUp:runAction(transition.sequence({cc.DelayTime:create(smallTime + bigTime), 
        cc.CallFunc:create(function()
            self.panelUp:runAction(cc.MoveBy:create(changeTime, cc.p(0, -self.panelUp:getContentSize().height)))
        end)}))
end

function HomeBarLayer:onEnter()
    local fightFactory =   md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    local gid, lid  = self.levelMapModel:getConfig()
    if lid == 2 and gid == 1 then 
        self.guide:check("xiangqian")
    end

    if lid == 3 and gid == 1 then 
        self.guide:check("weapon")
    end

    -- music
    local startMusic = "res/Music/bg/bjyx.wav"
    audio.playMusic(startMusic,true)        
end

function HomeBarLayer:onBtnStoreClicked()
    self.notiStore:setVisible(false)
    local dianji = "res/Music/ui/button.wav"
    audio.playSound(dianji,false)
    self.btnSetting:setVisible(false)
    self.btnBack:setVisible(true)
    self:refreshCommonLayer("StoreLayer")
    self.btnInlay:setButtonEnabled(true)
    self.btnStore:setButtonEnabled(false)
    self.btnArsenal:setButtonEnabled(true)
end

function HomeBarLayer:onBtnInlayClicked()
    self.btnSetting:setVisible(false)
    self.btnBack:setVisible(true)
    self:refreshCommonLayer("inlayLayer")
    self.btnInlay:setButtonEnabled(false)
    self.btnStore:setButtonEnabled(true)
    self.btnArsenal:setButtonEnabled(true)
    playSoundBtn()    
end

function HomeBarLayer:onBtnArsenalClicked()
    self.notiArsenal:setVisible(false)
    self.btnSetting:setVisible(false)
    self.btnBack:setVisible(true)
    self:refreshCommonLayer("WeaponListLayer")
    self.btnInlay:setButtonEnabled(true)
    self.btnStore:setButtonEnabled(true)
    self.btnArsenal:setButtonEnabled(false)
    playSoundBtn()
end

function HomeBarLayer:onBtnBackClicked()
    self.btnBack:setVisible(false)
    self.btnSetting:setVisible(true)
    self:refreshCommonLayer("levelMapLayer")
    self.btnInlay:setButtonEnabled(true)
    self.btnStore:setButtonEnabled(true)
    self.btnArsenal:setButtonEnabled(true)
end

function HomeBarLayer:initGuideWeapon()
    local isDone = self.guide:isDone("weapon")
    if isDone then return end

    print("function HomeBarLayer:initGuide()")

    self.guide:addClickListener({
        id = "weapon_wuqiku",
        groupId = "weapon",
        rect = self.btnArsenal:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
            self:onBtnArsenalClicked()
        end
     })    

    self.guide:addClickListener({
        id = "weapon_back",
        groupId = "weapon",
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
            self:onBtnBackClicked()
        end
     })        

end

return HomeBarLayer