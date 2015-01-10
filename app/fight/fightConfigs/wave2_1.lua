local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 3,	
				num = 4,
				pos = {0,50,150,250},
				delay = {0,2,4,6},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 4,	
				num = 4,
				pos = {0,100,200,300},
				delay = {0,2,4,6},
				property = { 
					placeName = "place2",
					id = 4,
					type = "dao",
					missileId = 5,
					missileType = "lei",
				},
			},		
			{
				time = 5,	
				num = 4,
				pos = {0,200,400,300},
				delay = {1,2,3,4},
				property = {
					placeName = "place3", 
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
				num = 3,
				delay = {0,2,4},
				pos = {0,300,150},
				property = {
					placeName = "place4",
					type = "jin",
					id = 2,
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0,2, 4},
				pos = {0,250,400},	
				property = { 
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 5,
				num = 3,
				delay = {0,2,4},
				pos = {0,200,100},					
				property = {
					placeName = "place6",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 8,	
				num = 3,
				pos = {0,100, 300},
				delay = {0,2, 4},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place1",
				},
			},
			{
				time = 9,	
				num = 3,
				pos = {0,100, 250},
				delay = {0,2,4},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place2",
				},
			},	
			{
				time = 10,	
				num = 5,
				pos = {0,50,150,250,100},
				delay = {0,1,2,3,4},
				property = { 
					placeName = "place6",
					id = 1,
				},
			},
			{
				time = 11,	
				num = 5,
				pos = {0,50,150,250,100},
				delay = {0,1,2,3,4},
				property = { 
					placeName = "place2",
					id = 1,
				},
			},
			{
				time = 12,	
				num = 5,
				pos = {0,50,150,250,100},
				delay = {0,1,2,3,4},
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
	{id=1,image="anim_enemy_002",demage=2,hp=340,walkRate=400,rollRate=400,fireRate=400,
	weak1=4,weak2=4},

	--近战兵
	{id=2,image="jinzhanb",demage=4,hp=1080,walkRate=400,rollRate=100,fireRate=100,
		weak1=2,weak2=2},

	--伞兵
	{id=3,image="sanbing01",demage=2,hp=340,walkRate=400,rollRate=100,
		fireRate=300,weak1=4,weak2=5},

	--手雷兵
	{id=4,image="shouleib",demage=10,hp=100,walkRate=400,rollRate=100,fireRate=400,weak1=3,weak2=5},	
	
	--手雷
	{id=5,image="shoulei",demage=10,hp=1,weak1=3,weak2=5},
}



local mapId = "map_1_2"
local isMoveMap = true

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.isMoveMap = isMoveMap
end

return waveClass