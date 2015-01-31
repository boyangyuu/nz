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

function FightProp:refreshData()
	print("function FightProp:refreshData()")
	self:dispatchEvent({name = self.PROP_UPDATE_EVENT})
end

function FightProp:costRobot(callfuncSuccess)
	local num = self.propModel:getPropNum("jijia")
	if num >= 1 then 
		self.propModel:costProp("jijia",1) 
		callfuncSuccess()
	else
		--buy
		local function deneyBuyFunc()
			self.buyModel:buy("armedMecha", {payDoneFunc = handler(self, self.refreshData)})
		end 
		self.buyModel:buy("goldGiftBag", {payDoneFunc = handler(self, self.refreshData),
						deneyBuyFunc = deneyBuyFunc})
	end
	self:refreshData()
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
		local function deneyBuyFunc()
			self.buyModel:buy("handGrenade", {payDoneFunc = handler(self, self.refreshData)})
		end 		
		self.buyModel:buy("goldGiftBag", {payDoneFunc = handler(self, self.refreshData),
						deneyBuyFunc = deneyBuyFunc})
	end
	self:refreshData()
end

function FightProp:getLeiNum()
	local num = self.propModel:getPropNum("lei")
	return num
end

function FightProp:costGoldWeapon()
	local fightInlay = md:getInstance("FightInlay")
	local isNativeGold = fightInlay:getIsNativeGold()
	if isNativeGold then return end

	local num = self:getGoldNum()
	if num >= 1 then 
		-- self.goldNum = self.goldNum - 1		
		local inlayModel = md:getInstance("InlayModel")
		inlayModel:equipAllInlays()
		fightInlay:checkNativeGold()
	else
		local function deneyBuyFunc()
			self.buyModel:buy("goldWeapon", {payDoneFunc = handler(self, self.startGoldWeapon)})
		end 		
		self.buyModel:buy("goldGiftBag", {payDoneFunc = handler(self, self.startGoldWeapon),
						deneyBuyFunc = deneyBuyFunc})	
	end

	self:refreshData()
end

function FightProp:getGoldNum()
	local inlayModel = md:getInstance("InlayModel")
	return inlayModel:getGoldWeaponNum()
end

function FightProp:startGoldWeapon()
	local inlay = md:getInstance("FightInlay")
	inlay:activeGoldForever()
	self:refreshData()
end

function FightProp:costReliveBag()
	
end


return FightProp