




local ModelManager = class("ModelManager", cc.mvc.ModelBase)
local modelClasses = {}
local needCreateClasses = {}

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
modelClasses["commonPopModel"]      = import("..commonPopup.commonPopModel")
--fight
modelClasses["Fight"]               = import("..fight.Fight")
modelClasses["FightInlay"]          = import("..fight.FightInlay")
modelClasses["Hero"]                = import("..fight.Hero")
modelClasses["Map"]                 = import("..fight.Map")
modelClasses["Defence"]             = import("..fight.skills.Defence")
modelClasses["Robot"]               = import("..fight.skills.Robot")
modelClasses["FightConfigs"]        = import("..fight.fightConfigs.FightConfigs")
modelClasses["AnimModel"]           = import("..animLayer.AnimModel")

--guide
modelClasses["Guide"]               = import("..guide.GuideModel")

--need create
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
    local classModel = modelClasses[clsName]
    local modelObj = classModel.new({id = classModel.__cname})
    self:setObject(clsName, modelObj)
    return modelObj    
end

function ModelManager:deleteInstance(clsName)
    self.objects_[clsName] = nil
    -- print("self:removeObject(clsName)", clsName)
end

return ModelManager