local DailyLoginConfig = class("DailyLoginConfig", cc.mvc.ModelBase)

local configs = {}

award = {	
	{time = 60 * 1, money = 500},
	{time = 60 * 2, money = 1500},
	{time = 60 * 4, money = 3000},
	{time = 60 * 8, money = 5000},
	{time = 60 * 16, money = 20000},
	{time = 60 * 30, money = 50000},
}

function DailyLoginConfig.getConfig(id)
	local config = award[id]
	return config
end

function DailyLoginConfig.getAwardNum()
	local num = #award
	return num
end

return DailyLoginConfig