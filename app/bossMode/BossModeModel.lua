local BossModeConfigs = import(".BossModeConfigs")

local BossModeModel = class("BossModeModel", cc.mvc.ModelBase)

BossModeModel.REFRESH_BOSSLAYER_EVENT = "REFRESH_BOSSLAYER_EVENT"

function BossModeModel:ctor(properties)
	BossModeModel.super.ctor(self, properties)
	self.weaponListModel = md:getInstance("WeaponListModel")
end

function BossModeModel:getInfo(chapterIndex)
	local bossConfig = BossModeConfigs.getConfig(chapterIndex)
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

function BossModeModel:setBossModeWave(chapterIndex,waveIndex)
	local info = self:getInfo(chapterIndex)
	local weaponId = info["weaponId"]

	local data = getUserData()
	if self.weaponListModel:isWeaponExist(weaponId) then return end
	if data.bossmodelevel.chapterIndex == chapterIndex and data.bossmodelevel.waveIndex < waveIndex then
		data.bossmodelevel.waveIndex = waveIndex
		self:setPartsComposition(chapterIndex)
	end
	dump(data.bossmodelevel)
	setUserData(data)
end

function BossModeModel:setPartsComposition(chapterIndex)
	local data = getUserData()
	if data.bossmodelevel.chapterIndex == chapterIndex and data.bossmodelevel.waveIndex >= 5 then
		local info = self:getInfo(chapterIndex)
		local weaponId = info["weaponId"]
		self.weaponListModel:buyWeapon(weaponId)
		if chapterIndex < self:getChapterNum() then
			data.bossmodelevel.chapterIndex = chapterIndex + 1
			data.bossmodelevel.waveIndex = 0
		end
	end
end

function BossModeModel:getAlreadyWave(chapterIndex)
	local data = getUserData()
	if data.bossmodelevel.chapterIndex == chapterIndex then
		return data.bossmodelevel.waveIndex
	end
	return 0
end

function BossModeModel:getAlreadyChapter()
	local data = getUserData()
	return data.bossmodelevel.chapterIndex
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