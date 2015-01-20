local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				delay = {0,},
				pos = {100,},
				property = {
					type = "jin",
					placeName = "place1",  
					id = 10,
				},
			},
			{
				time = 1,
				num = 3,
				delay = {0.4,0.8,1},
				pos = {200,300,400},
				property = {
					type = "jin",
					placeName = "place1",  
					id = 2,
				},
			},
			{
				time = 3,
				num = 3,
				delay = {0.3,2,0.6,},
				pos = {80,160,240},
				property = {
					type = "jin",
					placeName = "place4",  
					id = 2,
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0.3,},
				pos = {50,},					
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
				num = 1,
				delay = {0.5, 1, 2, 7,8,9},
				pos = {100,200,300,400,250,50},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 10,
				},
			},
			{
				time =5,
				num = 5,
				delay = {0.3, 0.8, 1.3, 8, 9,10},
				pos = {0,200,100,250,150,50},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 2,
				},
			},
			{
				time =7,
				num = 2,
				delay = {0.3, 0.8, 1.3, 8, 9,10},
				pos = {0,50},
				property = {
					type = "jin",
					placeName = "place7",  
					id = 2,
				},
			},
			{
				time = 13,
				num = 1,
				delay = {0.5, 1, 2, 7,8,9},
				pos = {50},
				property = {
					type = "jin",
					placeName = "place1",  
					id = 10,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0,1,0.6,0.9,5,7,6},
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
				delay = {0.3,2,0.6,0.9,5,7,6},
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
			{
				time = 18,	
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
	-- 金币
	{
		enemys = {
			{
				time = 1,
				num = 6,
				delay = {0, 0.7, 1.4,2,2.7,3.5},
				pos = {150,250,400,50,100,350},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 2,  --2*60 / s 
					id = 7,
				},
			},
			{
				time = 5,
				num = 7,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {200,100,0,300,50,150,250},
				property = {
					type = "jinbi",
					placeName = "place7",  
					speed = 3.5,
					id = 6,
				},
			},
			{
				time = 9,
				num = 6,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {50,150,250,100,200, 80},
				property = {
					type = "jinbi",
					placeName = "place4", 
					speed = 7, 
					id = 5,
				},
			},
			{
				time = 13,
				num = 6,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {150,250,400,50,100,350},
				property = {
					type = "jinbi",
					placeName = "place3",  
					speed = 6.5,
					id = 5,
				},
			},
			{
				time = 17,
				num = 7,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {200, 100, 0, 300, 50, 150, 250},
				property = {
					type = "jinbi",
					placeName = "place7",  
					speed = 3.5,
					id = 6,
				},
			},
			{
				time = 21,
				num = 5,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {50, 150, 250, 100, 200},
				property = {
					type = "jinbi",
					placeName = "place6", 
					speed = 1.5, 
					id = 7,
				},
			},			
			{
				time = 24,
				num = 6,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {150,250,400,50,100,350},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 1.5,
					id = 7,
				},
			},
			{
				time = 28,
				num = 7,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {200,100,0,300,50,150,250},
				property = {
					type = "jinbi",
					placeName = "place7",  
					speed = 4.5,
					id = 6,
				},
			},
			{
				time = 32,
				num = 6,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {50,150,250,100,200, 80},
				property = {
					type = "jinbi",
					placeName = "place4", 
					speed = 6, 
					id = 5,
				},
			},
			{
				time = 35,
				num = 6,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {150,250,400,50,100,350},
				property = {
					type = "jinbi",
					placeName = "place3",  
					speed = 5.5,
					id = 5,
				},
			},
			{
				time = 38,
				num = 7,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {200, 100, 0, 300, 50, 150, 250},
				property = {
					type = "jinbi",
					placeName = "place7",  
					speed = 3.0,
					id = 6,
				},
			},
			{
				time = 41,
				num = 5,
				delay = {0, 0.7, 1.4,2,2.7,3.5,4.2},
				pos = {50, 150, 250, 100, 200},
				property = {
					type = "jinbi",
					placeName = "place6", 
					speed = 1.5, 
					id = 7,
				},
			},			
		},
	},		
}

--enemy的关卡配置
local enemys = {

	--普通兵
	{id=1,image="anim_enemy_002",demage=3,hp=190,walkRate=200,rollRate=300,fireRate=400,
		weak1=3,weak2=3},

	--近战兵
	{id=2,image="jinzhanb",demage=3,hp=190,walkRate=400,rollRate=0,fireRate=100,
		weak1=2,weak2=2},

	--伞兵
	{id=3,image="sanbing01",demage=3,hp=200,walkRate=400,rollRate=0,
		fireRate=100,weak1=1,weak2=1},

	--自爆兵
	{id=4,image="zibaob",demage=10,hp=400,walkRate=400,rollRate=0,
		fireRate=100,weak1=1,weak2=1},	

	--金币黄气球
	{id=5,image="qiqiu01",demage=10,hp=1,weak1=3,award = 30},	

	--金币蓝气球
	{id=6,image="qiqiu02",demage=10,hp=1,weak1=3,award = 15},	

	--金币绿气球
	{id=7,image="qiqiu03",demage=10,hp=1,weak1=3,award = 9},
	--手雷兵
	{id=8,image="shouleib",demage=2,hp=340,walkRate=200,rollRate=200,fireRate=100,fireCd=5,weak1=3,weak2=5},	
	--手雷
	{id=9,image="shoulei",demage=5,hp=1,weak1=3,weak2=5},
	-- 盾兵
	{id=10,image="dunbing",demage=5,hp=380,walkRate=400,rollRate=0,fireRate=300,
		weak1=1,weak2=1},		
}

local mapId = "map_1_3"
local limit = 9   				--此关敌人上限


function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
end


return waveClass