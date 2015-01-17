local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 3,
				num = 3,
				delay = {0.3,0,0.6,0.9,5,7,6},
				pos = {0,75,150,200,50,100,150},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 2,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0.3,0,0.6,0.9,5,7,6},
				pos = {75,150,200,50,100,150},
				property = {
					type = "jin",
					placeName = "place1",  
					id = 2,
				},
			},
			{
				time = 5,
				num = 2,
				delay = {0.3,0,0.6,0.9,5,7,6},
				pos = {300,400,50,100,150},
				property = {
					type = "jin",
					placeName = "place2",  
					id = 2,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.3, 0.6},
				pos = {50,100},					
				property = {
					placeName = "place3",   
					id = 8,
					startState = "",
					type = "dao",
					missileId = 9,
					missileType = "lei",
				},
			},	
			{
				time = 9,
				num = 1,
				delay = {0.3, 0.6},
				pos = {150,200},					
				property = {
					placeName = "place4",   
					id = 8,
					startState = "",
					type = "dao",
					missileId = 9,
					missileType = "lei",
				},
			},					
		},
	},	
	{
		enemys = {
			{
				time = 3,
				num = 6,
				delay = {0.5, 1, 2, 7,8,9},
				pos = {100,200,300,400,250,50},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 2,
				},
			},
			{
				time =5,
				num = 6,
				delay = {0.3, 0.8, 1.3, 8, 9,10},
				pos = {0,200,100,250,150,50},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 2,
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0.3},
				pos = {200},
				property = {
					placeName = "place4",  
					id = 1,
				},
			},
			{
				time = 13,	
				num = 4,
				place = "place5",
				pos = {100, 200, 150, 250},
				delay = {0.1, 2, 0.9, 3},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place2",
				},
			},
			{
				time = 18,	
				num = 2,
				pos = {130, 200},
				delay = {0.1, 1.7},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place1",
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 3,
				num = 2,
				delay = {0.3, 1.3},
				pos = {150,250},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 2,
				},
			},
			{
				time =5,
				num = 2,
				delay = {0.3, 1.3},
				pos = {200,100},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 2,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.3,1.3},
				pos = {200,100},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 2,
				},
			},
			{
				time = 9,	
				num = 2,
				pos = {0,50},
				delay = {0.1, 0.4},
				property = { 
					id = 1,
					placeName = "place3",
				},
			},
			{
				descId = "zibaob",  --简介
				time = 15,	
				num = 3,
				pos = {130, 200,300},
				delay = {3.1, 4, 5},
				property = { 
					type = "bao",
					id = 4,
					placeName = "place4",
				},
			},
			{
				time = 18,	
				num = 3,
				pos = {130, 200, 0},
				delay = {0.1, 1,2},
				property = { 
					type = "bao",
					id = 4,
					placeName = "place4",
				},
			},
			{
				time = 21,	
				num = 1,
				pos = {0},
				delay = {0.1},
				property = { 
					type = "bao",
					id = 4,
					placeName = "place4",
				},
			},
			{
				time = 24,	
				num = 3,
				pos = {300, 350,400},
				delay = {0.1, 0.7,0.5},
				property = { 
					id = 1,
					placeName = "place2",
				},
			},						
		},
	},	
	-- 金币
	{
		enemys = {
			{
				time = 1,
				num = 6,
				delay = {0.3, 0.6, 1,1.5,2.0,2.5},
				pos = {150,250,400,50,100,350},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 2.0,
					id = 7,
				},
			},
			{
				time = 4,
				num = 7,
				delay = {0.3, 0.6,1.5,0.9,2,2.0,2.5},
				pos = {200,100,0,300,50,150,250},
				property = {
					type = "jinbi",
					placeName = "place7",  
					speed = 3.0,
					id = 6,
				},
			},
			{
				time = 7,
				num = 6,
				delay = {0.3,0.5,1,2.0,2.5, 2.6},
				pos = {50,150,250,100,200, 80},
				property = {
					type = "jinbi",
					placeName = "place6", 
					speed = 4.0, 
					id = 5,
				},
			},
			{
				time = 1,
				num = 6,
				delay = {0.3, 0.6, 1,1.5,2.0,2.5},
				pos = {150,250,400,50,100,350},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 4.0,
					id = 5,
				},
			},
			{
				time = 4,
				num = 7,
				delay = {0.3, 0.6, 1.5, 0.9, 2, 3.0, 3.5},
				pos = {200, 100, 0, 300, 50, 150, 250},
				property = {
					type = "jinbi",
					placeName = "place7",  
					speed = 3.0,
					id = 6,
				},
			},
			{
				time = 2,
				num = 5,
				delay = {0.3, 0.5, 1, 1.0, 1.5},
				pos = {50, 150, 250, 100, 200},
				property = {
					type = "jinbi",
					placeName = "place6", 
					speed = 2.0, 
					id = 7,
				},
			},			
		},
	},	
	{
		enemys = {
			{
				time = 1,
				num = 6,
				delay = {0.3, 0.6, 1,1.5,2.0,2.5},
				pos = {150,250,400,50,100,350},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 2.0,
					id = 7,
				},
			},
			{
				time = 4,
				num = 7,
				delay = {0.3, 0.6,1.5,0.9,2,2.0,2.5},
				pos = {200,100,0,300,50,150,250},
				property = {
					type = "jinbi",
					placeName = "place7",  
					speed = 3.0,
					id = 6,
				},
			},
			{
				time = 7,
				num = 6,
				delay = {0.3,0.5,1,2.0,2.5, 2.6},
				pos = {50,150,250,100,200, 80},
				property = {
					type = "jinbi",
					placeName = "place6", 
					speed = 4.0, 
					id = 5,
				},
			},
			{
				time = 1,
				num = 6,
				delay = {0.3, 0.6, 1,1.5,2.0,2.5},
				pos = {150,250,400,50,100,350},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 4.0,
					id = 5,
				},
			},
			{
				time = 4,
				num = 7,
				delay = {0.3, 0.6, 1.5, 0.9, 2, 3.0, 3.5},
				pos = {200, 100, 0, 300, 50, 150, 250},
				property = {
					type = "jinbi",
					placeName = "place7",  
					speed = 3.0,
					id = 6,
				},
			},
			{
				time = 2,
				num = 5,
				delay = {0.3, 0.5, 1, 1.0, 1.5},
				pos = {50, 150, 250, 100, 200},
				property = {
					type = "jinbi",
					placeName = "place6", 
					speed = 2.0, 
					id = 7,
				},
			},			
		},
	},		
}

