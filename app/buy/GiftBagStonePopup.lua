

local GiftBagStonePopup = class("GiftBagStonePopup", function()
	return display.newLayer()
end)

function GiftBagStonePopup:ctor(property)
	dump(property, "property")
	--instance
	self.property = property
	self:loadCCS()
	self:initButtons()
end

function GiftBagStonePopup:loadCCS()
	local ccsName = self.property["ccsName"] or "GiftBag_Xianshidacu"
	local ccsPath = "res/GiftBag/GiftBag/" .. ccsName .. ".json"
	self.ui =  cc.uiloader:load(ccsPath)
    self:addChild(self.ui)

    --armature
    local src = "res/GiftBag/lb_ljgm/lb_ljgm.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local plist = "res/GiftBag/lb_ljgm/lb_ljgm0.plist"
    local png   = "res/GiftBag/lb_ljgm/lb_ljgm0.png"
    display.addSpriteFrames(plist, png)

    --hql anim
    local hqlsrc = "res/WeaponList/iconhql_tx/iconhql_tx.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(hqlsrc)
    local plist = "res/WeaponList/iconhql_tx/iconhql_tx0.plist"
    local png   = "res/WeaponList/iconhql_tx/iconhql_tx0.png"
    display.addSpriteFrames(plist, png)       
end

function GiftBagStonePopup:initButtons()
	--receive
	local receiveBtn = cc.uiloader:seekNodeByName(self.ui, "btn_Receive")
    receiveBtn:onButtonClicked(function()
         self:onClickBuy()
    end)

	local armature = ccs.Armature:create("lb_ljgm")
	armature:getAnimation():play("lb_ljgm", -1, 1)
	addChildCenter(armature, receiveBtn)

	local gunArmature = ccs.Armature:create("iconhql_tx")
    gunArmature:getAnimation():play("bosschixu" , -1, 1)
    gunArmature:setScale(1.3)
    gunArmature:setPosition(cc.p(457, 330))
    self:addChild(gunArmature)

	--close
	local btnClose = cc.uiloader:seekNodeByName(self.ui, "btn_Closed")
    btnClose:onButtonClicked(function()
         self:onClickClose()
    end)

	--tousu
	local btnTousu = cc.uiloader:seekNodeByName(self.ui, "btn_tousu")
    btnTousu:onButtonClicked(function()
			ui:showPopup("KefuPopup")
    end)
end

function GiftBagStonePopup:onClickBuy()
	local user = md:getInstance("UserModel")
	local strPos = self.property["strPos"] or  "钻石不足_限时大促“火麒麟”"
    local cost   = self.property["stoneCost"]
    local isAfforded = user:costDiamond(cost, true, strPos) 
    if isAfforded then
		self:onBuyDone()
    end		
end

function GiftBagStonePopup:onBuyDone()
	--lei
	local propModel = md:getInstance("PropModel")
	propModel:addProp("lei", 100)	

	--hpBag 
	propModel:addProp("hpBag", 10)	

	--黄武
	local inlayModel = md:getInstance("InlayModel")
	inlayModel:buyGoldsInlay(5)

	--白银
    inlayModel:buyInlay(2,10) 
    inlayModel:buyInlay(5,10) 
    inlayModel:buyInlay(8,10) 
    inlayModel:buyInlay(11,10) 
    inlayModel:buyInlay(14,10) 
    inlayModel:buyInlay(17,10) 	

    --武器
    local weaponId = 9
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:buyWeapon(weaponId)
	-- ui:showPopup("WeaponNotifyLayer",
	--      {type = "gun",
	--      weaponId = weaponId},
	--      {opacity = 255})
	-- weaponListModel:equipBag(weaponId, 1)

	ui:showPopup("GiftBagStoneGetPopup")

	--close
	self:onClickClose()
end

function GiftBagStonePopup:onClickClose()
	ui:closePopup("GiftBagStonePopup",{animName = "normal"})
end

return GiftBagStonePopup
