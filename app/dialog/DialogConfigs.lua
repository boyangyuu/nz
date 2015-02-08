local DialogConfigs = class("DialogConfigs", cc.mvc.ModelBase)

local configs = {}

configs[1]  = {
	level1 = {
		forward = {
			{role = "安琪儿", imgname = "role_anqi",msg = "根据可靠情报，这个仓库里藏匿着很多被拐骗的无知少女！", pos = "right"},
			{role = "夜玫瑰", imgname = "role_yemeigui", msg = "杰，在支援没到之前你需要只身前往那里，一定要拖住敌人，为支援争取时间。", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "加油，不要辱没了我们龙组的威名！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "了解，少女们我来了！！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "。。。。。。", pos = "right"},
		},
	},
	level2 = {
		forward = {
			{role = "安琪儿",imgname = "role_anqi", msg = "阿杰，我们面临着被群歼的危险！！！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "动用“黄金武器”！全员立刻换装黄金武器！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "黄金武器，无限震动！！！！看看谁歼灭谁！！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "。。。。。。", pos = "right"},		
		},	
	},
	level3 = {
		forward = {
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "护士妹妹们的寝室楼被袭击！！！！请求支援！请求支援！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "。。。。。。中了敌人的调虎离山计了！行动组火速回援", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "收到！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "太卑鄙了！妹妹们等我！！", pos = "left"},
		},
	},
	level4 = {
		forward = {
			{role = "鬼眼",imgname = "role_guiyan", msg = "将敌人抵挡在基地外", pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "杰，占据制高点，使用狙击枪秒杀他们！",pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "哈哈，用狙击枪还是看我的吧", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "切", pos = "left"},
		},
	},
	level5 = {
		forward = {
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "啊！是你抓走了我姐姐！！！！！鬼眼！你个叛徒！",pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "呵呵，被发现也好，省的我费事了，都把命留下吧！", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "鬼眼绑架了很多人质，注意不要误伤人质！",  pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "真是无耻至极！！。。(搁我我也这么干！(^o^)~)。",  pos = "left"},
		},
		after = {
			{role = "杰",imgname = "role_jie", msg = "我姐姐被你带到哪里去啦？",  pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "你姐姐不识抬举，马上就要被我送到非洲了，哈哈!",  pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "杰，敌人援兵到了，快撤退。",  pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "啊！姐姐坚持住！！等我！！",  pos = "left"},
		},
	},
	level6 = {
		forward = {
			{role = "杰",imgname = "role_jie", msg = "我要继续追踪鬼眼，直到找到我的姐姐！", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "好，我和你去。",pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "小心他们最后的傀儡机甲首领————黑暗金刚！", pos = "left"},
			{role = "杰",imgname = "role_jie", msg = "是不是它从背后偷袭我姐姐的！！？？", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "对，是从背后偷袭你姐姐的！！",pos = "right"},		
		},
	},
}

configs[2]  = {
	level1 = {
		forward = {
			{role = "夜玫瑰", imgname = "role_yemeigui",msg = "沙漠深处发现鬼眼行踪！", pos = "left"},
			{role = "安琪儿", imgname = "role_anqi", msg = "杰这家伙也不见了", pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "坏了，一定是他自己上网吧偷偷打游戏去了！", pos = "left"},
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
	local gid = configs[groupId]
	if gid == nil then return nil end
	local lid = gid[levelId]
	if lid == nil then return nil end
	local dialogTable = lid[appear]
	return dialogTable
end

return DialogConfigs