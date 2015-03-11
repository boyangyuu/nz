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
			self.buyModel:showBuy("armedMecha", {payDoneFunc = handler(self, self.refreshData)}, "战斗界面_点击机甲")
		end 
		self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.refreshData),
						deneyBuyFunc = deneyBuyFunc}, "战斗界面_点击机甲")
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
		--todo 

	    --um
	    local fight = md:getInstance("Fight")
	    local levelInfo = fight:getLevelInfo()
	    assert(levelInfo, "levelInfo is nil")
	    local umData = {}
	    umData[levelInfo] = "手雷"
	    um:event("关卡道具使用", umData) 		
	else
		local function deneyBuyFunc()
			self.buyModel:showBuy("handGrenade", {payDoneFunc = handler(self, self.refreshData)}
						, "战斗界面_点击手雷")
		end 		
		self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.refreshData),
						deneyBuyFunc = deneyBuyFunc}
						, "战斗界面_点击手雷")
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
			self.buyModel:showBuy("goldWeapon", {payDoneFunc = handler(self, self.startGoldWeapon)}
				, "战斗界面_点击黄武")
		end 		
		self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.startGoldWeapon),
						deneyBuyFunc = deneyBuyFunc}
						, "战斗界面_点击黄武")	
	end
	self:refreshData()
end

function FightProp:getGoldNum()
	local inlayModel = md:getInstance("InlayModel")
	return inlayModel:getGoldWeaponNum()
end

function FightProp:startGoldWeapon()
	local inlay = md:getInstance("FightInlay")
	inlay:activeGoldOnCost()
	self:refreshData()
end

function FightProp:costReliveBag()
	
end


return FightProp