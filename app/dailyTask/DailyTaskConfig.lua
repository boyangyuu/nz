--[[*配置活动奖励说明文档
 * ui中会涉及到排序操作， 目前取index字段中最后两个字符 降序排列
 * 此排序方法有待优化，
 * 配置此表相关人员注意index使用。
 *
 */]]


local DailyTaskConfig = class("DailyTaskConfig", cc.mvc.ModelBase)

local configs = {}

configs = {
	{
		index = "buyTimes10",
		type  = "buyTimes",
		limit = 100,
		awardValue= 10,
		awardType = "diamond",
		str = string.format(LanguageManager.getStringForKey("string_hint53"),100),
	},
	{
		index = "buyTimes11",
		type  = "buyTimes",
		limit = 200,
		awardValue= 20,
		awardType = "diamond",
		str = string.format(LanguageManager.getStringForKey("string_hint53"),200),
	},
	{
		index = "buyTimes12",
		type  = "buyTimes",
		limit = 300,
		awardValue= 30,
		awardType = "diamond",
		str = string.format(LanguageManager.getStringForKey("string_hint53"),300),
	},
	{
		index = "keepKill01",
		type  = "keepKill",
		limit = 10,
		awardValue= 1000,
		awardType = "coin",
		str = string.format(LanguageManager.getStringForKey("string_hint54"),10),
	},
	{
		index = "keepKill02",
		type  = "keepKill",
		limit = 30,
		awardValue= 2000,
		awardType = "coin",
		str = string.format(LanguageManager.getStringForKey("string_hint54"),30),
	},
	{
		index = "keepKill03",
		type  = "keepKill",
		limit = 50,
		awardValue= 3000,
		awardType = "coin",
		str = string.format(LanguageManager.getStringForKey("string_hint54"),50),
	},
	{
		index = "keepKill05",
		type  = "keepKill",
		limit = 100,
		awardValue= 6000,
		awardType = "coin",
		str = string.format(LanguageManager.getStringForKey("string_hint54"),100),
	},
	{
		index = "totalKill04",
		type  = "totalKill",
		limit = 500,
		awardValue= 5000,
		awardType = "coin",
		str  = string.format(LanguageManager.getStringForKey("string_hint42"),500),
	},
	{
		index = "totalKill06",
		type  = "totalKill",
		limit = 1000,
		awardValue= 10000,
		awardType = "coin",
		str  = string.format(LanguageManager.getStringForKey("string_hint42"),1000),
	},
	{
		index = "totalKill07",
		type  = "totalKill",
		limit = 2000,
		awardValue= 20000,
		awardType = "coin",
		str  = string.format(LanguageManager.getStringForKey("string_hint42"),2000),
	},
	{
		index = "totalKill08",
		type  = "totalKill",
		limit = 3000,
		awardValue= 30000,
		awardType = "coin",
		str  = string.format(LanguageManager.getStringForKey("string_hint42"),3000),
	},
	{
		index = "fight_xianShi09",
		type  = "fight_xianShi",
		limit = 1,
		awardValue= 5,
		awardType = "diamond",
		str = LanguageManager.getStringForKey("string_hint55"),
	},
	{
		index = "fight_renZhi09",
		type  = "fight_renZhi",
		limit = 1,
		awardValue= 5,
		awardType = "diamond",
		str = LanguageManager.getStringForKey("string_hint56"),
	},
	{
		index = "fight_taoFan09",
		type  = "fight_taoFan",
		limit = 1,
		awardValue= 5,
		awardType = "diamond",
		str = LanguageManager.getStringForKey("string_hint57"),
	},
	{
		index = "fight_puTong09",
		type  = "fight_puTong",
		limit = 1,
		awardValue= 5,
		awardType = "diamond",
		str = LanguageManager.getStringForKey("string_hint58"),
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