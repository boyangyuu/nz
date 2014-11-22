local waveClass = class("wave1_2", cc.mvc.ModelBase)

local waves = {
	{
		enemys = { 
			{
				time = 3,	
				num = 4,
				place = "place1",
				pos = {-50,50,150,250},
				delay = {0,0.5,0.6,1},
				property = { 
					startState = "rollright",
					id = "1",
				},
			},
						{
				time = 4,	
				num = 3,
				place = "place2",
				pos = {100,200,300},
				delay = {0,1,2},
				property = { 
					startState = "rollleft",
					id = 1,
				},
			},		
			{
				time = 5,	
				num = 3,
				place = "place3",
				pos = {200,400,300},
				delay = {1,2,3},
				property = { 
					startState = "rollleft",
					id = 1,
				},
			},		
		},
	},
	{
		enemys = {
			{
				time = 3,
				num = 2,
				place = "place4",
				delay = {0.3, 0.6},
				pos = {300,150},
				property = { 
					id = 1,
				},
			},
			{
				time = 4,
				num = 2,
				place = "place5",
				delay = {0.3, 0.6},
				pos = {250,400},	
				property = { 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 5,
				num = 2,
				place = "place6",
				delay = {0.3, 0.6},
				pos = {200,100},					
				property = { 
					id = 1,
				},
			},	
			{
				time = 8,	
				num = 2,
				place = "place1",
				pos = {100, 300},
				delay = {1, 2},
				property = { 
					type = "san",
					id = 1,
					enemyId = 1,
					placeName = "place1",
				},
			},
			{
				time = 9,	
				num = 1,
				place = "place2",
				pos = {100, 250},
				delay = {0.5, 1.5},
				property = { 
					type = "san",
					id = 1,
					enemyId = 1,
					placeName = "place2",
				},
			},									
		},

	},	
	{
		enemys = {  --boss
			{
				time = 3,	
				num = 1,
				place = "place7",
				pos = {250},
				delay = {0.3},
				property = { 
					type = "boss",
					bossId = 1,
					configName = "BossConfig_1",
					index = 1, 
				},
			},		
		},
	},
}


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


--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		animName = "boss1", --图片名字
		hp = 10000,
		demage = 50,
		fireRate = 200,
		walkRate = 200,
		fireOffset = 0.2,
		demageScale = {weak1 = 2, weak2 = 3, weak3 = 3},
		
		skilltrigger = {   --技能触发(可以同时)
			moveLeftFire = {
				0.95, 0.70,
			},
			moveRightFire = {
				0.65, 0.30,
			},
			daoDan = {
				0.90, 0.60, 0.50, 0.40,
			},
			saoShe = {
				0.65, 0.55,
			},
			weak2 = {
				0.70,
			},	
			weak3 = {
				0.30,
			},							
		},
	},
}

function waveClass:getWaves(waveIndex)
	return waves[waveIndex] 
end

function waveClass:getBoss(index)
	return bosses[index] 
end
return waveClass