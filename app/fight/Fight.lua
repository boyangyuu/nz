local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“战斗”的实体

]]

--import
local Fight = class("Fight", cc.mvc.ModelBase)

--events
Fight.PAUSE_SWITCH_EVENT   = "PAUSE_SWITCH_EVENT"

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

Fight.INFO_HIDE_EVENT = "INFO_HIDE_EVENT"
Fight.INFO_SHOW_EVENT = "INFO_SHOW_EVENT"

Fight.RESULT_WIN_EVENT   = "RESULT_WIN_EVENT"
Fight.RESULT_FAIL_EVENT  = "RESULT_FAIL_EVENT"

function Fight:ctor(properties)
    Fight.super.ctor(self, properties)
end

function Fight:beginFight()
    --um
    self:refreshUm()

    --dialog
    scheduler.performWithDelayGlobal(handler(self, self.willStartFight), 0.4)    
end

function Fight:refreshData(properties)
    self.groupId = properties.groupId
    self.levelId = properties.levelId   

    --init inatance
    self:cleanModels()

    self.inlayModel = md:getInstance("InlayModel")
    self.hero       = md:createInstance("Hero")  --todo改为refreash Instance
    self.map        = md:createInstance("Map")
    self.robot      = md:createInstance("Robot")
    self.inlay      = self.hero:getFightInlay()

    local levelModel = md:getInstance("LevelDetailModel")
    self.isJujiFight = levelModel:isJujiFight(self.groupId,self.levelId)
    self.goldValue = 0.0
    self.result = nil
    self.resultData = {}
    self.isPause = false
end

function Fight:refreshUm()
    --事件统计_镶嵌
    self.inlay:refreshUm()

    --事件统计_关卡开始
    self:refreshUmFightTimesEvent()

    --任务统计
    local levelInfo = self:getLevelInfo()
    print(" um:startLevel(levelInfo)", levelInfo)
    um:startLevel(levelInfo)
end

function Fight:refreshUmFightTimesEvent()
    local data = getUserData()

    local fightedGid = data.user.fightedGroupId
    local fightedLid = data.user.fightedlevelId

    local fGid, fLid = self:getCurGroupAndLevel()    
    local isUnFighted = (fightedGid <= fGid and fightedLid < fLid) 
                        or (fightedGid < fGid)
    local str = nil
    if isUnFighted then
        data.user.fightedGroupId = fGid
        data.user.fightedlevelId = fLid
        setUserData(data)
        str = "关卡开始_首次进入"
    else
        str = "关卡开始_重复进入" 
    end

    local umData = {}
    local levelInfo = self:getLevelInfo()
    umData[levelInfo] = str
    um:event("关卡次数情况", umData)        
end

function Fight:willStartFight()
    self:checkDialogForward()
end

function Fight:startFight()
    self:dispatchEvent({name = Fight.FIGHT_START_EVENT})
    self.inlay:checkNativeGold()

    --check ju
    self:checkJuContorlType()

    --check guide
    local guide = md:getInstance("Guide")
    if self.groupId == 0 and self.levelId == 0 then 
        scheduler.performWithDelayGlobal(function()
            guide:check("fight01_move")
        end, 0.0)       
    elseif self.groupId == 1 and self.levelId == 5 then 
        scheduler.performWithDelayGlobal(function()
            guide:check("fightJu")
        end, 0.0)   
    end
end

function Fight:endFightWin()
    self:dispatchEvent({name = Fight.FIGHT_WIN_EVENT})
    self:pauseFight(true)
    self:checkDialogAfter()

    self:clearFightData()
end

function Fight:endFightFail()
    print("function Fight:endFightFail()")
    self:dispatchEvent({name = Fight.FIGHT_FAIL_EVENT})
    self.inlayModel:removeAllInlay()
    local fightProp = md:getInstance("FightProp")
    ui:showPopup("FightResultFailPopup",{},{anim = false}) 
    self:clearFightData()
end

