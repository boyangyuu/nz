local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“战斗”的实体

]]

--import
local Hero          = import(".Hero")
local Actor         = import(".Actor")
local Fight = class("Fight", cc.mvc.ModelBase)

--events
Fight.PAUSE_SWITCH_EVENT = "PAUSE_SWITCH_EVENT"


function Fight:ctor(properties)
    Fight.super.ctor(self, properties)
end

function Fight:refreshData(properties)
    --inatance
    self.hero = app:getInstance(Hero) 

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
        ui:showPopup("FightResultPopup",{},{anim = false})
    else
        ui:showPopup("FightResultFailPopup",{},{anim = false})
    end

    self:clearFightData()
end

function Fight:relive()
    self.hero.fsm__:doEvent("relive") --todo
end

function Fight:clearFightData()
    app:deleteInstance(Hero)
end

return Fight