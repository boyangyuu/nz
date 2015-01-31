require("config")

require("framework.init")
require("app.includes.functionUtils")
local UI = require("app.UI.UIManager")
local MD = require("app.Model.ModelManager")
local UM = require("app.SDK.UMsdk")
local Define = require("app.Define")
GameState = require("framework.cc.utils.GameState")
local IAPsdk = require("app.SDK.IAPsdk")
local MyApp = class("MyApp", cc.mvc.AppBase)

-- global var
GameData={}

-- --平时
-- isTest  = true
-- isDebug = false

-- 测试打包
isTest  = false
isDebug = true

-- --正式打包
-- isTest  = false        
-- isDebug = false


ui      = UI.new()
md      = MD.new()
um      = UM.new()
define  = Define.new()
iap     = IAPsdk.new()

function MyApp:ctor()

    MyApp.super.ctor(self)
    self.objects_ = {}
    self:initGameState()    
end

function MyApp:run()
    print("MyApp:run()!")
    cc.FileUtils:getInstance():addSearchPath("res/")
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
                                        weaponid   = 1,
                                        },
                                bag2 =  {
                                        weaponid   = 2,
                                        },
                                bag3 = {
                                        weaponid   = 6,
                                        },
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
                        lei = {num = 5},
                        jijia = {num = 0},
                        goldweapon = {num = 0},
            },
       
            weaponsuipian = {},
            money = 1000000,
            diamond = 100,


                      
            currentlevel =  {
                        group = 1,

                        level = 1,
            },
            guide = {
                        gamePre         = true,
                        fight01         = true,
                        afterfight01    = false,
                        prefight02      = false,
                        fight02_dun     = false,
                        fight02         = false,
                        afterfight02    = false,
                        fight04         = false,
                        xiangqian       = false,
            },
            fight = {
                        isPreferBag1 = true,
            },

            -- 礼包购买状态
            giftBag = { --buy
                        --false 为未购买
                        weaponGiftBag =  false,
                        novicesBag = false,
            },
            dailylogin = {
                        logintime = "00000",
                        isGet = false,
                        dailyid = 0,
            },
            
    }
    GameState.save(data)
    -- dump(GameState.load(), "GameState.load()")
end

function MyApp:showError(debugInfo)
    print("function MyApp:showError(debugInfo)")
    local debug = md:getInstance("DebugModel")
    debug:showPopup(debugInfo)
end

return MyApp
