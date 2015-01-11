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
					type = "dao",
					id = 2,
					enemyId = 3,
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
		enemys = {  
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
				descId = "zpbing",  --简介
				time = 4,
				num = 1,
				delay = {3.0},
				pos = {25},
				property = {
					placeName = "place7",  
					type = "dao",
					id = 2,
					enemyId = 3,
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
					type = "dao",
					id = 2,
					enemyId = 3,
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
					type = "dao",
					id = 2,
					enemyId = 3,
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
					type = "dao",
					id = 2,
					enemyId = 3,
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
					type = "dao",
					id = 2,
					enemyId = 3,
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
					type = "dao",
					id = 2,
					enemyId = 3,
				},
			},	
		},
	},
}
--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=4,hp=1150,walkRate=400,rollRate=400,fireRate=200,
	weak1=5,weak2=4},

	--导弹兵
	{id=2,image="zpbing",demage=0,hp=1150,walkRate=400,rollRate=0,
		fireRate=200,weak1=5,weak2=5},		

	--导弹
	{id=3,image="daodan",demage=8,hp=100,weak1=3,weak2=5},
	--
}
local mapId = "map_1_4"

local isMoveMap = true
function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.isMoveMap = isMoveMap
end

return waveClass