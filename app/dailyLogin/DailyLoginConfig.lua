local DailyLoginConfig = class("DailyLoginConfig", cc.mvc.ModelBase)

local configs = {}

configs["day1"] = {
	type = "gold",
	number = 1000,
}

configs["day2"] = {
	type = "lei",
	number = 10,
}

configs["day3"] = {
	type = "gold",
	number = 5000
}

configs["day4"] = {
	type = "jijia",
	number = 1,
}

configs["day5"] = {
	type = "goldweapon",
	number = 1,
}

configs["day6"] = {
	type = "lei",
	number = 10,
}

configs["day7"] = {
	type = "gold",
	number = 10000,
}

function DailyLoginConfig.getConfig(dailyID)
	local dailyTable = configs["day"..dailyID]
	return dailyTable
end

return DailyLoginConfig