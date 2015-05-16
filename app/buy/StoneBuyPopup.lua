

local BuyConfigs = import(".BuyConfigs")

local StoneBuyPopup = class("StoneBuyPopup", function()
	return display.newLayer()
end)

function StoneBuyPopup:ctor(properties)
	print(properties.popupName)
	--instance
	self.buyModel = md:getInstance("BuyModel")
	self.properties = properties

	--events
    -- cc.EventProxy.new(self.buyModel, self)
    --     :addEventListener(self.buyModel.BUY_SUCCESS_EVENT, handler(self, self.close))

	self:loadCCS()
end

function StoneBuyPopup:loadCCS()
    self.node = cc.uiloader:load("res/gouMai/buy_stone.ExportJson")
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
    local content = cc.uiloader:seekNodeByName(self.node, "content")
    content:setString(self.properties["tips"])
end

function StoneBuyPopup:onClickDeny(event)
    self:close()
end

function StoneBuyPopup:onClickConfirm(event)
    if self.properties["onClickConfirm"] then 
        self.properties["onClickConfirm"]() 
    else
        self.buyModel:iapPay()
    end
    -- self:close()
end

function StoneBuyPopup:close()
	ui:closePopup("StoneBuyPopup",{animName = "normal"})
end

return StoneBuyPopup
