local DailyLoginConfig = import(".DailyLoginConfig")
local DailyLoginModel = class("DailyLoginModel", cc.mvc.ModelBase)

function DailyLoginModel:ctor(properties)
	DailyLoginModel.super.ctor(self,properties)
end

local popup = false
function DailyLoginModel:setPopup()
	popup = true
end
function DailyLoginModel:donotPop()
	popup = false
end
function DailyLoginModel:checkPop()
	return popup
end

function DailyLoginModel:setTime()
	local data = getUserData()
	-- dump(os.date("%x"))
	data.dailylogin.logintime = os.date("%x")
	setUserData(data)
end

function DailyLoginModel:setGet(isget)
	local data = getUserData()
	data.dailylogin.isGet = isget
	setUserData(data)
end

function DailyLoginModel:getDailyInfo()
	local data = getUserData()
	local dailyInfo = data.dailylogin
	return dailyInfo
end

function DailyLoginModel:getDailyID()
	local data = getUserData()
	local dailyID = data.dailylogin.dailyid
	return dailyID
end

function DailyLoginModel:getNextDailyID()
	local dailyid = self:getDailyID()
	if dailyid < 7 then
		dailyid = dailyid + 1
	else
		dailyid = 0
	end
	return dailyid
end

function DailyLoginModel:setNextDailyID()
	local data = getUserData()
	local dailyID = data.dailylogin.dailyid
	if dailyID < 6 then
		data.dailylogin.dailyid = data.dailylogin.dailyid + 1
	else
		data.dailylogin.dailyid = 0
	end
end

function  DailyLoginModel:setGift(dailyID)
	local giftInfo = DailyLoginConfig.getConfig(dailyID)
	local UserModel = md:getInstance("UserModel")
	local propModel = md:getInstance("propModel")
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	if giftInfo["type"] == "gold" then
		UserModel:addMoney(giftInfo["number"])
	    um:bonusVirtualCurrency(giftInfo["number"],3)
		return true
	elseif giftInfo["type"] == "lei" then
		propModel:buyProp("lei",giftInfo["number"])
		um:bonusProps("手雷", giftInfo["number"], 0, 3)
		StoreModel:refreshInfo("prop")
		return true
	elseif giftInfo["type"] == "jijia" then
		propModel:buyProp("jijia",giftInfo["number"])
		um:bonusProps("机甲", giftInfo["number"], 0, 3)
		StoreModel:refreshInfo("prop")
		return true
	elseif giftInfo["type"] == "goldweapon" then
		InlayModel:buyGoldsInlay(giftInfo["number"])
		um:bonusProps("黄金武器", giftInfo["number"], 0, 3)
		StoreModel:refreshInfo("prop")
		InlayModel:refreshInfo("speed")
		return true
	end
	return false
end

function DailyLoginModel:isToday()
	local DailyInfo = self:getDailyInfo()
	if DailyInfo["logintime"] == os.date("%x") then
		return true
	else
		return false
	end
end

function DailyLoginModel:isGet()
	local DailyInfo = self:getDailyInfo()
	if DailyInfo["isGet"] then
		return true
	else
		return false
	end
end

function DailyLoginModel:setLoginState()
	local DailyInfo = self:getDailyInfo()
	if DailyInfo["logintime"] == os.date("%x") then
		if DailyInfo["isGet"] then

		else

		end
	else
		self:setTime()
		if DailyInfo["isGet"] then
			self:setGet(false)
		else
			
		end
	end
end

return DailyLoginModel