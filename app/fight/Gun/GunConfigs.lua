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
			local demage = 5000 + 2000 * level   --实际伤害5000*3次+2000*等级
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
				time = 6.0 + level * 0.5 ,   --基础6秒+等级*0.5秒
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