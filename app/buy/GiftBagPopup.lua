

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
	local title = BuyConfigs.getConfig(name)
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
			self:close()
			self.buyModel:payGift()
		end
	end)

	--按钮动画
	local armature = ccs.Armature:create("lb_ljgm")
	armature:getAnimation():play("lb_ljgm", -1, 1)
	addChildCenter(armature, receiveBtn)

	--
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
	ui:closePopup("GiftBagPopup",{isCancelAnim = true})
end

return GiftBagPopup
