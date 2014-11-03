--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 15:31:35
--
import("..includes.functionUtils")

local InlayModel = class("InlayModel", cc.mvc.ModelBase)

function InlayModel:ctor(properties)

end

function InlayModel:getConfigTable(fileName, index)
	assert(fileName and index, "invalid param")
	local config = getConfig("config/json_inlay.json")
	local records = getRecord(config, fileName, index) or {}
	return records
end

return InlayModel