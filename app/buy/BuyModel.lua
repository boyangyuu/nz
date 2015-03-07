
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
    self.propName = nil
end

function BuyModel:showBuy(configId, buyData, strDesc)
	assert(strDesc, "strDesc is nil configId :"..configId)
	-- local name = configName .. "__" .. strDesc
	-- um:..
	self:clearData()
    self.curId = configId
    self.curBuyData =  buyData

    -- TalkingData支付统计
    self.orderId = self:getRandomOrderId()

    local buyConfig = BuyConfigs.getConfig(configId) 
    print("展示付费点:" .. buyConfig.name .. ", 位置:" .. strDesc)
    local name = buyConfig.name .. "__" ..strDesc

    --todo 价格
    um:onChargeRequest(self.orderId, name, buyConfig.price, "CNY", 0, "MM")
    -- um:event(self.propName, {self.propName = "1234"})

	local config  = BuyConfigs.getConfig(configId)
	local isGift = config.isGift 
	self.isFight = buyData.isFight

	if isGift then
        ui:showPopup("GiftBagPopup",{popupName = configId})
    else
    	iap:pay(configId)
    end
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
	print("function BuyModel:payDone():"..self.curId)
	local funcStr = "buy_"..self.curId
	self[funcStr](self, self.curBuyData)

	-- TalkingData 支付成功标志
	um:onChargeSuccess(self.orderId)
	-- um:event(self.propName)

	-- dump(self.curBuyData, "self.curBuyData")
	local payDoneFunc = self.curBuyData.payDoneFunc
	if payDoneFunc then payDoneFunc() end
end

function BuyModel:deneyPay()
	print("function BuyModel:deneyBuy()"..self.curId)
	local deneyBuyFunc = self.curBuyData.deneyBuyFunc
	if deneyBuyFunc then  deneyBuyFunc() end
end

function BuyModel:buy_weaponGiftBag(buydata)
	local weaponListModel = md:getInstance("WeaponListModel")
	local StoreModel = md:getInstance("StoreModel")
	-- local weapontable = weaponListModel:getAllWeapon()
	local propModel = md:getInstance("propModel")
	local weapontable = {3,4,5,7,8}
	for k,v in pairs(weapontable) do
		weaponListModel:buyWeapon(v)
		weaponListModel:onceFull(v)
	end
	self:setBought("weaponGiftBag")

	--手雷*10
	propModel:buyProp("lei",10)
	StoreModel:refreshInfo("prop")
end

function BuyModel:buy_novicesBag( buydata )
	print("BuyModel:buy_novicesBag(buydata)")
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	local UserModel = md:getInstance("UserModel")
	--黄武*1
	InlayModel:buyGoldsInlay(1)
    InlayModel:refreshInfo("speed")
	--机甲*1
	propModel:buyProp("jijia",1)
	--手雷*10
	propModel:buyProp("lei",10)
	--金币*188888
	UserModel:addMoney(188888)
	StoreModel:refreshInfo("prop")
	self:setBought("novicesBag")
end

function BuyModel:buy_goldGiftBag( buydata )
	print("BuyModel:buy_goldGiftBag(buydata)")
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*15
	InlayModel:buyGoldsInlay(15)
    InlayModel:refreshInfo("speed")

	--机甲*15
	propModel:buyProp("jijia",15)
	--手雷*30
	propModel:buyProp("lei",30)
	StoreModel:refreshInfo("prop")
end

function BuyModel:buy_changshuang( buydata )
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*4
	InlayModel:buyGoldsInlay(4)
    InlayModel:refreshInfo("speed")
	--机甲*3
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	StoreModel:refreshInfo("prop")
end

function BuyModel:buy_timeGiftBag( buydata )
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	local UserModel = md:getInstance("UserModel")
	--黄武*4
	InlayModel:buyGoldsInlay(4)
    InlayModel:refreshInfo("speed")
	--机甲*3
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	--金币*188888
	--zuanshi*260
	UserModel:buyDiamond(260)
	UserModel:addMoney(188888)
	StoreModel:refreshInfo("prop")
end

function BuyModel:buy_handGrenade( buydata )
	local propModel = md:getInstance("propModel")
	local StoreModel = md:getInstance("StoreModel")
	--手雷*20
	propModel:buyProp("lei",20)
	StoreModel:refreshInfo("prop")
end

function BuyModel:buy_armedMecha( buydata )
	local propModel = md:getInstance("propModel")
	local StoreModel = md:getInstance("StoreModel")
	--jijia*2
	propModel:buyProp("jijia",2)
	StoreModel:refreshInfo("prop")
end

function BuyModel:buy_unlockWeapon( buydata )
	print("BuyModel:buy_unlockWeapon( buydata )")
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:buyWeapon(buydata.weaponid)
end

function BuyModel:buy_goldWeapon( buydata )
	print("BuyModel:buy_goldWeapon( buydata )")
	--黄武*2
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	InlayModel:buyGoldsInlay(2)
	InlayModel:refreshInfo("speed")
	StoreModel:refreshInfo("prop")
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
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(10)
end
function BuyModel:buy_stone45( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(45)
end
function BuyModel:buy_stone120( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(120)
end
function BuyModel:buy_stone260( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(260)
end
function BuyModel:buy_stone450( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(450)
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