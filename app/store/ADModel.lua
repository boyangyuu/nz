local ADModel = class("ADModel", cc.mvc.ModelBase)

function ADModel:ctor()
    ADModel.super.ctor(self)
end

function ADModel:watchAD()
    local isAvailable = network.isInternetConnectionAvailable()
    if not isAvailable then
        ui:showPopup("commonPopup",
             {type = "style1",content = LanguageManager.getStringForKey("string_hint347")},
             {opacity = 0})
        return
    end

    local isCanWatch = self:isCanWatch()
    if isCanWatch then
        local args = {
            onWatchADSuccess = handler(self, self.onWatchADSuccess),
            onWatchADFail = handler(self, self.onWatchADFail),
        }
        luaoc.callStaticMethod("AdsmogoControl", "showInterstitialVideo", args)
    else
        ui:showPopup("commonPopup",
         {type = "style1",content = LanguageManager.getStringForKey("string_hint184")},
         {opacity = 0})
    end
end

function ADModel:onWatchADSuccess()
    local userModel = md:getInstance("UserModel")
    --钻石*1
    userModel:addDiamond(1)
    self:addWatchTimes()
    ui:showPopup("commonPopup",
         {type = "style1",content = LanguageManager.getStringForKey("string_hint348")},
         {opacity = 0})
end

function ADModel:onWatchADFail()
    ui:showPopup("commonPopup",
     {type = "style1",content = LanguageManager.getStringForKey("string_hint186")},
     {opacity = 0})
end

function ADModel:isCanWatch()
    local alreadyWatchTimes = self:getWatchTimes()
    if alreadyWatchTimes < 5 then
        return true
    end
    return false
end

function ADModel:addWatchTimes()
    local data = getUserData()
    data.dailyAD.watchTimes = data.dailyAD.watchTimes + 1
    setUserData(data)
end

function ADModel:getWatchTimes()
    local data = getUserData()
    local watchTimes = data.dailyAD.watchTimes
    return watchTimes
end

function ADModel:resetWatchTimes()
    local data = getUserData()
    data.dailyAD.watchTimes = 0
    setUserData(data)
end

return ADModel