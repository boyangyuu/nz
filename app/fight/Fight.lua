local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“战斗”的实体

]]

--import
local Fight = class("Fight", cc.mvc.ModelBase)

--events
Fight.PAUSE_SWITCH_EVENT = "PAUSE_SWITCH_EVENT"

Fight.FIGHT_START_EVENT  = "FIGHT_START_EVENT"
Fight.FIGHT_END_EVENT    = "FIGHT_END_EVENT"
Fight.FIGHT_TIPS_EVENT   = "FIGHT_TIPS_EVENT"   
Fight.GUN_RELOAD_EVENT    = "GUN_RELOAD_EVENT"

Fight.CONTROL_HIDE_EVENT     = "CONTROL_HIDE_EVENT"
Fight.CONTROL_SHOW_EVENT     = "CONTROL_SHOW_EVENT"
Fight.CONTROL_SET_EVENT      = "CONTROL_SET_EVENT"
Fight.FIGHT_RESTOREGUN_EVENT = "FIGHT_RESTOREGUN_EVENT"

Fight.FIGHT_FIRE_PAUSE_EVENT = "FIGHT_FIRE_PAUSE_EVENT"

Fight.INFO_HIDE_EVENT = "INFO_HIDE_EVENT"
Fight.INFO_SHOW_EVENT = "INFO_SHOW_EVENT"

Fight.RESULT_WIN_EVENT   = "RESULT_WIN_EVENT"
Fight.RESULT_FAIL_EVENT  = "RESULT_FAIL_EVENT"

Fight.FIGHT_RESUMEPOS_EVENT  = "FIGHT_RESUMEPOS_EVENT"

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
    self.isJujiFight = levelModel:isJujiFight()
    self.goldValue = 0.0
    self.result = nil
    self.resultData = {}
    self.isPause = false
    self.killRenzhiNum  = 0
end

function Fight:refreshUm()
    --事件统计_镶嵌
    self.inlay:refreshUm()

    --事件统计_关卡开始
    self:refreshUmFightTimesEvent()

    --任务统计
    local levelInfo = self:getLevelInfo()
    assert(levelInfo, "levelInfo is nil")
    print(" um:startLevel(levelInfo)", levelInfo)
    um:startLevel(levelInfo)
end

function Fight:refreshUmFightTimesEvent()
    local data = getUserData()

    local fightedGid = data.user.fightedGroupId
    local fightedLid = data.user.fightedlevelId

    local fGid, fLid = self:getCurGroupAndLevel()    
    local isUnFighted = fightedGid <= fGid 
                and fightedLid < fLid
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

function Fight:willEndFight()
    self:checkDialogAfter()
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
    elseif self.groupId == 1 and self.levelId == 3.1 then 
        scheduler.performWithDelayGlobal(function()
            guide:check("fight04")
        end, 0.0)   
    end
end

function Fight:endFight()
    self:dispatchEvent({name = Fight.FIGHT_END_EVENT})
    ui:showPopup("FightResultPopup",{},{anim = false})
end

function Fight:onWin()
    if self.result then return end
    self.result = "win" 
    local levelMapModel = md:getInstance("LevelMapModel")
    local userModel = md:getInstance("UserModel")
    levelMapModel:levelPass(self.groupId, self.levelId)
    userModel:getUserLevel(self.groupId, self.levelId)
    self:setFightResult()

    --um 任务
    local levelInfo = self:getLevelInfo() 
    assert(levelInfo, "levelInfo is nil")  
    print(" um:finishLevel(levelInfo)", levelInfo)
    um:finishLevel(levelInfo)

    --um 关卡完成情况事件
    local umData = {}
    umData[levelInfo] = "关卡胜利"
    um:event("关卡完成情况", umData)

    self:willEndFight()  
    self:clearFightData()  
end

function Fight:onGiveUp()
    self.result = "fail"

     --um 关卡完成情况事件
    local levelInfo = self:getLevelInfo() 
    assert(levelInfo, "levelInfo is nil")
    local umData = {}
    umData[levelInfo] = "关卡失败"    
    um:event("关卡完成情况", umData)

    local failCause = self:getFailCause()
    um:failLevel(levelInfo, failCause)
end

function Fight:getFailCause()
    local goldCostTimes = self.inlay:getGoldCostTimes()
    -- print("goldCostTimes", goldCostTimes)
    return "黄金武器消耗次数: " .. goldCostTimes
end

function Fight:onFail()
    if self.result then return end   
    local fightProp = md:getInstance("FightProp")
    fightProp:costReliveBag()
    ui:showPopup("FightResultFailPopup",{},{anim = false})
    
    --clear
    self:clearFightData() 
end

function Fight:onRelive()
    --um
    local levelInfo = self:getLevelInfo()
    assert(levelInfo, "levelInfo is nil")
    local umData = {}
    umData[levelInfo] = "复活"
    um:event("关卡道具使用", umData)

    --relive
    ui:closePopup("FightResultFailPopup")
    self.hero:doRelive()
    
    --clear
    self:clearFightData()

    --gold
    self.inlayModel:equipGoldInlays(false)
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
        self:endFight()
        return 
    end

    --ad
    local buyModel = md:getInstance("BuyModel")
    if not buyModel:checkBought("weaponGiftBag") then 
        buyModel:showBuy("weaponGiftBag", {
            popFiveWeapon = false,
            payDoneFunc = handler(self, self.endFight),
            deneyBuyFunc = handler(self, self.endFight)},
            self:getLevelInfo() .. "战斗结束_自动弹出武器大礼包")
    else
        self:endFight()
    end
end

function Fight:checkDialogAward(callfunc)
    local dialog = md:getInstance("DialogModel")
    self:pauseFight(true)
    dialog:check("award",  callfunc)    
end

---- 关卡相关 ----
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
    return self.groupId.."-"..self.levelId
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

function Fight:addKillRenzhiNum()
    self.killRenzhiNum = self.killRenzhiNum + 1

    local fightConfigs  = md:getInstance("FightConfigs")
    local waveConfig    = fightConfigs:getWaveConfig()
    local limit         = waveConfig:getRenzhiLimit()
    if self.killRenzhiNum >= limit then
        self:killRenzhiOver()
    end
end

function Fight:killRenzhiOver()
    self:dispatchEvent({name = Fight.FIGHT_TIPS_EVENT , failType = "renzhi"})
    scheduler.performWithDelayGlobal(handler(self, self.doFail), 2.5)    
end

function Fight:doFail()
    self.hero:doKill()
    self:onFail()
end

function Fight:clearFightData()
    self.inlayModel:removeAllInlay()
    self.killRenzhiNum = 0
    self.result = nil     
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