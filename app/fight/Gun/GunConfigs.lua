local GunConfigs = class("GunConfigs", cc.mvc.ModelBase)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local configs = {}



configs["huoqilin"] = {

	skill1 = {
		animName = "skill_hql",
	    buffFunc = function ()
	    	local gunId = 9
		    local weaponModel = md:getInstance("WeaponListModel")
		    local level 	  = weaponModel:getIntenlevel(9) 
			local demage = 5000 + 300 * level
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
		cd       = 30.0,
	},
}

configs["baleite"] = {
	skill1 = {
		animName = "skill_blt",
	    buffFunc = function ()
	    	local gunId = 6
		    local weaponModel = md:getInstance("WeaponListModel")
		    local level 	  = weaponModel:getIntenlevel(gunId) 				
			local buffData = {
				buffAnimName  = "bltjn_mz",
				time = 5.0 + level * 0.2,
			}
			local enemyM = md:getInstance("EnemyManager")
			enemyM:doBuff("doBuffAll_pause", buffData)
	    end,
		cd       = 30.0,		
	},	
}


function GunConfigs.getConfig(gunName)
	return configs[gunName]
end

return GunConfigs