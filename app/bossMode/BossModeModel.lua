local BossModeConfigs = import(".BossModeConfigs")

local BossModeModel = class("BossModeModel", cc.mvc.ModelBase)

BossModeModel.REFRESH_BOSSLAYER_EVENT = "REFRESH_BOSSLAYER_EVENT"

function BossModeModel:ctor(properties)
	BossModeModel.super.ctor(self, properties)
end

function BossModeModel:getInfo(chapterId)
	local bossConfig = BossModeConfigs.getConfig(chapterId)
	return bossConfig
end

function BossModeModel:checkPre(choseChapter)
	local choseInfo = self:getInfo(choseChapter)
	if choseInfo then
		return true
	else
		return false
	end
end

function BossModeModel:checkNext(choseChapter)
	local choseInfo = self:getInfo(choseChapter)
	if choseInfo then
		return true
	else
		return false
	end
end

function BossModeModel:refreshInfo()
	self:dispatchEvent({name = BossModeModel.REFRESH_BOSSLAYER_EVENT})
end

return BossModeModel