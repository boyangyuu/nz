require("config")

require("framework.init")
local UI = require("app.UI.UIManager")
local MD = require("app.Model.ModelManager")
local UM = require("app.SDK.UMsdk")
local Define = require("app.Define")
local DataModel = require("app.DataModel")
GameState = require("framework.cc.utils.GameState")
local IAPsdk = require("app.SDK.IAPsdk")
local MyApp = class("MyApp", cc.mvc.AppBase)

-- global var
GameData={}

isFree = true       --付费免费
isTest  = true     --战斗的各种框     
isDebug = true      --debug页面
__versionId = "1.2"
isShowPausescene = true

ui        = UI.new()
md        = MD.new()
um        = UM.new()
define    = Define.new()
dataModel = DataModel.new()
iap       = IAPsdk.new()

function MyApp:ctor()
    MyApp.super.ctor(self)
    self.objects_ = {}
    self:initGameState()    
    
end

function MyApp:run()
    print("MyApp:run()!")
    cc.FileUtils:getInstance():addSearchPath("res/")
    self:enterScene("MainScene")
    dataModel:checkData() 
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
                returnValue={data=str}
            elseif param.name=="load" then
                local str=crypto.decryptXXTEA(param.values.data, "abcd")
                returnValue=json.decode(str)
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

    -- um 设置玩家账户及等级
    um:setUserAccount()
end

function MyApp:createGameStateFile()
    print("createGameStateFile")
    local data = GameData.data
    data = {
            versionId = __versionId,
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
                                    {
                                    intenlevel = 0,
                                    weaponid   = 6, 
                                    }
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

            money = 10000000,
            diamond = 8000,
            
            --开启的关卡
            currentlevel =  {
                        group = 1,
                        level = 1,
            },
            user = {
                level = 1,
            },
            guide = {
                        --记得和 filldata对应!

                        --第0-0关之内
                        gamePre         = false,
                        fight01_move    = false,
                        fight01_fire    = false,
                        fight01_lei     = false,
                        fight01_gold    = false,
                        fight01_change  = false,
                        fight01_jijia   = false, 

                        --第0-0关之后  
                        afterfight01    = false,   -- 进入下一关
                     
                        --第1-2关之前
                        xiangqian       = false,   --镶嵌一套青铜

                        --第1-3关之前
                        weapon          = false,   -- 升级武器
                        afterfight03    = false,   -- 回到主界面
                        
                        --第1-3.1关之内
                        fight04         = false,                        
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
            preference = {
                isOpenMusic = true
            },
            
    }
    GameState.save(data)
    -- dump(GameState.load(), "GameState.load()")
end

function MyApp:showError(debugInfo)
    local debug = md:getInstance("DebugModel")
    debug:showPopup(debugInfo)
end

function MyApp:onEnterBackground()
    if isShowPausescene ~= true then return end
    ui:showPopup("homePopup",{popupName = "mapset"},
        {anim = true,isPauseScene = true,isNotScrenCapture = true})
end

function MyApp:onEnterForeground()
   
end

return MyApp
