local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“战斗”的实体

]]

--import
local Fight = class("Fight", cc.mvc.ModelBase)

--events
Fight.PAUSE_SWITCH_EVENT = "PAUSE_SWITCH_EVENT"
Fight.CONTROL_HIDE_EVENT = "CONTROL_HIDE_EVENT"
Fight.CONTROL_SHOW_EVENT = "CONTROL_SHOW_EVENT"
Fight.RESULT_WIN_EVENT   = "RESULT_WIN_EVENT"
Fight.RESULT_FAIL_EVENT  = "RESULT_FAIL_EVENT"

function Fight:ctor(properties)
    Fight.super.ctor(self, properties)
end

function Fight:refreshData(properties)
    --init inatance

    self.hero = md:getInstance("Hero")  --todo改为refreash Instance
    self.inlay = md:getInstance("FightInlay")
    self.inlayModel = md:getInstance("InlayModel")
    self.userModel = md:getInstance("UserModel")

    --关卡
    self.groupId = properties.groupId
    self.levelId = properties.levelId
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

function Fight:setResult(isWin)
    --游戏暂停
    print("Fight:setResult(isWin)", isWin)
    if isWin then
        self.userModel:levelPass(self.groupId,self.levelId)
        self.inlayModel:removeAllInlay()
        ui:showPopup("FightResultPopup",{},{anim = false})
    else
        self.inlayModel:removeAllInlay()
        ui:showPopup("FightResultFailPopup",{},{anim = false})
    end

    self:clearFightData()
end

function Fight:relive()
    self.hero.fsm__:doEvent("relive") --todo
end

function Fight:clearFightData()
    md:deleteInstance("Hero")
    md:deleteInstance("FightInlay")  
    md:deleteInstance("Defence")  
end

return Fight