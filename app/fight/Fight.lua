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

    --hero
    local id1,id2 = self:getWeaponIds()
     self.hero:refreshData({gunId1 = id1, gunId2 = id2})

    --gun

end

---- 关卡相关 ----
function Fight:getGroupId()
    return self.groupId
end

function Fight:getLevelId()
    return self.levelId
end

---- 枪械相关 ----
function Fight:getWeaponIds()
    local data = getUserData()
    local id1 = data["weapons"]["weaponed"]["bag1"].weaponid
    local id2 = data["weapons"]["weaponed"]["bag2"].weaponid
    return id1, id2
end

function Fight:onHeroDie(event)
    self:setResult(false)
end

function Fight:setResult(isWin)
    --游戏暂停
    print("Fight:setResult(isWin)", isWin)
    if isWin then
        ui:showPopup("FightResultPopup",{})
    else
        ui:showPopup("FightResultFailPopup",{})
    end
end

function Fight:relive()
    self.hero.fsm__:doEvent("relive") --todo
end

return Fight