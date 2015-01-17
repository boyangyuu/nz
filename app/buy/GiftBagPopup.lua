

local BuyConfigs = import(".BuyConfigs")

local GiftBagPopup = class("GiftBagPopup", function()
	return display.newLayer()
end)

function GiftBagPopup:ctor(properties)
	print(properties.popupName)
	self.param = properties
	self:loadCCS()
	self:initButtons()
end

function GiftBagPopup:loadCCS()
	local name = self.param.popupName
	-- local btnTag = properties.btn
	local title = BuyConfigs.getConfig(name)
	local giftBagNode = cc.uiloader:load(title.ccsPath)
    self:addChild(giftBagNode)
end

function GiftBagPopup:initButtons()
	local receiveBtn = cc.uiloader:seekNodeByName(self, "btn_Receive")
	receiveBtn:setTouchEnabled(true)
	addBtnEventListener(receiveBtn, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			ui:closePopup("GiftBagPopup")

			-- self.param.callBackSuccess()
			local buy = md:getInstance("BuyModel")
			-- buy:buy("novicesBag", {})
			buy:buy_goldGiftBag()

			print("receiveBtn is pressed!")
		end
	end)

	local btnClose = cc.uiloader:seekNodeByName(self, "btn_Closed")
	btnClose:setTouchEnabled(true)
	addBtnEventListener(btnClose, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			ui:closePopup("GiftBagPopup")
			-- self:removeSelf()
			self.param.callBackFail()
			
			print("btnClose is pressed!")
		end
	end)

	for i = 0,3 do
		local bitmap = cc.uiloader:seekNodeByName(self, "BitmapLabel_2"..i)
		if bitmap then
			bitmap:setColor(cc.c3b(0, 255, 161))
		end
	end
end


return GiftBagPopup
