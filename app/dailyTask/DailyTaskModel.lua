local DailyTaskConfig = import(".DailyTaskConfig")
local DailyTaskModel = class("DailyTaskModel", cc.mvc.ModelBase)
DailyTaskModel.DAILYTASK_UPDATE_EVENT = "DAILYTASK_UPDATE_EVENT"

function DailyTaskModel:ctor(property)
	DailyTaskModel.super.ctor(self, property)
	self.isRefresh = false
end

function DailyTaskModel:clearData()
	print("function DailyTaskModel:clearData()")
	self.isRefresh = true

	--clear
	-- local data = getUserData()
	-- for k,v in pairs(data.dailyTask.tasks) do
	-- 	v = 0
	-- end
	-- data.dailyTask.awardedTasks = {}

	setUserData(data)
end

function DailyTaskModel:addTaskTimes(type)
	print("function DailyTaskModel:addTaskTimes(type)", type)
	local data = getUserData()
	assert(data.dailyTask.tasks[type] ~= nil, "invalid type:" .. type)
	data.dailyTask.tasks[type] = data.dailyTask.tasks[type] + 1
	setUserData(data)
	self:dispatchEvent({name = DailyTaskModel.DAILYTASK_UPDATE_EVENT})
end

function DailyTaskModel:setTaskTimes(type, times)
	local data = getUserData()
	assert(data.dailyTask.tasks[type] ~= nil, "invalid type:" .. type)
	assert(times, "times is nil")
	data.dailyTask.tasks[type] = times
	setUserData(data)
	self:dispatchEvent({name = DailyTaskModel.DAILYTASK_UPDATE_EVENT})
end

function DailyTaskModel:getTaskTimes(type)
	local data = getUserData()
	assert(data.dailyTask.tasks[type] ~= nil, "invalid type:" .. type)
	return data.dailyTask.tasks[type]
end

function DailyTaskModel:getSortedDatas()
	--datas
	local configs = DailyTaskConfig.getConfigs()
	local datas = {}
	for i,config in ipairs(configs) do
		datas[#datas + 1] = self:getTaskData(config["index"])
	end

	--sort
	local function sortFunction(record1, record2)
		local isGetted1V = record1["isGetted"] and -100 or 0
		local isGetted2V = record2["isGetted"] and -100 or 0
		local isCanGet1V = record1["isCanGet"] and 100 or 0
		local isCanGet2V = record2["isCanGet"] and 100 or 0
		local index1    = tonumber(string.sub(record1["index"], -2))
		local index2    = tonumber(string.sub(record2["index"], -2))

		return isGetted1V + isCanGet1V + index1 > isGetted2V + isCanGet2V + index2
	end
	table.sort(datas, sortFunction)
	return datas
end

function DailyTaskModel:getTaskData(index)
	local data = DailyTaskConfig.getConfig(index)
	assert(data, "data is nil" .. index)
	local type = data["type"]
	data.curValue = self:getTaskTimes(type)
	data.isGetted = self:isTaskGetted(index)
	data.isCanGet = data.curValue >= data.limit and not data.isGetted

	--assert
	return data
end

function DailyTaskModel:receiveTaskAward(index)
	print("function DailyTaskModel:receiveTaskAward(index)", index)
	local data = getUserData()
	assert(self:getTaskData(index)["isCanGet"], "awarded!! :" .. index)
	data.dailyTask.awardedTasks[index] = true
	setUserData(data)

	--send award
	local cfg = DailyTaskConfig.getConfig(index)
    print("发奖励")
    local user       = md:getInstance("UserModel")
    if cfg["awardType"] == "diamond" then
    	user:addDiamond(cfg["awardValue"])
	elseif cfg["awardType"] == "coin" then
	    user:addMoney(cfg["awardValue"])
	else
		assert(false, "cfg[awardType] is invalid".. cfg["awardType"])
	end

	self:dispatchEvent({name = DailyTaskModel.DAILYTASK_UPDATE_EVENT,
		taskIndex = cfg.index})
end

function DailyTaskModel:isTaskGetted(index)
	local data = getUserData()
	return data.dailyTask.awardedTasks[index] == true
end

function DailyTaskModel:resetDailyTask()
	local data = getUserData()
	for k,v in pairs(data.dailyTask.tasks) do
		data.dailyTask.tasks[k] = 0
	end
	data.dailyTask.awardedTasks = {}
	setUserData(data)
end

return DailyTaskModel