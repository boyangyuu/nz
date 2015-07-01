local StoreConfigs = class("StoreConfigs", cc.mvc.ModelBase)

local configs = {
	prop = {
		{
			costDiamond = 40,
			num		    = 20,
		},
		{
			costDiamond = 40,
			num		    = 2,
		},
		{
			costDiamond = 40,
			num		    = 2,
		},
	},	
	bank = {
		{
			buyId = "stone120",
		},
		{
			buyId = "stone260",
		},
		{
			buyId = "stone450",
		},
		{
			buyId = "stone600",
			payType = "al",
		},
		{
			buyId = "stone900",
			payType = "al",
		},
		{
			buyId = "stone1200",
			payType = "al",
		},
	},
	money = {
		{
			costDiamond = 40,
			number		= 450000,
		},
		{
			costDiamond = 80,
			number		= 950000,
		},
		{
			costDiamond = 160,
			number		= 2000000,
		},	
	},		
}

function StoreConfigs.getConfig(storeType)
	assert(configs[storeType], "invalid storeType :"..storeType)
	return configs[storeType]
end

return StoreConfigs