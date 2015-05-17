
local IAPsdk = class("IAPsdk", cc.mvc.ModelBase)

local className = "com/hgtt/com/IAPControl"

local sig = "(Ljava/lang/String;Ljava/lang/String;II)V"

function IAPsdk:ctor()
	self.iapName = getIapName()
	self:initConfigs()
	self.buyModel = md:getInstance("BuyModel")
end

function IAPsdk:initConfigs()
	self.config = {}
	local config = self.config
	-- assert(iapName, "iapName:")
	if self.iapName == "mm" then --mm
		--礼包
		config["novicesBag"]       = "30000883682301"		--新手礼包
		config["weaponGiftBag"]    = "30000883682317"		--武器礼包
		config["goldGiftBag"]      = "30000883682318"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "30000883682306"		--黄武
		config["handGrenade"]      = "30000883682307"		--手雷
		config["armedMecha"]       = "30000883682319"		--机甲
		config["onceFull"]         = "30000883682320"		--一键满级
		config["stone45"]          = "30000883682312"		--一堆宝石
		config["stone120"]         = "30000883682313"		--一麻袋宝石
		config["stone260"]         = "30000883682314"		--一箱子宝石
		config["stone450"]         = "30000883682315"		--堆成山的宝石
	
	elseif self.iapName == 'jd' then --基地
		config["novicesBag"]       = "001"		--新手礼包1
		config["weaponGiftBag"]    = "002"		--武器到礼包1
		config["goldGiftBag"]      = "003"		--土豪金礼包1

		--单件
		config["goldWeapon"]       = "004"		--黄武
		config["handGrenade"]      = "005"		--手雷
		config["armedMecha"]       = "006"		--机甲1
		config["onceFull"]         = "007"		--一键满级1
		config["stone120"]         = "009"		--一麻袋宝石
		config["stone260"]         = "010"		--一箱子宝石
		config["stone450"]         = "011"		--堆成山的宝石

	elseif self.iapName == "unicom" then --联通
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

	elseif self.iapName == "telecom" then -- 电信
		--礼包
		config["novicesBag"]       = "5156701"		--新手礼包
		config["weaponGiftBag"]    = "5156712"		--武器到礼包
		config["goldGiftBag"]      = "5156713"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "5128230"		--黄武
		config["handGrenade"]      = "5128231"		--手雷
		config["armedMecha"]       = "5156714"		--机甲
		config["onceFull"]         = "5156715"		--一键满级
		config["stone120"]         = "5128237"		--一麻袋宝石
		config["stone260"]         = "5128238"		--一箱子宝石
		config["stone450"]         = "5128239"		--堆成山的宝石
	end
end

--[[
	example:


]]

function IAPsdk:pay(name)
	-- print(name)
	local args = {self.config[name],name, handler(self, self.callbackSuccess), handler(self, self.callbackFaild)}
	if isFree or self.iapName == nil then
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

-- function IAPsdk:isMobileSimCard()
--     if self.iapName ~= 'unicom' and self.iapName ~= 'telecom' and self.iapName ~= 'unknown' then
--         return false, 6
--     else
--         return true, 1
--     end
-- end

return IAPsdk

