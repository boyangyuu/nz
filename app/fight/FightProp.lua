--[[--

“FightProp”的实体

]]

local FightProp  = class("FightProp", cc.mvc.ModelBase)
local StoreLayer   = import("..store.StoreLayer")


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
	    --buy
	    ui:showPopup("StoneBuyPopup",
	         {name = "无敌机甲x2",
	         price = 40,
	         onClickConfirm = handler(self, self.buyRobotByStone)},
	         {animName = "moveDown", opacity = 150})
	end
end

function FightProp:buyRobotByStone()
	print("function FightProp:buyRobotByStone()")
	local kValue = 40
	local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(kValue, true, "战斗界面_无敌机甲x2")
    if isAfforded then
    	self.propModel:addProp("jijia", 2)
        ui:closePopup("StoneBuyPopup")
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
		-- self.buyModel:showBuy("handGrenade", {
		-- 	isNotPopKefu = true}, "战斗界面_点击手雷")
	    --buy
	    ui:showPopup("StoneBuyPopup",
	         {name = "手雷x20",
	         price = 40,
	         onClickConfirm = handler(self, self.buyLeiByStone)},
	         {animName = "moveDown", opacity = 150})
	end
end

function FightProp:buyLeiByStone()
	print("function FightProp:buyLeiByStone()")
	local kValue = 40
	local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(kValue, true, "战斗界面_手雷x20")
    if isAfforded then
    	self.propModel:addProp("lei", 20)
        ui:closePopup("StoneBuyPopup")
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
	local isfree = self:isFreeCost()
	if isfree then
		fightInlay:checkNativeGold()
	elseif num >= 1 then
		local inlayModel = md:getInstance("InlayModel")
		inlayModel:equipAllInlays()
		fightInlay:checkNativeGold()
	else
	    --buy
	    ui:showPopup("StoneBuyPopup",
	         {name = "黄金武器x2",
	         price = 40,
	         onClickConfirm = handler(self, self.buyGoldsInlayByStone)},
	         {animName = "moveDown", opacity = 150})
	end
end

function FightProp:buyGoldsInlayByStone()
	print("function FightProp:buyGoldsInlayByStone()")
	local kValue = 40
	local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(kValue, true, "战斗界面_黄金武器x2")
    if isAfforded then
		local inlayModel = md:getInstance("InlayModel")
		inlayModel:buyGoldsInlay(2)
        ui:closePopup("StoneBuyPopup")
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
        self:buyHpBagByStone()
    end

    ui:showPopup("StoneBuyPopup",
         {name = "医疗包x6",
         price = kValue,
         onClickConfirm = onClickConfirm},
         {animName = "moveDown", opacity = 150})

end

function FightProp:buyHpBagByStone()
	print("function FightProp:buyHpBagByStone()")
	local kValue = 40
	local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(kValue, true, "战斗界面_点击医疗包")
    if isAfforded then
		local hero = md:getInstance("Hero")
		hero:costHpBag()
       	self.propModel:addProp("hpBag", 6)
        ui:closePopup("StoneBuyPopup")
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