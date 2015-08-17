local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
-------------- 汽油桶配置 ----------------------
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {450},
				property = { 
					placeName = "place2",
					type = "bao_tong",
					id = 4,
				},
			},
----------------------------------------------	
			{
				time = 1,
				num = 1,
				delay = {0.1},
				pos = {110},
				property = {
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 1.5,
				num = 1,
				delay = {0.3},
				pos = {260,},
				property = {
					placeName = "place2", 
					startState = "rollright", 
					id = 1,
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0.1,},
				pos = {140,},
				property = {
					placeName = "place4",  
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 2.5,
				num = 1,
				delay = {0},
				pos = {50},					
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
				time = 3,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 11,
					award = "goldWeapon",
					placeName = "place1",
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0.1},
				pos = {250},
				property = {
					placeName = "place6",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 3,                                          --第一波10个怪
				num = 2,
				delay = {0,0.5},
				pos = {800,400},					
				property = {
					placeName = "place5",   
					id = 8,
					startState = "rollright",
					type = "dao",
					missileId = 9,
					missileType = "lei",
				},
			},					
		},
	},
	                                                                -- 第二波15个怪	
	{
		enemys = {
			{
				time = 1,
				num = 2,
				delay = {0.5,1.0},
				pos = {250,350},
				property = {
					placeName = "place2",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 1.5,
				num = 3,
				delay = {0,0.5,1.1},
				pos = {700,850,1000},
				property = {
					placeName = "place6",
					startState = "rollleft",  
					id = 1,
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0.3},
				pos = {50},					
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
				time = 2.5,
				num = 1,
				delay = {0},
				pos = {120},					
				property = {
					placeName = "place1",   
					id = 8,
					startState = "rollright",
					type = "dao",
					missileId = 9,
					missileType = "lei",
				},
			},
			{
				time = 3,	
				num = 3,
				pos = {80,150,210},
				delay = {0,0.5,1},
				property = { 
					type = "common",
					startState = "san",
					id = 1,
					placeName = "place1",
				},
			},	
			{
				time = 3.5,	
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "common",
					startState = "san",
					id = 1,
					placeName = "place6",
				},
			},
			{
				time = 4,	
				num = 2,
				pos = {330,420},
				delay = {0,0.8},
				property = { 
					type = "common",
					startState = "san",
					id = 1,
					placeName = "place2",
				},
			},
			{
				time = 4.5,	
				num = 2,
				pos = {980,1050},
				delay = {0,0.8},
				property = { 
					type = "common",
					startState = "san",
					id = 1,
					placeName = "place5",
				},
			},												
		},
	},	
	{
		enemys = {
			{
				descId = "jinzhanb",  --简介
				time = 3,
				num = 1,
				delay = {4},
				pos = {580},
				property = {
					type = "jin",
					placeName = "place2",  
					id = 2,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0.2},
				pos = {340},
				property = {
					type = "jin",
					placeName = "place2",  
					id = 2,
				},
			}, 
			{
				time = 6,
				num = 1,
				delay = {0.5},
				pos = {100},
				property = {
					type = "jin",
					placeName = "place4",  
					id = 2,
				},
			}, 
			{
				time = 7,
				num = 1,
				delay = {0},
				pos = {90},
				property = {
					type = "jin",
					placeName = "place1",  
					id = 2,
				},
			}, 
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {30},
				property = {
					type = "jin",
					placeName = "place4",  
					id = 2,
				},
			}, 
		},
	}, 
                                                                             -- 金币气球
	{
		waveType = "award", 
		enemys = {

			{
				time = 2,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {410,490,570,630,710,790,870,950,1030,1110},
				property = {
					type = "jinbi",
					placeName = "place10",  
					speed = 2,                                                    --2*60 / s   每秒移动60像素(右斜)
					id = 7,
				},
			},
			{
				time = 3,
				num = 10,
				delay = {0, 3.0, 6.0,7.0,9.0,16.5,20.0,24,28,30},
				pos = {500,900,650,720,690, 400,800,650,430,740},
				property = {
					type = "jinbi",
					placeName = "place11", 
					speed = 4.5, 
					id = 6,
				},
			},
			                                                                                 -- 背景散飞蓝气球
			{
				time = 4,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --左斜
					id = 6,
				},
			},
			{
				time = 6,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 11,
					award = "goldWeapon",
					placeName = "place1",
				},
			},
			{
				time = 10,
				num = 10,
				delay = {0, 1.5, 3.0,5.0,9.0,13.5,15,20,25,28},
				pos = {450,750,650,700,800, 1000,800,350,666,888},                                    
				                                                                          -- 黄气球
				property = {
					type = "jinbi",
					placeName = "place11", 
					speed = 5, 
					id = 5,
				},
			},
			{
				time = 11,
				num = 10,
				delay = {1, 3.7, 5.4,7,8.7,9.5,14.2,16,21,26},
				pos = {750,450,600,380,800,550,750,350,870,666},
				property = {
					type = "jinbi",
					placeName = "place11",  
					speed = 3.5,
					id = 7,
				},
			},                                                                                -- 背景散飞绿气球
			{
				time = 12,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {410,490,570,630,710,790,870,950,1030,1110},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --右斜
					id = 7,
				},
			},
			{
				time = 17,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --横
					id = 6,
				},
			},
			{
				time = 17.5,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --左斜
					id = 7,
				},
			},
			{
				time = 18,
				num = 5,
				delay = {1, 4, 7,11,15},
				pos = {400, 500, 350, 300, 550},
				property = {
					type = "jinbi",
					placeName = "place2",  
					speed = 3.5,
					id = 6,
				},
			},
			{
				time = 19,
				num = 5,
				delay = {1, 4, 7,11,15},
				pos = {40, 50, 55, 280, 300},
				property = {
					type = "jinbi",
					placeName = "place4",  
					speed = 3.5,
					id = 7,
				},
			},
			{
				time = 23.5,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --左斜
					id = 7,
				},
			},
			{
				time = 28,	                                               --金武奖励箱子
				num = 1,
				pos = {80},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 11,
					award = "goldWeapon",
					placeName = "place4",
				},
			},
			{
				time = 29,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --横
					id = 6,
				},
			},
			{
				time = 30,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {410,490,570,630,710,790,870,950,1030,1110},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --右斜
					id = 7,
				},
			},
			{
				time = 34,
				num = 12,
				delay = {0,0,0,0.7,0.7,0.7,0.7,0.7,1.4,1.4,1.4,2.1},
				pos = {650,750,850,550,650,750,850,950,650,750,850,750},                                    
				                                                                          -- 绿气球
				property = {
					type = "jinbi",
					placeName = "place11", 
					speed = 3, 
					id = 7,
				},
			},
			{
				time = 38,
				num = 6,
				delay = {1,1.5,1.8,2.0,2.5,3},
				pos = {780,660,830,550,666,888},                                    
				                                                                          -- 黄气球
				property = {
					type = "jinbi",
					placeName = "place11", 
					speed = 5, 
					id = 5,
				},
			},
		},
		
	},		
}

--enemy的关卡配置                     MP5伤害65  dps大于等于1 怪物数据
local enemys = {

	--普通兵
	{id=1,image="anim_enemy_002",demage=2,hp=195,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
		weak1=3},

	--近战兵
	{id=2,image="jinzhanb",demage=3,hp=585,fireRate=180,fireCd=3,speed=40,
		weak1=3},	

	--汽油桶         --type = "bao_tong",
	{id=4,image="qyt_01",demage=2000,hp=1,
	weak1=1},

	--金币黄气球
	{id=5,image="qiqiu01",demage=10,hp=1,weak1=3,award = 40},	

	--金币蓝气球
	{id=6,image="qiqiu02",demage=10,hp=1,weak1=3,award = 20},	

	--金币绿气球
	{id=7,image="qiqiu03",demage=10,hp=1,weak1=3,award = 10},

	--手雷兵
	{id=8,image="shouleib",demage=0,hp=130,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=360,fireCd=5,
	weak1=3},
		
	--手雷
	{id=9,image="shoulei",demage=3,hp=1,
	weak1=3},
	
	-- 金武箱子奖励  type = "awardSan",
	{id=11,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励    

}

local mapId = "map_1_3"
local limit = 10   				--此关敌人上限


function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}

end


return waveClass