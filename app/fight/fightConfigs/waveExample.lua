local BaseWave = import(".BaseWave")
local waveClass = class("waveExample", BaseWave)


-- 测试 近战兵
local waves = {
	{
		enemys = {  	
			-- {
			-- 	time = 2,
			-- 	num = 1,
			-- 	pos = {600, 200, 0, 170, 340, 100},
			-- 	delay = {0.4, 0.2,0.3, 0.5, 0.1, 0.1},
			-- 	property = {
			-- 		type = "jipu" ,
			-- 		id = 12,
			-- 		placeName = "place1",
			-- 		missileId = 7,
			-- 		missileType = "daodan",
			-- 		missileOffsets = {cc.p(-100,-100), cc.p(-100, 100), 
			-- 			cc.p(100, 100)},					
			-- 		startState = "enterleft",

			-- 		lastTime = 20.0,		--持续时间			
			-- 	},
			-- },	
			-- {
			-- 	time = 2,
			-- 	num = 1,
			-- 	pos = {600, 200, 0, 170, 340, 100},
			-- 	delay = {0.4, 0.2,0.3, 0.5, 0.1, 0.1},
			-- 	property = {
			-- 		type = "feiji" ,
			-- 		id = 13,
			-- 		placeName = "place2",
			-- 		missileId = 7,
			-- 		missileType = "daodan",
			-- 		missileOffsets = {cc.p(-100,-100), cc.p(-100, 100)},
			-- 		startState = "enterleft",
			-- 		lastTime = 18.0,		--持续时间			
			-- 	},
			-- },			

			-- 人质
			{
				time = 2,
				num = 1,
				pos = {300, 400, 0, 170, 340, 100},
				delay = {0.4, 0.2,0.3, 0.5, 0.1, 0.1},
				property = { 
					id = 11,
					type = "renzhi",
					placeName = "place5",
					startState = "enterleft",
					lastTime = 1120.0,		--持续时间
				},
			},		
			-- {
			-- 	time = 5,
			-- 	num = 1,
			-- 	pos = {100, 200, 0, 170, 340, 100},
			-- 	delay = {0.4, 0.2,0.3, 0.5, 0.1, 0.1},
			-- 	property = { 
			-- 		id = 8,
			-- 		type = "dao",
			-- 		placeName = "place5",	
			-- 		missileId = 9,
			-- 		missileType = "lei",					
			-- 	},
			-- },						
			-- {
			-- 	time = 3,
			-- 	num = 1,
			-- 	pos = {100, 200, 0, 170, 140, 100},
			-- 	delay = {0.1, 0.2,0.3, 0.1, 0.5, 0.1},
			-- 	property = { 
			-- 		id = 1,
			-- 		-- enemyId = 1,
			-- 		placeName = "place2",				
			-- 	},
			-- },	
			-- {
			-- 	time = 1,
			-- 	num = 6,
			-- 	pos = {100, 200, 0, 170, 340, 100},
			-- 	delay = {0.1, 0.1,0.1, 0.1, 0.1, 0.1},
			-- 	property = { 
			-- 		id = 3,
			-- 		enemyId = 1,
			-- 		type = "san",
			-- 		placeName = "place4",					
			-- 	},
			-- },	
			-- {
			-- 	time = 1,
			-- 	num = 6,
			-- 	pos = {100, 200, 0, 170, 340, 100},
			-- 	delay = {0.1, 0.1,0.1, 0.1, 0.1, 0.1},
			-- 	property = { 
			-- 		id = 3,
			-- 		enemyId = 1,
			-- 		type = "san",
			-- 		placeName = "place4",					
			-- 	},
			-- },		
			-- {
			-- 	time = 1,
			-- 	num = 6,
			-- 	pos = {100, 200, 0, 170, 340, 100},
			-- 	delay = {0.1, 0.1,0.1, 0.1, 0.1, 0.1},
			-- 	property = { 
			-- 		id = 3,
			-- 		enemyId = 1,
			-- 		type = "san",
			-- 		placeName = "place4",					
			-- 	},
			-- },		
			-- {
			-- 	time = 1,
			-- 	num = 6,
			-- 	pos = {100, 200, 0, 170, 340, 100},
			-- 	delay = {0.1, 0.1,0.1, 0.1, 0.1, 0.1},
			-- 	property = { 
			-- 		id = 3,
			-- 		enemyId = 1,
			-- 		type = "san",
			-- 		placeName = "place4",					
			-- 	},
			-- },																																
						
		},
	},
}



