




local ModelManager = class("ModelManager", cc.mvc.ModelBase)
local modelClasses = {}

--home
modelClasses["UserModel"]           = import("..homeBar.UserModel")
modelClasses["DialogModel"]         = import("..dialog.DialogModel")
modelClasses["LevelMapModel"]       = import("..levelMap.LevelMapModel")
modelClasses["FightResultModel"]    = import("..fightResult.FightResultModel")
modelClasses["LevelDetailModel"]    = import("..levelDetail.LevelDetailModel")
modelClasses["propModel"]           = import("..store.propModel")
modelClasses["StoreModel"]          = import("..store.StoreModel")
modelClasses["InlayModel"]          = import("..inlay.InlayModel")
modelClasses["WeaponListModel"]     = import("..weaponList.WeaponListModel")

--fight
modelClasses["Fight"]               = import("..fight.Fight")
modelClasses["FightInlay"]          = import("..fight.FightInlay")
modelClasses["Hero"]                = import("..fight.Hero")
modelClasses["Map"]                 = import("..fight.Map")
modelClasses["Defence"]             = import("..fight.skills.Defence")
modelClasses["Robot"]               = import("..fight.skills.Robot")
modelClasses["FightConfigs"]        = import("..fight.fightConfigs.FightConfigs")

--guide
modelClasses["Guide"]               = import("..guide.GuideModel")

function ModelManager:ctor()
    ModelManager.super.ctor(self) 
    self.objects_ = {}
end

function ModelManager:loadAllModels()
    -- print("ModelManager:loadAllModels()")
    for i, v in pairs(modelClasses) do
        -- print("instancename:", i)
        if not self:isObjectExists(i) then 
            local modelObj = v.new()
            self:setObject(i, modelObj)
        end
    end
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
       local classModel = modelClasses[clsName]
    assert(classModel, "classModel is not in modelmanager: clsName"
        ..clsName) 

    local modelObj 
    if not self:isObjectExists(clsName) then
        modelObj = classModel.new({id = classModel.__cname})
        self:setObject(clsName, modelObj)
    else
        modelObj = self:getObject(clsName)
    end  
    return modelObj
end

function ModelManager:deleteInstance(clsName)
    self.objects_[clsName] = nil
    -- print("self:removeObject(clsName)", clsName)
end

return ModelManager