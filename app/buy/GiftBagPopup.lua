

local BuyConfigs = import(".BuyConfigs")

local GiftBagPopup = class("GiftBagPopup", function()
	return display.newLayer()
end)

function GiftBagPopup:ctor(properties)
	print(properties.popupName)
	--instance
	self.buyModel = md:getInstance("BuyModel")

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

    local src = "res/GiftBag/lb_ljlq/lb_ljlq.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)

end

function GiftBagPopup:initButtons()
	local receiveBtn = cc.uiloader:seekNodeByName(self, "btn_Receive")
	receiveBtn:setTouchEnabled(true)
	addBtnEventListener(receiveBtn, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:close()
			
			print("popupName:",self.param.popupName)
			local configName = self.param.popupName
			iap:pay(configName)

			-- self.buyModel:payDone()

			print("receiveBtn is pressed!")
		end
	end)

	if not self.param.isFight then 

		local armature = ccs.Armature:create("lb_ljlq")
		-- armature:setPosition(141, 45)
		armature:getAnimation():play("lb_ljlq", -1, 1)
		-- receiveBtn:addChild(armature)
		addChildCenter(armature, receiveBtn)
	end


	local btnClose = cc.uiloader:seekNodeByName(self, "btn_Closed")
	btnClose:setTouchEnabled(true)
	addBtnEventListener(btnClose, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:close()
			self.buyModel:deneyPay()
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

function GiftBagPopup:close()
	if self.param.isFight then
		ui:closePopup("GiftBagPopup", true)
	else
		ui:closePopup("GiftBagPopup")
	end
end

return GiftBagPopup
