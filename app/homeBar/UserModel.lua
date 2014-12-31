import("..includes.functionUtils")

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
		print("金钱不足请充值 弹出充值")
		-- self:dis	
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
		print("钻石不足请充值 弹出充值")
		return false
	end
end

 function UserModel:buyDiamond(diamond)
	local data = getUserData()
	data.diamond = data.diamond + diamond
	setUserData(data)
end

 function UserModel:addMoney(money)
	local data = getUserData()
	data.money = data.money + money
	setUserData(data)
end

function UserModel:levelPass(groupId,levelId)
	local data = getUserData()
	local group = data.currentlevel.group
	local level = data.currentlevel.level
	if groupId == group and levelId ==level then
		if self.LevelMapModel:getNextGroupAndLevel(group, level) == false then
			print("通关")
		else
			local nextgroup,nextlevel = self.LevelMapModel:getNextGroupAndLevel(group, level)
			data.currentlevel.group = nextgroup
			data.currentlevel.level = nextlevel
			setUserData(data)
			-- dump(GameState.load())
		end
	end
end


return UserModel