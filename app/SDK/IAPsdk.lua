
local IAPsdk = class("IAPsdk", cc.mvc.ModelBase)

local className = ""
local sig = "(Ljava/lang/String;I)V"

function IAPsdk:ctor()
	self:initConfigs()
end

function IAPsdk:initConfigs()
	self.config = {}
	local config = self.config
	if telecomOperator == "mobile" then
		--礼包
		config["novicesBag"]       = "30000883682301"
		config["weaponGiftBag"]    = "30000883682302"
		config["goldGiftBag"]      = "30000883682303"
		config["xianshitejia"]     = "30000883682304"
		config["changshuang"]      = "30000883682305"
		config["goldWeapon"]       = "30000883682306"
		config["handGrenade"]      = "30000883682307"
		config["armedMecha"]       = "30000883682308"

		--单件
		config["onceFull"]         = "30000883682309"
		config["resurrection"]     = "30000883682310"
		config["stone1"]           = "30000883682311"
		config["stone2"]           = "30000883682312"
		config["stone3"]           = "30000883682313"
		config["stone4"]           = "30000883682314"
		config["stone5"]           = "30000883682315"
	elseif telecomOperator == "unicom" then

	elseif telecomOperator == "telecom" then

	end
end

--[[
	example:


]]

function IAPsdk:pay(name, callbackFunc)
	local args = {self.config[name], callbackFunc}
	if device.platform == 'android' then
		luaj.callStaticMethod(className, "pay", args, sig)
	end
end

return IAPsdk

