local EnemyFactory = class("EnemyFactory",cc.mvc.ModelBase)

local MissileEnemyView = import(".enemys.MissileEnemyView")
local SanEnemyView 		= import(".enemys.SanEnemyView")
local JinEnemyView 		= import(".enemys.JinEnemyView")
local BaoEnemyView 		= import(".enemys.BaoEnemyView")
local DaoEnemyView 		= import(".enemys.DaoEnemyView")
local CommonEnemyView	= import(".enemys.CommonEnemyView")
local JinbiEnemyView  	= import(".enemys.JinbiEnemyView")
local RenzhiEnemyView 	= import(".enemys.RenzhiEnemyView")
local FeijiEnemyView    = import(".enemys.FeijiEnemyView")
local RenEnemyView   	= import(".enemys.RenEnemyView")

local BaseBossView 		= import(".enemys.BaseBossView")
local ChongBossView 	= import(".enemys.ChongBossView")
local RenBossView 		= import(".enemys.RenBossView")
local DuozuBossView		= import(".enemys.DuozuBossView")
 
function EnemyFactory.createEnemy(property)
	assert(property, "property is nil")
	local enemyView

	--boss
	local type = property.type
	if type == "boss" then 
		enemyView = BaseBossView.new(property)
	elseif type == "chongBoss" then
		enemyView = ChongBossView.new(property)		
	elseif type == "renzheBoss" then
		enemyView = RenBossView.new(property)		
	elseif type == "duozuBoss" then
		enemyView = DuozuBossView.new(property)	

	--enemy
	elseif type == "missile" then
		enemyView = MissileEnemyView.new(property)
	elseif type == "san" then
		enemyView = SanEnemyView.new(property)
	elseif type == "jin" then
		enemyView = JinEnemyView.new(property)
	elseif type == "bao" then
		enemyView = BaoEnemyView.new(property)	
	elseif type == "dao" then
		enemyView = DaoEnemyView.new(property)	
	elseif type == "jinbi" then
		enemyView = JinbiEnemyView.new(property)
	elseif type == "renzhi" then
		enemyView = RenzhiEnemyView.new(property)							
	elseif type == "feiji" or type == "jipu" then
		enemyView = FeijiEnemyView.new(property)							
	elseif type == "renzhe" then
		enemyView = RenEnemyView.new(property)							
	else				
		enemyView = CommonEnemyView.new(property)
	end
	return enemyView
end

return EnemyFactory