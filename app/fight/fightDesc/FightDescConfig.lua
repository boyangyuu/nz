local EnemyDescConfig = class("EnemyDescConfig", cc.mvc.ModelBase)

local configs = {}

configs["boss02"] = {
	title = "BOSS信息！",
	name = "毁灭者",
	spc = "技能：",
	skill = {"粉碎投掷","野蛮冲撞","火箭弹"},
	weakness = "头部，手部",
	describe = "海岛组研发的二代机甲战士，残酷冷血，破坏力极强。",
	playanim = "stand",
}

configs["boss01"] = {
	title = "BOSS信息！",
	name = "黑暗金刚",
	spc = "技能：",
	skill = {"狂热射击","召唤小怪","连续飞弹"},
	weakness = "头部，手部，腹部",
	describe = "新型试验机甲的杰作，厚装甲护盾使其拥有超高的防御。",
	playanim = "stand",
}

configs["zpbing"] = {
	title = "出现新兵种！",
	name = "导弹兵",
	spc = "特性：",
	skill = {"血量低","攻击慢","伤害高"},
	weakness = "头部",
	describe = "自身生命少，攻击节奏慢，但伤害恐怖。",
	playanim = "stand",
}

configs["dunbing"] = {
	title = "出现新兵种！",
	name = "盾牌兵",
	spc = "特性：",
	skill = {"血量高","防御高","行动慢"},
	weakness = "头部",
	describe = "行动迟缓，但防御和血量超高。",
	playanim = "stand",
}

configs["zibaob"] = {
	title = "出现新兵种！",
	name = "自爆兵",
	spc = "特性：",
	skill = {"移动快","近身自爆","血量低"},
	weakness = "瓦斯罐",
	describe = "移动快，近身自爆攻击。",
	playanim = "stand",
}

configs["hs"] = {
	title = "解救人质！",
	name = "人质",
	spc = "特性：",
	skill = {"不要误伤人质！"},
	weakness = " ",
	describe = "误杀人质会任务失败! ",
	playanim = "speak1",
}
configs["feiji"] = {
	title = "出现新兵种！",
	name = "飞机",
	spc = "特性：",
	skill = {"移动快","空投伞兵","发射导弹"},
	weakness = "螺旋桨",
	describe = "高机动,高伤害。",
	playanim = "fireright",
}
configs["yyc"] = {
	title = "出现新兵种！",
	name = "越野车",
	spc = "特性：",
	skill = {"运输兵","发导弹","血量高"},
	weakness = "导弹发射器",
	describe = "攻击高,血量高。",
	playanim = "fireright",
}
configs["dzboss"] = {
	title = "BOSS信息！",
	name = "巨炮泰坦",
	spc = "技能：",
	skill = {"闪光雷","召唤","恐怖蛛网"},
	weakness = "头部、手部、腹部",
	describe = "行动缓慢，但是是暴力伤害的象征。",
	playanim = "stand",
}
configs["renzb"] = {
	title = "BOSS信息！",
	name = "鬼眼",
	spc = "技能：",
	skill = {"影分身","旋风斩","手里剑"},
	weakness = "头部、腿部",
	describe = "行动敏捷的伊贺忍者后裔，海岛组三号人物。擅长伪装、暗杀。",
	playanim = "stand",
}

function EnemyDescConfig.getConfig(enemyID)
	local enemyDescTable = configs[enemyID]
	return enemyDescTable
end

return EnemyDescConfig