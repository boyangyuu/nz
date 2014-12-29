local DialogConfigs = import(".DialogConfigs")


local Dialog = class("Dialog", cc.mvc.ModelBase)

--定义事件
Dialog.DIALOG_START_EVENT  = "DIALOG_START_EVENT"
Dialog.DIALOG_FINISH_EVENT = "DIALOG_FINISH_EVENT"

function Dialog:ctor(properties)
	Dialog.super.ctor(self, properties)
end

function Dialog:check(groupId,levelId,appear)
	self.appearType = appear
	print(" Dialog:check"..groupId.."-"..levelId..","..appear)
	local config = DialogConfigs.getConfig(groupId,levelId,appear)
	if config == nil then
		self:finishDialog()
	end
	assert(self.appearType, "appearType is nil")
	self:startDialog()
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
	return #configs
end

function Dialog:finishDialog()
	--dispatch
	self:dispatchEvent({name = Dialog.DIALOG_FINISH_EVENT})
	local fight = md:getInstance("Fight")
	fight:onFinishDialog(self.appearType)
end

function Dialog:startDialog()
	--dispatch
	print("function Dialog:startDialog(appear)")
	self:dispatchEvent({name = Dialog.DIALOG_START_EVENT})
end

return Dialog