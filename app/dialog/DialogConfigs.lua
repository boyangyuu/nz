local DialogConfigs = class("DialogConfigs", cc.mvc.ModelBase)

local configs = {}

configs[1]  = {
	level1 = {
		forward = {
			{role = "安琪儿", imgname = "role_anqi",msg = "根据可靠情报，这个仓库里藏匿着眼镜蛇部队的大量军火。", pos = "right"},
			{role = "夜玫瑰", imgname = "role_yemeigui", msg = "杰，在支援没到之前你需要只身前往那里，一定要拖住敌人，为支援争取时间。", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "加油，不要辱没了我们龙组的威名！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "了解，任务开始！", pos = "left"},
		},
	},
	level2 = {
		forward = {
			{role = "杰",imgname = "role_jie", msg = "成功抵达位置，但是敌人有埋伏。我们被包围了。", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "队长，敌人越来越多了，申请动用“黄金武器”！", pos = "right"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "。。。。。。申请许可，全员立刻换装黄金武器！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "哈哈！黄金武器，这个给力！老虎不发威你当我是哈喽kitty ！", pos = "left"},
		},	
	},
	level3 = {
		forward = {
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "隐藏能源核心的金库被袭击！请求支援！请求支援！", pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "。。。。。。中了调虎离山的计了！行动组火速回援", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "收到！", pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "收到！", pos = "left"},
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
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "啊！叛徒竟然是你，鬼眼！",pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "呵呵，被发现也好，省的我费事了，都把命留下吧！", pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "鬼眼绑架了很多人质，注意不要误伤人质！",  pos = "right"},
			{role = "杰",imgname = "role_jie", msg = "无耻。。。。。。",  pos = "left"},
		},
		after = {
			{role = "杰",imgname = "role_jie", msg = "我哥哥是不是你害死的？",  pos = "left"},
			{role = "鬼眼",imgname = "role_guiyan", msg = "你哥哥不识抬举，想见他还不容易，我来帮你一把，哈哈!",  pos = "right"},
			{role = "安琪儿",imgname = "role_anqi", msg = "杰，敌人援兵到了，快撤退。",  pos = "right"},
		},
	},
	level6 = {
		forward = {
			{role = "杰",imgname = "role_jie", msg = "我要继续追踪鬼眼，查到杀害我哥哥的真凶", pos = "left"},
			{role = "安琪儿",imgname = "role_anqi", msg = "好，我和你去。",pos = "right"},
			{role = "夜玫瑰",imgname = "role_yemeigui", msg = "小心他们最后的傀儡机甲首领————黑暗金刚！", pos = "left"},
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