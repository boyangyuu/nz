local UM = class("UMsdk",cc.mvc.ModelBase)

------ 关卡相关 -------
-- 进入关卡.
-- @param level 关卡
-- @return void
-- cc.UMAnalytics:startLevel("1-2")
function UM:startLevel( level )
	if device.platform ~= "android" or not isAnalytics then
	    return
	end

    -- TalkingData
    TDGAMission:onBegin(level)
end

-- 通过关卡.
-- @param level 关卡,如果level == NULL 则为当前关卡
-- @return void
-- cc.UMAnalytics:finishLevel("1-2")
function UM:finishLevel(level)
    if device.platform ~= "android" or not isAnalytics then
        return
    end

    -- TalkingData
    TDGAMission:onCompleted(level)
end



-- 未通过关卡.
-- @param level 关卡,如果level == NULL 则为当前关卡
-- @return void
-- cc.UMAnalytics:failLevel("1-1")
function UM:failLevel( level, cause)
    if device.platform ~= "android" or not isAnalytics then
        return
    end

    -- TalkingData
    local cause = cause or "其他原因"
    TDGAMission:onFailed(level, cause )
end

------ 支付相关 -------

-- @param cash 真实货币数量
-- @param source 支付渠道
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
function UM:onChargeSuccess(orderid)
    if device.platform ~= "android" or not isAnalytics then
        return
    end    
    TDGAVirtualCurrency:onChargeSuccess(orderid)
end


-- @param cash 真实货币数量
-- @param source 支付渠道
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
function UM:onChargeRequest(orderId, iapId, currencyAmount, currencyType, virtualCurrencyAmount, paymentType)
    if device.platform ~= "android" or not isAnalytics then
        return
    end
    TDGAVirtualCurrency:onChargeRequest(orderId, iapId, currencyAmount, currencyType, virtualCurrencyAmount, paymentType)
end

-------- 道具相关 ------------
-- 玩家使用虚拟币购买道具
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
-- @return void
-- cc.UMAnalytics:use("prop_1", 1, 50)
function UM:use( item,amount,price )
    if device.platform ~= "android" or not isAnalytics then
        return
    end

    -- TalkingData
    TDGAItem:onUse(item, amount)
end

-- 玩家使用虚拟币购买道具
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
-- @return void
-- cc.UMAnalytics:buy("prop_1", 2, 50)
function UM:buy( item,amount,price )
    if device.platform ~= "android" or not isAnalytics then
        return
    end
    -- TalkingData
    TDGAItem:onPurchase(item, amount, price)
end

-- 玩家获虚拟币奖励
-- @param coin 虚拟币数量
-- @param source 奖励方式
-- @return void
-- cc.UMAnalytics:bonusVirtualCurrency(100, 21)
function UM:bonusVirtualCurrency( coin ,source)
    if device.platform ~= "android" or not isAnalytics then
        return
    end

    -- TalkingData
    TDGAVirtualCurrency:onReward(coin, source)

end

-- 玩家获道具奖励
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
-- @param source 奖励方式
-- @return void
-- cc.UMAnalytics:bonusProps("prop_1", 2, 50, 21)
function UM:bonusProps(item, amount, price, source)
    -- if device.platform ~= "android" then
    --     return
    -- end
    --todo td不打点（道具奖励）
    -- -- TalkingData
end

------------ 其他 ----------------

-- 自定义事件,数量统计
-- @param  eventId 网站上注册的事件Id.
-- @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为NULL或空字符串时后台会生成和eventId同名的标签.
-- @return void.
-- cc.UMAnalytics:event("1-1")
function UM:event( eventId, eventData )
    if device.platform ~= "android" or not isAnalytics then
        return
    end

    -- TalkingData todo
    if eventData == nil then
        eventData = {}
    end
    TalkingDataGA:onEvent(eventId, eventData)
end


-- 设置玩家等级
-- @param  levelId 玩家等级
function UM:setLevel( levelId )
    -- body
    if device.platform ~= "android" or not isAnalytics then
        return
    end    
    print("设置玩家等级:",levelId)
    TDGAAccount:setLevel(levelId)
end

function UM:setUserAccount()
    if device.platform ~= "android" or not isAnalytics then
        return
    end    
    --account
    TDGAAccount:setAccount(TalkingDataGA:getDeviceId())
    TDGAAccount:setAccountType(TDGAAccount.KAccountAnonymous)
    
    --level
    local data = getUserData()
    if data.user and data.user.level then 
        local levelId = data.user.level
        TDGAAccount:setLevel(levelId)
    else
        TDGAAccount:setLevel(1)
    end
end

return UM