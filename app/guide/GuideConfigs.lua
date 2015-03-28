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
		{id = "fight_fire", msg = "点击按钮，开火射击！", skipDelay = 2.0,rolepos = "left"},
		{id = "fight_lei", msg = "在高亮区域点击，将会投掷手雷"},
	}
}


---- 第0关 黄金枪----
configs["fight01_gold"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_gold", msg = "敌人越来越多，快使用黄金武器 ! "},
	}
}

--- 第0关毁灭者之后 ----
configs["fight01_jijia"] = {
	preGuideId = nil,
	steps = {
		--毁灭者掉剩下10% 血 机甲开
		{id = "fight01_jijia", msg = "开启无敌机甲和毁灭者决一死战！！", }, 
	}
}

-- ---- 第0关结算之后 ----
configs["afterfight01"] = {
	preGuideId = nil,
	steps = {
		{id = "afterfight01_jixu", msg = "点击按钮，进入下一关"}, 
	}
}

---- 第1-1关 引导换枪 ----
configs["fight_change"] = {
	preGuideId = "fight01_jijia",
	steps = {
		{id = "fight_change", msg = "在高亮区域点击，将会更换武器！"}, 
	}
}

---- 第1-1关 引导开盾 ----
configs["fight_dun"] = {
	preGuideId = "fight_change",
	steps = {
		{id = "fight_dun", msg = "使用盾牌可以抵挡大量伤害！"}, 
	}
}

---- 开启第2关之后  ----
configs["xiangqian"] = {
	preGuideId = "afterfight01",
	steps = {
		--进镶嵌页面  一套青铜 
		{id = "xiangqian_xiangqian", msg = "点击按钮进入镶嵌界面", }, 
		{id = "xiangqian_xiangqian1", msg = "点击左侧按钮选择镶嵌属性", rolepos = "right"}, 
		{id = "xiangqian_xiangqian2", msg = "点击购买",},
		{id = "xiangqian_xiangqian3", msg = "点击装备", },
		{id = "xiangqian_xiangqian4", msg = "也可点击快速镶嵌，镶嵌背包内最好的道具", },
		{id = "xiangqian_xiangqian5", msg = "镶嵌是消耗性道具哦！", rolepos = "right", skipMode = "clickScreen" },
		{id = "xiangqian_back", msg = "点击按钮返回大地图", },		
		{id = "xiangqian_nextLevel", msg = "点击按钮进入下一关",  contentOffset = {x = 0, y = 0},},		
	}
}

--- 开启第3关之后 ----
configs["weapon"] = {
	preGuideId = "xiangqian",
	steps = {
		{id = "weapon_wuqiku", msg = "点击按钮进入武器界面", }, 
		{id = "weapon_shengji1",contentOffset = {x = 100, y = 0}, msg = "点击左侧MP5", rolepos = "right"}, 
		{id = "weapon_shengji2", msg = "点击右侧升级按钮", skipDelay = 2.0},
		{id = "weapon_shengji3", msg = "恭喜杰哥 ， 升级成功！ ", skipMode = "clickScreen"},
		{id = "weapon_back", msg = "点击按钮返回大地图",rolepos = "right", },		
		{id = "weapon_nextlevel", msg = "点击关卡按钮进入下一关", rolepos = "left", contentOffset = {x = 0, y = -100}},			
		{id = "weapon_enter", contentOffset = {x = -100, y = 0}, msg = "点击开始游戏按钮，开始战斗！", },
	}
}

configs["afterfight03"] = {
	preGuideId = "weapon",
	steps = {
		{id = "afterfight03_inlay", msg = "点击按钮，镶嵌道具" },
		{id = "afterfight03_next", msg = "点击按钮，进入下一关" },		
	}
}

---- 第四关战斗开始之后 ----
configs["fightJu"] = {
	preGuideId = nil,
	steps = {
		{id = "fightJu_open", msg = "         点击开镜", }, 
		{id = "fightJu_fire", msg = "         点击开火", }, 
		{id = "fightJu_close", msg = "         点击关镜", }, 
		{id = "fightJu_finish", msg = "消灭剩下来的敌人", skipMode = "clickScreen", opacity = 0.0},
	}	
}

configs["fightRelive"] = {
	preGuideId = nil,
	steps = {
		{id = "fightRelive_relive", msg = "失败不要怕，信春哥，满状态复活！！", }, 
	}		

}

function GuideConfigs.getConfig(groupId)
	assert(configs[groupId], "configs is nil groupId: "..groupId )
	return configs[groupId]
end

return GuideConfigs