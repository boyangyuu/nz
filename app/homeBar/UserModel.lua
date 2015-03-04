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
		ui:showPopup("commonPopup",
				 {type = "style2", content = "您的金币不足"},
				 {opacity = 155})
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

 function UserModel:buyDiamond(diamond)
	local data = getUserData()
	data.diamond = data.diamond + diamond
	setUserData(data)
	self:dispatchEvent({name = "REFRESH_MONEY_EVENT"})
end

 function UserModel:addMoney(money)
	local data = getUserData()
	data.money = data.money + money
	setUserData(data)
	self:dispatchEvent({name = "REFRESH_MONEY_EVENT"})
end

function UserModel:levelPass(groupId,levelId)
	assert(groupId, "groupId")
	assert(levelId, "levelId")
	local data = getUserData()
	local curGroupId = data.currentlevel.group
	local curLevelId = data.currentlevel.level

	--是否开启下一关
	local isOpenNext = groupId == curGroupId and levelId == curLevelId
	
	if groupId == 0 and levelId == 0 then
		return
	elseif math.floor(levelId) < levelId then
		return
	elseif isOpenNext then
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