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
					placeName = "place3" ,
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},
			{
				time = 6,	
				num = 3,
				pos = {180,200,280},
				delay = {0,0.4,0.2},
				property = {
					placeName = "place2" , 
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
					placeName = "place1" ,   
					id = 1,
				},
			},		
			{
				time = 16,	
				num = 1,
				pos = {30},
				delay = {0.3},
				property = {
					placeName = "place2" ,    
					id = 1,
				},
			},		
			{
				time = 19,	
				num = 1,
				pos = {30},
				delay = {0.3},
				property = { 
					placeName = "place3" ,  
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
					placeName = "place4" ,  
				},
			},		
			{
				time = 25,	
				num = 1,
				pos = {30},
				delay = {0.3},
				property = {
					placeName = "place1" ,   
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
					placeName = "place2" ,
					id = 3,
				},
			},		
		
		},
	},
	{
		enemys = {
			{
				time = 2,
				num = 2,
				delay = {1.5,3},
				pos = {200,280},
				property = { 
					placeName = "place6" ,
					type = "jin",
					id = 2,
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0.3, 0.9,1.5},
				pos = {10, 200, 90},	
				property = { 
					placeName = "place2" ,
					id = 1,
				},
			},	
			{
				time = 5,
				num = 3,
				delay = {0.6, 0.9, 1.2},
				pos = {10, 50, 100},					
				property = { 
					placeName = "place1" ,
					type = "dao",
					id = 5,
					missileId = 6,
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 3,
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
			{
				time = 3,
				num = 5,
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},
				property = {
					placeName = "place2" , 
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
					placeName = "place1" , 
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
					placeName = "place2" , 
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
					placeName = "place11" , 
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

		},
	},	
	{
		enemys = {  --boss
			{
				descId = "boss02",  --简介
				time = 3,	
				num = 1,
				pos = {250},
				delay = {0.3},
				property = { 
					type = "boss",
					placeName = "place5",
					enemyId = 6, 
					id = 1,
				},
			},
		},
	},	
}




--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=6,hp=850,walkRate=200,rollRate=300,fireRate=400,
		weak1=2,weak2=2},
	
	--近战兵
	{id=2,image="jinzhanb",demage=5,hp=2000,walkRate=400,rollRate=0,fireRate=300,
		weak1=2,weak2=2},
	--伞兵
	{id=3,image="sanbing01",demage=1,hp=400,walkRate=400,rollRate=0,
		fireRate=300,weak1=1,weak2=1},

	--自爆兵
	{id=4,image="zibaob",demage=15,hp=1500,walkRate=400,rollRate=0,
		fireRate=100,weak1=3,weak2=5},	

	--导弹兵
	{id=5,image="zpbing",demage=0,hp=1500,walkRate=400,rollRate=0,
		fireRate=200,weak1=2,weak2=2},		

	--导弹
	{id=6,image="daodan",demage=20,hp=300,weak1=1,weak2=1},					
}

--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "boss01", --图片名字
		hp = 150000,
		demage = 3,
		fireRate = 400,
		walkRate = 200,
		saoFireOffset = 0.4, 		--扫射时间间隔
		saoFireTimes = 10, 			--扫射次数
		weakScale = {weak1 = 2, weak2 = 2, weak3 = 3},	--弱点伤害倍数
		
		skilltrigger = {   			--技能触发(可以同时)
			moveLeftFire = {
				0.65, 0.35,
			},
			moveRightFire = {
				0.55, 0.25,
			},
			daoDan = {
				0.80, 0.61, 0.40, 0.20,
			},
			saoShe = {
				0.95,0.70, 0.45,
			},
			weak2 = {
				0.60,
			},	
			weak3 = {
				0.30,
			},	
			demage150 = {  --伤害乘以1.20  备注不要超过三位数 比如demage1200是不行的
				0.59,
			},	
			demage400 = {  
				0.10,
			},										
		},
		getMoveLeftAction = function ()
			local move1 = cc.MoveBy:create(10/60, cc.p(0, 0))
			local move2 = cc.MoveBy:create(15/60, cc.p(-18, 0))
			local move3 = cc.MoveBy:create(13/60, cc.p(-45, 0))	
			local move4 = cc.MoveBy:create(7/60, cc.p(-12, 0))
			local move5 = cc.MoveBy:create(15/60, cc.p(-4, 0))
			return cc.Sequence:create(move1, move2, move3, move4, move5)
		end,

		getMoveRightAction = function ()
			local move1 = cc.MoveBy:create(10/60, cc.p(10, 0))
			local move2 = cc.MoveBy:create(15/60, cc.p(30, 0))
			local move3 = cc.MoveBy:create(10/60, cc.p(10, 0))	
			local move4 = cc.MoveBy:create(15/60, cc.p(12, 0))
			local move5 = cc.MoveBy:create(10/60, cc.p(4, 0))
			return cc.Sequence:create(move1, move2, move3, move4, move5)
		end,
	},
}

local mapId = "map_1_6"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
end
return waveClass