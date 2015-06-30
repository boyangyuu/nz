
--[[
“购买”的实体

]]
local BuyConfigs = import(".BuyConfigs")
local BuyModel = class("BuyModel", cc.mvc.ModelBase)
local JavaUtils = import("..includes.JavaUtils")
--events
BuyModel.BUY_SUCCESS_EVENT   = "BUY_SUCCESS_EVENT"
BuyModel.BUY_FAIL_EVENT   	 = "BUY_FAIL_EVENT"

-- 定义事件
function BuyModel:ctor(properties)
    BuyModel.super.ctor(self, properties)
end

function BuyModel:clearData()
    self.curId = nil
    self.curBuyData = nil
    self.orderId = nil
    self.strDesc = nil
    self.payType = nil
end

function BuyModel:showBuy(configId, buyData, strPos)
	if configId == "goldGiftBag" and JavaUtils.isDefendDX() then configId = "goldGiftBag_dx" end
	if configId == "stone450" and JavaUtils.isDefendDX() then  configId = "stone260" end
	if configId == "weaponGiftBag" and self:checkBought("weaponGiftBag") then return end

	assert(strPos, "strPos is nil configId :"..configId)
	self:clearData()
    self.curId = configId
    self.curBuyData =  buyData
    self.payType = buyData.payType or "duanxin"
    self.payType = "al"
        
    --um pay
    self.orderId = self:getRandomOrderId()
    local buyConfig = BuyConfigs.getConfig(configId) 
    print("展示付费点:" .. buyConfig.name .. ", 位置:" .. strPos)
    self.strDesc = buyConfig.name .. "__" ..strPos
    self.iap = md:getInstance("IAPsdk")
    um:onChargeRequest(self.orderId, self.strDesc, buyConfig.price, "CNY", 0, self.iap.telecomOperator)
	
    --um event
	local umData = {}
	umData[self.strDesc] = "展示付费点"
	um:event("支付情况", umData)  

	--pay
	local showType = buyConfig.showType 
	local iapType = JavaUtils.getIapType() or buyData.iapType
	local isGiftValid = JavaUtils.getIsGiftValid()

	if showType == "gift" then
		if isGiftValid  or buyData.isGiftDirect then 
	        ui:showPopup("GiftBagPopup",
	        	{popupName = configId},
	        	{animName = "shake"})
	    end
    elseif showType == "iap" or iapType == "noConfirm" then 
    	self:iapPay()  

    elseif showType =="prop_rmb" then --非钻石购买的道具
    	ui:showPopup("RmbBuyPopup", 
    		 {configId = configId,
			 onClickConfirm = handler(self, self.iapPay)},
			 {animName = "moveDown", opacity = 150})    			  
    else
    	assert(false, "invalid showType", showType)
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
	local iapType = JavaUtils.getIapType()	
	if iapType == "noIap" then 
		ui:showPopup("KefuPopup",{
		content = "对不起, 游戏计费暂停了",
        opacity = 0})
		return	
	end

	display.pause()
	self.iap:pay(self.curId)
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

	local isNotPopKefu = self.curBuyData.isNotPopKefu
	if not isNotPopKefu then 
		ui:showPopup("KefuPopup",{
                opacity = 0})
	end

	--um event
	local umData = {}
	umData[self.strDesc] = "支付成功"
	um:event("支付情况", umData)

	--events
	self:dispatchEvent({name = BuyModel.BUY_SUCCESS_EVENT})
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
	local propModel = md:getInstance("PropModel")
	local weaponIds = {3,4,5,7,8}
	local weaponIndex = 1
	for k,v in pairs(weaponIds) do
		weaponListModel:buyWeapon(v)
		weaponListModel:halfFull(v)
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
	     {type = "gun",weaponId = weaponId, onCloseFunc = showWeaponNotify},{opacity = 255})  
	    weaponIndex = weaponIndex + 1    	
    end
    showWeaponNotify()
end

function BuyModel:buy_yijiaoBag( buydata )
	print("BuyModel:buy_yijiaoBag(buydata)")
	local userModel = md:getInstance("UserModel")
	userModel:addMoney(188888)
	self:setBought("yijiaoBag")
end

function BuyModel:buy_novicesBag( buydata )
	print("BuyModel:buy_novicesBag(buydata)")
	local inlayModel = md:getInstance("InlayModel")
	local propModel = md:getInstance("PropModel")
	local userModel = md:getInstance("UserModel")
	--黄武*4
	inlayModel:buyGoldsInlay(1)
	--机甲*3
	propModel:addProp("jijia",1)
	--手雷*10
	propModel:addProp("lei",10)

	userModel:addMoney(188888)
	
	self:setBought("novicesBag")
end

function BuyModel:buy_goldGiftBag( buydata )
	print("BuyModel:buy_goldGiftBag(buydata)")
	local inlayModel = md:getInstance("InlayModel")
	local propModel = md:getInstance("PropModel")
	--黄武*15
	inlayModel:buyGoldsInlay(15)

	--机甲*15
	propModel:addProp("jijia",15)
	--手雷*30
	propModel:addProp("lei",30)

	if not buydata.isNotPopup then 
		ui:showPopup("WeaponNotifyLayer",{type = "goldGift"},{opacity = 255})
	end
end

function BuyModel:buy_goldGiftBag_dx( buydata )
	print("BuyModel:buy_goldGiftBag(buydata)")
	local inlayModel = md:getInstance("InlayModel")
	local propModel = md:getInstance("PropModel")
	--黄武*10
	inlayModel:buyGoldsInlay(10)

	--机甲*10
	propModel:addProp("jijia",10)
	--手雷*20
	propModel:addProp("lei",20)

	if not buydata.isNotPopup then 
		ui:showPopup("WeaponNotifyLayer",{type = "goldGift"},{opacity = 255})
	end
end

function BuyModel:buy_handGrenade( buydata )
	local propModel = md:getInstance("PropModel")
	
	--手雷*20
	propModel:addProp("lei",20)
end

function BuyModel:buy_armedMecha( buydata )
	local propModel = md:getInstance("PropModel")
	--jijia*2
	propModel:addProp("jijia",2)
end

function BuyModel:buy_goldWeapon( buydata )
	print("BuyModel:buy_goldWeapon( buydata )")
	--黄武*2
	local inlayModel = md:getInstance("InlayModel")
	inlayModel:buyGoldsInlay(2)
end

function BuyModel:buy_onceFull( buydata )
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:onceFull(buydata.weaponid)
end

function BuyModel:buy_relive( buydata )
	print("BuyModel:buy_relive( buydata )")
	--yby todo
end

function BuyModel:buy_stone120( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:addDiamond(120, true)
end
function BuyModel:buy_stone260( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:addDiamond(260, true)
end
function BuyModel:buy_stone450( buydata )
	local userModel = md:getInstance("UserModel")
	userModel:addDiamond(450, true)
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