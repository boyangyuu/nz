
--[[
“购买”的实体

]]
local BuyConfigs = import(".BuyConfigs")
local BuyModel = class("BuyModel", cc.mvc.ModelBase)

-- 定义事件


function BuyModel:ctor(properties)
    BuyModel.super.ctor(self, properties) 
	
	--instance
	-- self:buy("weaponGiftBag", {a=1})
end

--
function BuyModel:clearData()
    self.curId = nil
    self.curBuydata =  nil
end

function BuyModel:buy(configid, buydata)
	self:clearData()
    self.curId = configid
    self.curBuydata =  buydata
	local config  = BuyConfigs.getConfig(configid)
	local isGift = config.isGift --todo

	if isGift then
        ui:showPopup("GiftBagPopup",{popupName = configid})
    else
    	--mm
    	iap:pay(configName)
    end
end

function BuyModel:payDone(result)
	print("function BuyModel:payDone():"..self.curId)
	local funcStr = "buy_"..self.curId
	self[funcStr](self, self.curBuydata)
	local payDoneFunc = self.curBuydata.payDoneFunc
	if payDoneFunc then payDoneFunc() end

end

function BuyModel:deneyPay()
	print("function BuyModel:deneyBuy()"..self.curId)
	local deneyBuyFunc = self.curBuydata.deneyBuyFunc
	if deneyBuyFunc then  deneyBuyFunc() end
end

function BuyModel:buy_weaponGiftBag(buydata)
	print("BuyModel:buy_weaponGiftBag(buydata)")
	local weaponList = md:getInstance("WeaponListModel")
	local weaponId = buydata.weaponId
	dump(buydata, "buydata")
	for i = 3, 8 do
		if i ~= 6 then 
			weaponList:setWeapon(i)
			weaponList:onceFull(i)
		end
	end
	local data = getUserData()
	data.giftBag.weaponGiftBag.isBuyed = true
    setUserData(data)	
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
	StoreModel:setGoldWeaponNum()
end

function BuyModel:buy_goldGiftBag( buydata )
	print("BuyModel:buy_goldGiftBag(buydata)")
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*1
	InlayModel:buyGoldsInlay(15)
    InlayModel:refreshInfo("speed")

	--机甲*1
	propModel:buyProp("jijia",15)
	--手雷*10
	propModel:buyProp("lei",30)
	StoreModel:setGoldWeaponNum()
	
end

function BuyModel:buy_changshuang( buydata )
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*1
	InlayModel:buyGoldsInlay(4)
    InlayModel:refreshInfo("speed")
	--机甲*1
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	StoreModel:setGoldWeaponNum()

	--todo yby 满血
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
	StoreModel:setGoldWeaponNum()
end

function BuyModel:buy_handGrenade( buydata )
	local propModel = md:getInstance("propModel")
	local StoreModel = md:getInstance("StoreModel")
	--手雷*10
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
	StoreModel:setGoldWeaponNum()
	StoreModel:refreshInfo("prop")
end

function BuyModel:buy_onceFull( buydata )
	print("BuyModel:buy_handGrenade( buydata )")
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:onceFull(buydata.weaponid)
end

function BuyModel:buy_resurrection( buydata )
	print("BuyModel:buy_resurrection( buydata )")

	--yby todo
end

function BuyModel:buy_stone( buydata )
	print("BuyModel:buy_stone1( buydata )")
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(buydata.buynum)
end

return BuyModel