
require("config")
require("framework.init")
GameState = require("framework.cc.utils.GameState")

local MyApp = class("MyApp", cc.mvc.AppBase)

-- global var
GameData={}

function MyApp:ctor()
    MyApp.super.ctor(self)
    self.objects_ = {}
    self:initGameState()
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

function MyApp:initGameState(  )
    -- init GameState
    GameState.init(function(param)
        local returnValue=nil
        if param.errorCode then
            CCLuaLog("error")
        else
            -- crypto
            if param.name=="save" then
                local str=json.encode(param.values)
                str=crypto.encryptXXTEA(str, "abcd")
                returnValue={data=str}
            elseif param.name=="load" then
                local str=crypto.decryptXXTEA(param.values.data, "abcd")
                returnValue=json.decode(str)
            end
            -- returnValue=param.values
        end
        return returnValue
    end, "data.txt","1234")
    if io.exists(GameState.getGameStatePath()) then
        GameData=GameState.load()
    end

end

return MyApp
