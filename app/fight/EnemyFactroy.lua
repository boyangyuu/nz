local EnemyFactory = class("EnemyFactory",cc.mvc.ModelBase)

--missile
local DDNormalEnemyView = import(".enemys.DDNormalEnemyView")
local DaoEnemyView 		= import(".enemys.DaoEnemyView")
local DDWangEnemyView	= import(".enemys.DDWangEnemyView")
local DDWuEnemyView		= import(".enemys.DDWuEnemyView")

local SanEnemyView 		= import(".enemys.SanEnemyView")
local JinEnemyView 		= import(".enemys.JinEnemyView")
local BaoEnemyView 		= import(".enemys.BaoEnemyView")
local CommonEnemyView	= import(".enemys.CommonEnemyView")
local JinbiEnemyView  	= import(".enemys.JinbiEnemyView")
local FeijiEnemyView    = import(".enemys.FeijiEnemyView")
local RenEnemyView   	= import(".enemys.RenEnemyView")
local AwardEnemyView   	= import(".enemys.AwardEnemyView")

--award
local AwardSanEnemyView	= import(".enemys.AwardSanEnemyView")

--renzhi
local RZHushiEnemyView 	= import(".enemys.RZHushiEnemyView")
local RZShangrenEnemyView 	= import(".enemys.RZShangrenEnemyView")
local RZBangfeiEnemyView 	= import(".enemys.RZBangfeiEnemyView")
local RZBangrenEnemyView 	= import(".enemys.RZBangrenEnemyView")

--taofan
local TFQiuEnemyView 	= import(".enemys.TFQiuEnemyView")

--boss
local SaosheBossView 	= import(".enemys.SaosheBossView")
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
		enemyView = SaosheBossView.new(property)
	elseif type == "chongBoss" then
		enemyView = ChongBossView.new(property)		
	elseif type == "renzheBoss" then
		enemyView = RenBossView.new(property)		
	elseif type == "duozuBoss" then
		enemyView = DuozuBossView.new(property)	

	--dao
	elseif type == "dao_wang" then
		enemyView = DDWangEnemyView.new(property)
	elseif type == "missile" then
		enemyView = DDNormalEnemyView.new(property)
	elseif type == "dao_wu" then 
		enemyView = DDWuEnemyView.new(property)

	--award
	elseif type == "awardSan" then
		enemyView = AwardSanEnemyView.new(property)	

	--renzhi
	elseif type == "renzhi" then
		enemyView = RZHushiEnemyView.new(property)
	elseif type == "shangren" then
		enemyView = RZShangrenEnemyView.new(property)	
	elseif type == "bangfei" then
		enemyView = RZBangfeiEnemyView.new(property)	
	elseif type == "bangren" then
		enemyView = RZBangrenEnemyView.new(property)

	--taofan
	elseif type == "taofan_qiu" then
		enemyView = TFQiuEnemyView.new(property)

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