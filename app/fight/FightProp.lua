--[[--

“FightProp”的实体

]]

--import
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local FightProp  = class("FightProp", cc.mvc.ModelBase)

--events
-- FightProp.INLAY_UPDATE_EVENT           = "INLAY_UPDATE_EVENT"


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
		local buyData = {payDoneFunc = callfuncSuccess}
		self.buyModel:buy("goldGiftBag", buyData)
	end
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
		--buy
		local buyData = {payDoneFunc = callfuncSuccess}
		self.buyModel:buy("goldGiftBag", buyData)
	end
end

function FightProp:getLeiNum()
	local num = self.propModel:getPropNum("lei")
	return num
end
return FightProp