local waveClass = class("wave1_1", cc.mvc.ModelBase)

local waves = {
	-- {
	-- 	enemys = {  --boss
	-- 		{
	-- 			time = 3,	
	-- 			num = 1,
	-- 			place = "place3",
	-- 			pos = {250},
	-- 			delay = {0.3},
	-- 			property = { 
	-- 				type = "boss",
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 	},
	-- },
	{
		enemys = {
			{
				time = 2,
				num = 5,
				place = "place1",
				delay = {0.3, 0.6},
				pos = {10, 200, 50, 100, 90},
				property = { 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 3,
				num = 5,
				place = "place2",
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 200, 50, 100, 90},	
				property = { 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 2,
				num = 5,
				place = "place2",
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},					
				property = { 
					id = 1,
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 10,
				num = 5,
				place = "place1",
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},
				property = { 
					startState = "rollright",
					id = 1,
				},
			},					
		},
	},		
}

--测试 sanBing
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

function waveClass:getWaves(waveIndex)
	return waves[waveIndex] 
end

return waveClass