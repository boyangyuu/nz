local ProductInfoConfig = class("ProductInfoConfig", cc.mvc.ModelBase)

local configs = {
	novicesBag     = "购买新手大礼包1个，价值6元，点击确定购买！",
	goldGiftBag    = "购买土豪金大礼包1个，价值30元，点击确定购买！",
	weaponGiftBag  = "购买武器大礼包1个，价值20元，点击确定购买！",
	armedMecha     = "购买无敌机甲2次，价值4元，点击确定购买！",
	handGrenade    = "购买手雷20个，价值4元，点击确定购买！",
	goldWeapon     = "购买黄金武器2次，价值4元，点击确定购买！",
	onceFull       = "购买当前武器一键满级1次，价值2元，点击确定购买！",
	resurrection   = "购买复活赠送黄金武器1次，价值2元，点击确定购买！",
	stone120       = "购买一麻袋宝石，120个，价值10元，点击确定购买！",
	stone260       = "购买一箱子宝石，260个，价值20元，点击确定购买！",
	stone450       = "购买堆成山的宝石，450个，价值30元，点击确定购买！",
}


function ProductInfoConfig.getConfig(name)
	dump(name, "name")
	assert(configs[name], "invalid name :"..name)
	return configs[name]
end

return ProductInfoConfig