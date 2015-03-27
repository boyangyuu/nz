
local IAPsdk = class("IAPsdk", cc.mvc.ModelBase)

local className = "com/hgtt/com/IAPControl"

local sig = "(Ljava/lang/String;II)V"

function IAPsdk:ctor()
	self.telecomOperator = IAPsdk:setTelecomOperator()
	self:initConfigs()
	self.buyModel = md:getInstance("BuyModel")
end

function IAPsdk:setTelecomOperator()
    local telecomOperator = nil
    if device.platform == 'android' then
        local result,telecomOperator = luaj.callStaticMethod("com/hgtt/com/IAPControl", "getOperatorName", {}, "()Ljava/lang/String;")
        return telecomOperator
    end
	print("telecomOperator:",telecomOperator)
    return telecomOperator
end

-- 电信运营商


function IAPsdk:initConfigs()
	self.config = {}
	local config = self.config
	-- assert(telecomOperator, "telecomOperator:")
	if self.telecomOperator == "mobile" then
		--移动商用计费代码
		--礼包
		config["novicesBag"]       = "30000883682311"		--新手礼包
		config["weaponGiftBag"]    = "30000883682317"		--武器到礼包
		config["goldGiftBag"]      = "30000883682318"		--土豪金礼包
		config["timeGiftBag"]      = "30000883682304"		--限时特价
		config["changshuang"]      = "30000883682305"		--畅爽礼包

		--单件
		config["goldWeapon"]       = "30000883682306"		--黄武
		config["handGrenade"]      = "30000883682307"		--手雷
		config["armedMecha"]       = "30000883682319"		--机甲
		config["onceFull"]         = "30000883682320"		--一键满级
		config["resurrection"]     = "30000883682321"	    --复活送黄武
		config["highgradeWeapon"]  = "30000883682322"		--高级武器一把
		config["stone45"]          = "30000883682312"		--一堆宝石
		config["stone120"]         = "30000883682313"		--一麻袋宝石
		config["stone260"]         = "30000883682314"		--一箱子宝石
		config["stone450"]         = "30000883682315"		--堆成山的宝石
		config["unlockWeapon"] 	   = "30000883682323"       --武器购买

	elseif self.telecomOperator == "unicom" then
		--联通商用计费代码
		--礼包
		config["novicesBag"]       = "017"		--新手礼包
		config["weaponGiftBag"]    = "018"		--武器到礼包
		config["goldGiftBag"]      = "019"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "006"		--黄武
		config["handGrenade"]      = "007"		--手雷
		config["armedMecha"]       = "020"		--机甲
		config["onceFull"]         = "021"		--一键满级
		config["resurrection"]     = "022"	    --复活送黄武
		config["stone120"]         = "013"		--一麻袋宝石
		config["stone260"]         = "014"		--一箱子宝石
		config["stone450"]         = "015"		--堆成山的宝石
		config["unlockWeapon"]     = "024"       --武器购买
		config["highgradeWeapon"]  = "023"		--高级武器一把

	elseif self.telecomOperator == "telecom" then
		-- 电信外放计费代码
		--礼包
		config["novicesBag"]       = "5156711"		--新手礼包
		config["weaponGiftBag"]    = "5156712"		--武器到礼包
		config["goldGiftBag"]      = "5156713"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "5128230"		--黄武
		config["handGrenade"]      = "5128231"		--手雷
		config["armedMecha"]       = "5156714"		--机甲
		config["onceFull"]         = "5156715"		--一键满级
		config["resurrection"]     = "5156716"	    --复活送黄武
		config["stone120"]         = "5128237"		--一麻袋宝石
		config["stone260"]         = "5128238"		--一箱子宝石
		config["stone450"]         = "5128239"		--堆成山的宝石
		config["highgradeWeapon"]  = "5156717"		--高级武器一把
		config["unlockWeapon"] 	   = "5156718"       --武器购买1
	end
end

--[[
	example:


]]

function IAPsdk:pay(name)
	-- print(name)
	local args = {self.config[name], handler(self, self.callbackSuccess), handler(self, self.callbackFaild)}
	if isFree or telecomOperator == nil then
		self:callbackSuccess()
		print("请在手机上支付 傻逼！")
	else
		if device.platform == 'android' then
			luaj.callStaticMethod(className, "pay", args, sig)
		end
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

