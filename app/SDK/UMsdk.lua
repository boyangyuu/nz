local UM = class("UMsdk",cc.mvc.ModelBase)


-- 进入关卡.
-- @param level 关卡
-- @return void
-- cc.UMAnalytics:startLevel("1-2")
function UM:startLevel( level )
	if device.platform == "android" then
	    cc.UMAnalytics:startLevel(level)
	end
end

-- 玩家支付货币兑换虚拟币.
-- @param cash 真实货币数量
-- @param source 支付渠道
-- @param coin 虚拟币数量
-- @return void
-- cc.UMAnalytics:payVirtualCurrency(10, 21, 100)
function UM:payVirtualCurrency( cash ,source,coin)
    if device.platform == "android" then
        cc.UMAnalytics:payVirtualCurrency(cash, source, coin)
    end
end

-- 玩家支付货币购买道具.
-- @param cash 真实货币数量
-- @param source 支付渠道
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
-- @return void
-- cc.UMAnalytics:payProps(10, 21, "prop_1", 2, 50)
function UM:payProps( cash,source,item,amount,price )
    if device.platform == "android" then
        cc.UMAnalytics:payProps(cash, source, item, amount, price)
    end
end

-- 玩家使用虚拟币购买道具
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
-- @return void
-- cc.UMAnalytics:use("prop_1", 1, 50)
function UM:use( item,amount,price )
    if device.platform == "android" then
        cc.UMAnalytics:use(item, amount, price)
    end
end

-- 玩家使用虚拟币购买道具
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
-- @return void
-- cc.UMAnalytics:buy("prop_1", 2, 50)
function UM:buy( item,amount,price )
    if device.platform == "android" then
        cc.UMAnalytics:buy(item, amount, price)
    end
end

-- 玩家获虚拟币奖励
-- @param coin 虚拟币数量
-- @param source 奖励方式
-- @return void
-- cc.UMAnalytics:bonusVirtualCurrency(100, 21)

function UM:bonusVirtualCurrency( coin ,source)
    if device.platform == "android" then
        -- cc.UMAnalytics:bonusVirtualCurrency(coin, source)
    end
end

-- 玩家获道具奖励
-- @param item 道具名称
-- @param amount 道具数量
-- @param price 道具单价
-- @param source 奖励方式
-- @return void
-- cc.UMAnalytics:bonusProps("prop_1", 2, 50, 21)
function UM:bonusProps(item, amount, price, source)
    if device.platform == "android" then
        cc.UMAnalytics:bonusProps(item, amount, price, source)
    end
end

-- 自定义事件,数量统计
-- @param  eventId 网站上注册的事件Id.
-- @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为NULL或空字符串时后台会生成和eventId同名的标签.
-- @return void.
-- cc.UMAnalytics:event("1-1")
function UM:event( eventId )
    if device.platform == "android" then
        cc.UMAnalytics:event(eventId)
    end
end


-- 通过关卡.
-- @param level 关卡,如果level == NULL 则为当前关卡
-- @return void
-- cc.UMAnalytics:finishLevel("1-2")
function UM:finishLevel(level)
    if device.platform == "android" then
        cc.UMAnalytics:finishLevel(level)
    end
end



-- 未通过关卡.
-- @param level 关卡,如果level == NULL 则为当前关卡
-- @return void
-- cc.UMAnalytics:failLevel("1-1")
function UM:failLevel( level )
    if device.platform == "android" then
        cc.UMAnalytics:failLevel(level)
    end
end

return UM