local DailyLoginConfig = import(".DailyLoginConfig")
local DailyLoginModel = class("DailyLoginModel", cc.mvc.ModelBase)

function DailyLoginModel:ctor(properties)
	DailyLoginModel.super.ctor(self,properties)
	self:getDate()
end

local popup = false
function DailyLoginModel:setPopup()
	popup = true
	dump(popup)
end
function DailyLoginModel:donotPop()
	popup = false
end
function DailyLoginModel:checkPop()
	return popup
end

function DailyLoginModel:setTime()
	print("~~~~!~!~!~!~!")
	dump(network.getInternetConnectionStatus())
	if network.getInternetConnectionStatus() == 0 then return end
	local data = getUserData()
	data.dailylogin.logintime = self.date
	if data.registertime == nil then
		if network.getInternetConnectionStatus() == 0 then
			data.registertime = os.time()
		else
			data.registertime = self.date
		end
	end
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
	if os.date("%x",DailyInfo["logintime"]) == os.date("%x",self.date) then
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
	if os.date("%x",DailyInfo["logintime"]) == os.date("%x",self.date) then
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

function DailyLoginModel:getDate()
	local data = getUserData()
	self.date = data.dailylogin.logintime
	dump(data.dailylogin)
    local url = "http://123.57.213.26/timestamp.php"
    local request = network.createHTTPRequest(handler(self,self.onRequestFinished), url, "GET")
    request:start()
end

function DailyLoginModel:onRequestFinished(event)
    local ok = (event.name == "completed")
    local request = event.request
 
    if not ok then
        -- 请求失败，显示错误代码和错误消息
        print(request:getErrorCode(), request:getErrorMessage())
        return
    end
 
    local code = request:getResponseStatusCode()
    if code ~= 200 then
        -- 请求结束，但没有返回 200 响应代码
        print(code)
        return
    end
 
    -- 请求成功，显示服务端返回的内容
    local response = request:getResponseString()
    dump(response)
    if response then
	    self.date = response
	end
end

return DailyLoginModel