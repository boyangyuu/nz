
local EnemyDescConfig = class("EnemyDescConfig", cc.mvc.ModelBase)

local configs = {}

configs["boss02"] = {                  --蓝色(扔汽车)
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint81"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint83"),
				LanguageManager.getStringForKey("string_hint84"),
				LanguageManager.getStringForKey("string_hint85")},
	weakness = LanguageManager.getStringForKey("string_hint65"),
	describe = LanguageManager.getStringForKey("string_hint86"),
	playanim = "stand",
}

configs["boss02_1"] = {                  --cf红色肌肉男(扔铁球)
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint87"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint88"),
				LanguageManager.getStringForKey("string_hint84"),
				LanguageManager.getStringForKey("string_hint89")},
	weakness = LanguageManager.getStringForKey("string_hint65"),
	describe = LanguageManager.getStringForKey("string_hint86"),
	playanim = "stand",
}

configs["boss02_2"] = {                --黄色(扔汽油桶)
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint106"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint83"),
				LanguageManager.getStringForKey("string_hint84"),
				LanguageManager.getStringForKey("string_hint90")},
	weakness = LanguageManager.getStringForKey("string_hint65"),
	describe = LanguageManager.getStringForKey("string_hint86"),
	playanim = "stand",
}

configs["boss01"] = {                              --盾牌红boss原型
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint91"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint92"),
				LanguageManager.getStringForKey("string_hint93"),
				LanguageManager.getStringForKey("string_hint94")},
	weakness = LanguageManager.getStringForKey("string_hint66"),
	describe = LanguageManager.getStringForKey("string_hint95"),
	playanim = "stand",
}

configs["boss01_1"] = {                            --红色机甲开枪为主
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint96"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint92"),
				LanguageManager.getStringForKey("string_hint97"),
				LanguageManager.getStringForKey("string_hint94")},
	weakness = LanguageManager.getStringForKey("string_hint66"),
	describe = LanguageManager.getStringForKey("string_hint95"),
	playanim = "stand",
}

configs["boss01_2"] = {                            --银灰冷色终结者
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint98"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint99"),
				LanguageManager.getStringForKey("string_hint100"),
				LanguageManager.getStringForKey("string_hint94")},
	weakness = LanguageManager.getStringForKey("string_hint66"),
	describe = LanguageManager.getStringForKey("string_hint95"),
	playanim = "stand",
}

configs["zpbing"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name = LanguageManager.getStringForKey("string_hint339"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint62"),
			LanguageManager.getStringForKey("string_hint63"),},
	weakness = LanguageManager.getStringForKey("string_hint64"),
	describe = LanguageManager.getStringForKey("string_hint76"),
	playanim = "stand",
}

configs["jujib"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name = LanguageManager.getStringForKey("string_hint60"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint62"),
			LanguageManager.getStringForKey("string_hint63"),},
	weakness = LanguageManager.getStringForKey("string_hint64"),
	describe = LanguageManager.getStringForKey("string_hint67"),
	playanim = "stand",
}

configs["dunbing"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name = LanguageManager.getStringForKey("string_hint68"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint69"),
			LanguageManager.getStringForKey("string_hint70"),
			LanguageManager.getStringForKey("string_hint71")},
	weakness = LanguageManager.getStringForKey("string_hint64"),
	describe =  LanguageManager.getStringForKey("string_hint77"),
	playanim = "stand",
}

configs["zibaob"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name =  LanguageManager.getStringForKey("string_hint72"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint73"),
			LanguageManager.getStringForKey("string_hint74"),
			LanguageManager.getStringForKey("string_hint75")},
	weakness = LanguageManager.getStringForKey("string_hint78"),
	describe = LanguageManager.getStringForKey("string_hint79"),
	playanim = "stand",
}

