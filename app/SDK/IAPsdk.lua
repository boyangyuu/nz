
local IAPsdk = class("IAPsdk", cc.mvc.ModelBase)

local className = "org/cocos2dx/lua/IAPControl"
local sig = "(Ljava/lang/String;II)V"

function IAPsdk:ctor()
	self:initConfigs()
	self.buyModel = md:getInstance("BuyModel")
end

function IAPsdk:setTelecomOperator()
    local telecomOperator = nil
    if device.platform == 'android' then
        local result,telecomOperator = luaj.callStaticMethod("org/cocos2dx/lua/IAPControl", "getOperatorName", {}, "()Ljava/lang/String;")
        print("运营商名:",telecomOperator)
        return telecomOperator
    end
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
		config["stone1"]           = "30000883682311"		--一小堆宝石
		config["stone2"]           = "30000883682312"		--一堆宝石
		config["stone3"]           = "30000883682313"		--一麻袋宝石
		config["stone4"]           = "30000883682314"		--一箱子宝石
		config["stone5"]           = "30000883682315"		--堆成山的宝石
		config["weapon"]   		   = "30000883682316"       --武器购买
	elseif telecomOperator == "unicom" then

	elseif telecomOperator == "telecom" then

	end
end

--[[
	example:


]]

function IAPsdk:pay(name)
	local args = {self.config[name], handler(self, self.callbackSuccess), handler(self, self.callbackFaild)}
	dump(self.config,"self.config")
	dump(args,"args:")
	if device.platform == 'android' then
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

