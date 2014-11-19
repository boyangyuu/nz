local waves = {
	-- {
	-- 	enemys = {  --boss
	-- 		{
	-- 			time = 3,	
	-- 			num = 1,
	-- 			place = "place3",
	-- 			pos = {500},
	-- 			delay = 0.3,
	-- 			property = { 
	-- 				type = "boss",
	-- 				id = "1",
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
				delay = 0.3,
				pos = {10, 200, 50, 100, 90},
				property = { 
					startState = "rollright",
					id = "1",
				},
			},
			{
				time = 3,
				num = 5,
				place = "place2",
				delay = 0.3,
				pos = {10, 200, 50, 100, 90},	
				property = { 
					startState = "rollleft",
					id = "1",
				},
			},	
			{
				time = 2,
				num = 5,
				place = "place2",
				delay = 0.5,
				pos = {10, 20, 50, 100, 60},					
				property = { 
					id = "1",
				},
			},						
		},
	},	
	-- {
	-- 	enemys = {
	-- 		{
	-- 			time = 10,
	-- 			num = 5,
	-- 			place = "place1",
	-- 			delay = 0.3,
	-- 			pos = {10, 20, 50, 100, 60},
	-- 			offset = 15,
	-- 			property = { 
	-- 				startState = "rollright",
	-- 				id = "1",
	-- 			},
	-- 		},					
	-- 	},
	-- },		
}

function getWaves(waveIndex)
	return waves[waveIndex] 
end

function getFocusRange()
	return 20
end