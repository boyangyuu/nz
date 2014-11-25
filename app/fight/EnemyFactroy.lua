local EnemyFactory = class("EnemyFactory",cc.mvc.ModelBase)

local BaseEnemyView = import(".enemys.BaseEnemyView")
local BossView = import(".enemys.BossView")
local MissileEnemyView = import(".enemys.MissileEnemyView")
local SanEnemyView = import(".enemys.SanEnemyView")
local JinEnemyView = import(".enemys.JinEnemyView")
local BaoEnemyView = import(".enemys.BaoEnemyView")
local CommonEnemyView = import(".enemys.CommonEnemyView")



function EnemyFactory.createEnemy(property)

	local enemyView
	if property.type == "boss" then 
		enemyView = BossView.new(property)
	elseif property.type == "missile" then
		enemyView = MissileEnemyView.new(property)
	elseif property.type == "san" then
		enemyView = SanEnemyView.new(property)
	elseif property.type == "jin" then
		enemyView = JinEnemyView.new(property)
	elseif property.type == "bao" then
		enemyView = BaoEnemyView.new(property)		
	else
		enemyView = CommonEnemyView.new(property)
	end
	return enemyView
end

return EnemyFactory