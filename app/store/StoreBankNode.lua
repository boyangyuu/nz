
local StoreConfigs = import(".StoreConfigs")
local JavaUtils = import("..includes.JavaUtils")

local StoreBankNode = class("StoreBankNode", function()
    return display.newNode()
end)

function StoreBankNode:ctor(property)
    --instance
    self.userModel  = md:getInstance("UserModel")
    self.buyModel   = md:getInstance("BuyModel")
    --ui
    self:loadCCS()
    self:refreshUI()
end

function StoreBankNode:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/Store")
    local isAlValid = JavaUtils.getIsIapSDKValid("al") and not JavaUtils.getIsShenhe()
    local ccsName = isAlValid and "bank_zhifubao" or "bank"
    if device.platform == "ios" then
        ccsName = "bank_ios_ad"
    end
    self.ui = cc.uiloader:load(ccsName .. ".ExportJson")
    self:addChild(self.ui)
end

function StoreBankNode:refreshUI()
    --item
    local itemIndex = 1
    while true do
        print("itemIndex")
        local item = cc.uiloader:seekNodeByName(self.ui, "item"..itemIndex)
        if item == nil then break end

        if itemIndex == 3 and JavaUtils.isSIMDX() then
            item:setVisible(false)
        end

        --btn
        local btn  = cc.uiloader:seekNodeByName(item, "btnBuy")
        local index = itemIndex
        btn:onButtonClicked(function()
            if device.platform == "ios" and index ~= 7 then
                ui:showPopup("StoreLoadLayer",{},{animName = "normal",opacity = 0})
            end
            function delayBuy()
                 self:onClickBtnBuy(index)
            end
            self:performWithDelay(delayBuy, 0.5)
        end)
        itemIndex = itemIndex + 1
    end
end

function StoreBankNode:onClickBtnBuy(configIndex)
    if device.platform == "ios" and configIndex == 7 then
        local adModel = md:getInstance("ADModel")
        adModel:watchAD()
        return
    end

    local configs = StoreConfigs.getConfig("bank")
    local config  = configs[configIndex]
    dump(config, "config")
    self.buyModel:showBuy(config["buyId"],
        {iapType = "noConfirm", payType = config["payType"]},
        "商城界面_点击"..config["buyId"])
end

return StoreBankNode