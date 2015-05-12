--[[--

“FightProp”的实体

]]

local FightProp  = class("FightProp", cc.mvc.ModelBase)

--events
FightProp.PROP_UPDATE_EVENT           = "PROP_UPDATE_EVENT"

function FightProp:ctor(properties)
    --instance
    FightProp.super.ctor(self, properties)
    self.propModel = md:getInstance("PropModel") 
    self.buyModel  = md:getInstance("BuyModel")
end

function FightProp:costRobot(callfuncSuccess)
	local num = self.propModel:getPropNum("jijia")
	if num >= 1 then 
		self.propModel:costProp("jijia",1) 
		callfuncSuccess()
	else
		--buy
		-- local function deneyBuyFunc()
			self.buyModel:showBuy("armedMecha", {isNotPopKefu = true}, "战斗界面_点击机甲")
		-- end 
		-- self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.refreshData),
		-- 				deneyBuyFunc = deneyBuyFunc, isNotPopup = true,isNotPopKefu = true}, "战斗界面_点击机甲")
				
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
		--todo 

	    --um
	    local fightFactory = md:getInstance("FightFactory")
   		local fight = fightFactory:getFight()
	    local levelInfo = fight:getLevelInfo()
	    assert(levelInfo, "levelInfo is nil")
	    local umData = {}
	    umData[levelInfo] = "手雷"
	    um:event("关卡道具使用", umData) 		
	else
		-- local function deneyBuyFunc()
			self.buyModel:showBuy("handGrenade", {isNotPopKefu = true}, "战斗界面_点击手雷")
		-- end 		
		-- self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.refreshData),
		-- 				deneyBuyFunc = deneyBuyFunc, isNotPopup = true,isNotPopKefu = true}
		-- 				, "战斗界面_点击手雷")
	end
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
		local inlayModel = md:getInstance("InlayModel")
		inlayModel:equipAllInlays()
		fightInlay:checkNativeGold()
	else
		-- local function deneyBuyFunc()
			self.buyModel:showBuy("goldWeapon", {payDoneFunc = handler(self, self.startGoldWeaponByPay),
						isNotPopKefu = true}, "战斗界面_点击黄武")
		-- end 		
		-- self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.startGoldWeaponByPay),
		-- 		deneyBuyFunc = deneyBuyFunc, isNotPopup = true,isNotPopKefu = true}, "战斗界面_点击黄武")	

	end
end

function FightProp:getGoldNum()
	local inlayModel = md:getInstance("InlayModel")
	return inlayModel:getGoldWeaponNum()
end

function FightProp:getHpBagNum()
	return self.propModel:getPropNum("hpBag")
end

function FightProp:addHpBag(num)
	self.propModel:addProp("hpBag", num)
end

function FightProp:costHpBag(num)
	self.propModel:costProp("hpBag", num)
	local hero = md:getInstance("Hero")
	hero:costHpBag()
end

function FightProp:startGoldWeaponByPay()
	self:costGoldWeapon()
end

function FightProp:sendAward(awardData)
	local awardType = awardData.awardType
	local value 	= awardData.awardValue
	if awardType == "goldWeapon" then 
		local fightInlay = md:getInstance("FightInlay")
		fightInlay:activeGold()		
	elseif awardType == "healthBag" then 
		self.propModel:addProp("hpBag", value)
	elseif awardType == "shouLei" then
		self.propModel:addProp("lei", value)
	elseif awardType == "coin" then	
		local hero = md:getInstance("Hero")
	    hero:dispatchEvent({name = hero.AWARD_GOLD_INCREASE_EVENT, 
                    value = value})
	end	
end

return FightProp