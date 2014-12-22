




local ModelManager = class("ModelManager", cc.mvc.ModelBase)
local modelClasses = {}
modelClasses["UserModel"]         = import("..homeBar.UserModel")
-- modelClasses["FightPlayer"]          = import("..fight.FightPlayer")
-- modelClasses["WeaponBag"]            = import("..weaponList.WeaponBag")
-- modelClasses["HomeBarLayer"]         = import("..homeBar.HomeBarLayer")
-- modelClasses["FightResultLayer"]     = import("..fightResult.FightResultLayer")
-- modelClasses["LevelDetailLayer"]     = import("..levelDetail.LevelDetailLayer")
-- modelClasses["FightResultPopup"]     = import("..fightResult.FightResultPopup")
-- modelClasses["FightResultFailPopup"] = import("..fightResult.FightResultFailPopup")
modelClasses["DialogModel"]          = import("..dialog.DialogModel")
modelClasses["Fight"]                = import("..fight.Fight")
modelClasses["InlayModel"] = import("..inlay.InlayModel")
modelClasses["LevelMapModel"] = import("..levelMap.LevelMapModel")
modelClasses["FightResultModel"] = import("..fightResult.FightResultModel")
modelClasses["LevelDetailModel"]= import("..levelDetail.LevelDetailModel")
modelClasses["WeaponListModel"] = import("..weaponList.WeaponListModel")
modelClasses["propModel"] = import("..store.propModel")
modelClasses["StoreModel"] = import("..store.StoreModel")
modelClasses["Guide"] = import("..guide.GuideModel")
modelClasses["Hero"] = import("..fight.Hero")
function ModelManager:ctor()
    ModelManager.super.ctor(self)
    self.objects_ = {}
end

function ModelManager:loadAllModels()
    print("ModelManager:loadAllModels()")
    for i, v in pairs(modelClasses) do
        print("instancename:", i)
        if not self:isObjectExists(i) then 
            local modelObj = v.new()
            self:setObject(i, modelObj)
        end
    end
end

function ModelManager:setObject(id, object)
    assert(self.objects_[id] == nil, string.format("ModelManager:setObject() - id \"%s\" already exists", id))
    self.objects_[id] = object
    dump(self.objects_, "self.objects_")
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
        modelObj = classModel.new()
        self:setObject(clsName, modelObj)
    else
        modelObj = self:getObject(clsName)
    end  
    return modelObj
end

function ModelManager:deleteInstance(clsName)
    self.objects_[clsName] = nil
    print("self:removeObject(idStr)", clsName)
end

return ModelManager