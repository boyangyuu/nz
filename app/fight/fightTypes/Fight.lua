local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“战斗”的实体

]]

--import
local Fight = class("Fight", cc.mvc.ModelBase)

--events
Fight.PAUSE_SWITCH_EVENT     = "PAUSE_SWITCH_EVENT"

Fight.FIGHT_START_EVENT      = "FIGHT_START_EVENT"
Fight.FIGHT_WIN_EVENT        = "FIGHT_WIN_EVENT"
Fight.FIGHT_FAIL_EVENT       = "FIGHT_FAIL_EVENT"
Fight.FIGHT_RELIVE_EVENT     = "FIGHT_RELIVE_EVENT"
Fight.FIGHT_FIRE_PAUSE_EVENT = "FIGHT_FIRE_PAUSE_EVENT"
Fight.FIGHT_RESUMEPOS_EVENT  = "FIGHT_RESUMEPOS_EVENT"

Fight.GUN_RELOAD_EVENT       = "GUN_RELOAD_EVENT"

Fight.CONTROL_HIDE_EVENT     = "CONTROL_HIDE_EVENT"
Fight.CONTROL_SHOW_EVENT     = "CONTROL_SHOW_EVENT"
Fight.CONTROL_SET_EVENT      = "CONTROL_SET_EVENT"

Fight.INFO_HIDE_EVENT        = "INFO_HIDE_EVENT"
Fight.INFO_SHOW_EVENT        = "INFO_SHOW_EVENT"

Fight.RESULT_WIN_EVENT       = "RESULT_WIN_EVENT"
Fight.RESULT_FAIL_EVENT      = "RESULT_FAIL_EVENT"

function Fight:ctor(properties)
    Fight.super.ctor(self, properties)
    self.fightData = nil
end

function Fight:beginFight()
    --um
    self:refreshUm()

    --dialog
    scheduler.performWithDelayGlobal(handler(self, self.willStartFight), 2.0)    
end

function Fight:refreshData(fightData)
    self.groupId   = fightData.groupId
    self.levelId   = fightData.levelId
    self.inlayModel = md:getInstance("InlayModel")

    --clear   
    self.result = nil
    self.resultData = {}
    self.goldGet  = 0
    self.isPause = false  
    self.fightData = fightData   
    md:createInstance("FightMode")
    md:createInstance("FightConfigs")  
    md:createInstance("Map") 
    md:createInstance("EnemyManager")
    md:createInstance("FightProp")
    
    --init instance
    local isContinue = fightData["isContinue"]
    if isContinue then return end
    
    md:createInstance("FightInlay") 
    md:createInstance("Hero")
    md:createInstance("Defence")    
    md:createInstance("Robot")     

    self.hero       = md:getInstance("Hero") 
    self.inlay      = self.hero:getFightInlay()
    
    self.relivedTimes = 0
end

function Fight:refreshUm()
    --事件统计_镶嵌
    self.inlay:refreshUm()

    --事件统计_关卡开始
    self:refreshUmFightTimesEvent()

    --任务统计
    local levelInfo = self:getLevelInfo()
    um:startLevel(levelInfo)
end

function Fight:refreshUmFightTimesEvent()
    local levelInfo     = self:getLevelInfo()
    local umStr         = nil
    local isFighted     = self:getFightedLevelData()
    if isFighted then 
        umStr = "关卡开始_重复进入"
    else
        self:saveFightedLevelData("enter")
        umStr = "关卡开始_首次进入"
    end

    local umData = {}
    umData[levelInfo] = umStr
    um:event("关卡次数情况", umData)        
end

function Fight:saveFightedLevelData(_status, levelInfo)
    levelInfo = levelInfo or self:getLevelInfo() 
    assert(_status, "_status is nil")
    local data = getUserData()
    local status = data.user.fightedLevels[levelInfo]
    if status == "awarded" then return end 
    data.user.fightedLevels[levelInfo] = _status
    setUserData(data)    
