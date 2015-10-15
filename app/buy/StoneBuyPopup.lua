

local BuyConfigs = import(".BuyConfigs")

local StoneBuyPopup = class("StoneBuyPopup", function()
	return display.newLayer()
end)

function StoneBuyPopup:ctor(properties)
	print(properties.popupName)
	--instance
	self.buyModel = md:getInstance("BuyModel")
	self.properties = properties
	self:loadCCS()
end

function StoneBuyPopup:loadCCS()
    self.node = cc.uiloader:load("res/gouMai/buyBone.ExportJson")
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

    --price
    local labelPrice = cc.uiloader:seekNodeByName(self.node, "labelPrice")
    labelPrice:setString(LanguageManager.getStringForKey("string_hint47") .. self.properties["price"] .. "个")
    local labelDesc = cc.uiloader:seekNodeByName(self.node, "labelDesc")
    labelDesc:setString(LanguageManager.getStringForKey("string_hint46") .. self.properties["name"])
end

function StoneBuyPopup:onClickDeny(event)
    self:close()
end

function StoneBuyPopup:onClickConfirm(event)
    if self.properties["onClickConfirm"] then
        self.properties["onClickConfirm"]()
    end
end

function StoneBuyPopup:close()
	ui:closePopup("StoneBuyPopup",{animName = "normal"})
end

return StoneBuyPopup
