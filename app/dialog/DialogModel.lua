local DialogConfigs = import(".DialogConfigs")


local Dialog = class("Dialog", cc.mvc.ModelBase)

--定义事件
Dialog.DIALOG_START_EVENT  = "DIALOG_START_EVENT"
Dialog.DIALOG_FINISH_EVENT = "DIALOG_FINISH_EVENT"

function Dialog:ctor(properties)
	Dialog.super.ctor(self, properties)
end

local is = true
function Dialog:check(appear)
	assert(appear, "appearType is nil")
	self.appearType = appear
	local fight  = md:getInstance("Fight") 	
	local groupId = fight:getGroupId()
	local levelId = "level"..fight:getLevelId()
	local config = DialogConfigs.getConfig(groupId,levelId,appear)
	-- dump(config, "config")
	if config == nil then
		self:finishDialog()
	else
		self:startDialog()
	end
end

function Dialog:getAppearType()
	return self.appearType
end

function Dialog:getDialogNum()
	local fight  = md:getInstance("Fight") 	
	local groupId = fight:getGroupId()
	local levelId = "level"..fight:getLevelId()
	local appear  = self:getAppearType() 

	local configs = DialogConfigs.getConfig(groupId,levelId,appear)
	assert(configs, "configs is nil")
	return #configs
end

function Dialog:finishDialog()
	--dispatch
	-- print("function Dialog:finishDialog()")
	self:dispatchEvent({name = Dialog.DIALOG_FINISH_EVENT})
	local fight = md:getInstance("Fight")
	fight:onFinishDialog(self.appearType)
end

function Dialog:startDialog()
	--dispatch
	-- print("function Dialog:startDialog(appear)")
	self:dispatchEvent({name = Dialog.DIALOG_START_EVENT})
end

return Dialog