local InlayListCell = import(".InlayListCell")

local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
    self.inlayModel = md:getInstance("InlayModel")
    self.buyModel = md:getInstance("BuyModel")


   self.selectarm = nil

	self.btn = {}
    self.icon = {}
    self.typeIds = {"speed", "crit", "clip", "bullet", 
    "helper", "blood",}
end

function InlayLayer:onShow()
    -- load and init
    if self.ui == nil then
        self:loadCCS()
        self:initUI()
        self:initGuide()
    end

    -- refresh
    self:refreshBtnIcon()
    self:refreshListView("speed")
    self:refreshAvatar()

    -- event
    cc.EventProxy.new(self.inlayModel , self)
     :addEventListener(self.inlayModel.REFRESH_INLAY_EVENT, handler(self, self.refreshUI))
end

function InlayLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/InlayShop")
    local controlNode = cc.uiloader:load("xiangqian.ExportJson")
    if self.ui then
        return
    end
    self.ui = controlNode
    self:addChild(controlNode)
end

function InlayLayer:refreshUI(event)
    self:refreshBtnIcon(event)
    self:refreshListView(event.typeName)
    self:refreshAvatar()
end

function InlayLayer:initUI()
    self.panelInlay = cc.uiloader:seekNodeByName(self, "panelinlay")
    self.panelListView = cc.uiloader:seekNodeByName(self, "panellistview")
    self.rootListView = cc.uiloader:seekNodeByName(self.panelListView, "listview")
    self.oneForAllBtn = cc.uiloader:seekNodeByName(self.panelInlay, "btnforall")
    self.goldWeaponBtn = cc.uiloader:seekNodeByName(self.panelInlay, "btngoldweapon")
    cc.uiloader:seekNodeByName(self.oneForAllBtn, "yijianxiangqian")
            :enableOutline(cc.c4b(140, 49, 2,255), 2)

    local manager = ccs.ArmatureDataManager:getInstance()
    local inlaybtnsrc = "res/InlayShop/xqan_hjwq/xqan_hjwq.ExportJson"
    manager:addArmatureFileInfo(inlaybtnsrc)
    local plist = "res/InlayShop/xqan_hjwq/xqan_hjwq0.plist"
    local png   = "res/InlayShop/xqan_hjwq/xqan_hjwq0.png"
    display.addSpriteFrames(plist, png)          

    local hjwqbssrc = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs.ExportJson"
    manager:addArmatureFileInfo(hjwqbssrc)
    local plist = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs0.plist"
    local png   = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs0.png"
    display.addSpriteFrames(plist, png)          

    local xqtbsrc = "res/InlayShop/xqtb/xqtb.ExportJson"
    manager:addArmatureFileInfo(xqtbsrc)
    local plist = "res/InlayShop/xqtb/xqtb0.plist"
    local png   = "res/InlayShop/xqtb/xqtb0.png"
    display.addSpriteFrames(plist, png)          

    local xqzbsrc = "res/InlayShop/xqzb/xqzb.ExportJson"
    manager:addArmatureFileInfo(xqzbsrc)
    local plist = "res/InlayShop/xqzb/xqzb0.plist"
    local png   = "res/InlayShop/xqzb/xqzb0.png"
    display.addSpriteFrames(plist, png)

    self.iconarm = ccs.Armature:create("xqtb")
    self.goldBtnArmature = ccs.Armature:create("xqan_hjwq")
    addChildCenter(self.goldBtnArmature, self.goldWeaponBtn)
    self.goldBtnArmature:getAnimation():play("Animation1" , -1, 1)


    self.goldgun = cc.uiloader:seekNodeByName(self.panelInlay, "d")
    self.goldgun:setVisible(false)
    self.oneForAllBtn:setTouchEnabled(true)
    self.goldWeaponBtn:setTouchEnabled(true)
    addBtnEventListener(self.oneForAllBtn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickOneForAllBtn()
        end
    end)

    addBtnEventListener(self.goldWeaponBtn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickGoldWeaponBtn()
        end
    end)

    for k,v in pairs(self.typeIds) do
        self.btn[v] = cc.uiloader:seekNodeByName(self.panelInlay, "panel"..v)
        self.icon[v] = cc.uiloader:seekNodeByName(self.panelInlay, "icon"..v)
        self.btn[v]:setTouchEnabled(true)
        self.btn[v]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                self:refreshListView(v)    
            end
        end)
    end
end

function InlayLayer:onClickOneForAllBtn()
    self:playSoundxqcg()
    self.inlayModel:equipAllInlays()
end

function InlayLayer:onClickGoldWeaponBtn()
    local goldweaponNum = self.inlayModel:getGoldWeaponNum()
    if goldweaponNum > 0 then
        self.inlayModel:equipAllInlays()
        self:playSoundxqcg()
    else
        function equipGold()
            self.inlayModel:equipAllInlays()
            self:playSoundxqcg()
        end
        
        -- function deneyGoldGift()
            -- self.buyModel:showBuy("goldWeapon",{payDoneFunc = equipGold}, "镶嵌页面_土豪礼包取消")
        -- end
        -- self.buyModel:showBuy("goldGiftBag",{payDoneFunc = equipGold,deneyBuyFunc = deneyGoldGift},
        --      "镶嵌页面_点击一键黄武")
        
        local userModel = md:getInstance("UserModel")
        local isBuyed = userModel:costDiamond(40,
            true, "镶嵌界面_点击黄金武器") 
        if isBuyed then 
            self.inlayModel:buyGoldsInlay(2) 
            self.inlayModel:equipAllInlays()
            self:playSoundxqcg()
        end   
    end
