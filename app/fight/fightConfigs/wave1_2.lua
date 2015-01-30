local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
--[[
	{
		enemys = { 
			{
				time = 1,	
				num = 4,
				pos = {200,250,300,350,},
				delay = {0,0.5,0.8,1,},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {800},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollleft",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {250},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 1,	
				num = 2,
				pos = {250,350},
				delay = {1,1.5,1.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 3,	
				num = 3,
				pos = {800,750,700},
				delay = {0,0.6,0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},

						-- 以上是第一波第一批
			
			{
				time = 5,	
				num = 3,
				pos = {250,350,300},
				delay = {1,1.5,1.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 8,	
				num = 3,
				pos = {800,750,700},
				delay = {0,0.6,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.2,0},
				pos = {250,900},
				property = { 
					placeName = "place3",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},	
			{
				time = 9,	
				num = 2,
				pos = {900,950},
				delay = {0,0.6},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},

									-- 以上是第一波第二批

			{
				time = 5,	
				num = 3,
				pos = {250,350,300},
				delay = {1,1.5,1.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 8,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.2,0},
				pos = {250,900},
				property = { 
					placeName = "place3",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},	
			{
				time = 9,	
				num = 3,
				pos = {900,940,980},
				delay = {0,0.6,0.8},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
		                                     	-- 以上是第一波第三批
		},
	},	
	{
		enemys = {                                           
		                                                                -- 第二波

			{
				time = 1,
				num = 3,
				delay = {0, 0.6, 0.8},
				pos = {200,250,300,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 1.5,
				num = 3,
				delay = {0, 0.3, 0.7},
				pos = {800,850,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 3,
				num = 3,
				delay = {0.2,0.3, 0.6},
				pos = {500,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 1.2,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},

			                                          -- 以上是第二波第一批
			{
				time = 6,	
				num = 8,
				pos = {300,350,400,450,550,600,700,850},
				delay = {0,0.5,1,1.4,1.8,0.5,0.7,1},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place2",
				},
			},	
			{
				time = 7,	
				num = 2,
				pos = {350,700},
				delay = {0.3,0.7},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place3",
				},
			},
			
                                              -- 以上是第二波第二批
			{
				time = 10,
				num = 3,
				delay = {0, 0.6, 0.8},
				pos = {200,250,300,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 11,
				num = 3,
				delay = {0, 0.3, 0.7},
				pos = {800,850,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 12,
				num = 3,
				delay = {0.2,0.3, 0.6},
				pos = {500,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 13,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
 			                                       -- 以上是第二波第三批     

		},

	},
]]
	{	
		waveType = "boss",
		enemys = {                                              --boss
			{
				descId = "boss02",
				time = 3,	
				num = 1,
				pos = {194},
				delay = {4},
				property = { 
					type = "renzheBoss",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},
					placeName = "place8",
					missileId = 10,                 --导弹id        
					id = 1,
				},
			},		
		},
	},
}

--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=5,hp=260,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=3,
	weak1=3},

	--近战兵
	{id=2,image="jinzhanb",demage=4,hp=1080,walkRate=400,rollRate=100,fireRate=100,
		weak1=2,weak2=2},

	--伞兵
	{id=3,image="sanbing01",demage=0,hp=260,
	weak1=3},	             

    --导弹          --missileType = "daodan",
	{id=4,image="daodan",demage=10,hp=1,weak1=1},

	--铁球
	{id=5,image="tieqiu",demage=20,hp=10000,weak1=1},	

	--手雷兵
	{id=6,image="shouleib",demage=0,hp=195,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=300,fireCd=4,
	weak1=3},
	--手雷
	{id=7,image="shoulei",demage=10,hp=1,
	weak1=3},

	--BOSS导弹          --missileType = "daodan",
	{id=8,image="daodan",demage=3,hp=120,weak1=1},

	--忍者兵
	{id=9,image="renzb",demage=50,hp=900,fireRate=200, fireCd=2.0,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5, 
		shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=3,award = 60},	

	--飞镖
	{id=10,image="feibiao",demage=10,hp=300},		
}

	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{

		image = "renzb", --图片名字
		hp = 100000,
		fireRate = 30,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 180, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 40,                --冲锋造成伤害
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--左腿 弱点伤害倍数
		weak3 = 1.2,					--右腿 弱点伤害倍数	
		
		skilltrigger = {   			          --技能触发(可以同时)
			zhaohuan = {
				0.95,0.80,0.75,0.55,0.25
			},               --召唤
			chongfeng = {
				0.99, 0.97, 0.87,0.84, 0.75, 0.65, 0.45,0.35, 0.25, 0.15, 0.05,
			},
			weak3 = {                               --手 技能触发(可以同时)
				0.82,0.62,0.42, 0.22,                        
			},	
			weak2 = {                               --手 技能触发(可以同时)
				0.80,0.60,0.40, 0.20,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.90,0.70,0.50,0.30,0.10                        
			},
			demage125 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.85,
			},	
			demage250 = {  
				0.60,
			},	
			demage400 = {  
				0.50,
			},	
						
		},
		enemys1 = {                                                   --第一波召唤的自爆兵
			{
				time = 2,	
				num = 4,
				pos = {560,660,760,460},
				delay = {0.2,0.4,0.5,0.7},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "renzhe",
					missileId = 10,
				},
			},	
		},	
		enemys2 = {                                                   --第一波召唤的自爆兵
			{
				time = 2,	
				num = 4,
				pos = {560,660,760,460},
				delay = {0.2,0.4,0.5,0.7},
				property = {
					placeName = "place4" ,
					id = 9,
					type = "renzhe",
					missileId = 10,
				},
			},	
		},	
		enemys3 = {                                                   --第一波召唤的自爆兵
			{
				time = 2,	
				num = 4,
				pos = {560,660,760,460},
				delay = {0.2,0.4,0.5,0.7},
				property = {
					placeName = "place5" ,
					id = 9,
					type = "renzhe",
					missileId = 10,
				},
			},	
		},							
	},
}

local mapId = "map_1_2"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.goldLimits = {35}   --黄武激活所需杀人个数
end

return waveClass