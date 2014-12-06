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
		{id = "fight_move", msg = "在屏幕上左右滑动可以移动准星"},		
	}
}

function GuideConfigs.getConfig(groupId)
	assert(configs[groupId] , "configs is nil groupId: "..groupId )
	return configs[groupId]
end

return GuideConfigs