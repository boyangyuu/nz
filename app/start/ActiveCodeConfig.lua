local ActiveCodeConfig = class("ActiveCodeConfig", cc.mvc.ModelBase)

local configs = {}


--  五星好评礼包
configs["wuxing"] = {
	{lei = 20},
	{healthBag = 5},
	{money = 50000},
	{silverweapon = 5}, 
}

-- 渠道活动包
configs["qudao"] = {
	{lei = 10},
	{silverweapon = 5},
	{money = 18888},
}

-- 补偿性 宝石120
configs["diamond120"] = {
	{diamond = 120},
}

-- 补偿性 宝石260
configs["diamond260"] = {
	{diamond = 260},
}

-- 补偿性 宝石450
configs["diamond450"] = {
	{diamond = 450},
}

function ActiveCodeConfig.getConfig(type)
	local dailyTable = configs[type]
	return dailyTable
end

return ActiveCodeConfig