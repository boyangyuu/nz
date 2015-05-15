
--[[
“购买”的实体

]]
local BuyConfigs = import(".BuyConfigs")
local BuyModel = class("BuyModel", cc.mvc.ModelBase)
local proInfo = require("app.commonPopup.ProductInfoConfig")
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
	print("BuyModel:showBuy", strPos)
	assert(strPos, "strPos is nil configId :"..configId)
	self:clearData()
    self.curId = configId
    self.curBuyData =  buyData
    
    --um pay
    self.orderId = self:getRandomOrderId()
    local buyConfig = BuyConfigs.getConfig(configId) 
    -- print("展示付费点:" .. buyConfig.name .. ", 位置:" .. strPos)
    self.strDesc = buyConfig.name .. "__" ..strPos
    self.iap = md:getInstance("IAPsdk")
    um:onChargeRequest(self.orderId, self.strDesc, buyConfig.price, "CNY", 0, self.iap.telecomOperator)
	
    --um event
	local umData = {}
	umData[self.strDesc] = "展示付费点"
	um:event("支付情况", umData)  

	--pay
	local isGift = buyConfig.isGift 
	if isGift then
        ui:showPopup("GiftBagPopup",{popupName = configId},{animName = "shake"})
    else
    	local tipsStr = buyData.tips or proInfo.getConfig(configId)
    	ui:showPopup("commonPopup",
			 {type = "style7", content = tipsStr, 
			 callfuncCofirm = handler(self, self.iapPay)},
			 {opacity = 0})
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
	self.iap:pay(self.curId)
end

function BuyModel:gameResume()
	display.resume()
end

-- 生成订单号
function BuyModel:getRandomOrderId()
	local deviceId = "windows"
	if device.platform == "android" and isAnalytics then 
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

	local isNotPopKefu = self.curBuyData.isNotPopKefu
	if not isNotPopKefu then 
		ui:showPopup("commonPopup",{type = "style4",
                opacity = 0})
	end

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
	local propModel = md:getInstance("PropModel")
	local weaponIds = {3,4,5,7,8}
	local weaponIndex = 1
	for k,v in pairs(weaponIds) do
		weaponListModel:buyWeapon(v)
		weaponListModel:onceFull(v)
	end
	self:setBought("weaponGiftBag")

	--黄武*3
	inlayModel:buyGoldsInlay(3)
	if buydata.isNotPopFiveWeapon == true then
		ui:showPopup("commonPopup",
		 {type = "style1",content = "购买成功，请在武器库装备！"},
		 {opacity = 0})
		return 
	end
 
    local closeAllFunc = buydata.closeAllFunc

    local function showWeaponNotify()
		print("weaponIndex", weaponIndex)
	    local weaponId = weaponIds[weaponIndex]
	    if weaponId == nil then 
			ui:showPopup("commonPopup",
			 {type = "style1",content = "武器已购买，请在武器库装备！"},
			 {opacity = 0})
			if closeAllFunc then  closeAllFunc() end
			return 
		end
	    print("weaponId",weaponId)
	    ui:showPopup("WeaponNotifyLayer",
	     {type = "gun",weaponId = weaponId, onCloseFunc = showWeaponNotify})  
	    weaponIndex = weaponIndex + 1    	
    end
    showWeaponNotify()
end

function BuyModel:buy_novicesBag( buydata )
	print("BuyModel:buy_novicesBag(buydata)")
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("PropModel")
	--黄武*4
	inlayModel:buyGoldsInlay(4)
	--机甲*3
	propModel:addProp("jijia",3)
	--手雷*10
	propModel:addProp("lei",10)
	self:setBought("novicesBag")
end

function BuyModel:buy_goldGiftBag( buydata )
	print("BuyModel:buy_goldGiftBag(buydata)")
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("PropModel")
	--黄武*15
	inlayModel:buyGoldsInlay(15)

	--机甲*15
	propModel:addProp("jijia",15)
	--手雷*30
	propModel:addProp("lei",30)

	if not buydata.isNotPopup then 
		ui:showPopup("WeaponNotifyLayer",{type = "goldGift"})
	end
end

function BuyModel:buy_handGrenade( buydata )
	local propModel = md:getInstance("PropModel")
	local storeModel = md:getInstance("StoreModel")
	
	--手雷*20
	propModel:addProp("lei",20)
end

function BuyModel:buy_armedMecha( buydata )
	local propModel = md:getInstance("PropModel")
	local storeModel = md:getInstance("StoreModel")
	--jijia*2
	propModel:addProp("jijia",2)
end

function BuyModel:buy_goldWeapon( buydata )
	print("BuyModel:buy_goldWeapon( buydata )")
	--黄武*2
	local inlayModel = md:getInstance("InlayModel")
	local storeModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("PropModel")
	inlayModel:buyGoldsInlay(2)
end

function BuyModel:buy_onceFull( buydata )
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:onceFull(buydata.weaponid)
end

function BuyModel:buy_resurrection( buydata )
	print("BuyModel:buy_resurrection( buydata )")
	--yby todo
end

function BuyModel:buy_stone120( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:addDiamond(120)
end
function BuyModel:buy_stone260( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:addDiamond(260)
end
function BuyModel:buy_stone450( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:addDiamond(450)
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