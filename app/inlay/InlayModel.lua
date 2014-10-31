--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 15:31:35
--
import("..includes.functionUtils")

local InlayModelModel = class("InlayModelModel", cc.mvc.ModelBase)

function InlayModelModel:ctor()

end

function InlayModelModel:getConfigTable(fileName, index)
	local config = getConfig("config/json_inlay.json")
	local records = getRecord(config, fileName, index)
	return records
end

return InlayModelModel