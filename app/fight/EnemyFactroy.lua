local EnemyFactory = class("EnemyFactory",cc.mvc.ModelBase)

--missile
local MissileEnemyView = import(".enemys.MissileEnemyView")
local DaoEnemyView 		= import(".enemys.DaoEnemyView")
local WangEnemyView		= import(".enemys.WangEnemyView")

local SanEnemyView 		= import(".enemys.SanEnemyView")
local JinEnemyView 		= import(".enemys.JinEnemyView")
local BaoEnemyView 		= import(".enemys.BaoEnemyView")
local CommonEnemyView	= import(".enemys.CommonEnemyView")
local JinbiEnemyView  	= import(".enemys.JinbiEnemyView")
local RZHushiEnemyView 	= import(".enemys.RZHushiEnemyView")
local RZShangrenEnemyView 	= import(".enemys.RZShangrenEnemyView")
local FeijiEnemyView    = import(".enemys.FeijiEnemyView")
local RenEnemyView   	= import(".enemys.RenEnemyView")
local AwardEnemyView   	= import(".enemys.AwardEnemyView")

--award
local AwardSanEnemyView	= import(".enemys.AwardSanEnemyView")

--boss
local BaseBossView 		= import(".enemys.BaseBossView")
local ChongBossView 	= import(".enemys.ChongBossView")
local RenBossView 		= import(".enemys.RenBossView")
local DuozuBossView		= import(".enemys.DuozuBossView")

function EnemyFactory.createEnemy(property)
	assert(property, "property is nil")
	local enemyView

	--boss
	property.type = property.type or "common"	
	local type = property.type
	-- print("function EnemyFactory.createEnemy(property)"，type)	
	if type == "boss" then 
		enemyView = BaseBossView.new(property)
	elseif type == "chongBoss" then
		enemyView = ChongBossView.new(property)		
	elseif type == "renzheBoss" then
		enemyView = RenBossView.new(property)		
	elseif type == "duozuBoss" then
		enemyView = DuozuBossView.new(property)	

	--dao
	elseif type == "dao_wang" then
		enemyView = WangEnemyView.new(property)
	elseif type == "missile" then
		enemyView = MissileEnemyView.new(property)

	--award
	elseif type == "awardSan" then
		enemyView = AwardSanEnemyView.new(property)	
	 
	--enemy		
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
		enemyView = RZHushiEnemyView.new(property)
	elseif type == "shangren" then
		enemyView = RZShangrenEnemyView.new(property)									
	elseif type == "feiji" or type == "jipu" then
		enemyView = FeijiEnemyView.new(property)							
	elseif type == "renzhe" then
		enemyView = RenEnemyView.new(property)							
	elseif type == "award" then
		enemyView = AwardEnemyView.new(property)							
	else			
		enemyView = CommonEnemyView.new(property)
	end
	return enemyView
end

return EnemyFactory