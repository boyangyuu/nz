

local BuyConfigs = import(".BuyConfigs")

local GiftBagPopup = class("GiftBagPopup", function()
	return display.newLayer()
end)

function GiftBagPopup:ctor(properties)
	print(properties.popupName)
	--instance
	

	self.param = properties
	self:loadCCS()
	self:initButtons()
end

function GiftBagPopup:loadCCS()
	local name = self.param.popupName
	local title = BuyConfigs.getConfig(name)
	if device.platform == "ios" then
		if name == "weaponGiftBag" then
			title.ccsPath = "res/GiftBag/GiftBag/GiftBag_WeaponGiftBag_ios.json"
		elseif name == "goldGiftBag" then
			title.ccsPath = "res/GiftBag/GiftBag/GiftBag_GoldGiftBag_ios.json"
		end
	end
	local giftBagNode = cc.uiloader:load(title.ccsPath)
    self:addChild(giftBagNode)

    local src = "res/GiftBag/lb_ljgm/lb_ljgm.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local plist = "res/GiftBag/lb_ljgm/lb_ljgm0.plist"
    local png   = "res/GiftBag/lb_ljgm/lb_ljgm0.png"
    display.addSpriteFrames(plist, png)          
end

function GiftBagPopup:initButtons()
	local receiveBtn = cc.uiloader:seekNodeByName(self, "btn_Receive")
	receiveBtn:setTouchEnabled(true)
	addBtnEventListener(receiveBtn, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:payThis()
		end
	end)

	--按钮动画
	if device.platform ~= "ios" then 
		local armature = ccs.Armature:create("lb_ljgm")
		armature:getAnimation():play("lb_ljgm", -1, 1)
		addChildCenter(armature, receiveBtn)
	end

	--
	local btnClose = cc.uiloader:seekNodeByName(self, "btn_Closed")
	btnClose:setTouchEnabled(true)
	addBtnEventListener(btnClose, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:close()
			local buyModel = md:getInstance("BuyModel")
			buyModel:deneyPay()
			print("btnClose is pressed!")
		end
	end)
	--
	local btnTousu = cc.uiloader:seekNodeByName(self, "btn_tousu")
	btnTousu:setTouchEnabled(true)
	addBtnEventListener(btnTousu, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			ui:showPopup("KefuPopup",{
			                    opacity = 0})
		end
	end)

	for i = 0,3 do
		local bitmap = cc.uiloader:seekNodeByName(self, "BitmapLabel_2"..i)
		if bitmap then
			bitmap:setColor(cc.c3b(0, 255, 161))
		end
	end
end

function GiftBagPopup:payThis()
	local buyModel = md:getInstance("BuyModel")
	if device.platform == "android" then
		self:close()
		buyModel:payGift()
	elseif device.platform == "ios" then
		local userModel = md:getInstance("UserModel")
		local name = self.param.popupName
		
		if name == "weaponGiftBag" then
			local isAfforded = userModel:costDiamond(260)
			if isAfforded then
				self:close()
				buyModel:payGift()
			end
		elseif name == "goldGiftBag" then
			local isAfforded = userModel:costDiamond(450)
			if isAfforded then
				self:close()
				buyModel:payGift()
			end
		end
	else
		self:close()
		buyModel:payGift()
	end
end

function GiftBagPopup:close()
	ui:closePopup("GiftBagPopup",{animName = "normal"})
end

return GiftBagPopup
