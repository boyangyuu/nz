local BuyConfigs = class("BuyConfigs", cc.mvc.ModelBase)

local dir = "res/GiftBag/GiftBag/GiftBag_"

local configs = {
	goldGiftBag    = {				--土豪金
			ccsPath = dir.."GoldGiftBag.json",
			showType = "gift",
			price = 30,
			name = "土豪金礼包",
	},
	goldGiftBag_dx    = {				--土豪金
			ccsPath = dir.."GoldGiftBag_dx.json",
			showType = "gift",
			price = 20,
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
			showType = "prop_rmb",
			price = 4,
			name = "无敌机甲 x2",
			iapName = "无敌机甲2次",
	},
	handGrenade    = {             --手雷
			showType = "prop_rmb",
			price = 4,
			name = "手雷 x20",
			iapName = "手雷20个",
	},
	goldWeapon     = {				--金武
			showType = "prop_rmb",
			price = 4,
			name = "黄金武器 x2",
			iapName = "黄金武器2次",
	},
	onceFull       = {				--一键满级
			showType = "prop_rmb",
			price = 2,
			name = "当前武器一键满级",
			iapName = "当前武器一键满级",
	},
	stone120         = {
			showType = "iap",
			price = 10,
			name = "宝石 x120",
			iapName = "一麻袋宝石",
	},
	stone260         = {
			showType = "iap",
			price = 20,
			name = "宝石 x260",
			iapName = "一箱子宝石",
	},
	stone450         = {
			showType = "prop_rmb",
			price = 30,
			name = "宝石 x450",
			iapName = "堆成山的宝石",
	},
	-- hpBag         = {
	-- 		showType = "prop_stone",
	-- 		price = 30,
	-- 		jsonName = hpBag
	-- 		name = "医疗包4个",
	-- 		iapId = "stone450",
	-- },	
	-- weaponBuy      = {
	-- 		showType = "prop_stone",
	-- 		price = 30,
	-- 		jsonName = weaponBuy
	-- 		name = "武器解锁",
	-- 		iapId = "stone450",
	-- },	
	-- relive   = {        		--复活
	-- 		showType = "prop_stone",
	-- 		jsonName = relive
	-- 		price = 2,
	-- 		name = "复活1次",
	-- },		
}

function BuyConfigs.getConfig(name)
	-- dump(name, "name")
	assert(configs[name], "invalid name :"..name)
	return configs[name]
end

return BuyConfigs