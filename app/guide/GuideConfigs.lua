local GuideConfigs = class("GuideConfigs", cc.mvc.ModelBase)

local configs = {}

--[[
	skipMode: { condition, : 条件判断 外界指定doGuideNext
		   		clickScreen,:点击屏幕跳过
		   		auto		:时间到了自动跳过
		   		默认： 点击指定区域跳过 }
]]

configs["fight01"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_blood", msg = "这是生命值 , 生命耗尽后游戏失败", }, 
		{id = "fight_move", msg = "在屏幕上左右滑动可以移动准星",touchType = "all", skipMode = "condition", hand = "move"},
		{id = "fight_fire1", msg = "在高亮区域点击 , 枪械将会射击", skipDelay = 1.0},
		{id = "fight_fire2", msg = "长按会连续射击 , 请长按1.0秒",touchType = "all", skipMode = "condition", 
				hand = "longtouch",opacity = 0.0, contentOffset = {x = 0, y = 100}},
		{id = "fight_throw", msg = "在高亮区域点击 , 将会投掷手雷", skipDelay = 1.0},
		{id = "fight_change", msg = "在高亮区域点击 , 将会更换枪械", skipDelay = 1.0},
		{id = "fight_finish", msg = "消灭剩下来的敌人", skipMode = "clickScreen", opacity = 0.0},
	}
}

configs["afterfight01"] = {
	preGuideId = "fight01",
	steps = {
		{id = "afterfight01_jixu", msg = "点击按钮回到大地图", }, 
		{id = "afterfight01_wuqiku", msg = "点击按钮进入武器界面", }, 
		{id = "afterfight01_wuqiku", msg = "点击按钮进入武器界面", }, 
	}
}

configs["fight02"] = {
	preGuideId = "afterfight01",
	steps = {
		{id = "fight_blood", msg = "这是生命值 , 生命耗尽后游戏失败", }, 
	}
}

function GuideConfigs.getConfig(groupId)
	assert(configs[groupId] , "configs is nil groupId: "..groupId )
	return configs[groupId]
end

return GuideConfigs