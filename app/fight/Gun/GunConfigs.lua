local GunConfigs = class("GunConfigs", cc.mvc.ModelBase)

local configs = {}

configs["m4a1"] = {
	skill1 = {
		animName = "skill_hql",
		value    = 50,
		buffAnimName = "hqljn_mz",
	    buffFunc = "doBuffAll_decreaseHp",
		cd       = 5.0,
		times    = 3,
		timeOffset = 0.3,
	},
	skill2 = {
		animName = "skill_hql",
		value    = 50,
		buffAnimName = "hqljn_mz",
	    buffFunc = "doBuffAll_pause",
		cd       = 5.0,		
	},	
}

configs["huoqilin"] = {

}

configs["balete"] = {

}

configs["leimingdun"] = {
	skill1 = {
		animName = "skill_hql",
		value    = 50,
		buffAnimName = "hqljn_mz",
	    buffFunc = "doBuffAll_decreaseHp",
		cd       = 5.0,
		times    = 3,
		timeOffset = 0.3,
	},
	skill2 = {
		animName = "skill_hql",
		value    = 50,
		buffAnimName = "hqljn_mz",
	    buffFunc = "doBuffAll_pause",
		cd       = 5.0,		
	},	
}

function GunConfigs.getConfig(gunName)
	return configs[gunName]
end

return GunConfigs