local EnemyFactory = class("EnemyFactory",cc.mvc.ModelBase)

local EnemyView = import(".enemys.EnemyView")
local BossView = import(".enemys.BossView")
local MissileEnemyView = import(".enemys.MissileEnemyView")
local SanEnemyView = import(".enemys.SanEnemyView")
local JinEnemyView = import(".enemys.JinEnemyView")

function EnemyFactory.createEnemy(property)

	local enemyView
	if property.type == "boss" then 
		enemyView = BossView.new(property)
	elseif property.type == "missile" then
		enemyView = MissileEnemyView.new(property)
	elseif property.type == "san" then
		enemyView = SanEnemyView.new(property)
	elseif property.type = "jin" then
		enemyView = JinEnemyView.new(property)
	else
		enemyView = EnemyView.new(property)
	end
	return enemyView
end

return EnemyFactory