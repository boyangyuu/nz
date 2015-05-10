local GunConfigs = class("GunConfigs", cc.mvc.ModelBase)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local configs = {}

configs["m4a1"] = {

}

configs["huoqilin"] = {
	skill1 = {
		animName = "skill_hql",
	    buffFunc = function ()
		    local hero = md:getInstance("Hero")
			local demage = hero:getDemage() * 10
			local buffData = {
				buffAnimName  = "hqljn_mz",
				value = demage,
			}
			local enemyM = md:getInstance("EnemyManager")
			local function buffFunc()
				enemyM:doBuff("doBuffAll_decreaseHp", buffData)
			end	
			local delay = 0.0
			for i=1, 3 do
				delay = delay + 0.3
				scheduler.performWithDelayGlobal(buffFunc, delay)
			end
	    end,
		cd       = 5.0,
	},
}

configs["balete"] = {
	skill1 = {
		animName = "skill_blt",
	    buffFunc = function ()
			local buffData = {
				buffAnimName  = "bltjn_mz",
				time = 8.0,
			}
			local enemyM = md:getInstance("EnemyManager")
			enemyM:doBuff("doBuffAll_pause", buffData)
	    end,
		cd       = 5.0,		
	},	
}


configs["leimingdun"] = {
	skill1 = {
		animName = "skill_blt",
	    buffFunc = function ()
			local buffData = {
				buffAnimName  = "bltjn_mz",
				time = 8.0,
			}
			local enemyM = md:getInstance("EnemyManager")
			enemyM:doBuff("doBuffAll_pause", buffData)
	    end,
		cd       = 5.0,		
	},	
}

function GunConfigs.getConfig(gunName)
	return configs[gunName]
end

return GunConfigs