local BuyConfigs = class("BuyConfigs", cc.mvc.ModelBase)

local dir = "res/GiftBag/GiftBag/GiftBag_"
local configs = {
	changshuang    = {				--畅爽
			ccsPath = dir.."ChangShuang.json",
			isGift = true,
			price = 6,
			name = "畅爽礼包",
			
	},
	goldGiftBag    = {				--土豪金
			ccsPath = dir.."GoldGiftBag.json",
			isGift = true,
			price = 30,
			name = "土豪金礼包",
	},
	novicesBag     = {              --新手礼包
			ccsPath = dir.."NovicesBag.json",
			isGift = true,
			price = 1,
			name = "新手礼包",
	}, 
	weaponGiftBag  = {           --武器大礼包
			ccsPath = dir.."WeaponGiftBag.json",
			isGift = true,
			price = 20,
			name = "武器大礼包",
	},
	timeGiftBag= {           	  --限时大礼包
			ccsPath = dir.."TimeGiftBag.json",
			isGift = true,
			price = 25,
			name = "限时大礼包",
	},
	armedMecha     = {				--机甲
			isGift = false,
			price = 4,
			name = "机甲变身2次",
	},
	handGrenade    = {             --手雷
			isGift = false,
			price = 4,
			name = "手雷20个",
	},
	unlockWeapon   = {            --解锁武器
			isGift = false,
			price = 6,
			name = "解锁武器",
	},
	highgradeWeapon   = {      --解锁高级武器
			isGift = false,
			price = 10,
			name = "解锁高级武器",
	},
	goldWeapon     = {				--金武
			isGift = false,
			price = 4,
			name = "金武2次",
	},
	onceFull       = {				--一键满级

			isGift = false,
			price = 2,
			name = "一键满级",
	},
	resurrection   = {        		--复活
			isGift = false,
			price = 2,
			name = "复活1次",
	},
	stone10         = {
			isGift = false,
			price = 1,
			name = "钻石10个",
	},
	stone45         = {
			isGift = false,
			price = 4,
			name = "钻石45个",
	},
	stone120         = {
			isGift = false,
			price = 10,
			name = "钻石120个",
	},
	stone260         = {
			isGift = false,
			price = 20,
			name = "钻石260个",
	},
	stone450         = {
			isGift = false,
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