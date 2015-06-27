local StorePropNode = class("StorePropNode", function()
    return display.newNode()
end)

function StorePropNode:ctor(property)
    --instance
    self.inlayModel = md:getInstance("InlayModel")
    self.propModel = md:getInstance("PropModel")
    self.userModel = md:getInstance("UserModel")
    self.storeModel = md:getInstance("StoreModel")
    self.buyModel = md:getInstance("BuyModel")

    --ui
    self:loadCCS()
    self:refreshUI()
end

function StorePropNode:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/Store")
    self.ui = cc.uiloader:load("prop.ExportJson")
    self:addChild(self.ui)
end

function StorePropNode:refreshUI()
    --item lei
    local item = cc.uiloader:seekNodeByName(self.ui, "item1")

    local btnBuy  = cc.uiloader:seekNodeByName(item, "btnBuy")  
    btnBuy:onButtonClicked(function()
         self:onClickBtn_lei()
    end)       
    local btnarmature = ccs.Armature:create("bt_yjzb")
    -- btnarmature
    btnBuy:addChild(btnarmature)
    btnarmature:getAnimation():play("yjzb" , -1, 1)

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
    -- btnarmature
    btnBuy:addChild(btnarmature)
    btnarmature:getAnimation():play("yjzb" , -1, 1)

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
    -- btnarmature
    btnBuy:addChild(btnarmature)
    btnarmature:getAnimation():play("yjzb" , -1, 1)
    
    local ownnumber = cc.uiloader:seekNodeByName(item, "ownnumber")
    local num = self.inlayModel:getGoldWeaponNum()
    ownnumber:setString(num)    
end

function StorePropNode:onClickBtn_lei()
    print("function StorePropNode:onClickBtn_lei()")
    self.buyModel:showBuy("handGrenade",
        {payDoneFunc = handler(self,self.onBuySuccessed)}, 
        "商城界面_取消土豪买手雷")
end

function StorePropNode:onClickBtn_goldWeapon()
    print("function StorePropNode:onClickBtn_goldWeapon()")    
    self.buyModel:showBuy("goldWeapon",
        {payDoneFunc = handler(self,self.onBuySuccessed)}, 
        "商城界面_取消土豪买黄武")
end

function StorePropNode:onClickBtn_jijia()
    print("function StorePropNode:onClickBtn_jijia()")
    self.buyModel:showBuy("armedMecha",
        {payDoneFunc = handler(self,self.onBuySuccessed)}, 
        "商城界面_取消土豪买机甲")
end

function StorePropNode:onBuySuccessed()
    self:playSound()
    self.storeModel:refreshInfo("prop")
end

function StorePropNode:getContentType()
    return "prop"
end

return StorePropNode