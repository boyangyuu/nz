--[[
	备注：1. id不能重复

]]

local GuideConfigs = class("GuideConfigs", cc.mvc.ModelBase)

local configs = {}

--[[
	skipMode: {
				condition, : 条件判断 外界指定doGuideNext
		   		clickScreen,:点击屏幕跳过
		   		auto		:时间到了自动跳过
		   		默认： 点击指定区域跳过
	}

	skipDelay: {
				skipDelay = 1.0 代表引导层消失1.0秒, 且可以移动
	}
	touchType： {
				all = 接受所有事件

	}
	skipMode;  {
				condition = 满足条件才能跳过
				clickScreen = 点击屏幕任意一点跳过
	}
]]

----第0关 移动----
configs["fight01_move"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_move", msg = "", hand = "move",rolepos = "hide"},
	}
}

--第0关 开火
configs["fight01_fire"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_fire", msg = LanguageManager.getStringForKey("string_hint305"), skipDelay = 2.0,rolepos = "left"},
		{id = "fight_lei", msg = LanguageManager.getStringForKey("string_hint306")},
	}
}

configs["fight01_skill"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_fusillade", msg = LanguageManager.getStringForKey("string_hint343"), skipDelay = 3.0,rolepos = "left"},
		{id = "fight_skill", msg = LanguageManager.getStringForKey("string_hint307")},
	}
}

---- 第0关 黄金枪----
configs["fight01_gold"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_gold", msg = LanguageManager.getStringForKey("string_hint308")},
	}
}

--- 第0关毁灭者之后 ----
configs["fight01_jijia"] = {
	preGuideId = nil,
	steps = {
		--毁灭者掉剩下10% 血 机甲开
		{id = "fight01_jijia", msg = LanguageManager.getStringForKey("string_hint309")},
	}
}

-- ---- 第0关结算之后 ----
configs["afterfight01"] = {
	preGuideId = nil,
	steps = {
		{id = "afterfight01_jixu", msg = LanguageManager.getStringForKey("string_hint310")},
	}
}

---- 第1-1关 引导换枪 ----
configs["fight_change"] = {
	preGuideId = "fight01_jijia",
	steps = {
		{id = "fight_change", msg = LanguageManager.getStringForKey("string_hint311")},
	}
}

---- 第1-1关 引导开盾 ----
configs["fight_dun"] = {
	preGuideId = "fight_change",
	steps = {
		{id = "fight_dun", msg = LanguageManager.getStringForKey("string_hint312")},
	}
}

---- 开启第2关之后  ----
configs["xiangqian"] = {
	preGuideId = "afterfight01",
	steps = {
		--进装备页面  一套青铜
		{id = "xiangqian_xiangqian", msg = LanguageManager.getStringForKey("string_hint313")},
		{id = "xiangqian_xiangqian1", msg = LanguageManager.getStringForKey("string_hint314"), rolepos = "right"},
		{id = "xiangqian_xiangqian2", msg = LanguageManager.getStringForKey("string_hint315"),},
		{id = "xiangqian_xiangqian3", msg = LanguageManager.getStringForKey("string_hint316"), },
		{id = "xiangqian_xiangqian4", msg = LanguageManager.getStringForKey("string_hint317"), },
		{id = "xiangqian_xiangqian5", msg = LanguageManager.getStringForKey("string_hint318"), rolepos = "right", skipMode = "clickScreen" },
		{id = "xiangqian_back", msg = LanguageManager.getStringForKey("string_hint319")},
		{id = "xiangqian_nextLevel", msg = LanguageManager.getStringForKey("string_hint320"), rolepos = "right",  contentOffset = {x = 0, y = -100},},
	}
}

--- 开启第3关之后 ----
configs["weapon"] = {
	preGuideId = "xiangqian",
	steps = {
		{id = "weapon_wuqiku", msg = LanguageManager.getStringForKey("string_hint321"), },
		{id = "weapon_shengji1",contentOffset = {x = 100, y = 0}, msg = LanguageManager.getStringForKey("string_hint322"), rolepos = "right"},
		{id = "weapon_shengji2", msg = LanguageManager.getStringForKey("string_hint323"), skipDelay = 2.0},
		{id = "weapon_shengji3", msg = LanguageManager.getStringForKey("string_hint324"), skipMode = "clickScreen"},
		{id = "weapon_back", msg = LanguageManager.getStringForKey("string_hint325"),rolepos = "right", },
		{id = "weapon_nextlevel", msg = LanguageManager.getStringForKey("string_hint326"), rolepos = "right", contentOffset = {x = 0, y = -200}},
		{id = "weapon_enter", contentOffset = {x = -100, y = 0}, msg = LanguageManager.getStringForKey("string_hint327"), },
	}
}

configs["afterfight03"] = {
	preGuideId = "weapon",
	steps = {
		-- {id = "afterfight03_inlay", msg = "点击按钮，装备道具" },
		{id = "afterfight03_next", msg = LanguageManager.getStringForKey("string_hint328") },
	}
}

---- 第四关战斗开始之后 ----
configs["fightJu"] = {
	preGuideId = nil,
	steps = {
		{id = "fightJu_open",contentOffset = {x = 0, y = -220}, msg = LanguageManager.getStringForKey("string_hint329"), rolepos = "right"},
		{id = "fightJu_fire",contentOffset = {x = 0, y = -220}, msg = LanguageManager.getStringForKey("string_hint330"), opacity = 0.0 },
		{id = "fightJu_close",contentOffset = {x = 0, y = -220}, msg = LanguageManager.getStringForKey("string_hint331"), opacity = 0.0},
		{id = "fightJu_finish", msg = LanguageManager.getStringForKey("string_hint332"), skipMode = "clickScreen", opacity = 0.0},
	}
}

configs["fightRelive"] = {
	preGuideId = nil,
	steps = {
		{id = "fightRelive_relive", msg = LanguageManager.getStringForKey("string_hint333"), },
	}

}

function GuideConfigs.getConfig(groupId)
	assert(configs[groupId], "configs is nil groupId: "..groupId )
	return configs[groupId]
end

return GuideConfigs