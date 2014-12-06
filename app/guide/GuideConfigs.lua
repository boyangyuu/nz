local GuideConfigs = class("GuideConfigs", cc.mvc.ModelBase)

local configs = {}

--[[
	mode: {auto, click, wait}
]]

configs["fight"] = {
	steps = {
		{id = "fight_blood", msg = "这是生命值,生命耗尽后游戏失败",
			 mode = "click"}, 
		{id = "fight_move", msg = "在屏幕上左右滑动可以移动准星"},
		{id = "fight_fire", msg = "在高亮区域点击,枪械将会射击, 长按会连续射击"},
		{id = "fight_throw", msg = "在高亮区域点击,将会投掷手雷"},
		{id = "fight_change", msg = "在高亮区域点击,将会更换枪械"},
		{id = "fight_finish", msg = "消灭剩下来的敌人"},
	}
}

function GuideConfigs.getConfig(groupId)
	assert(configs[groupId] , "configs is nil groupId: "..groupId )
	return configs[groupId]
end

return GuideConfigs