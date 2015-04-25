local BossModeConfigs = import(".BossModeConfigs")

local BossModeModel = class("BossModeModel", cc.mvc.ModelBase)

BossModeModel.REFRESH_BOSSLAYER_EVENT = "REFRESH_BOSSLAYER_EVENT"

function BossModeModel:ctor(properties)
	BossModeModel.super.ctor(self, properties)
	self.weaponListModel = md:getInstance("WeaponListModel")
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

function BossModeModel:setBossModeWave(chapterId,waveNum)
	local info = self:getInfo(chapterId)
	local weaponId = info["weaponId"]

	local data = getUserData()
	if self.weaponListModel:isWeaponExist(weaponId) then return end
	if data.bossmodelevel.chapterId == chapterId and data.bossmodelevel.waveNum < waveNum then
		data.bossmodelevel.waveNum = waveNum
		self:setPartsComposition(chapterId)
	end
	dump(data.bossmodelevel)
	setUserData(data)
end

function BossModeModel:setPartsComposition(chapterId)
	local data = getUserData()
	if data.bossmodelevel.chapterId == chapterId and data.bossmodelevel.waveNum >= 5 then
		local info = self:getInfo(chapterId)
		local weaponId = info["weaponId"]
		self.weaponListModel:buyWeapon(weaponId)
		if chapterId < self:getChapterNum() then
			data.bossmodelevel.chapterId = chapterId + 1
			data.bossmodelevel.waveNum = 0
		end
	end
end

function BossModeModel:getAlreadyWave(chapterId)
	local data = getUserData()
	if data.bossmodelevel.chapterId == chapterId then
		return data.bossmodelevel.waveNum
	end
	return 0
end

function BossModeModel:getAlreadyChapter()
	local data = getUserData()
	return data.bossmodelevel.chapterId
end

function BossModeModel:getChapterNum()
	local num = 0
	local table = BossModeConfigs.getConfigs()
	for k,v in pairs(table) do
		num = num + 1
	end
	return num
end

function BossModeModel:refreshInfo()
	self:dispatchEvent({name = BossModeModel.REFRESH_BOSSLAYER_EVENT})
end

return BossModeModel