local BuyConfigs = class("BuyConfigs", cc.mvc.ModelBase)

local dir = "res/GiftBag/GiftBag/GiftBag_"
local configs = {
	changshuang    = {				--畅爽
			ccsPath = dir.."ChangShuang.json",
			isGift = true,
	},
	goldGiftBag    = {				--土豪金
			ccsPath = dir.."GoldGiftBag.json",
			isGift = true,
	},
	novicesBag     = {              --新手礼包
			ccsPath = dir.."NovicesBag.json",
			isGift = true,
	}, 
	weaponGiftBag  = {           --武器大礼包
			ccsPath = dir.."WeaponGiftBag.json",
			isGift = true,
	},
	timeGiftBag= {           	  --限时大礼包
			ccsPath = dir.."TimeGiftBag.json",
			isGift = true,
	},
	armedMecha     = {				--机甲
			isGift = false,
	},
	handGrenade    = {             --手雷
			isGift = false,
	},
	unlockWeapon   = {            --解锁武器
			isGift = false,
	},
	goldWeapon     = {				--金武
			isGift = false,
	},
	onceFull       = {				--一键满级

			isGift = false,
	},
	resurrection   = {        		--复活
			isGift = false,
	},
	stone10         = {
			isGift = false,
	},
	stone45         = {
			isGift = false,
	},
	stone120         = {
			isGift = false,
	},
	stone260         = {
			isGift = false,
	},
	stone450         = {
			isGift = false,
	},
}


function BuyConfigs.getConfig(name)
	dump(name, "name")
	assert(configs[name], "invalid name :"..name)
	return configs[name]
end

return BuyConfigs