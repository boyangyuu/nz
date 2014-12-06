-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]
--import
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Actor = import("..fight.Actor")
local GuideConfigs = import(".GuideConfigs")
local Guide = class("Guide", cc.mvc.ModelBase)

-- 定义事件
Guide.GUIDE_SHOW_EVENT = "GUIDE_SHOW_EVENT"

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
	
	--init config
	
	--init
	print(":初始化引导")
	self:initGuide()

	return false
end

function Guide:doGuideNext()
	self.stepIndex = self.stepIndex + 1
	-- self.curConfig = 
end

function Guide:doGuide(groupId, index)
	print("开始引导: groupId:"..groupId..",index:"..index)
	--config check
	local configGroup =  GuideConfigs.getConfig(groupId)
	local configStep = configGroup["steps"][index]
	local stepId = configStep.id
	local listenData = self.datas[stepId]
	assert(listenData, "listenData is nil, step id :"..stepId)

	--set instance
	self.stepIndex = index
	self.curData = listenData
	self.curConfig = configStep

	--dispatch
	self:dispatchEvent({name = Guide.GUIDE_SHOW_EVENT, 
				groupId = self.groupId})
	--
end

function Guide:isDone(groupId)
	--userdata
	return false
end

function Guide:addClickListener(data)
	local groupId = data.groupId
	local id = data.id
	self.datas[id] = data

	dump(data, "data name:"..groupId)
end

function Guide:initGuide()
	--init
	self.stepIndex = 1
end

function Guide:finishGuide()
	self.datas = {}
	self.stepIndex = nil
	--dispatch
end

function Guide:getCurData()
	assert(self.curData, "监听数据为空 step index"..self.stepIndex)
	return self.curData
end

function Guide:getCurConfig()
	assert(self.curConfig, "监听数据为空 step index"..self.stepIndex)
	return self.curConfig
end

function Guide:getNextId()
	
end

function Guide:getBtn()
	dump(self["fight"], "node")
	return self["fight"]
end

return Guide