
require("config")
require("framework.init")
require("app.includes.functionUtils")
local UI = require("app.UI.UIManager")
local MD = require("app.Model.ModelManager")  
local Define = require("app.Define")  

GameState = require("framework.cc.utils.GameState")

local MyApp = class("MyApp", cc.mvc.AppBase)

-- global var
GameData={}
isTest  = false
isTest  = true
ui      = UI.new()
md      = MD.new()
define  = Define.new()
umSDK   = cc.UMAnalytics

function MyApp:ctor()
    MyApp.super.ctor(self)
    self.objects_ = {}
    self:initGameState()    
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    md:loadAllModels()
    self:enterScene("MainScene")
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
                returnValue=param.values
            end
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
                                    crit = nil,
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
                        level = 6,
            },
            guide = {
                        fight = false,
            },
            fight = {
                        isPreferBag1 = true,
            },
    }
    GameState.save(data)
    -- dump(GameState.load(), "GameState.load()")
end


return MyApp
