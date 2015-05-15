
local UserModel = class("UserModel", cc.mvc.ModelBase)

function UserModel:ctor(properties)
	UserModel.super.ctor(self, properties)
	self.LevelMapModel = md:getInstance("LevelMapModel")
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function UserModel:panelAction()
	self:dispatchEvent({name = "HOMEBAR_ACTION_UP_EVENT"})
end
function UserModel:getMoney(  )
	local data = getUserData()
	 return data.money
end

 function UserModel:getDiamond(  )
	local data = getUserData()
	 return data.diamond
end

 function UserModel:costMoney(money)
	local data = getUserData()
	if data.money >= money then
		data.money = data.money - money
		setUserData(data)
		self:dispatchEvent({name = "REFRESH_MONEY_EVENT"})
		return true
	else
		-- ui:showPopup("commonPopup",
		-- 		 {type = "style2", content = "您的金币不足"},
		-- 		 {opacity = 155})
		return false
	end
end

function UserModel:costDiamond(diamond)
	local data = getUserData()
	if data.diamond >= diamond then
		data.diamond = data.diamond - diamond 
		setUserData(data)
		self:dispatchEvent({name = "REFRESH_MONEY_EVENT"})
		return true
	else
		return false
	end
end

 function UserModel:addDiamond(diamond)
 	if diamond <= 0 then return end
	local data = getUserData()
	data.diamond = data.diamond + diamond
	setUserData(data)
	self:dispatchEvent({name = "REFRESH_MONEY_EVENT"})
end

 function UserModel:addMoney(money)
 	if money <= 0 then return end
	local data = getUserData()
	data.money = data.money + money
	setUserData(data)
	self:dispatchEvent({name = "REFRESH_MONEY_EVENT"})
end

function UserModel:setUserLevel(level)
	--check
	local data = getUserData()
	local curLevel = data.user.level 
	-- assert(level >= curLevel and level < curLevel + 2, "invalid level : " .. level)
	if level ~= curLevel + 1 then 
		print("等级异常: 当前等级:" .. curLevel .. "目标等级:" .. level)
	end
	
	--save
	data.user.level = level
	setUserData(data)

	--um
	um:setLevel(level)	
end

function UserModel:getUserLevel()
	local data = getUserData()
	local curLevel = data.user.level 
	return curLevel 
end

function UserModel:getLoginTime()
	local data = getUserData()
	local loginTime = data.dailylogin.loginTime
	return loginTime
end

function UserModel:getRegisterTime()
	local data = getUserData()
	local registerTime = data.registTime
	return registerTime 
end

function UserModel:getUserName()
	local data = getUserData()
	return data.user.userName
end

return UserModel