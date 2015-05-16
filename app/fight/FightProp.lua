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

function FightProp:isFreeCost()
    local fightFactory = md:getInstance("FightFactory")
	local fight = fightFactory:getFight()
    if fight:getLevelId() == 0 and fight:getGroupId() == 0 then 
        return true
    else
        return false
    end
end

function FightProp:costRobot(callfuncSuccess)
	local num = self.propModel:getPropNum("jijia")
	local isfree = self:isFreeCost() 	
	if num >= 1 or isfree then 
        local robot = md:getInstance("Robot")
        robot:startRobot()
        if callfuncSuccess then callfuncSuccess() end
        if not isfree then 
        	self.propModel:costProp("jijia",1)  
        end
	else
		self.buyModel:showBuy("armedMecha", {
			isNotPopKefu = true}, "战斗界面_点击机甲")
	end
end

function FightProp:getRobotNum()
	local num = self.propModel:getPropNum("jijia")
	return num
end

function FightProp:costLei(callfuncSuccess)
	local num = self.propModel:getPropNum("lei")
	local  isfree = self:isFreeCost() 
	if num >= 1 then  
		callfuncSuccess()
	    --um
	    local fightFactory = md:getInstance("FightFactory")
   		local fight = fightFactory:getFight()
	    local levelInfo = fight:getLevelInfo()
	    assert(levelInfo, "levelInfo is nil")
	    local umData = {}
	    umData[levelInfo] = "手雷"
	    um:event("关卡道具使用", umData)
	    if not isfree then 
	    	self.propModel:costProp("lei",1) 
	    end
	else
		self.buyModel:showBuy("handGrenade", {
			isNotPopKefu = true}, "战斗界面_点击手雷")
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
		self.buyModel:showBuy("goldWeapon", {payDoneFunc = handler(self, self.startGoldWeaponByPay),
			isNotPopKefu = true}, "战斗界面_点击黄武")
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

function FightProp:costHpBag()
	local num = self.propModel:getPropNum("hpBag")
	local isfree = self:isFreeCost()  
	if num >= 1 or isfree then 
		local hero = md:getInstance("Hero")
		hero:costHpBag()
        if not isfree then 
	       	self.propModel:costProp("hpBag",1)  
        end
        return 
    end

    --buy
	local kValue = 40
    local function onClickConfirm()
        if self:buyHpBagByStone() then 
            ui:closePopup("StoneBuyPopup")
        else 
            local strPos  =  "战斗界面_点击血包"
            self.buyModel:showBuy("stone450", 
        	{showType = "iap",
        	payDoneFunc = handler(self, self.buyHpBagByStone)}, 
        	strPos)
        end
    end

    local tips = "是否花费"..kValue.."宝石购买医疗包x6？"
    ui:showPopup("StoneBuyPopup",
         {tips = tips, 
         onClickConfirm = onClickConfirm},
         {opacity = 0})	

end

function FightProp:buyHpBagByStone()
	print("function FightProp:buyHpBagByStone()")	
	local kValue = 40
	local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(kValue) 
    if isAfforded then
		local hero = md:getInstance("Hero")
		hero:costHpBag()
       	self.propModel:addProp("hpBag",6)  
       	print("addProp")
        ui:closePopup("StoneBuyPopup")
        return true
    else
        return false
    end	
end

function FightProp:onBuyHpSucc()
	local user = md:getInstance("UserModel")
	local isAfforded = user:costDiamond(20) 
	if isAfforded then 
		self.propModel:costProp("hpBag",1) 
	end
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