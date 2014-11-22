local waveClass = class("wave1_2", cc.mvc.ModelBase)

local waves = {
	{
		enemys = {  --boss
			{
				time = 3,	
				num = 5,
				place = "place1",
				pos = {10,110,210,310,410},
				delay = {0,0.3,0.6,0.5,0.8},
				property = { 
					id = "1",
				},
			},
						{
				time = 4,	
				num = 3,
				place = "place3",
				pos = {100,200,300},
				delay = {0,0,0},
				property = { 
					startState = "rollleft",
					id = 1,
				},
			},		
			{
				time = 5,	
				num = 3,
				place = "place2",
				pos = {200,100,300},
				delay = {0.3,0.3,0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 8,	
				num = 1,
				place = "place4",
				pos = {25},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 10,	
				num = 1,
				place = "place5",
				pos = {40},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 10,	
				num = 1,
				place = "place6",
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 10,	
				num = 1,
				place = "place7",
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 13,	
				num = 1,
				place = "place8",
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 13,	
				num = 1,
				place = "place9",
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 16,	
				num = 1,
				place = "place10",
				pos = {10},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
		
		},
	},
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



function waveClass:getWaves(waveIndex)
	return waves[waveIndex] 
end

return waveClass