




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
-- modelClasses["DialogLayer"]          = import("..dialog.DialogLayer")


function ModelManager:ctor()
    self.objects_ = {}
    self:loadAllModels()
end

function ModelManager:loadAllModels()
    print("ModelManager:loadAllModels()")
    for i, v in pairs(modelClasses) do
        assert(not self:isObjectExists(i) , "already added model")
        local modelObj = v.new()
        self:setObject(i, modelObj)
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

    assert(clsName, "clsName is nil"..tostring(clsName))
    print("ModelManager get model id is:", clsName)
    local modelObj = self:getObject(clsName)
    return modelObj
end

function ModelManager:deleteInstance(clsName)
    self.objects_[clsName] = nil
    print("self:removeObject(idStr)", clsName)
end

return ModelManager