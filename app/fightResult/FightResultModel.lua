import("..includes.functionUtils")

local FightResultModel = class("FightResultModel", cc.mvc.ModelBase)

function FightResultModel:ctor(properties)
	FightResultModel.super.ctor(self, properties)
end

function FightResultModel:getInlayrecordByID(inlayid)
	local record = getRecordByKey("config/items_xq.json", "id", inlayid)[1]
	return record
end


function FightResultModel:getRewardFall()
	local config = getConfig("config/inlayfall.json")
	local fightModel = md:getInstance("Fight")
	local levelDetailModel = md:getInstance("LevelDetailModel")
	local weaponListModel = md:getInstance("WeaponListModel")
	local curGroup, curLevel = fightModel:getCurGroupAndLevel()
	local curRecord = levelDetailModel:getConfig(curGroup, curLevel)

-- 武器碎片
	if curRecord["suipianid"] ~= "null" then
		local isWeaponAlreadyTogether = weaponListModel:isWeaponExist(curRecord["suipianid"])
		if isWeaponAlreadyTogether == false then
			table.insert(probaTable,{id = curRecord["suipianid"],falltype = "suipian"})
			table.insert(giveTable,{id = curRecord["suipianid"],falltype = "suipian"})

		end
	end
end

function FightResultModel:popuplevelDetail(group,level)
    self:dispatchEvent({name = "POPUP_LEVELDETAIL",gid = group,lid = level})
end

function FightResultModel:isGetAwarded(weaponId)
	local data = getUserData()
	for k,v in pairs(data.weapons.awardedIds) do
		if data.weapons.awardedIds.isGet == nil then
			return false
		elseif data.weapons.awardedIds.isGet == weaponId then
			return true
		else
			return false
		end
	end
end

function FightResultModel:setAwardedId(weaponId)
	local data = getUserData()
	dump(data.weapons)
	data.weapons.awardedIds = {isGet = weaponId}
	setUserData(data)
	dump(data.weapons)
end

return FightResultModel