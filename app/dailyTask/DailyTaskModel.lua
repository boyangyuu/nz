local DailyTaskConfig = import(".DailyTaskConfig")
local DailyTaskModel = class("DailyTaskModel", cc.mvc.ModelBase)
DailyTaskModel.TASK_UPDATE_EVENT = "TASK_UPDATE_EVENT"

function DailyTaskModel:ctor(property)
	DailyTaskModel.super.ctor(self, property)
	self.isRefresh = false
end

function DailyTaskModel:clearData()
	print("function DailyTaskModel:clearData()")
	self.isRefresh = true

	--clear
	local data = getUserData()
	for k,v in pairs(data.dailyTask) do
		-- print(k,v)
		v = 0
	end	
	setUserData(data)
end

function DailyTaskModel:addTaskTimes(type)
	print("function DailyTaskModel:addTaskTimes(type)", type)
	local data = getUserData()
	assert(data.dailyTask[type] ~= nil, "invalid type:" .. type)
	data.dailyTask[type] = data.dailyTask[type] + 1
	setUserData(data)
	self:dispatchEvent({name = DailyTaskModel.TASK_UPDATE_EVENT})
	dump(data.dailyTask, "data.dailyTask")
end

function DailyTaskModel:setTaskTimes(type, times)
	local data = getUserData()
	assert(data.dailyTask[type] ~= nil, "invalid type:" .. type)
	assert(times, "times is nil")
	data.dailyTask[type] = times
	setUserData(data)
	self:dispatchEvent({name = DailyTaskModel.TASK_UPDATE_EVENT})	
end

function DailyTaskModel:getTaskTimes(type)
	local data = getUserData()
	assert(data.dailyTask[type] ~= nil, "invalid type:" .. type)
	return data.dailyTask[type] 
end

return DailyTaskModel