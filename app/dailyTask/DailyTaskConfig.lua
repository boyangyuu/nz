local DailyLoginConfig = class("DailyLoginConfig", cc.mvc.ModelBase)

local configs = {}

configs[1] = {
	{
		type  = "buyTimes",
		limit = 1,
		awardValue= 10,
		awardType = "diamond",
	},
	{
		type  = "buyTimes",
		limit = 2,
		awardValue= 20,
		awardType = "diamond",		
	},
	{
		type  = "buyTimes",
		limit = 3,
		awardValue= 30,
		awardType = "diamond",
	},		
}

configs[2] = {
	{
		type  = "keepKill",
		limit = 1,
		awardValue= 10,
		awardType = "diamond",
	},
	{
		type  = "keepKill",
		limit = 1,
		awardValue= 20,
		awardType = "diamond",		
	},
	{
		type  = "keepKill",
		limit = 1,
		awardValue= 30,
		awardType = "diamond",
	},		
	{
		type  = "totalKill",
		limit = 1,
		awardValue= 10,
		awardType = "diamond",
	},
	{
		type  = "totalKill",
		limit = 1,
		awardValue= 20,
		awardType = "diamond",		
	},
	{
		type  = "totalKill",
		limit = 1,
		awardValue= 30,
		awardType = "diamond",
	},	
}

configs[3] = {
	type = "fight_taoFan",
	number = 5000,
}


function DailyLoginConfig.getConfig(dailyID)
	local dailyTable = configs["day"..dailyID]
	return dailyTable
end

return DailyLoginConfig