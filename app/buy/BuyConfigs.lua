local BuyConfigs = class("BuyConfigs", cc.mvc.ModelBase)

local dir = "res/GiftBag/GiftBag/GiftBag_"

-- local isNovicesGift, novicesPrice = isMobileSimCard() 

local configs = {
	goldGiftBag    = {				--土豪金
			ccsPath = dir.."GoldGiftBag.json",
			showType = "gift",
			price = 30,
			name = "土豪金礼包",
	},
	novicesBag     = {              --新手礼包
			ccsPath = dir.."NovicesBag.json",
			showType = "gift",
			price = 1,
			name = "新手礼包",
	}, 
	weaponGiftBag  = {           --武器大礼包
			ccsPath = dir.."WeaponGiftBag.json",
			showType = "gift",
			price = 20,
			name = "武器大礼包",
	},
	armedMecha     = {				--机甲
			showType = "tips",
			price = 4,
			name = "机甲变身2次",
	},
	handGrenade    = {             --手雷
			showType = "tips",
			price = 4,
			name = "手雷20个",
	},
	goldWeapon     = {				--金武
			showType = "tips",
			price = 4,
			name = "金武2次",
	},
	onceFull       = {				--一键满级

			showType = "tips",
			price = 2,
			name = "一键满级",
	},
	resurrection   = {        		--复活
			showType = "tips",
			price = 2,
			name = "复活1次",
	},
	stone120         = {
			showType = "iap",
			price = 10,
			name = "钻石120个",
	},
	stone260         = {
			showType = "iap",
			price = 20,
			name = "钻石260个",
	},
	stone450         = {
			showType = "iap",
			price = 30,
			name = "钻石450个",
	},
}

function BuyConfigs.getConfig(name)
	dump(name, "name")
	assert(configs[name], "invalid name :"..name)
	return configs[name]
end

return BuyConfigs