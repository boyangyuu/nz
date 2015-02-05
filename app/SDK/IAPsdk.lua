
local IAPsdk = class("IAPsdk", cc.mvc.ModelBase)

local className = "com/hgtt/ccn/IAPControl"
local sig = "(Ljava/lang/String;II)V"

function IAPsdk:ctor()
	self:initConfigs()
	self.buyModel = md:getInstance("BuyModel")
end

function IAPsdk:setTelecomOperator()
    local telecomOperator = nil
    if device.platform == 'android' then
        local result,telecomOperator = luaj.callStaticMethod("com/hgtt/ccn/IAPControl", "getOperatorName", {}, "()Ljava/lang/String;")
        return telecomOperator
    end
	print("telecomOperator:",telecomOperator)
    return telecomOperator
end

-- 电信运营商
local telecomOperator = IAPsdk:setTelecomOperator()

function IAPsdk:initConfigs()
	self.config = {}
	local config = self.config
	-- assert(telecomOperator, "telecomOperator:")
	if telecomOperator == "mobile" then
		--礼包
		config["novicesBag"]       = "30000883682301"		--新手礼包
		config["weaponGiftBag"]    = "30000883682302"		--武器到礼包
		config["goldGiftBag"]      = "30000883682303"		--土豪金礼包
		config["timeGiftBag"]      = "30000883682304"		--限时特价
		config["changshuang"]      = "30000883682305"		--畅爽礼包

		--单件
		config["goldWeapon"]       = "30000883682306"		--黄武
		config["handGrenade"]      = "30000883682307"		--手雷
		config["armedMecha"]       = "30000883682308"		--机甲
		config["onceFull"]         = "30000883682309"		--一键满级
		config["resurrection"]     = "30000883682310"	    --复活送黄武
		config["stone10"]           = "30000883682311"		--一小堆宝石
		config["stone45"]           = "30000883682312"		--一堆宝石
		config["stone120"]           = "30000883682313"		--一麻袋宝石
		config["stone260"]           = "30000883682314"		--一箱子宝石
		config["stone450"]           = "30000883682315"		--堆成山的宝石
		config["unlockWeapon"]   		   = "30000883682316"       --武器购买
	elseif telecomOperator == "unicom" then
		--礼包
		config["novicesBag"]       = "001"		--新手礼包
		config["weaponGiftBag"]    = "002"		--武器到礼包
		config["goldGiftBag"]      = "003"		--土豪金礼包
		config["timeGiftBag"]      = "004"		--限时特价
		config["changshuang"]      = "005"		--畅爽礼包

		--单件
		config["goldWeapon"]       = "006"		--黄武
		config["handGrenade"]      = "007"		--手雷
		config["armedMecha"]       = "008"		--机甲
		config["onceFull"]         = "009"		--一键满级
		config["resurrection"]     = "010"	    --复活送黄武
		config["stone10"]          = "011"		--一小堆宝石
		config["stone45"]          = "012"		--一堆宝石
		config["stone120"]         = "013"		--一麻袋宝石
		config["stone260"]         = "014"		--一箱子宝石
		config["stone450"]         = "015"		--堆成山的宝石
		config["unlockWeapon"]     = "016"       --武器购买

	elseif telecomOperator == "telecom" then

	end
end

--[[
	example:


]]

function IAPsdk:pay(name)
	-- print(name)
	local args = {self.config[name], handler(self, self.callbackSuccess), handler(self, self.callbackFaild)}
	-- dump(self.config,"self.config")
	-- dump(args,"args:")

	-- if isTest or isDebug or telecomOperator == nil then
	-- 	-- self:callbackSuccess()
	-- 	print("请在手机上支付 傻逼！")
	-- else
		if device.platform == 'android' then
			luaj.callStaticMethod(className, "pay", args, sig)
		end
	-- end
end

function IAPsdk:callbackSuccess( result )
	-- body
	self.buyModel:payDone(result)
end

function IAPsdk:callbackFaild(result)

	self.buyModel:deneyPay()

end
return IAPsdk

