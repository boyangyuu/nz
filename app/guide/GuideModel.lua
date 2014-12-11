-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]
--import
import("..includes.functionUtils")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Actor = import("..fight.Actor")
local GuideConfigs = import(".GuideConfigs")
local Guide = class("Guide", cc.mvc.ModelBase)

-- 定义事件
Guide.GUIDE_START_EVENT = "GUIDE_START_EVENT"
Guide.GUIDE_FINISH_EVENT = "GUIDE_FINISH_EVENT"
Guide.GUIDE_HIDE_EVENT = "GUIDE_HIDE_EVENT"

function Guide:ctor(properties)
    Guide.super.ctor(self, properties) 
	
	--instance
	self.datas = {}
	self.groupId = nil
	self.stepIndex = nil
	self.curData = nil
end

function Guide:check(groupId)
	print(" Guide:check"..groupId)
	if self:isDone(groupId) then return true end
	return false
end

function Guide:doGuideNext()
	--next
	self.stepIndex = self.stepIndex + 1

	--update config
	local configGroup =  GuideConfigs.getConfig(self.groupId)
	local configStep = configGroup["steps"][self.stepIndex]	
	self.curConfig = configStep

	--check finish
	if self.curConfig == nil then 
		self:finishGuide()
		return
	end

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
	if self:isDone(groupId) then return end
	self.groupId = groupId
	self.stepIndex = 0
	self:doGuideNext()
end

function Guide:isDone(groupId)
	--read userdata
	local data = getUserData()
	local isDone = data.guide[groupId] 
	isDone = false
	return isDone
end

function Guide:addClickListener(data)
	local groupId = data.groupId
	if self:isDone(groupId) then return end
	local id = data.id
	self.datas[id] = data

	dump(data, "data name:"..groupId)
end

function Guide:hideGuideForTime(delay)
	self:dispatchEvent({name = Guide.GUIDE_HIDE_EVENT, 
				delay = delay})	
end

function Guide:finishGuide()
	--clear
	self.datas = {}
	self.stepIndex = 0

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
end

function Guide:getCurData()
	assert(self.curData, "listendata为空 step index"..self.stepIndex)
	return self.curData
end

function Guide:getCurConfig()
	assert(self.curConfig, "guideconfigs为空 step index"..self.stepIndex)
	return self.curConfig
end

function Guide:getBtn()
	dump(self["fight"], "node")
	return self["fight"]
end

return Guide