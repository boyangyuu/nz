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
				time = 3,
				num = 1,
				delay = {0},
				pos = {568},
				property = {
					placeName = "place5",  
					startState = "rollright",
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
					startState = "",
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
				pos = {200},
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
					startState = "rollright",
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {116},
				property = {
					placeName = "place6",  
					startState = "",
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
					startState = "rollright",
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
					startState = "rollright",
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
					startState = "rollright",
				},
			},	
			{
				time = 20,
				num = 1,
				delay = {0},
				pos = {15},
				property = {
					placeName = "place10",  
					type = "dao",
					id = 2,
					missileId = 3,
					missileType = "daodan",
				},
			},
			
		},
	},

}
--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=3,hp=220,walkRate=120,walkCd=1,rollRate=1200,rollCd=10,fireRate=420,fireCd=4,
	weak1=3},

	--导弹兵
	{id=2,image="zpbing",demage=0,hp=450,walkRate=400,walkCd=2.0,fireRate=480,fireCd=5,
	weak1=3},		

	--导弹
	{id=3,image="daodan",demage=8,hp=100,
	weak1=3},

	--手雷兵
	{id=4,image="shouleib",demage=0,hp=220,walkRate=200,walkCd=1.0,rollRate=1200,rollCd=10,fireRate=400,fireCd=5,
	weak1=3},	
	--手雷
	{id=5,image="shoulei",demage=4,hp=1,
	weak1=3,},	
}
local mapId = "map_1_4"

local limit = 10    				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId

end

return waveClass