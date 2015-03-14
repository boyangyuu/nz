
--[[
“购买”的实体

]]
local BuyConfigs = import(".BuyConfigs")
local BuyModel = class("BuyModel", cc.mvc.ModelBase)

-- 定义事件
function BuyModel:ctor(properties)
    BuyModel.super.ctor(self, properties) 
end

function BuyModel:clearData()
    self.curId = nil
    self.curBuyData =  nil
    self.orderId = nil
    self.strDesc = nil
end

function BuyModel:showBuy(configId, buyData, strPos)
	assert(strPos, "strPos is nil configId :"..configId)
	self:clearData()
    self.curId = configId
    self.curBuyData =  buyData
	local config  = BuyConfigs.getConfig(configId)

    --um pay
    self.orderId = self:getRandomOrderId()
    local buyConfig = BuyConfigs.getConfig(configId) 
    -- print("展示付费点:" .. buyConfig.name .. ", 位置:" .. strPos)
    self.strDesc = buyConfig.name .. "__" ..strPos
    um:onChargeRequest(self.orderId, self.strDesc, buyConfig.price, "CNY", 0, "MM")
	
    --um event
	local umData = {}
	umData[self.strDesc] = "展示付费点"
	um:event("支付情况", umData)  

	--pay
	local isGift = config.isGift 
	if isGift then
        ui:showPopup("GiftBagPopup",{popupName = configId},{animName = "Shake"})
    else
    	self:iapPay()
    end
end

function BuyModel:payGift()
	self:iapPay()

	--um
	local umData = {}
	umData[self.strDesc] = "点击购买礼包"
	um:event("支付情况", umData)   	
end

function BuyModel:iapPay()
	display.pause()
	iap:pay(self.curId)
end

function BuyModel:gameResume()
	display.resume()
end


-- 生成订单号
function BuyModel:getRandomOrderId()
	local deviceId = "windows"
	if device.platform == "android" then 
		deviceId = TalkingDataGA:getDeviceId()
	end
	local osTime = os.time()
	local seed = math.random(1, osTime)
	local id = deviceId.."_"..osTime.."_"..seed
	return id
end

function BuyModel:payDone(result)
	self:gameResume()
	local funcStr = "buy_"..self.curId
	self[funcStr](self, self.curBuyData)

	-- TalkingData 支付成功标志
	local buyConfig = BuyConfigs.getConfig(self.curId ) 
	print("成功记录付费点:", buyConfig["name"])
	um:onChargeSuccess(self.orderId)
	
	-- dump(self.curBuyData, "self.curBuyData")
	local payDoneFunc = self.curBuyData.payDoneFunc
	if payDoneFunc then payDoneFunc() end

	--um event
	local umData = {}
	umData[self.strDesc] = "支付成功"
	um:event("支付情况", umData)
end

function BuyModel:deneyPay()
	print("function BuyModel:deneyBuy()"..self.curId)
	self:gameResume()
	local deneyBuyFunc = self.curBuyData.deneyBuyFunc
	if deneyBuyFunc then  
		deneyBuyFunc() 
	end

	-- um event
	local umData = {}
	umData[self.strDesc] = "支付拒绝"
	um:event("支付情况", umData)	
end

function BuyModel:buy_weaponGiftBag(buydata)
	local weaponListModel = md:getInstance("WeaponListModel")
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	-- local weapontable = weaponListModel:getAllWeapon()
	local propModel = md:getInstance("propModel")
	local weapontable = {3,4,5,7,8}
	for k,v in pairs(weapontable) do
		weaponListModel:buyWeapon(v)
		weaponListModel:onceFull(v)
	end
	self:setBought("weaponGiftBag")

	--黄武*3
	inlayModel:buyGoldsInlay(3)
    inlayModel:refreshInfo("speed")

	storeModel:refreshInfo("prop")

	ui:showPopup("commonPopup",
	 {type = "style1",content = "请在武器库装备！"},
	 {opacity = 0})

end

function BuyModel:buy_novicesBag( buydata )
	print("BuyModel:buy_novicesBag(buydata)")
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*4
	inlayModel:buyGoldsInlay(4)
    inlayModel:refreshInfo("speed")
	--机甲*3
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	storeModel:refreshInfo("prop")
	self:setBought("novicesBag")
end

function BuyModel:buy_goldGiftBag( buydata )
	print("BuyModel:buy_goldGiftBag(buydata)")
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*15
	inlayModel:buyGoldsInlay(15)
    inlayModel:refreshInfo("speed")

	--机甲*15
	propModel:buyProp("jijia",15)
	--手雷*30
	propModel:buyProp("lei",30)
	storeModel:refreshInfo("prop")
end

function BuyModel:buy_changshuang( buydata )
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*4
	inlayModel:buyGoldsInlay(4)
    inlayModel:refreshInfo("speed")
	--机甲*3
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	storeModel:refreshInfo("prop")
end

function BuyModel:buy_timeGiftBag( buydata )
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	local userModel = md:getInstance("UserModel")
	--黄武*4
	inlayModel:buyGoldsInlay(4)
    inlayModel:refreshInfo("speed")
	--机甲*3
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	--金币*188888
	--zuanshi*260
	userModel:buyDiamond(260)
	userModel:addMoney(188888)
	storeModel:refreshInfo("prop")
end

function BuyModel:buy_handGrenade( buydata )
	local propModel = md:getInstance("propModel")
	local storeModel = md:getInstance("StoreModel")
	--手雷*20
	propModel:buyProp("lei",20)
	storeModel:refreshInfo("prop")
end

function BuyModel:buy_armedMecha( buydata )
	local propModel = md:getInstance("propModel")
	local storeModel = md:getInstance("StoreModel")
	--jijia*2
	propModel:buyProp("jijia",2)
	storeModel:refreshInfo("prop")
end

function BuyModel:buy_unlockWeapon( buydata )
	print("BuyModel:buy_unlockWeapon( buydata )")
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:buyWeapon(buydata.weaponid)

	ui:showPopup("commonPopup",
	 {type = "style1",content = "请在武器库装备！"},
	 {opacity = 0})

end

function BuyModel:buy_highgradeWeapon(buydata)
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:buyWeapon(buydata.weaponid)
	
	ui:showPopup("commonPopup",
	 {type = "style1",content = "请在武器库装备！"},
	 {opacity = 0})
end

function BuyModel:buy_goldWeapon( buydata )
	print("BuyModel:buy_goldWeapon( buydata )")
	--黄武*2
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	inlayModel:buyGoldsInlay(2)
	inlayModel:refreshInfo("speed")
	storeModel:refreshInfo("prop")
end

function BuyModel:buy_onceFull( buydata )
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:onceFull(buydata.weaponid)
end

function BuyModel:buy_resurrection( buydata )
	print("BuyModel:buy_resurrection( buydata )")
	--yby todo
end

function BuyModel:buy_stone10( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:buyDiamond(10)
end
function BuyModel:buy_stone45( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:buyDiamond(45)
end
function BuyModel:buy_stone120( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:buyDiamond(120)
end
function BuyModel:buy_stone260( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:buyDiamond(260)
end
function BuyModel:buy_stone450( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:buyDiamond(450)
end

function BuyModel:checkBought(giftId)
	local data = getUserData()
	local isDone = data.giftBag[giftId] 
	return isDone
end

function BuyModel:setBought(giftId)
	local data = getUserData()
	data.giftBag[giftId] = true
	setUserData(data)
end

return BuyModel