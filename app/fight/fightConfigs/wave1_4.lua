local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place1",  
					id = 1,
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place2",  
					id = 1,
				},
			},
			{
				time = 11,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place3",  
					id = 1,
				},
			},	
		},
	},
	{
		enemys = {  --boss
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place3",  
					id = 1,
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place1",  
					id = 1,
				},
			},
			{
				time = 11,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place2",  
					id = 1,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place4",  
					id = 1,
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place5",  
					id = 1,
				},
			},
			{
				time = 13,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place6",  
					id = 1,
				},
			},	
		},
	},
	{
		enemys = {  --boss
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place6",  
					id = 1,
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place4",  
					id = 1,
				},
			},
			{
				time = 11,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place5",  
					id = 1,
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place7",  
					id = 1,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place8",  
					id = 1,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place9",  
					id = 1,
				},
			},	
		},
	},
	{
		enemys = {  --boss
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place2",  
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place3",  
					id = 1,
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place1",  
					id = 1,
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place8",  
					id = 1,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place7",  
					id = 1,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place9",  
					id = 1,
				},
			},	
		},
	},
		{
		enemys = {  --boss
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place1",  
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place4",  
					id = 1,
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place7",  
					id = 1,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place10",  
					id = 1,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place9",  
					id = 1,
				},
			},
			{
				time = 18,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place6",  
					id = 1,
				},
			},	
		},
	},
	{
		enemys = {  --boss
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place2",  
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place5",  
					id = 1,
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place8",  
					id = 1,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place10",  
					id = 1,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place7",  
					id = 1,
				},
			},
			{
				time = 18,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					placeName = "place4",  
					id = 1,
				},
			},	
		},
	},
}
--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=5,hp=460,walkRate=400,rollRate=400,fireRate=200,
	weak1=2,weak2=4},

	--
}

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
end

return waveClass