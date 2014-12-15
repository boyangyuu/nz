local DialogConfigs = import(".DialogConfigs")


local Dialog = class("Dialog", cc.mvc.ModelBase)

function Dialog:ctor(properties)
	Dialog.super.ctor(self, properties)
end

function Dialog:check(groupId,levelId,appear)
	print(" Dialog:check"..groupId.."-"..levelId..","..appear)
	local config = DialogConfigs.getConfig(groupId,levelId)
	if config ~= nil then
		for k,v in pairs(config) do
			if v.appear == appear then
				return true
			end
		end
		config[]
	end
	return false
end

return Dialog