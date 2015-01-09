local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 2,
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
				time = 0,
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
				time = 7,
				num = 1,
				delay = {0.5},
				pos = {50},
				property = { 
					placeName = "place2",
					id = 1,
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
				time = 8,
				num = 3,
				delay = {0, 0.4, 0.8},
				pos = {0, 50, 100},
				property = { 
					placeName = "place4", 
					startState = "rollright",
					id = 1,
				},
			},						
		},

	},
	{
		enemys = {
			{
				time = 3,
				num = 2,
				delay = {0, 0.1},
				pos = {0,100},
				property = { 
					placeName = "place5", 
					startState = "",
					id = 1,
				},
			},	
			{
				time = 4,
				num = 2,
				delay = {0, 0.1},
				pos = {20,90},
				property = { 
					placeName = "place6", 
					startState = "",
					id = 1,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place7", 
					startState = "",
					id = 1,
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0, 0.3},
				pos = {100, 150},
				property = { 
					placeName = "place8",
					startState = "rollleft",
					id = 1,
				},
			},						
		},

	},				
}

--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=1,hp=170,walkRate=400,rollRate=400,fireRate=200,
	weak1=5,weak2=4},

	--
}

local mapId = "map_1_1"

local isMoveMap = false

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.isMoveMap = isMoveMap
end

return waveClass