configs["hs"] = {
	title = LanguageManager.getStringForKey("string_hint101"),
	name = LanguageManager.getStringForKey("string_hint102"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint103"),},
	weakness = LanguageManager.getStringForKey("string_hint104"),
	describe = LanguageManager.getStringForKey("string_hint105"),
	playanim = "speak1",
}

configs["bangren"] = {
	title = LanguageManager.getStringForKey("string_hint101"),
	name = LanguageManager.getStringForKey("string_hint102"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint103"),},
	weakness = LanguageManager.getStringForKey("string_hint104"),
	describe = LanguageManager.getStringForKey("string_hint105"),
	playanim = "speak1",
}

configs["yiliaob"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name = LanguageManager.getStringForKey("string_hint107"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint108")},
	weakness = LanguageManager.getStringForKey("string_hint64"),
	describe = LanguageManager.getStringForKey("string_hint105"),
	playanim = "stand",
}

configs["qiufan"] = {
	title = LanguageManager.getStringForKey("string_hint109"),
	name = LanguageManager.getStringForKey("string_hint110"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint111")},
	weakness = LanguageManager.getStringForKey("string_hint64"),
	describe = LanguageManager.getStringForKey("string_hint112"),
	playanim = "runright",
}
configs["feiji"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name = LanguageManager.getStringForKey("string_hint113"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint114"),
			LanguageManager.getStringForKey("string_hint115")},
	weakness = LanguageManager.getStringForKey("string_hint116"),
	describe = LanguageManager.getStringForKey("string_hint117"),
	playanim = "fireright",
}
configs["yyc"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name = LanguageManager.getStringForKey("string_hint118"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint90")},
	weakness = LanguageManager.getStringForKey("string_hint120"),
	describe = LanguageManager.getStringForKey("string_hint121"),
	playanim = "fireright",
}
configs["dzboss"] = {
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint122"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint123"),
			LanguageManager.getStringForKey("string_hint124"),
			LanguageManager.getStringForKey("string_hint125"),},
	weakness = LanguageManager.getStringForKey("string_hint66"),
	describe = LanguageManager.getStringForKey("string_hint126"),
	playanim = "stand",
}
configs["dzboss_1"] = {
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint127"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint90"),
			LanguageManager.getStringForKey("string_hint119"),
			LanguageManager.getStringForKey("string_hint128")},
	weakness = LanguageManager.getStringForKey("string_hint66"),
	describe = LanguageManager.getStringForKey("string_hint129"),
	playanim = "stand",
}
configs["dzboss_2"] = {
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint340"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint90"),
			LanguageManager.getStringForKey("string_hint89"),
			LanguageManager.getStringForKey("string_hint124")},
	weakness = LanguageManager.getStringForKey("string_hint66"),
	describe = LanguageManager.getStringForKey("string_hint341"),
	playanim = "stand",
}
configs["renzb"] = {
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint130"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint131"),
			LanguageManager.getStringForKey("string_hint132"),
			LanguageManager.getStringForKey("string_hint133")},
	weakness = LanguageManager.getStringForKey("string_hint342"),
	describe = LanguageManager.getStringForKey("string_hint134"),
	playanim = "stand",
}
configs["renzb_01"] = {
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint135"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint131"),
			LanguageManager.getStringForKey("string_hint125"),
			LanguageManager.getStringForKey("string_hint133")},
	weakness = LanguageManager.getStringForKey("string_hint342"),
	describe = LanguageManager.getStringForKey("string_hint136"),
	playanim = "stand",
}
configs["nvrenzb"] = {
	title = LanguageManager.getStringForKey("string_hint80"),
	name = LanguageManager.getStringForKey("string_hint137"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint138"),
			LanguageManager.getStringForKey("string_hint132"),
			LanguageManager.getStringForKey("string_hint139")},
	weakness = LanguageManager.getStringForKey("string_hint342"),
	describe = LanguageManager.getStringForKey("string_hint140"),
	playanim = "stand",
}

configs["xiaorz"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name = LanguageManager.getStringForKey("string_hint141"),
	spc = LanguageManager.getStringForKey("string_hint82"),
	skill = {LanguageManager.getStringForKey("string_hint132"),
			LanguageManager.getStringForKey("string_hint142")},
	weakness = LanguageManager.getStringForKey("string_hint342"),
	describe = LanguageManager.getStringForKey("string_hint143"),
	playanim = "stand",
}

configs["jinzhanb"] = {
	title = LanguageManager.getStringForKey("string_hint59"),
	name = LanguageManager.getStringForKey("string_hint144"),
	spc = LanguageManager.getStringForKey("string_hint61"),
	skill = {LanguageManager.getStringForKey("string_hint69"),
			LanguageManager.getStringForKey("string_hint145")},
	weakness = LanguageManager.getStringForKey("string_hint64"),
	describe = LanguageManager.getStringForKey("string_hint146"),
	playanim = "stand",
}

function EnemyDescConfig.getConfig(enemyID)
	local enemyDescTable = configs[enemyID]
	return enemyDescTable
end

return EnemyDescConfig