--[[--

“FightProp”的实体

]]

--import
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local FightProp  = class("FightProp", cc.mvc.ModelBase)

--events
FightProp.PROP_UPDATE_EVENT           = "PROP_UPDATE_EVENT"

function FightProp:ctor(properties)
    --instance
    FightProp.super.ctor(self, properties)
    self.propModel = md:getInstance("propModel") 
    self.buyModel  = md:getInstance("BuyModel")
end

function FightProp:costRobot(callfuncSuccess)
	local num = self.propModel:getPropNum("jijia")
	if num >= 1 then 
		self.propModel:costProp("jijia",1) 
		callfuncSuccess()
	else
		--buy
		self.buyModel:buy("goldGiftBag", buyData)
	end
	self:dispatchEvent({name = self.PROP_UPDATE_EVENT})
end

function FightProp:getRobotNum()
	local num = self.propModel:getPropNum("jijia")
	return num
end

function FightProp:costLei(callfuncSuccess)
	local num = self.propModel:getPropNum("lei")
	if num >= 1 then 
		self.propModel:costProp("lei",1) 
		callfuncSuccess()
	else
		self.buyModel:buy("goldGiftBag", buyData)
	end
	self:dispatchEvent({name = self.PROP_UPDATE_EVENT})
end

function FightProp:getLeiNum()
	local num = self.propModel:getPropNum("lei")
	return num
end
return FightProp