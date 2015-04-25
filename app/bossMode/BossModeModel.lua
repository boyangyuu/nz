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
	if self:isProgressExist(chapterId) then 
		for k,v in pairs(data.bossmodelevel) do
			if v.chapterId == chapterId and v.waveNum < waveNum then
				v.waveNum = waveNum
				self:setPartsComposition(chapterId)
			end
		end
	else
		local insertPart = {chapterId = chapterId, waveNum = waveNum}
		table.insert(data.bossmodelevel,insertPart)
	end
	dump(data.bossmodelevel)
	setUserData(data)
end

function BossModeModel:setPartsComposition(chapterId)
	local data = getUserData()
	for k,v in pairs(data.bossmodelevel) do
		if v.chapterId == chapterId and v.waveNum >= 5 then
			table.remove(data.bossmodelevel,k)
			local info = self:getInfo(chapterId)
			local weaponId = info["weaponId"]
			self.weaponListModel:buyWeapon(weaponId)
		end
	end
end

function BossModeModel:isProgressExist(chapterId)
	local data = getUserData()
	for k,v in pairs(data.bossmodelevel) do
		if v.chapterId == chapterId then
			return true
		end
	end
	return false
end

function BossModeModel:getAlreadyWave(chapterId)
	local data = getUserData()
	for k,v in pairs(data.bossmodelevel) do
		if v.chapterId == chapterId then
			return v.waveNum
		end
	end
	return 0
end

function BossModeModel:refreshInfo()
	self:dispatchEvent({name = BossModeModel.REFRESH_BOSSLAYER_EVENT})
end

return BossModeModel