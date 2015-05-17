

local BuyConfigs = import(".BuyConfigs")

local RmbBuyPopup = class("RmbBuyPopup", function()
	return display.newLayer()
end)

function RmbBuyPopup:ctor(properties)
	print(properties.popupName)
	--instance
	self.buyModel = md:getInstance("BuyModel")
	self.properties = properties

	-- events
    cc.EventProxy.new(self.buyModel, self)
        :addEventListener(self.buyModel.BUY_SUCCESS_EVENT, handler(self, self.close))

	self:loadCCS()
end

function RmbBuyPopup:loadCCS()
    local jsonName = self.properties["jsonName"] 
    print("jsonName", jsonName)
    jsonName = "buy_stone"
    self.node = cc.uiloader:load("res/gouMai/"..jsonName..".ExportJson")
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
    local price = cc.uiloader:seekNodeByName(self.node, "content")
    price:setString(self.properties["price"])
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
