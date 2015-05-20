local DataModel = class("DataModel", cc.mvc.ModelBase)

function DataModel:ctor()
    DataModel.super.ctor(self) 
end

function DataModel:checkData()
	local data = getUserData()
    -- dump(data)
	if data.versionId ~= __versionId then
		print(" function DataModel:checkData() unmatch!!!!!!!")
        print("data.versionId", data.versionId)
        print("__versionId", __versionId)
        self:setNewData()
    else
        print("match")
	end
end

function DataModel:setNewData()
    local data = getUserData()

    --版本
    data.versionId = __versionId

    -- 用户等级
    -- data.user = {level = 1, 
    -- fightedGroupId = 0, 
    -- fightedlevelId = 0}
    
    --hpBag
    data.prop = {
            hpBag = {num = 1},
        }

    --bossMode
    data.bossMode = {chapterIndex = 1, 
            waveIndex = 0,}

    --jujiMode
    data.jujiMode = {
            waveIndex = 40, 
            scoreAwarded = {},
        }
    
    --user
    data.user = {
            fightedLevels = {},
            userName  = "玩家自己",
            vipLevel  = 0,
        }

    --引导
    local guideModel = md:getInstance("Guide")
    guideModel:fillData()
    setUserData(data)
end

return DataModel