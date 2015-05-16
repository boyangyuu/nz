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

function DailyLoginModel:isToday()
	local DailyInfo = self:getDailyInfo()
	dump(DailyInfo)
	if os.date("%x",DailyInfo["loginTime"]) == os.date("%x",self.date) then
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
		self:refreshTime(event, callfunc)
	end
    local url = "http://123.57.213.26/timestamp.php"
    local request = network.createHTTPRequest(onRequestFinished, url, "GET")
    request:start()
end

function DailyLoginModel:refreshTime(event, callfunc)
	dump(event, "event refreshTime")
    local name = event.name 
    local request = event.request
 	
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
	    local response = request:getResponseString()
	    -- dump(response, "请求成功 response")
	    if response then
	    	local curTimeStamp = response
	    	self:saveTimeData(curTimeStamp)
	    	callfunc("success")
		end
    end
end

function DailyLoginModel:saveTimeData(curTimeStamp)
	local data = getUserData()
	data.dailylogin.loginTime = curTimeStamp
	if data.dailylogin.registTime == nil then
		data.dailylogin.registTime = curTimeStamp
	end
	setUserData(data)
end

return DailyLoginModel