
require("config")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
    self.objects_ = {}
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    self:enterScene("MainScene")
end

function MyApp:loadCCSJsonFile(scene, jsonFile)
    local node, width, height = cc.uiloader:load(jsonFile)
    width = width or display.width
    height = height or display.height
    if node then
        node:setPosition((display.width - width)/2, (display.height - height)/2)
        scene:addChild(node)
    end
end

function MyApp:setObject(id, object)
    assert(self.objects_[id] == nil, string.format("MyApp:setObject() - id \"%s\" already exists", id))
    self.objects_[id] = object
end

function MyApp:getObject(id)
    assert(self.objects_[id] ~= nil, string.format("MyApp:getObject() - id \"%s\" not exists", id))
    return self.objects_[id]
end

function MyApp:isObjectExists(id)
    return self.objects_[id] ~= nil
end

function MyApp:getInstance(cls, id)
    local modelObj 
    local idStr = id or cls.__cname
    if not self:isObjectExists(idStr) then
        modelObj = cls.new(
            {
                id = idStr,
            })
        self:setObject(idStr, modelObj)
        print("MyApp create model id is:", idStr)
    else
        print("MyApp get model id is:", idStr)
        modelObj = self:getObject(idStr)
    end  
    return modelObj
end

return MyApp
