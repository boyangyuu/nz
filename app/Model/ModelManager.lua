
local ModelManager = class("ModelManager", cc.mvc.ModelBase)
local modelClasses = {}
local needCreateClasses = {}

--home
modelClasses["UserModel"]           = import("..homeBar.UserModel")
modelClasses["DialogModel"]         = import("..dialog.DialogModel")
modelClasses["LevelMapModel"]       = import("..levelMap.LevelMapModel")
modelClasses["FightResultModel"]    = import("..fightResult.FightResultModel")
modelClasses["LevelDetailModel"]    = import("..levelDetail.LevelDetailModel")
modelClasses["PropModel"]           = import("..store.PropModel")
modelClasses["InlayModel"]          = import("..inlay.InlayModel")
modelClasses["WeaponListModel"]     = import("..weaponList.WeaponListModel")
modelClasses["DailyLoginModel"]     = import("..dailyLogin.DailyLoginModel")
modelClasses["VipModel"]            = import("..levelMap.VipModel")
modelClasses["ActiveCodeModel"]     = import("..start.ActiveCodeModel")

--bossFight
modelClasses["BossModeModel"]       = import("..bossMode.BossModeModel")

--jujiFight
modelClasses["JujiModeModel"]       = import("..jujiMode.JujiModeModel")

--fight
modelClasses["FightFactory"]        = import("..fight.fightTypes.FightFactory")
modelClasses["FightInlay"]          = import("..fight.FightInlay")
modelClasses["FightGun"]            = import("..fight.Gun.FightGun")
modelClasses["FightProp"]           = import("..fight.FightProp")
modelClasses["Hero"]                = import("..fight.Hero")
modelClasses["Map"]                 = import("..fight.Map")
modelClasses["Defence"]             = import("..fight.skills.Defence")
modelClasses["Robot"]               = import("..fight.skills.Robot")
modelClasses["FightConfigs"]        = import("..fight.fightConfigs.FightConfigs")
modelClasses["FightDescModel"]      = import("..fight.fightDesc.FightDescModel")
modelClasses["FightMode"]           = import("..fight.fightMode.FightMode")
modelClasses["EnemyManager"]        = import("..fight.EnemyManager")
modelClasses["FightAdviseModel"]    = import("..fight.fightTips.FightAdviseModel")


--guide
modelClasses["Guide"]               = import("..guide.GuideModel")

--debug
modelClasses["DebugModel"]          = import("..debug.DebugModel")

--buy
modelClasses["BuyModel"]            = import("..buy.BuyModel")

--PauseScene
modelClasses["PauseModel"]          = import("..pause.PauseModel")

-- IAPsdk
modelClasses["IAPsdk"]              = import("..SDK.IAPsdk")

-- rank
modelClasses["RankModel"]              = import("..rank.RankModel")

--awardTIme
modelClasses["AwardTimeModel"]              = import("..awardTime.AwardTimeModel")

--dailyTask
modelClasses["DailyTaskModel"]         = import("..dailyTask.DailyTaskModel")
modelClasses["ActivityMainModel"]      = import("..activitys.ActivityMainModel")



--need create
needCreateClasses["FightMode"] = true
needCreateClasses["Map"] = true
needCreateClasses["EnemyManager"] = true
needCreateClasses["Hero"] = true
needCreateClasses["FightInlay"] = true

function ModelManager:ctor()
    ModelManager.super.ctor(self) 
    self.objects_ = {}
end

function ModelManager:setObject(id, object)
    assert(self.objects_[id] == nil, string.format("ModelManager:setObject() - id \"%s\" already exists", id))
    self.objects_[id] = object
    -- dump(self.objects_, "self.objects_")
end

function ModelManager:getObject(id)
    assert(self.objects_[id] ~= nil, string.format("ModelManager:getObject() - id \"%s\" not exists", id))
    return self.objects_[id]
end

function ModelManager:isObjectExists(id)
    return self.objects_[id] ~= nil
end

function ModelManager:getInstance(clsName)
    -- print("ModelManager:getInstanc", clsName)
    local classModel = modelClasses[clsName]
    assert(classModel, "classModel is not in modelmanager: clsName"
        ..clsName) 

    local modelObj 
    if not self:isObjectExists(clsName) then
        local allowAutoCreate = needCreateClasses[clsName] == nil
        assert(allowAutoCreate, "不允许私自创建的类："..clsName)
        modelObj = self:createInstance(clsName)
    else
        modelObj = self:getObject(clsName)
    end  
    return modelObj
end

function ModelManager:createInstance(clsName)
    print("create clsName"..clsName)
    -- clear
    self.objects_[clsName] = nil

    local classModel = modelClasses[clsName]
    local modelObj = classModel.new({id = classModel.__cname})
    self:setObject(clsName, modelObj)
    return modelObj    
end

function ModelManager:deleteInstance(clsName)
    self.objects_[clsName] = nil
end

return ModelManager