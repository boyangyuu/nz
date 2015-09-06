local ActiveCodeConfig = class("ActiveCodeConfig", cc.mvc.ModelBase)

local configs = {}

-- 渠道活动包（又 4399新手）ABC
configs["qudao"] = {
	{lei = 10},
	{silverweapon = 5},
	{money = 18888},
}

--  五星好评礼包 D
configs["wuxing"] = {
	{lei = 20},
	{healthBag = 5},
	{money = 50000},
	{silverweapon = 5},
}

-- 特权包 E
configs["tequan"] = {
	{lei = 20},
	{healthBag = 5},
	{money = 50000},
	{silverweapon = 5},
}

-- 独家包 F
configs["dujia"] = {
	{lei = 20},
	{healthBag = 5},
	{money = 88888},
	{silverweapon = 10},
}

-- 补偿性 宝石120 H
configs["diamond120"] = {
	{diamond = 120},
}

-- 补偿性 宝石260 I
configs["diamond260"] = {
	{diamond = 260},
}

-- 补偿性 宝石450 J
configs["diamond450"] = {
	{diamond = 450},
}

-- 补偿性 宝石1200 G
configs["diamond1200"] = {
	{diamond = 1200},
}

function ActiveCodeConfig.getConfig(type)
	local dailyTable = configs[type]
	return dailyTable
end

return ActiveCodeConfig