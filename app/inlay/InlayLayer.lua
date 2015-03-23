local InlayListCell = import(".InlayListCell")

local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
    self.inlayModel = md:getInstance("InlayModel")
    self.buyModel = md:getInstance("BuyModel")

    cc.EventProxy.new(self.inlayModel , self)
        :addEventListener("REFRESH_INLAY_EVENT", handler(self, self.refreshInlay))

   self.selectarm = nil

	self.btn = {}
    self.icon = {}
    self.typeId = {"speed", "crit", "clip", "bullet", 
    "helper", "blood",}
end

function InlayLayer:onEnter()
    self:loadCCS()
    self:initUI()
    self:initGuide()
    self:refreshBtnIcon()
    self:refreshListView("speed")
    self:refreshAvatar()
end

function InlayLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/InlayShop")
    local controlNode = cc.uiloader:load("xiangqian.ExportJson")
    if self.ui then
        return
    end
    self.ui = controlNode
    self:addChild(controlNode)

    display.addSpriteFrames("xiangqian0.plist", "xiangqian0.png")
end

function InlayLayer:refreshInlay(event)
    self:refreshBtnIcon(event)
    self:refreshListView(event.typename)
    self:refreshAvatar()
end

function InlayLayer:initUI()
    self.rootListView = cc.uiloader:seekNodeByName(self, "listview")
    self.oneForAllBtn = cc.uiloader:seekNodeByName(self, "btnforall")
    local goldWeaponBtn = cc.uiloader:seekNodeByName(self, "btngoldweapon")
    local yijianxiangqian = cc.uiloader:seekNodeByName(self, "yijianxiangqian")
    yijianxiangqian:enableOutline(cc.c4b(140, 49, 2,255), 2)

    local manager = ccs.ArmatureDataManager:getInstance()
    local inlaybtnsrc = "res/InlayShop/xqan_hjwq/xqan_hjwq.csb"
    manager:addArmatureFileInfo(inlaybtnsrc)
    local plist = "res/InlayShop/xqan_hjwq/xqan_hjwq0.plist"
    local png   = "res/InlayShop/xqan_hjwq/xqan_hjwq0.png"
    display.addSpriteFrames(plist, png)          

    local hjwqbssrc = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs.csb"
    manager:addArmatureFileInfo(hjwqbssrc)
    local plist = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs0.plist"
    local png   = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs0.png"
    display.addSpriteFrames(plist, png)          

    local xqtbsrc = "res/InlayShop/xqtb/xqtb.csb"
    manager:addArmatureFileInfo(xqtbsrc)
    local plist = "res/InlayShop/xqtb/xqtb0.plist"
    local png   = "res/InlayShop/xqtb/xqtb0.png"
    display.addSpriteFrames(plist, png)          

    local xqzbsrc = "res/InlayShop/xqzb/xqzb.csb"
    manager:addArmatureFileInfo(xqzbsrc)
    local plist = "res/InlayShop/xqzb/xqzb0.plist"
    local png   = "res/InlayShop/xqzb/xqzb0.png"
    display.addSpriteFrames(plist, png)

    self.iconarm = ccs.Armature:create("xqtb")
    local armature = ccs.Armature:create("xqan_hjwq")
    addChildCenter(armature, goldWeaponBtn)
    armature:getAnimation():play("Animation1" , -1, 1)


    self.goldgun = cc.uiloader:seekNodeByName(self, "d")
    self.goldgun:setVisible(false)
    self.oneForAllBtn:setTouchEnabled(true)
    goldWeaponBtn:setTouchEnabled(true)
    addBtnEventListener(self.oneForAllBtn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickOneForAllBtn()
        end
    end)

    addBtnEventListener(goldWeaponBtn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickGoldWeaponBtn()
        end
    end)

    for k,v in pairs(self.typeId) do
        self.btn[v] = cc.uiloader:seekNodeByName(self, "panel"..v)
        self.icon[v] = cc.uiloader:seekNodeByName(self, "icon"..v)
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
    self.inlayModel:refreshInfo("speed",true)
end

function InlayLayer:onClickGoldWeaponBtn()
    local goldweaponNum = self.inlayModel:getGoldWeaponNum()
    if goldweaponNum > 0 then
        self.inlayModel:equipAllInlays()
        self:playSoundxqcg()
    else
        function equipGold()
            self.inlayModel:equipAllInlays(true)
            self:playSoundxqcg()
        end
        function deneyGoldGift()
            self.buyModel:showBuy("goldWeapon",{payDoneFunc = equipGold}, "镶嵌页面_土豪礼包取消")
        end
        self.buyModel:showBuy("goldGiftBag",{payDoneFunc = equipGold,deneyBuyFunc = deneyGoldGift},
             "镶嵌页面_点击一键黄武")
    end
    self.inlayModel:refreshInfo("speed",true)
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
    dump(allInlayed, "allInlayed")
    for k,v in pairs(allInlayed) do
        local table = self.inlayModel:getConfigTable("id", v)
        local img =  display.newSprite("#"..table[1]["imgname"]..".png")
        addChildCenter(img,self.btn[k])
    end

    if event then    
        if event.isall then
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
        elseif event.typename then
            local equiparm = ccs.Armature:create("xqzb")
            equiparm:getAnimation():setMovementEventCallFunc(
                function ( armatureBack,movementType,movementId ) 
                    if movementType == ccs.MovementEventType.complete then
                        armatureBack:removeSelf()
                    end
                end)
            addChildCenter(equiparm, self.btn[event.typename])
            equiparm:getAnimation():play("Animation1" , -1, 0)
        end
    end
end

function InlayLayer:initGuide()
    local guide = md:getInstance("Guide")
    local isDone = guide:isDone("xiangqian")
    if isDone then return end

    --点击镶嵌
    local usermodel = md:getInstance("UserModel")
    
    --click
    guide:addClickListener({
        id = "xiangqian_xiangqian1",
        groupId = "xiangqian",
        rect = self.btn["clip"]:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
            self:refreshListView("clip")

            playSoundBtn()
        end
     }) 

    --buy
    guide:addClickListener({
        id = "xiangqian_xiangqian2",
        groupId = "xiangqian",
        rect = cc.rect(780, 70, 140, 50),
        endfunc = function (touchEvent)
            self.inlayModel:buyInlay(7,true,1) 

            playSoundBtn()
        end
     })    

    --equip
    guide:addClickListener({
        id = "xiangqian_xiangqian3",
        groupId = "xiangqian",
        rect = cc.rect(940, 70, 140, 50),
        endfunc = function (touchEvent)
            self.inlayModel:equipInlay(7,true) 

            playSoundBtn()
        end
     }) 

    --fast equip
    guide:addClickListener({
        id = "xiangqian_xiangqian4",
        groupId = "xiangqian",
        rect = self.oneForAllBtn:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
           self.inlayModel:buyInlay(3,false,1) 
           self.inlayModel:buyInlay(6,false,1) 
           self.inlayModel:buyInlay(9,false,1) 
           self.inlayModel:buyInlay(12,false,1) 
           self.inlayModel:buyInlay(15,false,1) 
           self.inlayModel:buyInlay(18,true,1) 
           self.inlayModel:equipAllInlays(true)

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