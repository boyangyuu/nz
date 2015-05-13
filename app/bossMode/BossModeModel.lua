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

function BossModeModel:passWave(chapterIndex,waveIndex)
	local data = getUserData()
	if data.bossMode.chapterIndex == chapterIndex 
		and data.bossMode.waveIndex < waveIndex then
		data.bossMode.waveIndex = waveIndex

		--next chapter
		if data.bossMode.waveIndex >= 5 then
			if chapterIndex < self:getChapterNum() then
				data.bossMode.chapterIndex = chapterIndex + 1
				data.bossMode.waveIndex = 0
			end
		end
		setUserData(data)
		return true --有突破
	else
		return false --没突破
	end
end

function BossModeModel:setWeapon(chapterIndex)
	local data = getUserData()
	if data.bossMode.chapterIndex > chapterIndex then
		local info = self:getInfo(chapterIndex)
		local weaponId = info["weaponId"]
		self.weaponListModel:buyWeapon(weaponId)
		ui:showPopup("WeaponNotifyLayer",
	     {type = "gun",weaponId = weaponId})

	end
end

function BossModeModel:getAlreadyWave(chapterIndex)
	local data = getUserData()
	if data.bossMode.chapterIndex == chapterIndex then
		return data.bossMode.waveIndex
	elseif data.bossMode.chapterIndex > chapterIndex then
		return 5
	else
		return 0
	end
end

function BossModeModel:getAlreadyChapter()
	local data = getUserData()
	return data.bossMode.chapterIndex
end

function BossModeModel:getChapterNum()
	local num = 0
	local table = BossModeConfigs.getConfigs()
	for k,v in pairs(table) do
		num = num + 1
	end
	return num
end

function BossModeModel:getChapterModel(chapterId,waveIndex)
	local info = self:getInfo(chapterId)
	local data = info["reward"..waveIndex]
	assert(data, "invalid param: chapterId:" .. chapterId .. "waveIndex: " ..waveIndex)
	return data
end

function BossModeModel:refreshInfo()
	self:dispatchEvent({name = BossModeModel.REFRESH_BOSSLAYER_EVENT})
end

return BossModeModel