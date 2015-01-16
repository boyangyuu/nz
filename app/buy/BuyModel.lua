
--[[
“购买”的实体

]]
local BuyConfigs = import(".buyConfigs")
local BuyModel = class("BuyModel", cc.mvc.ModelBase)

-- 定义事件


function BuyModel:ctor(properties)
    BuyModel.super.ctor(self, properties) 
	
	--instance
	-- self:buy("weaponGiftBag", {a=1})
end

--
function BuyModel:buy(configid, buydata)
	local config  = BuyConfigs.getConfig(configid)
	local isGift = true --todo

	local callFuncSuccess = function ()
		local funcStr = "buy_"..configid
		self[funcStr](self, buydata)
	end
	if isGift then
        ui:showPopup("GiftBagPopup",{popupName = configid,
            callBackSuccess = callFuncSuccess})
    else
    	--mm

    end
    --self.curId = configid
    --self.curBuydata =  buydata
end

function BuyModel:confirmBuy()
	
end

function BuyModel:buy_weaponGiftBag(buydata)
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
	
	--todo yby 满血
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
	--黄武*1
	InlayModel:buyGoldsInlay(4)
    InlayModel:refreshInfo("speed")
	--机甲*1
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	--金币*188888
	UserModel:buyDiamond(260)
	UserModel:addMoney(188888)
	StoreModel:setGoldWeaponNum()


end

return BuyModel