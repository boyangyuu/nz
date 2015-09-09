local ADModel = class("ADModel", cc.mvc.ModelBase)

function ADModel:ctor()
    ADModel.super.ctor(self)
end

function ADModel:watchAD()
    local isAvailable = network.isInternetConnectionAvailable()
    if not isAvailable then
        ui:showPopup("commonPopup",
             {type = "style1",content = "网络连接异常，请检查网络！"},
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
         {type = "style1",content = "今天没有可以观看的视频了喔，明天再试"},
         {opacity = 0})
    end
end

function ADModel:onWatchADSuccess()
    local inlayModel = md:getInstance("InlayModel")
    --黄武*1
    inlayModel:buyGoldsInlay(1)
    self:addWatchTimes()
    ui:showPopup("commonPopup",
         {type = "style1",content = "恭喜您获得黄金武器1套！"},
         {opacity = 0})
end

function ADModel:onWatchADFail()
    ui:showPopup("commonPopup",
     {type = "style1",content = "观看视频失败，请重新尝试。"},
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