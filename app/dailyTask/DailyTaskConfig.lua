local DailyTaskConfig = class("DailyTaskConfig", cc.mvc.ModelBase)

local configs = {}

configs = {
	{	
		index = "buyTimes1",
		type  = "buyTimes",
		limit = 100,
		awardValue= 10,
		awardType = "diamond",
		str = "使用100宝石",
	},
	{	
		index = "buyTimes2",
		type  = "buyTimes",
		limit = 200,
		awardValue= 20,
		awardType = "diamond",	
		str = "使用200宝石",	
	},
	{
		index = "buyTimes3",
		type  = "buyTimes",
		limit = 300,
		awardValue= 30,
		awardType = "diamond",
		str = "使用300宝石",
	},		
	{
		index = "keepKill1",
		type  = "keepKill",
		limit = 10,
		awardValue= 1000,
		awardType = "coin",
		str = "10连杀",
	},
	{	
		index = "keepKill2",
		type  = "keepKill",
		limit = 30,
		awardValue= 2000,
		awardType = "coin",	
		str = "30连杀",	
	},
	{
		index = "keepKill3",
		type  = "keepKill",
		limit = 50,
		awardValue= 3000,
		awardType = "coin",
		str = "50连杀",
	},		
	{
		index = "totalKill1",
		type  = "totalKill",
		limit = 500,
		awardValue= 5000,
		awardType = "coin",
		str  = "500杀敌",
	},
	{
		index = "totalKill2",
		type  = "totalKill",
		limit = 1000,
		awardValue= 10000,
		awardType = "coin",
		str  = "1000杀敌",	
	},
	{	
		index = "fight_xianShi1",
		type  = "fight_xianShi",
		limit = 1,
		awardValue= 5,
		awardType = "diamond",
		str = "完成限时模式1次",
	},	
	{
		index = "fight_renZhi1",
		type  = "fight_renZhi",
		limit = 1,
		awardValue= 5,
		awardType = "diamond",
		str = "完成人质模式1次",
	},
	{
		index = "fight_taoFan1",
		type  = "fight_taoFan",
		limit = 1,
		awardValue= 5,
		awardType = "diamond",
		str = "完成逃犯模式1次",
	},
	{
		index = "fight_puTong1",
		type  = "fight_puTong",
		limit = 1,
		awardValue= 5,
		awardType = "diamond",
		str = "完成杀戮模式1次",
	},			
}
--[[
	{	
		--user
		curValue = 0, 	

		type  = "fight_puTong",
		limit = 1,
		awardValue= 30,
		awardType = "diamond",
		str = "杀戮模式1次",
	},	
]]

function DailyTaskConfig.getConfigs()
	return configs
end

function DailyTaskConfig.getConfig(index)
	for i,v in ipairs(configs) do
		if v["index"] == index then 
			return v 
		end

	end
	assert(false, "index is invalid"..index)
end

return DailyTaskConfig