local BossDescConfigs = class("BossDescConfigs", cc.mvc.ModelBase)

local configs = {}

config["boss01"] = {
	title = "BOSS信息！",
	name = "毁灭者",
	skill = {"粉碎投掷","野蛮冲撞","火箭弹"},
	weakness = "头，手",
	describe = "海岛组研发的二代机甲战士，残酷冷血，破坏力极强",
	playanim = "stand",

}

config["boss02"] = {
	title = "BOSS信息！",
	name = "黑暗金刚",
	skill = {"狂热射击","召唤小怪","连续飞弹"},
	weakness = "头，手，腹",
	describe = "海岛组研发的二代机甲战士，残酷冷血，破坏力极强",
	playanim = "stand",
}

config["boss03"] = {
	title = "BOSS信息！",
	name = "巨炮泰坦",
	skill = {"狂热射击","召唤小怪","连续飞弹"},
	weakness = "头，手，腹",
	describe = "海岛组研发的二代机甲战士，残酷冷血，破坏力极强",
	playanim = "stand",
}