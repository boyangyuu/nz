local waves = {
	{
		-- time = 10,
		enemys = {
			{
				time = 3,
				id = 1,
				num = 5,
				place = "place1",
			},
			{
				time = 6,
				id = 1,
				num = 5,
				place = "place2",
			},			
		},
	},
	 {
		-- time = 30,
		enemys = {
			{
				time = 10,
				id = 1,
				num = 2,
				place = "place1",
			},
			{
				time = 12,
				id = 1,
				num = 2,
				place = "place2",
			},	
			{
				time = 20,
				id = 1,
				num = 3,
				place = "place1",
			},						
		},
	},	
}

function getWaves()
	return waves
end