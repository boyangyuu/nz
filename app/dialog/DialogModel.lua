local DialogConfigs = import(".DialogConfigs")


local Dialog = class("Dialog", cc.mvc.ModelBase)

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
	local configs = DialogConfigs.getConfig(groupId,levelId,appear)
	return #configs
end

return Dialog