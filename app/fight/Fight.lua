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
Fight.GUN_RELOAD_EVENT    = "GUN_RELOAD_EVENT"

Fight.CONTROL_HIDE_EVENT = "CONTROL_HIDE_EVENT"
Fight.CONTROL_SHOW_EVENT = "CONTROL_SHOW_EVENT"
Fight.CONTROL_SET_EVENT  = "CONTROL_SET_EVENT"
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
    --关卡

    --dialog
    scheduler.performWithDelayGlobal(handler(self, self.willStartFight), 0.4)    
end

function Fight:refreshData(properties)
    print("function Fight:refreshData()")

    self.groupId = properties.groupId
    self.levelId = properties.levelId   

    --init inatance
    self:cleanModels()

    self.userModel  = md:getInstance("UserModel")
    self.inlayModel = md:getInstance("InlayModel")
    self.hero       = md:createInstance("Hero")  --todo改为refreash Instance
    self.map        = md:createInstance("Map")
    self.robot      = md:createInstance("Robot")
    self.inlay = self.hero:getFightInlay()

    local levelModel = md:getInstance("LevelDetailModel")
    self.isJujiFight = levelModel:isJujiFight()
    self.goldValue = 0.0
    self.result = nil
    self.isPause = false
    self.killRenzhiNum  = 0
end

function Fight:willStartFight()
    self:checkDialog("forward")
end

function Fight:willEndFight()
    self:checkDialog("after")
end

function Fight:startFight()
    self:dispatchEvent({name = Fight.FIGHT_START_EVENT})
    self.inlay:checkNativeGold()

    --check ju
    self:checkJuContorlType()

    --check guide
    local guide = md:getInstance("Guide")
    if self.groupId == 1 and self.levelId == 1 then 
        scheduler.performWithDelayGlobal(function()
            guide:check("fight01")
        end, 0.0)   
    elseif self.groupId == 1 and self.levelId == 4 then 
        scheduler.performWithDelayGlobal(function()
            guide:check("fight04")
        end, 0.0)   
    end
end

function Fight:endFight()
    -- print("function Fight:endFight()")
    self:dispatchEvent({name = Fight.FIGHT_END_EVENT})
    ui:showPopup("FightResultPopup",{},{anim = false})

end

function Fight:onWin()
    if self.result then return end
    self.result = "win" 
    self.userModel:levelPass(self.groupId,self.levelId)

    self:setFightResult()
    local levelInfo = self.groupId.."-"..self.levelId    
    um:finishLevel(levelInfo)
    self:willEndFight()  
    self:clearFightData()  
end

function Fight:onFail()
    if self.result then return end
    self.result = "fail"   
    local fightProp = md:getInstance("FightProp")
    fightProp:costReliveBag()

    ui:showPopup("FightResultFailPopup",{},{anim = false})

    local buy = md:getInstance("BuyModel")
    buy:buy("goldGiftBag", {payDoneFunc = handler(self,self.payDone)})

    --clear
    self:clearFightData() 

    --todo 改在返回大地图
    -- local levelInfo = self.groupId.."-"..self.levelId  
    -- um:failLevel(levelInfo)
end

function Fight:payDone()
    self.inlayModel:equipGoldInlays(false)
    self:relive()
    ui:closePopup("FightResultFailPopup")
end

function Fight:pauseFight(isPause)
    self.isPause = isPause
    self:dispatchEvent({name = Fight.PAUSE_SWITCH_EVENT, 
        isPause = self.isPause})
end

function Fight:isPauseFight()
    return self.isPause
end

function Fight:checkDialog(appearType)
    local dialog = md:getInstance("DialogModel")
    dialog:check(appearType)
end

function Fight:onFinishDialog(appearType)
    if appearType == "forward" then
        self:startFight()
    elseif appearType == "after" then
        self:endFight()
    elseif appearType == "middle" then
        --
    else 
        assert(true, "invalid appearType :"..appearType)
    end
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
        self.hero:doKill()
    end
end

function Fight:relive()
    self.hero:doRelive()
    self.inlay:checkNativeGold()
    self.killRenzhiNum = 0
    self.result = nil
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
    self.fightResult = {}
    self.fightResult["goldNum"]   = self.goldValue
    self.fightResult["hpPercent"] = hpPercent
end

function Fight:getFightResult()
    return self.fightResult
end

return Fight