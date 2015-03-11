
-- --[[--
--[[--
“敵人”的实体

]]

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Actor = import("..fight.Actor")
local GuideConfigs = import(".GuideConfigs")
local Guide = class("Guide", cc.mvc.ModelBase)

-- 定义事件
Guide.GUIDE_START_EVENT 		= "GUIDE_START_EVENT"
Guide.GUIDE_FINISH_EVENT 		= "GUIDE_FINISH_EVENT"
Guide.GUIDE_HIDE_EVENT 			= "GUIDE_HIDE_EVENT"
Guide.GUIDE_TOUCHSWALLOW_EVENT  = "GUIDE_TOUCHSWALLOW_EVENT"

function Guide:ctor(properties)
    Guide.super.ctor(self, properties) 
	
	--instance
	self.datas = {}
	self.groupId = nil
	self.stepIndex = nil
	self.curData = nil
	self.isGuiding = false
end

function Guide:check(groupId)
	if self.isGuiding then return end
	
	local configGroup =  GuideConfigs.getConfig(groupId)
	assert(configGroup, "configGroup is nil groupId:"..groupId)
	local preGroupId = configGroup["preGuideId"]
	local isPreDone = true
	if preGroupId then 
		isPreDone = self:isDone(preGroupId)
	end
	local isCurDone = self:isDone(groupId)
	print("isCurDone", isCurDone)
	if not isCurDone and isPreDone then 
		self:startGuide(groupId)
		return true
	end
end

function Guide:setTouchSwallow(isSwallow)
	self:dispatchEvent({name = Guide.GUIDE_TOUCHSWALLOW_EVENT, 
				isSwallow = isSwallow})
end

function Guide:doGuideNext()
	--check finish
	if self:isDone(self.groupId) then 
		-- self:finishGuide()
		return
	end
	local configGroup =  GuideConfigs.getConfig(self.groupId)

	--um finish
	local umStr = nil
	if self.stepIndex ~= 0 then
		local lastconfigStep = configGroup["steps"][self.stepIndex]	
		--todo 改为自定义事件
		assert(lastconfigStep["id"], "lastconfigStep is nil")
		um:finishLevel("新手:" .. lastconfigStep["id"])
	end
	--next
	self.stepIndex = self.stepIndex + 1

	--update config
	local configStep = configGroup["steps"][self.stepIndex]	
	self.curConfig = configStep

	--check finish
	if self.curConfig == nil then 
		self:finishGuide()
		return
	end

	-- --um start
	assert(self.curConfig["id"], "self.curConfig is nil")
	um:startLevel("新手:" .. self.curConfig["id"])

	--update listenData
	local id = configStep.id
	local listenData = self.datas[id]	
	self.curData = listenData

	--dispatch
	print("GuideModel开始新引导: stepIndex:"..self.stepIndex..",  stepId:"..id)
	self:dispatchEvent({name = Guide.GUIDE_START_EVENT, 
				groupId = self.groupId})	
end

function Guide:startGuide(groupId)
	print("function Guide:startGuide(groupId)", groupId)
	self.isGuiding = true
	assert(self:isDone(groupId) == false , "no exist groupId"..groupId)
	self.groupId = groupId
	self.stepIndex = 0
	self:doGuideNext()
end

function Guide:isDone(groupId)
	--read userdata
	local data = getUserData()
	local isUnMatchVesion = data.guide[groupId] == nil
	local isAndroid = device.platform == "android" 
	if isUnMatchVesion then 
		assert(isAndroid, "invalid groupId",groupId )
		print("isUnMatchVesion")
		return true 
	end
	local isDone = data.guide[groupId] 
	return isDone
end

function Guide:addClickListener(data)
	local groupId = data.groupId
	if self:isDone(groupId) then return end
	local id = data.id
	self.datas[id] = data

	-- dump(data, "data name:"..groupId)
end

function Guide:hideGuideForTime(delay)
	self:dispatchEvent({name = Guide.GUIDE_HIDE_EVENT, 
				delay = delay})	
end

function Guide:finishGuide()
	--save userdata
	local data = getUserData()
	local groupId = self.groupId
	assert(data.guide[groupId] == false, 
			"引导已经做过 重复引导了， groupId:"..self.groupId)
	data.guide[groupId] = true
	setUserData(data)

	--dispatch
	self:dispatchEvent({name = Guide.GUIDE_FINISH_EVENT, 
				groupId = self.groupId})

	--clear
	print("function Guide:finishGuide()")
	self.stepIndex = 0
	self.isGuiding = false	
	self.groupId = nil	
end

function Guide:getIsGuiding()
	return self.isGuiding
end

function Guide:getCurData()
	assert(self.curData, "listendata为空 step index"..self.stepIndex)
	return self.curData
end

function Guide:getCurConfig()
	assert(self.curConfig, "guideconfigs为空 step index"..self.stepIndex)
	return self.curConfig
end

function Guide:getCurGuideId()
	if self.curConfig == nil then 
		return nil
	else
		return self.curConfig["id"]
	end
end

function Guide:getCurGroupId()
	return self.groupId
end

function Guide:clearData()
	local data = getUserData()
	for k,v in pairs(data.guide) do
		print(k,v)
		data.guide[k] = false
	end
	setUserData(data)
end

function Guide:fillData()
	local data = getUserData()

	--cur data
	for k,v in pairs(data.guide) do
		print(k,v)
		data.guide[k] = true
	end
	setUserData(data)
end



return Guide