end

function InlayLayer:playSoundxqcg()
    local xqcg = "res/Music/ui/xqcg.wav"
    audio.playSound(xqcg,false)
end

function InlayLayer:refreshListView(index)
    if self.selectarm then
        self.selectarm:removeFromParent()
        self.selectarm = nil
    end
    
    removeAllItems(self.rootListView)
    local table = self.inlayModel:getConfigTable("type", index)
    for i=1,#table do
        local item = self.rootListView:newItem()
        local content = InlayListCell.new(table[i])
        item:addContent(content)
        item:setItemSize(550, 165)
        self.rootListView:addItem(item)
    end
    self.rootListView:reload()

    self.selectarm = ccs.Armature:create("xqtb")
    addChildCenter(self.selectarm, self.icon[index])
    self.selectarm:getAnimation():play("xqtb",-1,1)
end

function InlayLayer:refreshAvatar()
    self.goldgun:setVisible(true)
    local goldarm = ccs.Armature:create("xqan_hjwqbs")
    if self.inlayModel:isGetAllGold() then
        self.goldgun:removeAllChildren()
        goldarm:getAnimation():setMovementEventCallFunc(
            function ( armatureBack,movementType,movementId ) 
                if movementType == ccs.MovementEventType.complete then
                    goldarm:getAnimation():play("xqan_chixu" , -1, 1)
                end
            end)
        addChildCenter(goldarm, self.goldgun)
        goldarm:getAnimation():play("xqan_hjwqbs" , -1, 0)

    else
        print("takeoff")
        self.goldgun:removeAllChildren()
        self.goldgun:setVisible(false)
    end
end

function InlayLayer:refreshBtnIcon(event)
    local allInlayed = self.inlayModel:getAllInlayed()
    for k,v in pairs(self.btn) do
        self.btn[k]:removeAllChildren()
    end
    for k,v in pairs(allInlayed) do
        local table = self.inlayModel:getConfigTable("id", v)
        local img =  display.newSprite("#"..table[1]["imgname"]..".png")
        addChildCenter(img,self.btn[k])
    end

    if event then    
        if event.isAll then
            for k,v in pairs(allInlayed) do
                local equiparm = ccs.Armature:create("xqzb")
                equiparm:getAnimation():setMovementEventCallFunc(
                    function ( armatureBack,movementType,movementId ) 
                        if movementType == ccs.MovementEventType.complete then
                            armatureBack:removeSelf()
                        end
                    end)
                addChildCenter(equiparm, self.btn[k])
                equiparm:getAnimation():play("Animation1" , -1, 0)
            end
            return
        elseif event.typeName then
            local equiparm = ccs.Armature:create("xqzb")
            equiparm:getAnimation():setMovementEventCallFunc(
                function ( armatureBack,movementType,movementId ) 
                    if movementType == ccs.MovementEventType.complete then
                        armatureBack:removeSelf()
                    end
                end)
            addChildCenter(equiparm, self.btn[event.typeName])
            equiparm:getAnimation():play("Animation1" , -1, 0)
        end
    end
end

function InlayLayer:initGuide()
    local guide = md:getInstance("Guide")
    local isDone = guide:isDone("xiangqian")
    if isDone then return end
    
    --click
    guide:addClickListener({
        id = "xiangqian_xiangqian1",
        groupId = "xiangqian",
        rect = cc.rect(35,227,117,90),
        endfunc = function (touchEvent)
            self:refreshListView("clip")

            playSoundBtn()
        end
     }) 

    --buy
    guide:addClickListener({
        id = "xiangqian_xiangqian2",
        groupId = "xiangqian",
        rect = cc.rect(780, 50, 140, 50),
        endfunc = function (touchEvent)
            self.inlayModel:buyInlay(6,1) 

            playSoundBtn()
        end
     })    

    --equip
    guide:addClickListener({
        id = "xiangqian_xiangqian3",
        groupId = "xiangqian",
        rect = cc.rect(940, 50, 140, 50),
        endfunc = function (touchEvent)
            self.inlayModel:equipInlay(6) 

            playSoundBtn()
        end
     }) 

    --fast equip
    guide:addClickListener({
        id = "xiangqian_xiangqian4",
        groupId = "xiangqian",
        rect = cc.rect(155,28,230,62),
        endfunc = function (touchEvent)
           self.inlayModel:buyInlay(3,1) 
           self.inlayModel:buyInlay(6,1) 
           self.inlayModel:buyInlay(9,1) 
           self.inlayModel:buyInlay(12,1) 
           self.inlayModel:buyInlay(15,1) 
           self.inlayModel:buyInlay(18,1) 
           self.inlayModel:equipAllInlays()

           playSoundBtn()
        end
     })     

    guide:addClickListener({
        id = "xiangqian_xiangqian5",
        groupId = "xiangqian",
        rect = cc.rect(0, 0, display.width1, display.height1),
        endfunc = function (touchEvent)
            
        end
     })        
end

return InlayLayer