end

function Fight:getFightedLevelData(levelInfo)
    levelInfo = levelInfo or self:getLevelInfo()
    local data = getUserData()
    local status = data.user.fightedLevels[levelInfo]
    print("levelInfo", levelInfo)
    print("getFightedLevelData status", status)
    dump(data.user.fightedLevels, "getFightedLevelData")
    return status
end

function Fight:willStartFight()
    self:checkDialogForward()
end

function Fight:startFight()
    self:dispatchEvent({name = Fight.FIGHT_START_EVENT})
    self.inlay:checkNativeGold()

    --check guide
    local guide = md:getInstance("Guide")
    if self.groupId == 0 and self.levelId == 0 then 
        scheduler.performWithDelayGlobal(function()
            guide:check("fight01_move")
        end, 0.0)
        return       
    elseif self.groupId == 1 and self.levelId == 5 then 
        scheduler.performWithDelayGlobal(function()
            guide:check("fightJu")
        end, 0.0)
        return   
    end

    --check ad
    self:checkFightStartAds()
end

function Fight:checkFightStartAds()
    if self.groupId <= 1 or self.levelId % 2 == 1 then 
        return 
    end
    print("function Fight:checkFightStartAds()")
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("goldGiftBag", 
        {isNotPopup = true,isNotPopKefu = true},"战斗界面_战斗开始")  
end

function Fight:endFightWin()
    self:dispatchEvent({name = Fight.FIGHT_WIN_EVENT})
    self:pauseFight(true)
    self:checkDialogAfter()
    if self:getFightType() ~= "jujiFight" then 
        self:clearFightData()
    end
    --um 任务
    local levelInfo = self:getLevelInfo() 
    um:finishLevel(levelInfo)

    --um 关卡完成情况事件
    local umData = {}
    umData[levelInfo] = "关卡胜利"
    um:event("关卡完成情况", umData)

    --save data
    self:saveFightedLevelData("win")

    --level
    local levelMapModel = md:getInstance("LevelMapModel")
    levelMapModel:levelPass(self.groupId, self.levelId)
end


function Fight:startFightResult()
    local fightDescModel = md:getInstance("FightDescModel")
    fightDescModel:dispatchEvent({name = fightDescModel.SUCCESS_ANIM_EVENT})
end

function Fight:willWin(time)
    if self:getResult() ~= nil then return end
    local delay = time or 1.0
    self:setResult("win")
    scheduler.performWithDelayGlobal(handler(self, self.doWin), delay)
end

function Fight:willFail(time)
    if self:getResult() ~= nil then return end
    local delay = time or 2.0
    self:setResult("willFail")    
    scheduler.performWithDelayGlobal(handler(self, self.doFail), delay)
end

function Fight:doWin()
    assert(self.result)
    self:endFightWin()  
end

function Fight:doFail()
    assert(self.result)
    self.hero:doKill()
    self:endFightFail()
end

function Fight:doGiveUp()
    self.result = "fail"

     --um 关卡完成情况事件
    local levelInfo = self:getLevelInfo() 
    local umData = {}
    umData[levelInfo] = "关卡失败"    
    um:event("关卡完成情况", umData)

    -- save data
    self:saveFightedLevelData("fail")

    --um
    local failCause = self:getFailCause()
    um:failLevel(levelInfo, failCause)
end

function Fight:doRelive()
    --um
    local levelInfo = self:getLevelInfo()
    local umData = {}
    umData[levelInfo] = "复活"
    um:event("关卡道具使用", umData)
  
    --clear
    self:clearFightData()
    self.result = nil

    --relive
    self.hero:doRelive()
    self:equipReliveAward()
    self:dispatchEvent({name = Fight.FIGHT_RELIVE_EVENT})
    self:pauseFight(false)

    self.relivedTimes = self.relivedTimes + 1
end

function Fight:getRelivedTimes()
    return self.relivedTimes
end


