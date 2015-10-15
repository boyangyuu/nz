

local BuyConfigs = import(".BuyConfigs")

local LayerColor_BLACK = cc.c4b(0, 0, 0, 180)

local RmbBuyPopup = class("RmbBuyPopup", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RmbBuyPopup:ctor(properties)
	--instance
	self.buyModel = md:getInstance("BuyModel")
	self.properties = properties
    self.configId = self.properties["configId"]
	-- events
    cc.EventProxy.new(self.buyModel, self)
        :addEventListener(self.buyModel.BUY_SUCCESS_EVENT, handler(self, self.close))

	self:loadCCS()
end

function RmbBuyPopup:loadCCS()
    self.node = cc.uiloader:load("res/gouMai/buyRmb.ExportJson")
    self:addChild(self.node)

    --btn close
    local btnDeny = cc.uiloader:seekNodeByName(self.node, "btnDeny")
    btnDeny:onButtonClicked(function()
         self:onClickDeny()
    end)

    --btn close
    local btnConfirm = cc.uiloader:seekNodeByName(self.node, "btnConfirm")
    btnConfirm:onButtonClicked(function()
         self:onClickConfirm()
    end)

    --content
    local config = BuyConfigs.getConfig(self.configId)
    local labelIapName = cc.uiloader:seekNodeByName(self.node, "labelIapName")
    labelIapName:setString(LanguageManager.getStringForKey("string_hint43") .. config["iapName"])
    local labelPrice = cc.uiloader:seekNodeByName(self.node, "labelPrice")
    labelPrice:setString(LanguageManager.getStringForKey("string_hint44") .. config["price"] .. LanguageManager.getStringForKey("string_hint45"))

    --易接
    local labelDesc = cc.uiloader:seekNodeByName(self.node, "labelDesc")
    labelDesc:setString(LanguageManager.getStringForKey("string_hint46") .. config["name"])
end

function RmbBuyPopup:onClickDeny(event)
    self:close()
end

function RmbBuyPopup:onClickConfirm(event)
    if self.properties["onClickConfirm"] then
        self.properties["onClickConfirm"]()
    end
end

function RmbBuyPopup:close()
	ui:closePopup("RmbBuyPopup",{animName = "normal"})
end

return RmbBuyPopup
