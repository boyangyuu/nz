
local IAPsdk = class("IAPsdk", cc.mvc.ModelBase)
local BuyConfigs = import("..buy.BuyConfigs")
local className = "com/hgtt/com/IAPControl"

local sig = "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V"

function IAPsdk:ctor()
	local JavaUtils = require("app.includes.JavaUtils")
	self.iapName = JavaUtils.getIapName()
	self.buyModel = md:getInstance("BuyModel")
end

function IAPsdk:getPayConfig(iapName)
	print("function IAPsdk:getPayConfig(iapName):",iapName)
	local config = {}
	-- assert(iapName, "iapName:")
	if iapName == "mm" then --mm
		--礼包
		config["novicesBag"]       = "30000899255201"		--新手礼包
		config["weaponGiftBag"]    = "30000899255207"		--武器礼包
		config["goldGiftBag"]      = "30000899255208"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "30000899255202"		--黄武
		config["handGrenade"]      = "30000899255203"		--手雷
		config["armedMecha"]       = "30000899255209"		--机甲
		config["onceFull"]         = "30000899255210"		--一键满级
		config["stone120"]         = "30000899255204"		--一麻袋宝石
		config["stone260"]         = "30000899255205"		--一箱子宝石
		config["stone450"]         = "30000899255206"		--堆成山的宝石
	
	elseif iapName == 'jd' then --基地
		config["yijiaoBag"]        = "014"		--1角礼包
		config["novicesBag"]       = "001"		--新手礼包
		config["weaponGiftBag"]    = "007"		--武器到礼包
		config["goldGiftBag"]      = "008"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "002"		--黄武
		config["handGrenade"]      = "003"		--手雷
		config["armedMecha"]       = "009"		--机甲1
		config["onceFull"]         = "010"		--一键满级1
		config["stone120"]         = "004"		--一麻袋宝石
		config["stone260"]         = "005"		--一箱子宝石
		config["stone450"]         = "006"		--堆成山的宝石

	elseif iapName == "lt" then --联通
		--礼包
		config["novicesBag"]       = "001"		--新手礼包1
		config["weaponGiftBag"]    = "018"		--武器到礼包1
		config["goldGiftBag"]      = "019"		--土豪金礼包1

		--单件
		config["goldWeapon"]       = "006"		--黄武
		config["handGrenade"]      = "007"		--手雷
		config["armedMecha"]       = "020"		--机甲1
		config["onceFull"]         = "021"		--一键满级1
		config["stone120"]         = "013"		--一麻袋宝石
		config["stone260"]         = "014"		--一箱子宝石
		config["stone450"]         = "015"		--堆成山的宝石

	elseif iapName == "dx" then -- 电信
		--礼包
		--游游共赢的
		config["novicesBag"]       = "5156701"		--新手礼包
		config["weaponGiftBag"]    = "5156712"		--武器到礼包
		config["goldGiftBag_dx"]   = "5156713"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "5128230"		--黄武
		config["handGrenade"]      = "5128231"		--手雷
		config["armedMecha"]       = "5156714"		--机甲
		config["onceFull"]         = "5156715"		--一键满级
		config["stone120"]         = "5128237"		--一麻袋宝石
		config["stone260"]         = "5128238"		--一箱子宝石
		config["stone450"]         = "5128239"		--堆成山的宝石

	elseif iapName == "al" then -- alibaba
		--礼包
		config["stone600"]         = "60"		--60 yuan
		config["stone900"]         = "90"		--90
		config["stone1200"]        = "120"		--120		
	end
	dump(config, "iapName:"..iapName)
	assert(config, "config is nil: iapName:" .. iapName)
	return config
end

function IAPsdk:isPayValid()
	if self.iapName == "noSim" and payType == "duanxin" then
		self:callbackFaild()
		ui:showPopup("commonPopup",
			 {type = "style2", content = "请在插有SIM卡的手机上支付！", delay = 1},
			 {opacity = 0})
		return false
	elseif self.iapName == 'invalid' and payType == "duanxin" then
		self:callbackFaild()
		ui:showPopup("commonPopup",
			 {type = "style2", content = "请在插有移动卡的手机上支付！", delay = 1},
			 {opacity = 0})	
		 return	false
	end
	return true
end

function IAPsdk:getPaycode(configId, payType)
	local iapName = nil
	if payType == "duanxin" then 
		iapName = self.iapName
	else
		iapName = payType
	end
	local config = self:getPayConfig(iapName)
	dump(config, "config")
	assert(config, "config is nil payType" .. payType)
	assert(config[configId], "config[configId] is nil")
	return config[configId]
end

function IAPsdk:pay(configId, payType)
	print("configId", configId)
	print("payType", payType)	
	print("self.iapName", self.iapName)
	if __isFree then 	self:callbackSuccess() return end
	if not self:isPayValid() then return end

	
	local paycode = self:getPaycode(configId, payType)
	local buyName = BuyConfigs.getConfig(configId)["name"]
	local args = {
		paycode, 
		buyName, 
		payType,
		handler(self, self.callbackSuccess), 
		handler(self, self.callbackFaild)}
	if device.platform ~= 'android' then
		ui:showPopup("commonPopup",
			 {type = "style2", content = "请在插有SIM卡的手机上支付！", delay = 1},
			 {opacity = 0})		
		display.resume()
	else
		luaj.callStaticMethod(className, "pay", args, sig)
	end
end

function IAPsdk:callbackSuccess( result )
	-- body
	self.buyModel:payDone(result)
end

function IAPsdk:callbackFaild(result)
	self.buyModel:deneyPay()
end



return IAPsdk

