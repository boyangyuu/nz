local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 3,	
				num = 4,
				pos = {-50,50,150,250},
				delay = {0,0.5,0.6,1},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
						{
				time = 4,	
				num = 3,
				pos = {100,200,300},
				delay = {0,1,2},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},		
			{
				time = 5,	
				num = 3,
				pos = {200,400,300},
				delay = {1,2,3},
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
				num = 2,
				delay = {0.3, 0.6},
				pos = {300,150},
				property = {
					placeName = "place4",  
					id = 1,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0.3, 0.6},
				pos = {250,400},	
				property = { 
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 5,
				num = 2,
				delay = {0.3, 0.6},
				pos = {200,100},					
				property = {
					placeName = "place6",  
					id = 1,
				},
			},	
			{
				time = 8,	
				num = 2,
				pos = {100, 300},
				delay = {1, 2},
				property = { 
					type = "san",
					id = 1,
					enemyId = 1,
					placeName = "place1",
				},
			},
			{
				time = 9,	
				num = 1,
				pos = {100, 250},
				delay = {0.5, 1.5},
				property = { 
					type = "san",
					id = 1,
					enemyId = 1,
					placeName = "place2",
				},
			},									
		},

	},	
	{
		enemys = {  --boss
			{
				time = 3,	
				num = 1,
				
				pos = {250},
				delay = {0.3},
				property = { 
					type = "boss",
					placeName = "place7",
					bossId = 1,
					configName = "BossConfig_1",
					index = 1, 
				},
			},		
		},
	},
}

--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=30,hp=100,walkRate=400,rollRate=400,fireRate=200,
	weak1=2,weak2=4},

	--
}

--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "boss01", --图片名字
		hp = 20000,
		demage = 50,
		fireRate = 200,
		walkRate = 200,
		fireOffset = 0.2,
		demageScale = {weak1 = 2, weak2 = 3, weak3 = 3},
		
		skilltrigger = {   --技能触发(可以同时)
			moveLeftFire = {
				0.95, 0.70,
			},
			moveRightFire = {
				0.65, 0.30,
			},
			daoDan = {
				0.90, 0.60, 0.50, 0.40,
			},
			saoShe = {
				0.65, 0.55,
			},
			weak2 = {
				0.70,
			},	
			weak3 = {
				0.30,
			},							
		},
	},
}

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
end

return waveClass