function Fight:startFightResult()
    ui:showPopup("FightResultPopup",{},{anim = false})
end

function Fight:doWin()
    if self.result then return end
    print("")
    self.result = "win" 

    local levelMapModel = md:getInstance("LevelMapModel")
    local userModel = md:getInstance("UserModel")
    levelMapModel:levelPass(self.groupId, self.levelId)
    userModel:getUserLevel(self.groupId, self.levelId)
    self:setFightResult()

    --um 任务
    local levelInfo = self:getLevelInfo() 
    um:finishLevel(levelInfo)

    --um 关卡完成情况事件
    local umData = {}
    umData[levelInfo] = "关卡胜利"
    um:event("关卡完成情况", umData)

    self:endFightWin()  
end

function Fight:doFail()
    if self.result then return end
    self.result = "fail"

    self.hero:doKill()
    self:endFightFail()
end

function Fight:doGiveUp()
    self.result = "giveUp"

     --um 关卡完成情况事件
    local levelInfo = self:getLevelInfo() 
    local umData = {}
    umData[levelInfo] = "关卡失败"    
    um:event("关卡完成情况", umData)

    local failCause = self:getFailCause()
    um:failLevel(levelInfo, failCause)
end

function Fight:doRelive()
    --um
    local levelInfo = self:getLevelInfo()
    local umData = {}
    umData[levelInfo] = "复活"
    um:event("关卡道具使用", umData)

    --relive
    ui:closePopup("FightResultFailPopup")
    self.hero:doRelive()
    
    --clear
    self:clearFightData()

    self.result = nil
    
    self:equipReliveAward()

    --relive
    self:dispatchEvent({name = Fight.FIGHT_RELIVE_EVENT})
end

function Fight:equipReliveAward()
    --gold
    self.inlayModel:equipGoldInlays()
    self.inlay:checkNativeGold()

    --jijia
    local robot = md:getInstance("Robot")
    robot:startRobot(define.kRobotTimeRelieve)

    --refresh
    local fightProp = md:getInstance("FightProp")
    fightProp:refreshData()
end

function Fight:pauseFight(isPause)
    self.isPause = isPause
    self:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, 
        isPause = self.isPause})
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
    local isAd = self.groupId == 1 and self.levelId == 2
        or self.groupId == 0 and self.levelId == 0
    if not isAd then 
        self:startFightResult()
        return 
    end

    --ad
    local buyModel = md:getInstance("BuyModel")
    if not buyModel:checkBought("weaponGiftBag") then 
        buyModel:showBuy("weaponGiftBag", {
            closeAllFunc = handler(self, self.startFightResult),
            deneyBuyFunc = handler(self, self.startFightResult)},
            self:getLevelInfo() .. "战斗结束_自动弹出武器大礼包")
    else
        self:startFightResult()
    end
end

function Fight:checkDialogAward(callfunc)
    local dialog = md:getInstance("DialogModel")
    self:pauseFight(true)
    dialog:check("award",  callfunc)    
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

function Fight:checkJuContorlType()
    if self.isJujiFight == false then return end
    local comps = {btnJu = true, btnChange =  false,}
    self:setCompsVisible(comps)
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
    md:deleteInstance("Hero")
    md:deleteInstance("FightInlay")  
    md:deleteInstance("Defence")
    md:deleteInstance("Robot")
end

function Fight:setGoldValue(goldValue_)
    self.goldValue = goldValue_
end

function Fight:getGoldValue()
    return self.goldValue
end

function Fight:setFightResult()
    local hpPercent = self.hero:getHp() / self.hero:getMaxHp()
    -- is gold weapon
    local inlay = md:getInstance("FightInlay")
    local isGold = inlay:getIsNativeGold()
    local hpPercent = isGold and 1.00 or hpPercent

    self.resultData["goldNum"]   = self.goldValue
    self.resultData["hpPercent"] = hpPercent
end

function Fight:getResult()
    return self.result
end

function Fight:getResultData()
    return self.resultData
end

return Fight