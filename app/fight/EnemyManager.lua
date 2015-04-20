
--EnemyManager
local EnemyManager = class("EnemyManager", cc.mvc.ModelBase)

--event
EnemyManager.ENEMY_KILL_BANGFEI_EVENT      = "ENEMY_KILL_BANGFEI_EVENT"   --杀死召唤 
EnemyManager.ENEMY_SKILL_ADDHP_EVENT       = "ENEMY_SKILL_ADDHP_EVENT"    --全体回血

function EnemyManager:ctor(properties)
    EnemyManager.super.ctor(self, properties)
    self.enemys = {}
end

function EnemyManager:addEnemy(enemyView)
	self.enemys[#self.enemys + 1] = enemyView
end

function EnemyManager:removeEnemy(enemy)
	for i,v in ipairs(self.enemys) do
		if v == enemy then
			local name = enemy:getNickname() 
			print("remove: " ..name)
			table.remove(self.enemys, i)
		end
	end
end

function EnemyManager:getEnemys()
	return self.enemys
end

function EnemyManager:doBuffAll_increaseHp(buffData)
	local value = buffData.value
	local time  = buffData.time
	local name  = buffData.name

	local enemys = self:getEnemys(buffName)
	for i,enemy in ipairs(enemys) do
		local enemyModel =  enemy:getEnemyModel()
		enemyModel:increaseHp(value)
		local name = enemy:getNickname() 
		print("name :increaseHp" .. value)
	end
end

function EnemyManager:doBuffAll_decreaseHp()
	-- body
end


return EnemyManager

