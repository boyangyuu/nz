local DailyLoginConfig = import(".DailyLoginConfig")
local DailyLoginModel = class("DailyLoginModel", cc.mvc.ModelBase)

function DailyLoginModel:ctor(properties)
	DailyLoginModel.super.ctor(self,properties)
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
	local propModel = md:getInstance("PropModel")
	local InlayModel = md:getInstance("InlayModel")
	if giftInfo["type"] == "gold" then
		UserModel:addMoney(giftInfo["number"])
	    um:bonusVirtualCurrency(giftInfo["number"],3)
		return true
	elseif giftInfo["type"] == "lei" then
		propModel:addProp("lei",giftInfo["number"])
		um:bonusProps("手雷", giftInfo["number"], 0, 3)
		return true
	elseif giftInfo["type"] == "jijia" then
		propModel:addProp("jijia",giftInfo["number"])
		um:bonusProps("无敌机甲", giftInfo["number"], 0, 3)
		return true
	elseif giftInfo["type"] == "goldweapon" then
		InlayModel:buyGoldsInlay(giftInfo["number"])
		um:bonusProps("黄金武器", giftInfo["number"], 0, 3)
		return true
	elseif giftInfo["type"] == "suipian" then
		local levelDetailModel = md:getInstance("LevelDetailModel")
		levelDetailModel:setsuipian(giftInfo["id"])
	elseif giftInfo["type"] == "gun" then
		local weaponListModel = md:getInstance("WeaponListModel")
		weaponListModel:buyWeapon(giftInfo["id"])
	end
	return false
end

function DailyLoginModel:isSameDay(curTimeStamp)
	local dailyInfo = self:getDailyInfo()
	if dailyInfo["loginTime"] == nil then return false end
	if os.date("%x",dailyInfo["loginTime"]) == os.date("%x",curTimeStamp) then
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

function DailyLoginModel:requestDateSever(callfunc)
	local function onRequestFinished(event)
		self:onRequestEvent(event, callfunc)
	end
    local url = "http://123.57.213.26/timestamp.php"
    local request = network.createHTTPRequest(onRequestFinished, url, "GET")
    request:start()
end

function DailyLoginModel:onRequestEvent(event, callfunc)
	-- dump(event, "event onRequestEvent")
    local name = event.name
    local request = event.request
 	-- if request == nil then return end
    if name ~= "completed" then
        print("网络请求中", request:getErrorCode()..request:getErrorMessage())
        return
    end

    local code = request:getResponseStatusCode()
    if code ~= 200 then
        print("网络请求失败", code)
        callfunc("fail")
    else
    	print("网络请求成功", code)
    	local timeStamp = request:getResponseString()
    	if timeStamp == nil then return end
    	self:refreshTime(timeStamp, callfunc)
    end
end

function DailyLoginModel:refreshTime(timeStamp, callfunc)
	--refresh
	local userModel = md:getInstance("UserModel")
	print("timeStamp", timeStamp)
	local isSameDay = self:isSameDay(timeStamp)
	local isGet = self:isGet()
	if not isSameDay then
		local vipModel = md:getInstance("VipModel")
		vipModel:setGet(false)
		self:setGet(false)
    	callfunc("success")
    	userModel:updateLoginDate()

		-- resetDailyTask()
        dailyTaskModel = md:getInstance("DailyTaskModel")
        adModel = md:getInstance("ADModel")
		dailyTaskModel:resetDailyTask()
        adModel:resetWatchTimes()
    elseif isSameDay and isGet == false then
    	callfunc("success")
    else
    	callfunc("success notPop")
	end

	userModel:saveTimeData(timeStamp)
end

return DailyLoginModel