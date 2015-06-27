local StoreConfigs = class("StoreConfigs", cc.mvc.ModelBase)

local configs = {
	prop = {

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
		},
		{
			buyId = "stone900",
		},
		{
			buyId = "stone1200",
		},
	},
	money = {
		{
			costDiamond = 40,
		},
		{
			costDiamond = 80,
		},
		{
			costDiamond = 160,
		},	
	},		
}

function StoreConfigs.getConfig(storeType)
	assert(configs[storeType], "invalid storeType :"..storeType)
	return configs[storeType]
end

return StoreConfigs