local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				delay = {0, 0.3},
				pos = {50, 20},
				property = { 
					placeName = "place1",
					startState = "",
					id = 1,
				},
			},					
		},
	},
	{
		enemys = {
			{
				time = 1,
				num = 2,
				delay ={0, 0.3},
				pos = {10,100},		
				property = { 
					placeName = "place2",
					startState = "",
					id = 1,
				},
			},	
			{
				time = 1,
				num = 1,
				delay = {0.5},
				pos = {50},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 3,
				num = 2,
				delay = {0, 0.3},
				pos = {100,120},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {50},
				property = { 
					placeName = "place5",
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},						
			{
				time = 1,
				num = 3,
				delay = {0, 0.4, 0.8},
				pos = {0, 50, 100},
				property = { 
					placeName = "place4", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0.5},
				pos = {50},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},						
			{
				time = 5,
				num = 2,
				delay = {0, 0.1},
				pos = {0,100},
				property = { 
					placeName = "place5", 
					startState = "rollright",
					id = 1,
				},
			},	
			{
				time = 7,
				num = 2,
				delay = {0, 0.1},
				pos = {20,90},
				property = { 
					placeName = "place6", 
					startState = "",
					id = 1,
				},
			},
		},
	},				
}

--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=1,hp=170,walkRate=200,rollRate=200,fireRate=100,fireCd=5,
	weak1=5,weak2=4},
	--手雷兵
	{id=2,image="shouleib",demage=1,hp=170,walkRate=200,rollRate=200,fireRate=200,fireCd=5,weak1=3,weak2=5},	
	--手雷
	{id=3,image="shoulei",demage=5,hp=1,weak1=3,weak2=5},				
}


local mapId = "map_1_7"

local isNotMoveMap = true  		--此关不能移动 

local limit = 6   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.isNotMoveMap = isNotMoveMap
end

return waveClass