function Fight:equipReliveAward()
    --gold
    self.inlayModel:equipGoldInlays()
    self.inlay:checkNativeGold()

    --jijia
    local robot = md:getInstance("Robot")
    robot:startRobot(define.kRobotTimeRelieve)
end

function Fight:pauseFight(isPause)
    self.isPause = isPause
    self:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, 
        isPause = self.isPause})

    --fire
    if isPause then 
        self:stopFire() 
    end
end

function Fight:isPauseFight()
    return self.isPause
end

function Fight:checkDialogForward()
    local dialog = md:getInstance("DialogModel")
    dialog:check("forward", handler(self, self.onDialogForwardEnd))     
end

function Fight:onDialogForwardEnd()
    self:startFight()
end
 
function Fight:checkDialogAfter()
    local dialog = md:getInstance("DialogModel")
    dialog:check("after",  handler(self, self.onDialogAfterEnd))
end

function Fight:onDialogAfterEnd()
    if (self.groupId == 0 and self.levelId == 0) then 
        ui:showPopup("GiftBagStonePopup", 
            {ccsName = "GiftBag_Xianshidacu",
            strPos   = "打开武器库_自动弹出限时大促",
            stoneCost = 900, 
            closeAllFunc = handler(self, self.startFightResult),
            },
            {animName = "shake"})    
        return        
    end


    if (self.groupId == 1 and self.levelId == 2) or 
        (self.groupId == 1 and self.levelId == 6) then 
        --ad 1-2 
        local buyModel = md:getInstance("BuyModel")
        if not buyModel:checkBought("weaponGiftBag") then 
            buyModel:showBuy("weaponGiftBag", {
                closeAllFunc = handler(self, self.startFightResult),
                deneyBuyFunc = handler(self, self.startFightResult),
                isNotPopKefu = true},
                self:getLevelInfo() .. "战斗结束_自动弹出武器大礼包")
            return 
        end
    end

    self:startFightResult()
end

---- 关卡相关 ----
function Fight:getFailCause()
    local goldCostTimes = self.inlay:getGoldCostTimes()
    return "黄金武器消耗次数: " .. goldCostTimes
end

function Fight:getGroupId()
    return self.groupId
end

function Fight:getLevelId()
    return self.levelId
end

function Fight:getCurGroupAndLevel()
    return self.groupId , self.levelId 
end

function Fight:getLevelInfo()
    local str = self.groupId.."-"..self.levelId 
    assert(str, "str is nil")
    return str
end

function Fight:setCompsVisible(componentVisibles)
    self:dispatchEvent({name = Fight.CONTROL_SET_EVENT, 
        comps = componentVisibles})
end

---- 关卡相关end ----
function Fight:stopFire()
    self:dispatchEvent({name = Fight.FIGHT_FIRE_PAUSE_EVENT})
end

function Fight:clearFightData()
    self.inlayModel:removeAllInlay()
end

function Fight:cleanModels()
 
end

function Fight:addGoldValue(goldValue_)
    self.goldGet = self.goldGet + goldValue_ 
end

function Fight:getGoldValue()
    local user = md:getInstance("UserModel")
    return self.goldGet + user:getMoney()
end

function Fight:getResult()
    print("getResult", self.result)
    return self.result
end

function Fight:setResult(result)
    print("setResult", self.result)
    self.result = result
end


function Fight:waveUpdate(nextWaveIndex, waveType)
    assert(false, "must implement")
end

function Fight:getResultData()
    assert(false, "must implement")
end

function Fight:getFightType()
    assert(false, "must implement")
end

function Fight:isJujiFight()
    assert(false, "must implement")
end

function Fight:endFightFail()
    assert(false, "must implement") 
end

function Fight:onReliveConfirm()
   assert(false, "must implement") 
end

function Fight:onReliveDeny()
    assert(false, "must implement")
end

function Fight:getReliveCost()
    assert(false, "must implement")
end

return Fight
