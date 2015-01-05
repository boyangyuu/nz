local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 3,	
				num = 4,
				pos = {10,90,310,400},
				delay = {0,0.9,0.5,0.8},
				property = {
					placeName = "place1" ,
					id = 1
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {230},
				delay = {0.6},
				property = {
					placeName = "place13" ,
					type = "jin",
					id = 2,
				},
			},
			{
				time = 6,	
				num = 3,
				pos = {80,200,280},
				delay = {0,0.4,0.2},
				property = {
					placeName = "place3" , 
					startState = "rollleft",
					id = 1,
				},
			},		
			{
				time = 9,	
				num = 3,
				place = "",
				pos = {200,120,100},
				delay = {0.3,0.6,0.7},
				property = {
					placeName = "place2" , 
					id = 1,
				},
			},		
			{
				time = 10,	
				num = 1,
				pos = {25},
				delay = {0.3},
				property = {
					placeName = "place4" ,  
					id = 1,
				},
			},		
			{
				time = 13,	
				num = 1,
				pos = {40},
				delay = {0.3},
				property = {
					placeName = "place5" ,   
					id = 1,
				},
			},		
			{
				time = 16,	
				num = 1,
				pos = {30},
				delay = {0.3},
				property = {
					placeName = "place6" ,    
					id = 1,
				},
			},		
			{
				time = 19,	
				num = 1,
				pos = {30},
				delay = {0.3},
				property = { 
					placeName = "place7" ,  
					id = 1,
				},
			},		
			{
				time = 22,	
				num = 1,
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
					placeName = "place8" ,  
				},
			},		
			{
				time = 25,	
				num = 1,
				pos = {30},
				delay = {0.3},
				property = {
					placeName = "place9" ,   
					id = 1,
				},
			},		
			{
				time = 16,	
				num = 1,
				pos = {10},
				delay = {0.3},
				property = {
					type = "san",
					enemyId = 1,
					placeName = "place10" ,
					id = 3,
				},
			},		
		
		},
	},
	{
		enemys = {
			{
				time = 2,
				num = 4,
				delay = {0.6,0.8,1.1,1.6},
				pos = {10,50, 120, 90},
				property = { 
					placeName = "place1" ,
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 2,
				num = 2,
				delay = {0.3,3},
				pos = {0,400},
				property = { 
					placeName = "place13" ,
					type = "jin",
					id = 2,
				},
			},
			{
				time = 4,
				num = 5,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 200, 50, 120, 90},	
				property = { 
					startState = "rollleft",
					placeName = "place3" ,
					id = 1,
				},
			},	
			{
				time = 5,
				num = 5,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},					
				property = { 
					placeName = "place2" ,
					id = 1,
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 3,
				num = 5,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},
				property = {
					placeName = "place1" , 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 5,
				num = 1,
				delay = { 1.2},
				pos = {30},
				property = {
					placeName = "place2" , 
					type = "dao",
					id = 5,
					missileId = 6,
				},
			},
			{
				time =7,
				num = 1,
				delay = { 1.2},
				pos = {30},
				property = {
					placeName = "place3" , 
					type = "dao",
					id = 5,
					missileId = 6,
				},
			},
			{
				time =8,
				num = 4,
				delay = { 1.2,0.5,5,6},
				pos = {400,300,260,60},
				property = {
					placeName = "place13" , 
					type = "jin",
					id = 2,
				},
			},
			{
				time =12,
				num = 1,
				delay = { 1.2},
				pos = {30},
				property = {
					placeName = "place4" , 
					type = "dao",
					id = 5,
					missileId = 6,
				},
			},
			{
				time =15,
				num = 1,
				delay = { 1.2},
				pos = {300},
				property = {
					placeName = "place3" , 
					type = "dao",
					id = 5,
					missileId = 6,
				},
			},	
			{
				time = 18,
				num = 4,
				delay = {0.6,0.8,1.1,1.6},
				pos = {10,50, 120, 90},
				property = {
					type = "san",
					enemyId = 1, 
					placeName = "place1" ,
					id = 3,
				},
			},								
		},
	},		
}

--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=2,hp=200,walkRate=400,rollRate=400,fireRate=300,
		weak1=2,weak2=4},
	--近战兵
	{id=2,image="jinzhanb",demage=5,hp=2000,walkRate=400,rollRate=0,fireRate=300,
		weak1=3,weak2=5},
	--伞兵
	{id=3,image="sanbing01",demage=1,hp=1,walkRate=400,rollRate=0,
		fireRate=300,weak1=3,weak2=5},

	--自爆兵
	{id=4,image="zibaob",demage=10,hp=100,walkRate=400,rollRate=0,
		fireRate=100,weak1=3,weak2=5},	

	--导弹兵
	{id=5,image="zpbing",demage=0,hp=100,walkRate=400,rollRate=0,
		fireRate=200,weak1=3,weak2=5},		

	--导弹
	{id=6,image="daodan",demage=20,hp=100,weak1=3,weak2=5},					
}

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
end

return waveClass