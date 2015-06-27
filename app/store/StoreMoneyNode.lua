

local StoreConfigs = import(".StoreConfigs")

local StoreMoneyNode = class("StoreMoneyNode", function()
    return display.newNode()
end)

function StoreMoneyNode:ctor(property)
    --instance
    self.storeModel = md:getInstance("StoreModel")
    self.userModel  = md:getInstance("UserModel")
    self.buyModel   = md:getInstance("BuyModel")

    --ui
    self:loadCCS()
    self:refreshUI()
end

function StoreMoneyNode:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/Store")
    self.ui = cc.uiloader:load("money.ExportJson")
    self:addChild(self.ui)
    
    --armature
    local sctbsrc = "res/Store/shangchengz_tb/shangchengz_tb.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(sctbsrc)
    local plist = "res/Store/shangchengz_tb/shangchengz_tb0.plist"
    local png = "res/Store/shangchengz_tb/shangchengz_tb0.png"
    display.addSpriteFrames(plist,png)    
end

function StoreMoneyNode:refreshUI()
    --item
    local itemIndex = 1
    while true do
        print("itemIndex: ", itemIndex) 
        local item = cc.uiloader:seekNodeByName(self.ui, "item"..itemIndex)
        if item == nil then break end

        --btn
        local btnBuy  = cc.uiloader:seekNodeByName(item, "btnBuy")
        local index = itemIndex
        btnBuy:onButtonClicked(function()
             self:onClickBtnBuy(index)
        end)

        -- btnarmature 
        local btnarmature = ccs.Armature:create("bt_yjzb")
        btnBuy:addChild(btnarmature)
        btnarmature:getAnimation():play("yjzb" , -1, 1)  
        local panelimg = cc.uiloader:seekNodeByName(item, "panelimg")  
        local iconArmature = ccs.Armature:create("shangchengz_tb")
        addChildCenter(iconArmature, panelimg, -1)
        iconArmature:getAnimation():play("die" , -1, 1)              

        itemIndex = itemIndex + 1
    end  
end

function StoreMoneyNode:onClickBtnBuy(configIndex)
    local configs = StoreConfigs.getConfig("money")
    local config  = configs[configIndex]
    -- dump(config, "config")  
    local result = self.userModel:costDiamond(
        config["costDiamond"],true,
        "商城页面购买金币")
    if result then 
        self.userModel:addMoney(config["number"])
        ui:showPopup("commonPopup",
             {type = "style2", content = "购买成功！"},
             { opacity = 0})              
    end
end

function StoreMoneyNode:getContentType()
    return "money"
end

return StoreMoneyNode