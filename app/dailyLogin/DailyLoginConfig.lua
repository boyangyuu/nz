local DailyLoginConfig = class("DailyLoginConfig", cc.mvc.ModelBase)

local configs = {}

configs["day1"] = {
	type = "gold",
	number = 3000,
}

configs["day2"] = {
	type = "lei",
	number = 20,
}

configs["day3"] = {
	type = "jijia",
	number = 1,
}

configs["day4"] = {
	type = "gold",
	number = 5000
}

configs["day5"] = {
	type = "suipian",
	id = 4,
}

configs["day6"] = {
	type = "lei",
	number = 20,
}

configs["day7"] = {
	type = "gun",
	id = 4,
}

function DailyLoginConfig.getConfig(dailyID)
	local dailyTable = configs["day"..dailyID]
	return dailyTable
end

return DailyLoginConfig