--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=1,hp=50,walkRate=4,rollRate=4,walkCd = 1.0, rollCd = 1.5, fireRate=200,
		weak1=2 ,fireCd=30.0},

	--近战兵
	{id=2,image="jinzhanb",demage=20,hp=400,walkRate=400,rollRate=0,fireRate=100,
		weak1=3},

	--伞兵
	{id=3,image="sanbing01",demage=3,hp=1,walkRate=400,rollRate=0,
		fireRate=100,weak1=3},

	--自爆兵
	{id=4,image="zibaob",demage=2,hp=200,walkRate=400,rollRate=0,
		fireRate=100,weak1=3},	

	--盾兵
	{id=5,image="dunbing",demage=2,hp=200,walkRate=400,rollRate=0,
		fireRate=100,weak1=3},			

	--导弹兵
	{id=6,image="zpbing",demage=0,hp=1000,walkRate=4,rollRate=4,walkCd = 1.0, rollCd = 1.5, fireRate=200,
		weak1=2, fireCd=30.0},		
		
	--导弹
	{id=7,image="daodan",demage=10,hp=100, weak1=3},		

	--手雷兵
	{id=8,image="shouleib",demage=10,hp=100,walkRate=400,rollRate=10, rollCd = 1.5,
		fireRate=200,weak1=3},	

	--手雷
	{id=9,image="shoulei",demage=10,hp=1,weak1=3},	

	--金币兵
	{id=10,image="qiqiu01",demage=10,hp=1,weak1=3,award = 60},	

	--人质
	{id=11,image="hs",demage=0,hp=300,walkRate=100,walkCd = 1.0,rollRate=10, rollCd = 1.5,
		weak1=3,speakRate =100,speakCd = 5.0,award = 60},

	--飞机
	{id=12,image="feiji",demage=0,hp=3000,fireRate=200, fireCd=2.0,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5, 
		weak1=3,award = 60},

	--越野车
	{id=13,image="yyc",demage=0,hp=3000,fireRate=200, fireCd=2.0,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5, 
		weak1=3,award = 60},		
}

local mapId = "map_1_2"

local isNotMoveMap = true  		--此关不能移动 

local limit = 6   				--此关敌人上限
 
function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.isMoveMap = isMoveMap
	self.renzhiLimit = 2   		--杀死人质上限
	self.goldLimits = {1, 5, 9}   --黄武激活所需杀人个数
end

return waveClass


-- -- 测试 近战
-- local waves = {
-- 	{
-- 		enemys = {  

-- 			{
-- 				time = 2,	
-- 				num = 6,
-- 				place = "place3",
-- 				pos = {100, 200, 0, 170, 190, 100},
-- 				delay = {0.1, 0.4, 0.7, 0.9, 1.2, 1.5},
-- 				property = { 
-- 					type = "jin",
-- 					id = 3,
-- 				},
-- 			},		
-- 		},
-- 	},
-- }

--伞兵例子
-- waves = {
-- 	{
-- 		enemys = {  
-- 			{
-- 				time = 2,	
-- 				num = 6,
-- 				place = "place2",
-- 				pos = {100, 200, 0, 170, 190, 100},
-- 				delay = {0.1, 0.4, 0.7, 0.9, 1.2, 1.5},
-- 				property = { 
-- 					type = "san",
-- 					id = 1,
-- 					enemyId = 1,
-- 					placeName = "place2",
-- 				},
-- 			},		
-- 		},
-- 	},
-- }

--boss例子
-- wave的配置
-- local waves = {
-- 	{
-- 		enemys = {  --boss
-- 			{
-- 				time = 3,	
-- 				num = 1,
-- 				place = "place3",
-- 				pos = {250},
-- 				delay = {0.3},
-- 				property = { 
-- 					type = "boss",
-- 					bossId = 1,
-- 					configName = "BossConfig_1",
-- 					index = 1, 
-- 				},
-- 			},		
-- 		},
-- 	},	
-- }

-- --boss的技能配置
-- local bosses = {
-- 	--第一个出场的boss
-- 	{
-- 		animName = "boss1", --图片名字
-- 		hp = 2000,
-- 		demage = 50,
-- 		fireRate = 200,
-- 		walkRate = 200,
-- 		fireOffset = 0.2,
-- 		demageScale = {weak1 = 2, weak2 = 3, weak3 = 3},
		
-- 		skilltrigger = {   --技能触发(可以同时)
-- 			moveLeftFire = {
-- 				0.95, 0.70,
-- 			},
-- 			moveRightFire = {
-- 				0.65, 0.30,
-- 			},
-- 			daoDan = {
-- 				0.90, 0.60, 0.50, 0.40,
-- 			},
-- 			saoShe = {
-- 				0.65, 0.55,
-- 			},
-- 			weak2 = {
-- 				0.70,
-- 			},	
-- 			weak3 = {
-- 				0.30,
-- 			},							
-- 		},
-- 	},

-- 	--第二个boss
-- 	{

-- 	},
-- }
