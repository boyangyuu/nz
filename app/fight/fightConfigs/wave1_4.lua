local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {350},
				property = {
					placeName = "place5",  
					startState = "rollleft",
					id = 1,
				},
			},

		},
	},
	{
		enemys = { 
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {330},
				property = {
					placeName = "place5",  
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {200},
				property = {
					placeName = "place11",  
					startState = "rollright",
					id = 4,
					type = "dao",
					missileId = 5,
					missileType = "lei",
				},
			},
			{
				
				time = 9,
				num = 1,
				delay = {0},
				pos = {125},
				property = {
					placeName = "place2",  
					startState = "rollleft",
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
				pos = {200},
				property = {
					placeName = "place11",  
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {116},
				property = {
					placeName = "place6",  
					id = 1,
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0},
				pos = {100},
				property = {
					placeName = "place2",  
					id = 1,
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0},
				pos = {666},
				property = {
					placeName = "place5",  
					id = 4,
					type = "dao",
					missileId = 5,
					missileType = "lei",
				},
			},
			{
				time = 17,
				num = 1,
				delay = {0},
				pos = {76},
				property = {
					placeName = "place3",  
					id = 1,
				},
			},	
			{
				time = 20,
				num = 1,
				delay = {0},
				pos = {20},
				property = {
					placeName = "place10",  
					type = "dao",
					id = 2,
					missileId = 3,
				},
			},
			
		},
	},

}
--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=3,hp=220,walkRate=400,rollRate=800,fireRate=400,
	weak1=5,weak2=4},

	--导弹兵
	{id=2,image="zpbing",demage=0,hp=450,walkRate=400,rollRate=400,fireRate=500,weak1=5,weak2=5},		

	--导弹
	{id=3,image="daodan",demage=8,hp=100,weak1=3,weak2=5},

	--手雷兵
	{id=4,image="shouleib",demage=1,hp=220,walkRate=200,rollRate=600,fireRate=400,fireCd=5,weak1=3,weak2=5},	
	--手雷
	{id=5,image="shoulei",demage=4,hp=1,weak1=3,weak2=5},	
}
local mapId = "map_1_4"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId

end

return waveClass