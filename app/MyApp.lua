
require("config")
require("framework.init")
require("app.includes.functionUtils")
local UI = require("app.UI.UIManager")
ui = UI.new()

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
    assert(cls, "cls is nil"..tostring(cls))
    local idStr = id or cls.__cname
    if not self:isObjectExists(idStr) then
        modelObj = cls.new(
            {
                id = idStr,
            })
        self:setObject(idStr, modelObj)
        -- print("MyApp create model id is:", idStr)
    else
        -- print("MyApp get model id is:", idStr)
        modelObj = self:getObject(idStr)
    end  
    return modelObj
end

function MyApp:initGameState()
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
                returnValue={data=param.values}
            elseif param.name=="load" then
                local str=crypto.decryptXXTEA(param.values.data, "abcd")
                -- returnValue=json.decode(str)
                returnValue=param.values
            end
            -- returnValue=param.values
        end
        return returnValue
    end, "data.txt","1234")
    if io.exists(GameState.getGameStatePath()) then
        GameData=GameState.load()
    else
        self:createGameStateFile()
        GameData=GameState.load()
    end
end

function MyApp:createGameStateFile()
    print("createGameStateFile")
    local data = GameData.data
    data = {
            weapons = {
                        bags = {
                                    {
                                    intenlevel = 0,
                                    weaponid   = 1,
                                    },
                                    {
                                    intenlevel = 0,
                                    weaponid   = 2 ,           
                                    },
                        },
                        weaponed = {
                                bag1 =  {
                                        intenlevel = 0,
                                        weaponid   = 1,
                                        },
                                bag2 =  {
                                        intenlevel = 0,
                                        weaponid   = 2,
                                        }
                        },
            }, 
            inlay = {
                        bags = {}, --{inlayid = 1,ownednum = 1}
                        inlayed  = {
                                        --存id bullet = 1,
                                    bullet = nil,
                                    clip = nil,
                                    speed = nil,
                                    aim = nil,
                                    blood = nil,
                                    helper = nil,
                        },
            },
            prop = {
                            lei = {num = 0},
                            jijia = {num = 0},
                            goldweapon = {num = 0},
            },
       
            weaponsuipian = {},
            money = 12000000,
            diamond = 1000000,
                      
            currentlevel =  {
                        group = 1,
                        level = 5,
            },
            guide = {
                        fight = false,
            },
    }
    GameState.save(data)
    -- dump(GameState.load(), "GameState.load()")
end


return MyApp
