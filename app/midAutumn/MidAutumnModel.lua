local MidAutumnModel = class("MidAutumnModel", cc.mvc.ModelBase)
local MidAutumnConfigs = import(".MidAutumnConfigs")

MidAutumnModel.REFRESH_MOONCAKE_EVENT = "REFRESH_MOONCAKE_EVENT"

function MidAutumnModel:ctor(properties)
    MidAutumnModel.super.ctor(self,properties)
end

function MidAutumnModel:isCanPlay()
    local playTimes = self:getMidAutTimes()
    if self.couldPlayTime == nil then self.couldPlayTime = 10 end
    if playTimes < self.couldPlayTime then
        return true
    else
        return false
    end
end

function MidAutumnModel:onRequestEvent(event)
    local name = event.name
    local request = event.request
    -- if request == nil then return end
    if name ~= "completed" then
        print("网络请求中", request:getErrorCode()..request:getErrorMessage())
        return
    end

    local code = request:getResponseStatusCode()
    if code ~= 200 then
        print("网络请求失败", code)
    else
        print("网络请求成功", code)
        self.couldPlayTime = request:getResponseString()
        self.couldPlayTime = tonumber(self.couldPlayTime)
        dump(self.couldPlayTime,"couldPlayTimecouldPlayTimecouldPlayTime")
        -- if appStoreState == "open" then
        --     self.btn_activate:setVisible(true)
        -- else
        --     self.btn_activate:setVisible(false)
        -- end
    end
end

function MidAutumnModel:addMidAutTimes()
    local data = getUserData()
    data.midAutumn.playTimes = data.midAutumn.playTimes + 1
    setUserData(data)
end

function MidAutumnModel:getMidAutTimes()
    local data = getUserData()
    local playTimes = data.midAutumn.playTimes
    return playTimes
end

function MidAutumnModel:resetMidAutTimes()
    local data = getUserData()
    data.midAutumn.playTimes = 0
    setUserData(data)
end

function MidAutumnModel:getCouldPlayTimes()
    if device.platform == "ios" then
        local url = "http://123.57.213.26/midautumnios.php"
    else
        local url = "http://123.57.213.26/midautumn.php"
    end
    local request = network.createHTTPRequest(handler(self,self.onRequestEvent), url, "GET")
    request:start()
end

function MidAutumnModel:addMoonCakeNum(moonCakeNum)
    local data = getUserData()
    data.moonCake = data.moonCake + moonCakeNum
    setUserData(data)
    self:dispatchEvent({name = "REFRESH_MOONCAKE_EVENT"})
end

function MidAutumnModel:getAlreadyNum()
    local data = getUserData()
    return data.moonCake
end

function MidAutumnModel:costMoonCake(needMoonCakeNum)
    local data = getUserData()
    if data.moonCake >= needMoonCakeNum then
        data.moonCake = data.moonCake - needMoonCakeNum
        setUserData(data)
        ui:showPopup("commonPopup",
                 {type = "style2", content = "兑换成功！"},
                 {opacity = 155})
        self:dispatchEvent({name = "REFRESH_MOONCAKE_EVENT"})
        return true
    else
        ui:showPopup("commonPopup",
                 {type = "style2", content = "您的月饼不够喔，请去战斗吧！"},
                 {opacity = 155})
        return false
    end
end

function MidAutumnModel:exchangeMoonCake(changeType)
    local propModel = md:getInstance("PropModel")
    if changeType == "jijia" then
        local isAfforded = self:costMoonCake(10)
        if isAfforded then
            propModel:addProp("jijia",1)
        end
    elseif changeType == "goldWeapon" then
        local isAfforded = self:costMoonCake(10)
        if isAfforded then
            local inlayModel = md:getInstance("InlayModel")
            inlayModel:buyGoldsInlay(1)
        end
    elseif changeType == "hpBag" then
        local isAfforded = self:costMoonCake(10)
        if isAfforded then
            propModel:addProp("hpBag",2)
        end
    end
end

function MidAutumnModel:getInfo(levelIndex)
    if levelIndex == nil then levelIndex = 1 end
    local midAutumnConfig = MidAutumnConfigs.getConfig(levelIndex)
    return midAutumnConfig
end

return MidAutumnModel