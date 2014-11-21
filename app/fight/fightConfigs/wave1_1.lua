local waveClass = class("wave1_1", cc.mvc.ModelBase)

local waves = {
	{
		enemys = {
			{
				time = 2,
				num = 1,
				place = "place1",
				delay = {0, 0.3},
				pos = {50, 20},
				property = { 
					startState = "",
					id = "1",
				},
			},
			{
				time = 7,
				num = 2,
				place = "place2",
				delay ={0, 0.3},
				pos = {10,100},		
				property = { 
					startState = "",
					id = "1",
				},
			},	
			{
				time = 8,
				num = 1,
				place = "place2",
				delay = {0.5},
				pos = {50},
				property = { 
					id = "1",
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 3,
				num = 2,
				place = "place3",
				delay = {0, 0.3},
				pos = {120,130},
				property = { 
					startState = "rollleft",
					id = "1",
				},
			},	
			{
				time = 8,
				num = 3,
				place = "place4",
				delay = {0, 0.4, 0.8},
				pos = {0, 50, 100},
				property = { 
					startState = "rollright",
					id = "1",
				},
			},						
		},

	},
	{
		enemys = {
			{
				time = 3,
				num = 2,
				place = "place5",
				delay = {0, 0.1},
				pos = {0,100},
				property = { 
					startState = "",
					id = "1",
				},
			},	
			{
				time = 4,
				num = 2,
				place = "place6",
				delay = {0, 0.1},
				pos = {20,90},
				property = { 
					startState = "",
					id = "1",
				},
			},
			{
				time = 5,
				num = 1,
				place = "place7",
				delay = {0.1},
				pos = {20},
				property = { 
					startState = "",
					id = "1",
				},
			},
			{
				time = 6,
				num = 2,
				place = "place8",
				delay = {0, 0.3},
				pos = {100, 150},
				property = { 
					startState = "rollleft",
					id = "1",
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