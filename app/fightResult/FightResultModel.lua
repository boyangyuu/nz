import("..includes.functionUtils")

local FightResultModel = class("FightResultModel", cc.mvc.ModelBase)

function FightResultModel:ctor(properties)
	FightResultModel.super.ctor(self, properties)
end

function FightResultModel:getInlayrecordByID(inlayid)
	local config = getConfig("config/items_xq.json")
	local record = getRecord(config, "id", inlayid)[1]
	return record
end

return FightResultModel