--enemy的关卡配置
local enemys = {

	--普通兵
	{id=1,image="anim_enemy_002",demage=3,hp=510,walkRate=200,rollRate=300,fireRate=400,
		weak1=3,weak2=3},

	--近战兵
	{id=2,image="jinzhanb",demage=3,hp=600,walkRate=400,rollRate=0,fireRate=100,
		weak1=2,weak2=2},

	--伞兵
	{id=3,image="sanbing01",demage=3,hp=200,walkRate=400,rollRate=0,
		fireRate=100,weak1=1,weak2=1},

	--自爆兵
	{id=4,image="zibaob",demage=10,hp=400,walkRate=400,rollRate=0,
		fireRate=100,weak1=1,weak2=1},	

	--金币兵
	{id=5,image="qiqiu01",demage=10,hp=1,weak1=3,award = 100},	

	--金币兵
	{id=6,image="qiqiu02",demage=10,hp=1,weak1=3,award = 40},	

	--金币兵
	{id=7,image="qiqiu03",demage=10,hp=1,weak1=3,award = 20},
	--手雷兵
	{id=8,image="shouleib",demage=2,hp=340,walkRate=200,rollRate=200,fireRate=100,fireCd=5,weak1=3,weak2=5},	
	--手雷
	{id=9,image="shoulei",demage=5,hp=1,weak1=3,weak2=5},		
}

local mapId = "map_1_3"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
end

return waveClass