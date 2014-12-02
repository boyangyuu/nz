
local waveClass = class("waveExample", cc.mvc.ModelBase)


-- 测试 近战兵
local waves = {
	{
		enemys = {  

			{
				time = 2,
				num = 1,
				
				pos = {100, 200, 0, 170, 340, 100},
				delay = {0.1, 0.4, 1.7, 0.9, 3.2, 1.5},
				property = { 
					type = "bao",
					id = 1,
					placeName = "place3",
				},
			},		
		},
	},
}

function waveClass:getWaves(waveIndex)
	return waves[waveIndex] 
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
