local DialogConfigs = import(".DialogConfigs")


local Dialog = class("Dialog", cc.mvc.ModelBase)

--定义事件
Dialog.DIALOG_START_EVENT  = "DIALOG_START_EVENT"
Dialog.DIALOG_FINISH_EVENT = "DIALOG_FINISH_EVENT"

function Dialog:ctor(properties)
	Dialog.super.ctor(self, properties)
end

function Dialog:check(groupId,levelId,appear)
	print(" Dialog:check"..groupId.."-"..levelId..","..appear)
	local config = DialogConfigs.getConfig(groupId,levelId,appear)
	if config == nil then
		return false
	end
	return true
end

function Dialog:getDialogNum(groupId,levelId,appear)
	dump(appear)
	local configs = DialogConfigs.getConfig(groupId,levelId,appear)
	dump(configs)
	return #configs
end

function Dialog:finishDialog()
	--dispatch
	self:dispatchEvent({name = Dialog.DIALOG_FINISH_EVENT})
end

function Dialog:startDialog(appear)
	--dispatch
	self:dispatchEvent({name = Dialog.DIALOG_START_EVENT,appear = appear})
end

return Dialog