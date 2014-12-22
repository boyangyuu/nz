local ModelManager = class("ModelManager", cc.mvc.ModelBase)


function ModelManager:setObject(id, object)
    assert(self.objects_[id] == nil, string.format("ModelManager:setObject() - id \"%s\" already exists", id))
    self.objects_[id] = object
end

function ModelManager:getObject(id)
    assert(self.objects_[id] ~= nil, string.format("ModelManager:getObject() - id \"%s\" not exists", id))
    return self.objects_[id]
end

function ModelManager:isObjectExists(id)
    return self.objects_[id] ~= nil
end

function ModelManager:getInstance(cls)
    local modelObj  
    assert(cls, "cls is nil"..tostring(cls))
    local idStr = cls.__cname
    if not self:isObjectExists(idStr) then
        modelObj = cls.new(
            {
                id = idStr,
            })
        self:setObject(idStr, modelObj)
        -- print("ModelManager create model id is:", idStr)
    else
        -- print("ModelManager get model id is:", idStr)
        modelObj = self:getObject(idStr)
    end  
    return modelObj
end

function ModelManager:deleteInstance(cls)
    local idStr = cls.__cname
    self.objects_[idStr] = nil
    print("self:removeObject(idStr)", idStr)
end