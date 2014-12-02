local waveClass = class("wave1_3", cc.mvc.ModelBase)

local waves = {
	-- {
	-- 	enemys = {
	-- 		{
	-- 			time = 3,
	-- 			num = 7,
	-- 			delay = {0.3,0,0.5,0.7,5,5.2,5.4},
	-- 			pos = {0,75,150,200,50,100,150},
	-- 			property = {
	-- 				placeName = "place1",  
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 3,
	-- 			num = 7,
	-- 			delay = {0.3,0, 0.5, 0.7, 4.1,4.5,4.3},
	-- 			pos = {100, 200, 300, 400, 150,250,350},	
	-- 			property = {
	-- 				placeName = "place2",   
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 4,
	-- 			num = 2,
	-- 			delay = {0.3, 0.6},
	-- 			pos = {50,100},					
	-- 			property = {
	-- 				placeName = "place3",   
	-- 				id = 1,
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 4,
	-- 			num = 2,
	-- 			delay = {0.3, 0.6},
	-- 			pos = {150,200},					
	-- 			property = {
	-- 				placeName = "place4",   
	-- 				id = 1,
	-- 			},
	-- 		},					
	-- 	},
	-- },	
	{
		enemys = {
			{
				time = 3,
				num = 1,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5,2.0},
				pos = {0,50,100,300,350,400},
				property = {
					type = "common",
					placeName = "place5",  
					id = 2,
				},
			},		
			{
				time = 5,
				num = 6,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5,2.0},
				pos = {0,50,100,300,350,400},
				property = {
					type = "jin",
					placeName = "place5",  
					id = 1,
				},
			},
			{
				time = 6,
				num = 6,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5,2.0},
				pos = {300,250,200,100,50},
				property = {
					type = "jin",
					placeName = "place5",  
					id = 1,
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0.3},
				pos = {200},
				property = {
					placeName = "place4",  
					id = 1,
				},
			},
			{
				time = 8,	
				num = 4,
				place = "place5",
				pos = {100, 200, 150, 250},
				delay = {0.1, 0.4, 0.7, 0.9},
				property = { 
					type = "san",
					id = 1,
					enemyId = 1,
					placeName = "place5",
				},
			},
			{
				time = 8,	
				num = 2,
				pos = {130, 200},
				delay = {0.1, 0.7},
				property = { 
					type = "san",
					id = 1,
					enemyId = 1,
					placeName = "place6",
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 3,
				num = 3,
				delay = {0.3, 0.6, 0.9},
				pos = {150,250,400},
				property = {
					type = "jin",
					placeName = "place5",  
					id = 1,
				},
			},
			{
				time = 3,
				num = 2,
				delay = {0.3, 0.6},
				pos = {200,100},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 1,
				},
			},
			{
				time = 3,
				num = 2,
				delay = {0.3,0.5},
				pos = {200,100},
				property = {
					type = "jin",
					placeName = "place6",  
					id = 1,
				},
			},
			{
				time = 8,	
				num = 2,
				pos = {0,50},
				delay = {0.1, 0.4},
				property = { 
					id = 1,
					placeName = "place3",
				},
			},
			{
				time = 8,	
				num = 3,
				pos = {130, 200,300},
				delay = {0.1, 0.7,0.4},
				property = { 
					type = "bao",
					id = 1,
					placeName = "place5",
				},
			},
			{
				time = 8,	
				num = 3,
				pos = {130, 200,0},
				delay = {0.1, 0.7,0.5},
				property = { 
					type = "bao",
					id = 1,
					placeName = "place6",
				},
			},
			{
				time = 8,	
				num = 1,
				pos = {0},
				delay = {0.1},
				property = { 
					type = "bao",
					id = 1,
					placeName = "place4",
				},
			},
			{
				time = 8,	
				num = 3,
				pos = {300, 350,400},
				delay = {0.1, 0.7,0.5},
				property = { 
					id = 1,
					placeName = "place2",
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 1,
				num = 6,
				delay = {0.3, 0.6, 0.9,1.2,4.0,4.5},
				pos = {150,250,400,50,100,350},
				property = {
					type = "san",
					placeName = "place5",  
					id = 1,
				},
			},
			{
				time = 2,
				num = 7,
				delay = {0.3, 0.6,0,0.9,1.2,5.0,5.5,6.0},
				pos = {200,100,0,300,50,150,250},
				property = {
					type = "san",
					placeName = "place7",  
					id = 1,
				},
			},
			{
				time = 3,
				num = 6,
				delay = {0.3,0.5,0.9,6.0,6.5},
				pos = {50,150,250,100,200},
				property = {
					type = "san",
					placeName = "place6",  
					id = 1,
				},
			},
		},
	},	
}


function waveClass:getWaves(waveIndex)
	return waves[waveIndex] 
end

return waveClass