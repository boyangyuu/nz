local BaseWave = import(".BaseWave")
local waveClass = class("waveExample", BaseWave)


-- 测试 近战兵
local waves = {
	{
		enemys = {  	
			{
				time = 1,
				num = 1,
				pos = {100, 200, 0, 170, 340, 100},
				delay = {0.1, 0.1,0.1, 0.1, 0.1, 0.1},
				property = { 
					id = 4,
					type = "bao",
					placeName = "place4",
				},
			},	
						
		},
	},
}
--[[

]]
--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=3,hp=100,walkRate=400,rollRate=400,fireRate=200,
		weak1=2,weak2=4},

	--近战兵
	{id=2,image="jinzhanb",demage=20,hp=400,walkRate=400,rollRate=0,fireRate=100,
		weak1=3,weak2=5},

	--伞兵
	{id=3,image="sanbing01",demage=3,hp=1,walkRate=400,rollRate=0,
		fireRate=100,weak1=3,weak2=5},

	--自爆兵
	{id=4,image="zibaob",demage=2,hp=200,walkRate=400,rollRate=0,
		fireRate=100,weak1=3,weak2=5},	

	--盾兵
	{id=5,image="dunbing",demage=2,hp=200,walkRate=400,rollRate=0,
		fireRate=100,weak1=3,weak2=5},			

	--导弹兵
	{id=6,image="zpbing",demage=0,hp=1000,walkRate=400,rollRate=0,
		fireRate=200,weak1=3,weak2=5},		
		
	--导弹
	{id=7,image="daodan",demage=10,hp=100, weak1=3,weak2=5},		

	--手雷兵
	{id=8,image="shouleib",demage=10,hp=100,walkRate=400,rollRate=100,
		fireRate=200,weak1=3,weak2=5},	

	--手雷
	{id=9,image="shoulei",demage=10,hp=1,weak1=3,weak2=5},				
}

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
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
