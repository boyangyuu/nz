import("..includes.functionUtils")

local FightResultModel = class("FightResultModel", cc.mvc.ModelBase)

function FightResultModel:ctor(properties)
	FightResultModel.super.ctor(self, properties)
end

function FightResultModel:getInlayrecordByID(inlayid)
	local record = getRecordByKey("config/items_xq.json", "id", inlayid)[1]
	return record
end

function FightResultModel:popupleveldetail(nextgroup,nextlevel)
    self:dispatchEvent({name = "POPUP_LEVELDETAIL",gid = nextgroup,lid = nextlevel})
end

function FightResultModel:giftInlay(quality)
	local config = getConfig("config/items_xq.json")
	local giftTable = getRecordFromTable(config, "property", quality) or {}
	for k,v in pairs(giftTable) do
		local inlaymodel = md:getInstance("InlayModel")
		inlaymodel:buyInlay(v["id"],false,1)
	end
end

return FightResultModel