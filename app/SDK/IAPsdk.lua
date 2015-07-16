
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
		config["weaponGiftBag"]    = "007"		--武器到礼包1
		config["goldGiftBag"]      = "008"		--土豪金礼包1

		--单件
		config["goldWeapon"]       = "002"		--黄武
		config["handGrenade"]      = "003"		--手雷
		config["armedMecha"]       = "009"		--机甲1
		config["onceFull"]         = "010"		--一键满级1
		config["stone120"]         = "004"		--一麻袋宝石
		config["stone260"]         = "005"		--一箱子宝石
		config["stone450"]         = "006"		--堆成山的宝石

	elseif iapName == "dx" then -- 电信
		--礼包
		--游游共赢的
		config["novicesBag"]       = "TOOL5"		--新手礼包
		config["weaponGiftBag"]    = "TOOL6"		--武器到礼包
		config["goldGiftBag_dx"]   = "TOOL7"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "TOOL1"		--黄武
		config["handGrenade"]      = "TOOL2"		--手雷
		config["armedMecha"]       = "TOOL8"		--机甲
		config["onceFull"]         = "TOOL9"		--一键满级
		config["stone120"]         = "TOOL3"		--一麻袋宝石
		config["stone260"]         = "TOOL4"		--一箱子宝石

	elseif iapName == "al" then -- alibaba
		--礼包
		config["stone600"]         = "60"		--60 yuan
		config["stone900"]         = "90"		--90
		config["stone1200"]        = "120"		--120
	elseif iapName == "ios" then -- ios 
		--礼包
		config["stone120"]         = "60"		--600钻石
		config["stone260"]         = "180"		--一箱子宝石
		config["stone450"]         = "300"		--堆成山的宝石
		config["stone600"]         = "600"		--60 yuan
		config["stone900"]         = "880"		--90
		config["stone1200"]        = "1280"		--120	
	end
	dump(config, "iapName:"..iapName)
	assert(config, "config is nil: iapName:" .. iapName)
	return config
end

function IAPsdk:isPayValid()
	if device.platform == "ios" then
		return true
	end

	local payType =  self.buyModel:getPayType()
	if self.iapName == "noSim" and payType == "duanxin" then
		self:callbackFaild()
		ui:showPopup("commonPopup",
			 {type = "style2", content = "请在插有SIM卡的手机上支付", delay = 1},
			 {opacity = 0})
		return false
	elseif self.iapName == 'invalid' and payType == "duanxin" then
		self:callbackFaild()
		-- ui:showPopup("commonPopup",
		-- 	 {type = "style2", content = "请在插有移动卡的手机上支付！", delay = 1},
		-- 	 {opacity = 0})	
		 return	false
	end
	return true
end

function IAPsdk:getPaycode(configId)
	local iapName = nil
	local payType = self.buyModel:getPayType()
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

function IAPsdk:pay(configId)
	if __isFree then 	self:callbackSuccess() return end
	if not self:isPayValid() then return end
	
	if device.platform == 'ios' then
		self:pay_ios(configId)
	elseif device.platform == 'windows' or 'mac' then
		self:pay_win()
	elseif device.platform == 'android' then
		self:pay_android(configId)
	end
end

function IAPsdk:pay_ios(configId)
	dump(configId)
	if configId == "weaponGiftBag" or configId == "goldGiftBag" then
		self:callbackSuccess()
		return
	end
	print("aaaaaios")
	payType = self.buyModel:getPayType()
	local paycode = self:getPaycode(configId, payType)
	dump(paycode)
	local args = {
		buyType = paycode,
		success = handler(self, self.callbackSuccess),
		fail = handler(self, self.callbackFaild)
	}
	luaoc.callStaticMethod("IAPControl", "buy", args)
end

function IAPsdk:pay_android(configId)
	payType = self.buyModel:getPayType()
	local paycode = self:getPaycode(configId, payType)
	local buyName = BuyConfigs.getConfig(configId)["name"]
	local args = {
		paycode, 
		buyName, 
		payType,
		handler(self, self.callbackSuccess), 
		handler(self, self.callbackFaild)}
	luaj.callStaticMethod(className, "pay", args, sig)
end

function IAPsdk:pay_win()
	ui:showPopup("commonPopup",
		 {type = "style2", content = "请在插有SIM卡的手机上支付！", delay = 1},
		 {opacity = 0})		
	display.resume()
end

function IAPsdk:callbackSuccess(result)
	-- body
	self.buyModel:payDone(result)
end

function IAPsdk:callbackFaild(result)
	self.buyModel:deneyPay()
end



return IAPsdk

