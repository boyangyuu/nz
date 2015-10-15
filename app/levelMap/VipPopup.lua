local VipPopup = class("VipPopup", function()
	return display.newLayer()
end)

function VipPopup:ctor(properties)
	self.userModel = md:getInstance("UserModel")
	self.vipModel = md:getInstance("VipModel")
	self.properties = properties
	self:loadCCS()
	self:initUI()
end

function VipPopup:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/vip")
	local controlNode = nil
	if self.properties.style == "notBought" then
	    controlNode = cc.uiloader:load("vip.json")
	elseif self.properties.style == "haveBought" then
		controlNode = cc.uiloader:load("vipGet.json")
	end
    self:addChild(controlNode)
end

function VipPopup:initUI()
	if self.properties.style == "notBought" then
		self:initButtonsNotBought()
	elseif self.properties.style == "haveBought" then
		self:initButtonsHaveBought()
	end
end

function VipPopup:initButtonsNotBought()
	local btnConfirm = cc.uiloader:seekNodeByName(self, "btnConfirm")
    btnConfirm:onButtonPressed(function( event )
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function( event )
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function()
         	self:onClickConfirm()
	    end)
	local btnCancel = cc.uiloader:seekNodeByName(self, "btnCancel")
    btnCancel:onButtonPressed(function( event )
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function( event )
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function()
	        self:onClickCancel()
	    end)
end

function VipPopup:initButtonsHaveBought()
	local btnGet = cc.uiloader:seekNodeByName(self, "btnGet")
	local isGet = self.vipModel:isGet()
	if isGet then
		btnGet:setButtonEnabled(false)
	end
    btnGet:onButtonPressed(function( event )
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function( event )
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function()
	        self:onClickGet()
	    end)
    local btnCancel = cc.uiloader:seekNodeByName(self, "btnCancel")
    btnCancel:onButtonPressed(function( event )
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function( event )
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function()
	        self:onClickCancel()
	    end)
end

function VipPopup:onClickConfirm()
    local isAfforded = self.userModel:costDiamond(260, true, "260钻石购买VIP")
    if not isAfforded then return end
    self.vipModel:setGift()
    self.vipModel:setGet(true)
    local buyModel = md:getInstance("BuyModel")
    buyModel:setBought("vip")
    ui:showPopup("commonPopup",
     {type = "style1", content = LanguageManager.getStringForKey("string_hint172")},
     { opacity = 170})
    ui:closePopup("VipPopup")
end

function VipPopup:onClickCancel()
	ui:closePopup("VipPopup")
end

function VipPopup:onClickGet()
	self.vipModel:setGift()
    self.vipModel:setGet(true)
    ui:showPopup("commonPopup",
     {type = "style2", content = LanguageManager.getStringForKey("string_hint6")},
     { opacity = 170})
    ui:closePopup("VipPopup")
end

return VipPopup