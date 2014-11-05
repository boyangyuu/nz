local waves = {
	{
		enemys = {
			{
				time = 3,	
				num = 5,
				place = "place1",
				delay = 0.3,
				property = { 
					startState = "rollright", --出生状态
					id = "1",
				},
				
			},
			{
				time = 6,
				num = 5,
				place = "place2",
				delay = 0.3,
				property = { 
					startState = "rollright",
					id = "2",
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
}

function getWaves(waveIndex)
	return waves[waveIndex] 
end