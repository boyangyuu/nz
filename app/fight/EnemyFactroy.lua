local EnemyFactory = class("EnemyFactory",cc.mvc.ModelBase)

local MissileEnemyView = import(".enemys.MissileEnemyView")
local SanEnemyView = import(".enemys.SanEnemyView")
local JinEnemyView = import(".enemys.JinEnemyView")
local BaoEnemyView = import(".enemys.BaoEnemyView")
local DaoEnemyView = import(".enemys.DaoEnemyView")
local CommonEnemyView = import(".enemys.CommonEnemyView")

local BaseBossView = import(".enemys.BaseBossView")
local ChongBossView = import(".enemys.ChongBossView")

function EnemyFactory.createEnemy(property)
	assert(property, "property is nil")
	local enemyView

	--boss
	if property.type == "boss" then 
		enemyView = BaseBossView.new(property)
	elseif property.type == "chongBoss" then
		enemyView = ChongBossView.new(property)		
		
	--enemy
	elseif property.type == "missile" then
		enemyView = MissileEnemyView.new(property)
	elseif property.type == "san" then
		enemyView = SanEnemyView.new(property)
	elseif property.type == "jin" then
		enemyView = JinEnemyView.new(property)
	elseif property.type == "bao" then
		enemyView = BaoEnemyView.new(property)	
	elseif property.type == "dao" then
		enemyView = DaoEnemyView.new(property)			
	else
		enemyView = CommonEnemyView.new(property)
	end
	return enemyView
end

return EnemyFactory