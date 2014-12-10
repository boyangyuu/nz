local waveClass = class("wave1_5", cc.mvc.ModelBase)
local waves = {
	-- {
	-- 	enemys = { 
	-- 		{
	-- 			time = 3,	
	-- 			num = 4,
	-- 			pos = {10,90,310,400},
	-- 			delay = {0,0.9,0.5,0.8},
	-- 			property = {
	-- 				placeName = "place1" ,
	-- 				type = "",
	-- 				id = "1"
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 2,	
	-- 			num = 1,
	-- 			pos = {230},
	-- 			delay = {0.6},
	-- 			property = {
	-- 				placeName = "place13" ,
	-- 				type = "jin",
	-- 				id = "8",
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 6,	
	-- 			num = 3,
	-- 			pos = {80,200,280},
	-- 			delay = {0,0.4,0.2},
	-- 			property = {
	-- 				placeName = "place3" , 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 9,	
	-- 			num = 3,
	-- 			place = "",
	-- 			pos = {200,120,100},
	-- 			delay = {0.3,0.6,0.7},
	-- 			property = {
	-- 				placeName = "place2" , 
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 10,	
	-- 			num = 1,
	-- 			pos = {25},
	-- 			delay = {0.3},
	-- 			property = {
	-- 				placeName = "place4" ,  
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 13,	
	-- 			num = 1,
	-- 			pos = {40},
	-- 			delay = {0.3},
	-- 			property = {
	-- 				placeName = "place5" ,   
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 16,	
	-- 			num = 1,
	-- 			pos = {30},
	-- 			delay = {0.3},
	-- 			property = {
	-- 				placeName = "place6" ,    
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 19,	
	-- 			num = 1,
	-- 			pos = {30},
	-- 			delay = {0.3},
	-- 			property = { 
	-- 				placeName = "place7" ,  
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 22,	
	-- 			num = 1,
	-- 			pos = {30},
	-- 			delay = {0.3},
	-- 			property = { 
	-- 				id = 1,
	-- 				placeName = "place8" ,  
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 25,	
	-- 			num = 1,
	-- 			pos = {30},
	-- 			delay = {0.3},
	-- 			property = {
	-- 				placeName = "place9" ,   
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 16,	
	-- 			num = 1,
	-- 			pos = {10},
	-- 			delay = {0.3},
	-- 			property = {
	-- 				type = "san",
	-- 				enemyId = 1,
	-- 				placeName = "place10" ,
	-- 				id = 9,
	-- 			},
	-- 		},		
		
	-- 	},
	-- },
	{
		enemys = {
			{
				time = 2,
				num = 4,
				delay = {0.6,0.8,1.1,1.6},
				pos = {10,50, 120, 90},
				property = { 
					placeName = "place1" ,
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 2,
				num = 2,
				delay = {0.3,3},
				pos = {0,400},
				property = { 
					placeName = "place13" ,
					type = "jin",
					id = 4,
				},
			},
			{
				time = 4,
				num = 5,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 200, 50, 120, 90},	
				property = { 
					startState = "rollleft",
					placeName = "place3" ,
					id = 1,
				},
			},	
			{
				time = 5,
				num = 5,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},					
				property = { 
					placeName = "place2" ,
					id = 1,
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 3,
				num = 5,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},
				property = {
					placeName = "place1" , 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 5,
				num = 2,
				delay = { 1.2, 1.5},
				pos = {10, 60},
				property = {
					placeName = "place13" , 
					type = "dao",
					id = 6,
				},
			},					
		},
	},		
}

function waveClass:getWaves(waveIndex)
	return waves[waveIndex] 
end

return waveClass