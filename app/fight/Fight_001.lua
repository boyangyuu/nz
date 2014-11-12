local waves = {
	{
		enemys = {  --boss
			{
				time = 3,	
				num = 1,
				place = "place1",
				delay = 0.3,
				property = { 
					type = "boss",
					id = "1",
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
				delay = 0.3,
				pos = 20,
				offset = 5,
				property = { 
					startState = "rollright",
					id = "1",
				},
			},
			{
				time = 12,
				num = 5,
				place = "place2",
				delay = 0.3,
				pos = 20,
				offset = 5,			
				property = { 
					startState = "rollright",
					id = "1",
				},
			},	
			{
				time = 20,
				num = 5,
				place = "place2",
				delay = 0.5,
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
				time = 10,
				num = 5,
				place = "place1",
				delay = 0.3,
				pos = 20,
				offset = 5,
				property = { 
					startState = "rollright",
					id = "1",
				},
			},					
		},
	},		
}

function getWaves(waveIndex)
	return waves[waveIndex] 
end