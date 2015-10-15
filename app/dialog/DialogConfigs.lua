local DialogConfigs = class("DialogConfigs", cc.mvc.ModelBase)

local kDialogConfig = {}
kDialogConfig["group0"] = {
	level0 = {
		award = {
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint231"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"), imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint232"), pos = "left"},
		},

		after = {
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint233"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint234"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg =LanguageManager.getStringForKey("string_hint235"), pos = "right"},
		},
	},
}

kDialogConfig["group1"]  = {
	level1 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint227"), imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint236"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"), imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint237"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint238"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint239"), pos = "right"},
		},

	},
	level2 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint240"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint241"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint242"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint243"), pos = "left"},
		},

		award = {
			{role = LanguageManager.getStringForKey("string_hint228"), imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint244"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint245"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint246"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint247"), pos = "left"},
		},

		after = {
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint248"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint249"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint250"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint251"), pos = "right"},
		},
	},
	level3 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint252"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint253"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint254"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint255"), pos = "left"},
		},

		middle1 = {
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint335"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint336"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint337"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint338"), pos = "left"},
		},

		after = {
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint256"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint257"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint258"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint259"), pos = "left"},
		},
	},
	level4 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint260"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint261"),pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint262"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint263"), pos = "left"},
		},
	},

	level5 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint264"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint265"),pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint266"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint267"), pos = "left"},
		},
	},

	level6 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint268"),pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint269"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint270"),  pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint271"),  pos = "left"},
		},
		after = {
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint272"),  pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint273"),  pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint274"),  pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint275"),  pos = "left"},
		},
	},
	level7 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint276"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint277"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint278"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint279"), pos = "right"},
		},
		after = {
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint280"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint281"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint282"),pos = "right"},
			-- {role = "杰",imgname = "role_jie", msg = "我要继续追踪鬼眼，找到我师姐的下落！", pos = "left"},
			-- {role = "安琪儿",imgname = "role_anqi", msg = "好，我和你去。",pos = "right"},
		},
	},
}

kDialogConfig["group2"]  = {
	level1 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint228"), imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint285"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"), imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint286"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint287"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint288"), pos = "right"},
		},
	},
	level2 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint289"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint290"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint291"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint292"), pos = "left"},
		},
	},
	level3 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint276"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint277"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint278"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint279"), pos = "right"},
		},
	},
	level3_1 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint276"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint277"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint278"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint230"),imgname = "role_guiyan",
			msg = LanguageManager.getStringForKey("string_hint279"), pos = "right"},
		},
	},
	level4 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint293"),pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint294"),pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint295"), pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint296"), pos = "left"},
		},
	},
	level5 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint297"),pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint298"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint299"),  pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint300"),  pos = "left"},
		},
	},
	level6 = {
		forward = {
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint301"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint227"),imgname = "role_anqi",
			msg = LanguageManager.getStringForKey("string_hint302"),pos = "right"},
			{role = LanguageManager.getStringForKey("string_hint228"),imgname = "role_yemeigui",
			msg = LanguageManager.getStringForKey("string_hint303"), pos = "left"},
			{role = LanguageManager.getStringForKey("string_hint229"),imgname = "role_jie",
			msg = LanguageManager.getStringForKey("string_hint304"), pos = "left"},
		},
	},
}

--[[kDialogConfig["group70"]  = {
	level1 = {
		forward = {
			{role = "夜玫瑰", imgname = "role_yemeigui",msg = "沙漠深处发现鬼眼行踪！", pos = "left"},
			{role = "安琪儿", imgname = "role_anqi", msg = "杰这家伙也不见了", pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "坏了，一定是他自己追捕鬼眼去了！", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "我去追他！！", pos = "right"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "呵呵，可爱的小朋友，又追来了，我忙着哪，没工夫陪你玩哦。", pos = "right"},
		},
	},
	level2 = {
		forward = {
			{role = "杰",imgname = "role_jie", msg = "幸好你来了，不然我也要被俘获了！！哭。。", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "你个笨笨，总让我为你操心！！", pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "敌人越来越多，快炸毁大门，挡住敌人。", pos = "left"},
			{role = "杰",imgname = "role_jie", msg = "收到！", pos = "left"},
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
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "全球反恐会议会场查到了有炸弹！",pos = "left"},
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
			{role = "杰",imgname = "role_jie", msg = "可恶的家伙，拼了！全员启用黄金武器！！", pos = "left"},
		},
	},
}]]--

function DialogConfigs.getConfig(groupId,levelId,appear)
	local configGroup = kDialogConfig["group" .. groupId]
	if configGroup == nil then return
		nil
	end

	if math.floor(levelId) < levelId then
        levelId = tostring(levelId)
        levelId = string.gsub(levelId, "%.", "_")
	end

	local configLevel = configGroup["level" .. levelId]
	if configLevel == nil then
		return nil
	end
	local config = configLevel[appear]
	return config
end

return DialogConfigs