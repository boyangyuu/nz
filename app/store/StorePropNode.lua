local StoreConfigs = import(".StoreConfigs")

local StorePropNode = class("StorePropNode", function()
    return display.newNode()
end)

function StorePropNode:ctor(property)
    --instance
    self.inlayModel = md:getInstance("InlayModel")
    self.propModel = md:getInstance("PropModel")
    self.userModel = md:getInstance("UserModel")
    self.buyModel = md:getInstance("BuyModel")

    --events
    cc.EventProxy.new(self.propModel, self)
            :addEventListener(self.propModel.PROP_UPDATE_EVENT, handler(self, self.refreshUI))

    cc.EventProxy.new(self.inlayModel, self)
            :addEventListener(self.inlayModel.REFRESH_ALLINLAY_EVENT, handler(self, self.refreshUI))

    --ui
    self:loadCCS()
    self:initUI()
end

function StorePropNode:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/Store")
    self.ui = cc.uiloader:load("prop.ExportJson")
    self:addChild(self.ui)

    --armature
    local sctbsrc = "res/Store/shangchengz_tb/shangchengz_tb.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(sctbsrc)
    local plist = "res/Store/shangchengz_tb/shangchengz_tb0.plist"
    local png = "res/Store/shangchengz_tb/shangchengz_tb0.png"
    display.addSpriteFrames(plist,png)

end

function StorePropNode:initUI(event)
    --item lei
    local item = cc.uiloader:seekNodeByName(self.ui, "item1")

    local btnBuy  = cc.uiloader:seekNodeByName(item, "btnBuy")  
    btnBuy:onButtonClicked(function()
         self:onClickBtn_lei()
    end)       

    local btnarmature = ccs.Armature:create("bt_yjzb")
    btnBuy:addChild(btnarmature)
    btnarmature:getAnimation():play("yjzb" , -1, 1)
    local panelimg = cc.uiloader:seekNodeByName(item, "panelimg")  
    local iconArmature = ccs.Armature:create("shangchengz_tb")
    addChildCenter(iconArmature, panelimg, -1)
    iconArmature:getAnimation():play("die" , -1, 1)

    local ownnumber = cc.uiloader:seekNodeByName(item, "ownnumber")
    local num = self.propModel:getPropNum("lei")
    ownnumber:setString(num)

    --item jijia
    local item = cc.uiloader:seekNodeByName(self.ui, "item2")

    local btnBuy  = cc.uiloader:seekNodeByName(item, "btnBuy")
    btnBuy:onButtonClicked(function()
         self:onClickBtn_jijia()
    end)  

    local btnarmature = ccs.Armature:create("bt_yjzb")
    btnBuy:addChild(btnarmature)
    btnarmature:getAnimation():play("yjzb" , -1, 1)
    local panelimg = cc.uiloader:seekNodeByName(item, "panelimg")  
    local iconArmature = ccs.Armature:create("shangchengz_tb")
    addChildCenter(iconArmature, panelimg, -1)
    iconArmature:getAnimation():play("die" , -1, 1)

    local ownnumber = cc.uiloader:seekNodeByName(item, "ownnumber")
    local num = self.propModel:getPropNum("jijia")
    ownnumber:setString(num)

    --item goldWeapon
    local item = cc.uiloader:seekNodeByName(self.ui, "item3")
    local btnBuy  = cc.uiloader:seekNodeByName(item, "btnBuy")
    btnBuy:onButtonClicked(function()
         self:onClickBtn_goldWeapon()
    end)    

    local btnarmature = ccs.Armature:create("bt_yjzb")
    btnBuy:addChild(btnarmature)
    btnarmature:getAnimation():play("yjzb" , -1, 1)
    local panelimg = cc.uiloader:seekNodeByName(item, "panelimg")  
    local iconArmature = ccs.Armature:create("shangchengz_tb")
    addChildCenter(iconArmature, panelimg, -1)
    iconArmature:getAnimation():play("die" , -1, 1)
    
    local ownnumber = cc.uiloader:seekNodeByName(item, "ownnumber")
    local num = self.inlayModel:getGoldWeaponNum()
    ownnumber:setString(num)    
end

function StorePropNode:refreshUI(event)
    --item lei
    local item = cc.uiloader:seekNodeByName(self.ui, "item1")
    local ownnumber = cc.uiloader:seekNodeByName(item, "ownnumber")
    local num = self.propModel:getPropNum("lei")
    ownnumber:setString(num)

    --item jijia
    local item = cc.uiloader:seekNodeByName(self.ui, "item2")
    local ownnumber = cc.uiloader:seekNodeByName(item, "ownnumber")
    local num = self.propModel:getPropNum("jijia")
    ownnumber:setString(num)

    --item goldWeapon
    local item = cc.uiloader:seekNodeByName(self.ui, "item3")
    local ownnumber = cc.uiloader:seekNodeByName(item, "ownnumber")
    local num = self.inlayModel:getGoldWeaponNum()
    ownnumber:setString(num)     
end

function StorePropNode:onClickBtn_lei()
    print("function StorePropNode:onClickBtn_lei()")
    local configs = StoreConfigs.getConfig("prop")
    local config  = configs[1]
    dump(config, "config")    
    local isBuyed = self.userModel:costDiamond(config["costDiamond"], 
        true, "商城界面_钻石不足买手雷") 
    if isBuyed then
        self.propModel:addProp("lei",config["num"])
    else
        -- self.buyModel:showBuy("handGrenade",
        --     {payDoneFunc = handler(self,self.onBuySuccessed)}, 
        --     "商城界面_钻石不足买手雷")        
    end
end

function StorePropNode:onClickBtn_goldWeapon()
    print("function StorePropNode:onClickBtn_goldWeapon()")    
    local configs = StoreConfigs.getConfig("prop")
    local config  = configs[2]    
    local isBuyed = self.userModel:costDiamond(config["costDiamond"],
        true, "商城界面_钻石不足买黄武") 
    if isBuyed then 
        self.inlayModel:buyGoldsInlay(config["num"]) 
    end    

    -- self.buyModel:showBuy("goldWeapon",
    --     {payDoneFunc = handler(self,self.onBuySuccessed)}, 
    --     "商城界面_钻石不足买黄武")
end

function StorePropNode:onClickBtn_jijia()
    print("function StorePropNode:onClickBtn_jijia()")
    local configs = StoreConfigs.getConfig("prop")
    local config  = configs[3]    
    local isBuyed = self.userModel:costDiamond(config["costDiamond"],
        true, "商城界面_钻石不足买机甲") 
    if isBuyed then
        self.propModel:addProp("jijia",
            config["num"])
    else     
        -- self.buyModel:showBuy("armedMecha",
        --     {payDoneFunc = handler(self,self.onBuySuccessed)}, 
        --     "商城界面_钻石不足买机甲")
    end
end

function StorePropNode:onBuySuccessed()

end

function StorePropNode:getContentType()
    return "prop"
end

return StorePropNode