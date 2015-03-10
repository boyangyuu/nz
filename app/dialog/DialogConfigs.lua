local DialogConfigs = class("DialogConfigs", cc.mvc.ModelBase)

local kDialogConfig = {}
kDialogConfig["group0"] = {
	level0 = {
		award = {
			{role = "安琪儿",imgname = "role_anqi", msg = "敌人越来越多! 阿杰快坚持不住了! ", pos = "right"},
			{role = "夜玫瑰", imgname = "role_yemeigui", msg = "算了, 看你是新手的份上, 把我的枪借你一用!", pos = "left"},
			{role = "杰",imgname = "role_jie", msg = "多谢!", pos = "left"},
		},	

		after = {
			{role = "安琪儿",imgname = "role_anqi", msg = "好厉害啊!! 你开加特林的姿势真的真的好帅啊!! ", pos = "right"},		
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "废话, 谁开加特林都帅", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "阿杰, 想买这把酷酷的武器的话, 到武器商城就有卖哦!!", pos = "right"},		
		},			
	},
}

kDialogConfig["group1"]  = {
	level1 = {
		forward = {
			{role = "安琪儿", imgname = "role_anqi",msg = "杰,敌人的弱点在头部,爆头会造成三倍伤害！", pos = "right"},
			{role = "夜玫瑰", imgname = "role_yemeigui", msg = "优先击杀红衣手雷兵,他造成的伤害更高！", pos = "left"},
			{role = "杰",imgname = "role_jie", msg = "了解，看我黄金爆头！！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "加油，不要辱没了我们龙组的威名！", pos = "right"},
		},

	},
	level2 = {
		forward = {
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "所有敌人都有弱点,只是位置不同！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "伞兵的弱点在伞上！", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "手雷也是可以打掉的哦！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "哈哈,全记住了,就是优先打弱点！", pos = "left"},		
		},

		after = {
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "进步神速啊！以后敌人的弱点就靠你自己发现了", pos = "left"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "战斗结束后会奖励大量镶嵌道具！不用吝惜使用哦！！", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "装备镶嵌道具能大幅提升战斗力！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "太好了,我这就去镶嵌一下！", pos = "left"},
		},	
	},
	level3 = {
		forward = {
			{role = "杰",imgname = "role_jie", msg = "哈哈,镶嵌之后强力了好多哦！", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "高防御的近战兵会冲在最前面,他们身后藏着的手雷兵才是更大的威胁！！", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "优先击杀后面的红衣手雷兵,他造成的伤害更高！", pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "永远记住击杀敌人的顺序很重要！！", pos = "left"},
		},
	},
	level3_1 = {
		forward = {
			{role = "鬼眼",imgname = "role_guiyan", msg = "将敌人抵挡在基地外", pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "杰，占据制高点，使用狙击枪秒杀他们！",pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "哈哈，用狙击枪还是看我的吧", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "切", pos = "left"},
		},
	},
	level4 = {
		forward = {
			{role = "鬼眼",imgname = "role_guiyan", msg = "敌人派出了一个巨大机械怪物-黑暗金刚！找到弱点,消灭它!", pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "杰，战斗前记得装备镶嵌道具！",pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "全套黄金镶嵌才能触发黄金武器哦!", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "明白了,镶嵌完毕", pos = "left"},
		},
	},
	level5 = {
		forward = {
			{role = "杰",imgname = "role_jie",  msg = "啊！是你抓走了我姐姐！！！！！鬼眼！你个叛徒！",pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "呵呵，被发现也好，省的我费事了，都把命留下吧！", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "鬼眼绑架了很多人质，注意不要误伤人质！",  pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "真是无耻至极！!",  pos = "left"},
		},
		after = {
			{role = "杰",imgname = "role_jie", msg = "我姐姐被你带到哪里去啦？",  pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "你姐姐不识抬举，马上就要被我送到非洲了，哈哈!",  pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "杰，敌人援兵到了，快撤退。",  pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "非洲！？姐姐要坚持住啊！！",  pos = "left"},
		},
	},
	level6 = {
		forward = {
			{role = "杰",imgname = "role_jie", msg = "出来吧，鬼眼！我知道你在这！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "呵呵，可爱的小朋友，又追来了，我忙着哪，没工夫陪你玩哦。", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "闭嘴！你被捕了！叛徒！", pos = "right"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "哼哼，想抓我？那就要看你的本事了！", pos = "right"},
		},
		after = {
			{role = "鬼眼",imgname = "role_guiyan", msg = "呵呵，还挺能打，我还有更重要的事情，今天先放过你们。", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "别跑，我姐姐在哪里？", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "追。",pos = "right"},
			-- {role = "杰",imgname = "role_jie", msg = "我要继续追踪鬼眼，找到我姐姐的下落！", pos = "left"},
			-- {role = "安琪儿",imgname = "role_anqi", msg = "好，我和你去。",pos = "right"},
		},
	},
}

kDialogConfig["group2"]  = {
	level1 = {
		forward = {
			{role = "夜玫瑰", imgname = "role_yemeigui",msg = "沙漠深处发现鬼眼行踪！", pos = "left"},
			{role = "安琪儿", imgname = "role_anqi", msg = "杰这家伙也不见了", pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "坏了，一定是他自己追捕鬼眼去了！", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "我去追他！！", pos = "right"},
		},
	},
	level2 = {
		forward = {
			{role = "安琪儿",imgname = "role_anqi", msg = "幸好你来了，不然我也要被俘获了！！哭。。", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "额，我看够呛，会被你俘获才对！！", pos = "left"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "敌人越来越多，快炸毁大门，挡住敌人。", pos = "left"},
			{role = "杰",imgname = "role_jie", msg = "收到！", pos = "left"},
		},	
	},
	level3 = {
		forward = {
			{role = "杰",imgname = "role_jie", msg = "出来吧，鬼眼！我知道你在这！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "呵呵，可爱的小朋友，又追来了，我忙着哪，没工夫陪你玩哦。", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "闭嘴！你被捕了！叛徒！", pos = "right"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "哼哼，想抓我？那就要看你的本事了！", pos = "right"},
		},
	},
	level3_1 = {
		forward = {
			{role = "杰",imgname = "role_jie", msg = "出来吧，鬼眼！我知道你在这！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "呵呵，可爱的小朋友，又追来了，我忙着哪，没工夫陪你玩哦。", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "闭嘴！你被捕了！叛徒！", pos = "right"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "哼哼，想抓我？那就要看你的本事了！", pos = "right"},
		},
	},
	level4 = {
		forward = {
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "鬼眼逃跑时掉落了一瓶药剂，这很可能是他拥有超级体制的秘密，我要把这瓶药剂带回总部分析。",pos = "left"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "我有一种不祥的预感，恐怕眼镜蛇部队在制造生化兵。",pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "生化兵？感觉好恐怖啊！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "可恶的家伙，继续追击！", pos = "left"},
		},
	},
	level5 = {
		forward = {
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "全球反恐会议会场查到了有炸弹!",pos = "left"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "一级警报！清除炸弹，解救人质！", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "龙组行动！",  pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "行动！",  pos = "left"},
		},
	},
	level6 = {
		forward = {
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "会场外又遭到了一个巨大机械怪物的袭击，消灭它。", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "这个BOSS好巨大啊，破坏力好恐怖！",pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "又是一场恶战，全员出击！", pos = "left"},
			{role = "杰",imgname = "role_jie", msg = "可恶的家伙，拼了！", pos = "left"},
		},
	},
}

function DialogConfigs.getConfig(groupId,levelId,appear)
	-- print("groupId", groupId)
	-- print("appear", appear)
	-- print("levelId", levelId)
	local configGroup = kDialogConfig["group" .. groupId]
	-- dump(configGroup, 'configGroup')
	if configGroup == nil then return 
		nil 
	end

	local configLevel = configGroup["level" .. levelId]
	-- dump(configLevel, 'configLevel')
	if configLevel == nil then 
		return nil 
	end
	local config = configLevel[appear]
	-- dump(config, 'config')
	return config
end

return DialogConfigs